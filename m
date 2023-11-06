Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4D7E2B37
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 Nov 2023 18:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjKFRji (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 6 Nov 2023 12:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKFRjV (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Mon, 6 Nov 2023 12:39:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F1910FE;
        Mon,  6 Nov 2023 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ht1nE6SouNNqW2kjQ+aS4bAvHBgYKtkA+uUBcsC3lgw=; b=WPjoA4r6xy94/HOVUz9sXCuuOc
        xKiM2twJemtPbuMis8G/VqHLeuGluz7116x0FE1DAhQCKo4wGY/YKS6mBpyye88ZqNNuAmjeSU9iK
        ErzY2sT+/BPZTugNAeLueLzCcC4YQs5C+/KG3hQhK4yd3Q3ZmsEaVM91+U9BhjykjJGBmt0zbZIWH
        FepRR7iRB9EnFbFDGKFCpBMYa/30UN4NthpL457EVzD3uPq2OKgEO3fkYfFq4RsakFWoKqt3gs7Zz
        hfCHFDa9KNKbLFeAU1/Glal7LJNQr1nAL8ECkuMAqcN4Wb37cJhhQcVSC063ovP+mdN/0KzR5Fvuv
        a+yyZ0eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r03Z8-007HBh-8U; Mon, 06 Nov 2023 17:39:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 34/35] nilfs2: Convert nilfs_prepare_chunk() and nilfs_commit_chunk() to folios
Date:   Mon,  6 Nov 2023 17:39:02 +0000
Message-Id: <20231106173903.1734114-35-willy@infradead.org>
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

All callers now have a folio, so convert these two functions.
Saves one call to compound_head() in unlock_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 1085e9a5b84e..85db5772795b 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -78,33 +78,32 @@ static unsigned int nilfs_last_byte(struct inode *inode, unsigned long page_nr)
 	return last_byte;
 }
 
-static int nilfs_prepare_chunk(struct page *page, unsigned int from,
+static int nilfs_prepare_chunk(struct folio *folio, unsigned int from,
 			       unsigned int to)
 {
-	loff_t pos = page_offset(page) + from;
+	loff_t pos = folio_pos(folio) + from;
 
-	return __block_write_begin(page, pos, to - from, nilfs_get_block);
+	return __block_write_begin(&folio->page, pos, to - from, nilfs_get_block);
 }
 
-static void nilfs_commit_chunk(struct page *page,
-			       struct address_space *mapping,
-			       unsigned int from, unsigned int to)
+static void nilfs_commit_chunk(struct folio *folio,
+		struct address_space *mapping, size_t from, size_t to)
 {
 	struct inode *dir = mapping->host;
-	loff_t pos = page_offset(page) + from;
-	unsigned int len = to - from;
-	unsigned int nr_dirty, copied;
+	loff_t pos = folio_pos(folio) + from;
+	size_t copied, len = to - from;
+	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(page, from, to);
-	copied = block_write_end(NULL, mapping, pos, len, len, page, NULL);
+	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, from, to);
+	copied = block_write_end(NULL, mapping, pos, len, len, &folio->page, NULL);
 	if (pos + copied > dir->i_size)
 		i_size_write(dir, pos + copied);
 	if (IS_DIRSYNC(dir))
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 	err = nilfs_set_file_dirty(dir, nr_dirty);
 	WARN_ON(err); /* do not happen */
-	unlock_page(page);
+	folio_unlock(folio);
 }
 
 static bool nilfs_check_folio(struct folio *folio, char *kaddr)
@@ -409,11 +408,11 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 	int err;
 
 	folio_lock(folio);
-	err = nilfs_prepare_chunk(&folio->page, from, to);
+	err = nilfs_prepare_chunk(folio, from, to);
 	BUG_ON(err);
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
-	nilfs_commit_chunk(&folio->page, mapping, from, to);
+	nilfs_commit_chunk(folio, mapping, from, to);
 	folio_release_kmap(folio, de);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
@@ -486,7 +485,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 got_it:
 	from = offset_in_folio(folio, de);
 	to = from + rec_len;
-	err = nilfs_prepare_chunk(&folio->page, from, to);
+	err = nilfs_prepare_chunk(folio, from, to);
 	if (err)
 		goto out_unlock;
 	if (de->inode) {
@@ -501,7 +500,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	memcpy(de->name, name, namelen);
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
-	nilfs_commit_chunk(&folio->page, folio->mapping, from, to);
+	nilfs_commit_chunk(folio, folio->mapping, from, to);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	nilfs_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
@@ -543,12 +542,12 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct folio *folio)
 	if (pde)
 		from = (char *)pde - kaddr;
 	folio_lock(folio);
-	err = nilfs_prepare_chunk(&folio->page, from, to);
+	err = nilfs_prepare_chunk(folio, from, to);
 	BUG_ON(err);
 	if (pde)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
-	nilfs_commit_chunk(&folio->page, mapping, from, to);
+	nilfs_commit_chunk(folio, mapping, from, to);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 out:
 	folio_release_kmap(folio, kaddr);
@@ -570,7 +569,7 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	err = nilfs_prepare_chunk(&folio->page, 0, chunk_size);
+	err = nilfs_prepare_chunk(folio, 0, chunk_size);
 	if (unlikely(err)) {
 		folio_unlock(folio);
 		goto fail;
@@ -591,7 +590,7 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
 	memcpy(de->name, "..\0", 4);
 	nilfs_set_de_type(de, inode);
 	kunmap_local(kaddr);
-	nilfs_commit_chunk(&folio->page, mapping, 0, chunk_size);
+	nilfs_commit_chunk(folio, mapping, 0, chunk_size);
 fail:
 	folio_put(folio);
 	return err;
-- 
2.42.0

