Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC707E2B17
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 Nov 2023 18:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjKFRjT (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 6 Nov 2023 12:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjKFRjS (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Mon, 6 Nov 2023 12:39:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CDAD6D;
        Mon,  6 Nov 2023 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hR2d3wLXiqfslGTGihlfM0yCkgESgafqHrMpePJor1M=; b=WCRc7XCsz0go2ez/i3GAq93DKA
        sU+DWdB0IPK8U8yeZ7o9lgLw3CVy/9CiRBR5+WLpBt24X6sUCN8SemBSqn71fJiBfY83AtVjpChEE
        +LxvZwXg7fGNVd6STxkE5/onHbA28nbyxm7XEeOs6gqyYiA0bKkz9Al/as3+ashFqtHwO4W/s7M+O
        i5D/r0K3qnAqnxZY+XL+N2Lxb8vqJXV3rBNqNs9i3DYUZCL7vL7nII7Bk3CJLtdDqQCQiouRCu2qH
        3v8EpMMjByutbuLESPBen7zSANIG/fTyybHOIQ3Mhm78PBzEgAUAUPSE2BAWXi9n7NKqxtIoHvU3k
        0gIoZTlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r03Z4-007H8D-Eq; Mon, 06 Nov 2023 17:39:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/35] nilfs2: Convert nilfs_writepage() to use a folio
Date:   Mon,  6 Nov 2023 17:38:34 +0000
Message-Id: <20231106173903.1734114-7-willy@infradead.org>
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

Convert the incoming page to a folio.  Replaces three calls to
compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index f861f3a0bf5c..c7ec56358a79 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -175,7 +175,8 @@ static int nilfs_writepages(struct address_space *mapping,
 
 static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 	int err;
 
 	if (sb_rdonly(inode->i_sb)) {
@@ -186,12 +187,12 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * So, here we simply discard this dirty page.
 		 */
 		nilfs_clear_dirty_page(page, false);
-		unlock_page(page);
+		folio_unlock(folio);
 		return -EROFS;
 	}
 
-	redirty_page_for_writepage(wbc, page);
-	unlock_page(page);
+	folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
 
 	if (wbc->sync_mode == WB_SYNC_ALL) {
 		err = nilfs_construct_segment(inode->i_sb);
-- 
2.42.0

