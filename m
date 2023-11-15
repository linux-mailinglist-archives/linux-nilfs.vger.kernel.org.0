Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9A7E2B16
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 Nov 2023 18:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjKFRjT (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 6 Nov 2023 12:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjKFRjS (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Mon, 6 Nov 2023 12:39:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264BD7F;
        Mon,  6 Nov 2023 09:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F4G+iHL8t8+cwmBR3NRbeBWt2xI2c3RvXRM3QO5MLTw=; b=VqY+B6Y2nO/TvkEt1F/bHt0/gn
        mimQzV76d7uCC9OHwtbBH8n7UCrVw9bp3wcqTnvVZGQqvmkzAb6roneZBcHJx5ZQfRHJCXAmN0xKW
        j20AsU93UH8Hsb5PoUT1AS8G3Rf5w8oTj3Iz89Hn1eFtC6qJcVFQ6QoiJ+Q5hVS/+z7XVec3FvyO+
        4rHa3uG3LOjXtqfObpHSllTzEinGqAeukpMCwD/+1yzWT76uYe9jpKFZSTpAgBMoYyHOY/N3tw6wF
        iBmaRKAvCMfT+U7p7m3D0xtjUxEX86qolpLJChlOi2tgGJx3cntHZlUi1FTYQDsvUsQX9bIDTvHc/
        Oltb3jbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r03Z5-007H8j-2d; Mon, 06 Nov 2023 17:39:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/35] nilfs2: Convert nilfs_page_mkwrite() to use a folio
Date:   Mon,  6 Nov 2023 17:38:39 +0000
Message-Id: <20231106173903.1734114-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Using the new folio APIs saves seven hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/file.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 740ce26d1e76..bec33b89a075 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -45,34 +45,36 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vma->vm_file);
 	struct nilfs_transaction_info ti;
+	struct buffer_head *bh, *head;
 	int ret = 0;
 
 	if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
 		return VM_FAULT_SIGBUS; /* -ENOSPC */
 
 	sb_start_pagefault(inode->i_sb);
-	lock_page(page);
-	if (page->mapping != inode->i_mapping ||
-	    page_offset(page) >= i_size_read(inode) || !PageUptodate(page)) {
-		unlock_page(page);
+	folio_lock(folio);
+	if (folio->mapping != inode->i_mapping ||
+	    folio_pos(folio) >= i_size_read(inode) ||
+	    !folio_test_uptodate(folio)) {
+		folio_unlock(folio);
 		ret = -EFAULT;	/* make the VM retry the fault */
 		goto out;
 	}
 
 	/*
-	 * check to see if the page is mapped already (no holes)
+	 * check to see if the folio is mapped already (no holes)
 	 */
-	if (PageMappedToDisk(page))
+	if (folio_test_mappedtodisk(folio))
 		goto mapped;
 
-	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+	head = folio_buffers(folio);
+	if (head) {
 		int fully_mapped = 1;
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			if (!buffer_mapped(bh)) {
 				fully_mapped = 0;
@@ -81,11 +83,11 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 		} while (bh = bh->b_this_page, bh != head);
 
 		if (fully_mapped) {
-			SetPageMappedToDisk(page);
+			folio_set_mappedtodisk(folio);
 			goto mapped;
 		}
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 
 	/*
 	 * fill hole blocks
@@ -105,7 +107,7 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	wait_for_stable_page(page);
+	folio_wait_stable(folio);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return vmf_fs_error(ret);
-- 
2.42.0

