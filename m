Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C77E2B39
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 Nov 2023 18:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjKFRjj (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 6 Nov 2023 12:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKFRjV (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Mon, 6 Nov 2023 12:39:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F210FF;
        Mon,  6 Nov 2023 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cufnaJg2QOsF32aUmx1UzAxRfZEwQNwO4xqmARoWL4c=; b=lyFuy+hoVsJbum6wnUyMQpqxTD
        pHS3cU3eS0SUmBBDZoh84G7wdCGQ06zOB335xd7+csdxan/Lx2WA84sGR59ev3Iec+olEF5IKG9KH
        Xm+JUZ97xVb6v67z/OolbRuGpPF1BZQXGHxAcwIJh+9tfT9bxjhuMinZ+u12f006TVhuKIjjXFpTI
        +jMjt+vWw1NVQap2+T7UZ2QZOQL44ngwRHiAmk8Z2aciCKF5oST0cqiJ5B6VZKcp79trgNrMTvLoI
        ex5/BUTSK2uOXagmbEHEIudDcIUgPwdICsdNUKjW4FNu5fqQrkA56nNi4MFRH1+xr5B/w3ZMb2ZMP
        9foRsb+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r03Z8-007HBn-CY; Mon, 06 Nov 2023 17:39:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 35/35] nilfs2: Convert nilfs_page_bug() to nilfs_folio_bug()
Date:   Mon,  6 Nov 2023 17:39:03 +0000
Message-Id: <20231106173903.1734114-36-willy@infradead.org>
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

All callers have a folio now, so convert it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/btnode.c |  4 ++--
 fs/nilfs2/page.c   | 25 +++++++++++++------------
 fs/nilfs2/page.h   |  6 +++---
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 1204dd06ead8..0131d83b912d 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -190,7 +190,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 retry:
 		/* BUG_ON(oldkey != obh->b_folio->index); */
 		if (unlikely(oldkey != ofolio->index))
-			NILFS_PAGE_BUG(&ofolio->page,
+			NILFS_FOLIO_BUG(ofolio,
 				       "invalid oldkey %lld (newkey=%lld)",
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
@@ -246,7 +246,7 @@ void nilfs_btnode_commit_change_key(struct address_space *btnc,
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		ofolio = obh->b_folio;
 		if (unlikely(oldkey != ofolio->index))
-			NILFS_PAGE_BUG(&ofolio->page,
+			NILFS_FOLIO_BUG(ofolio,
 				       "invalid oldkey %lld (newkey=%lld)",
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 94e11bcee05b..5c2eba1987bd 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -150,29 +150,30 @@ bool nilfs_folio_buffers_clean(struct folio *folio)
 	return true;
 }
 
-void nilfs_page_bug(struct page *page)
+void nilfs_folio_bug(struct folio *folio)
 {
+	struct buffer_head *bh, *head;
 	struct address_space *m;
 	unsigned long ino;
 
-	if (unlikely(!page)) {
-		printk(KERN_CRIT "NILFS_PAGE_BUG(NULL)\n");
+	if (unlikely(!folio)) {
+		printk(KERN_CRIT "NILFS_FOLIO_BUG(NULL)\n");
 		return;
 	}
 
-	m = page->mapping;
+	m = folio->mapping;
 	ino = m ? m->host->i_ino : 0;
 
-	printk(KERN_CRIT "NILFS_PAGE_BUG(%p): cnt=%d index#=%llu flags=0x%lx "
+	printk(KERN_CRIT "NILFS_FOLIO_BUG(%p): cnt=%d index#=%llu flags=0x%lx "
 	       "mapping=%p ino=%lu\n",
-	       page, page_ref_count(page),
-	       (unsigned long long)page->index, page->flags, m, ino);
+	       folio, folio_ref_count(folio),
+	       (unsigned long long)folio->index, folio->flags, m, ino);
 
-	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+	head = folio_buffers(folio);
+	if (head) {
 		int i = 0;
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			printk(KERN_CRIT
 			       " BH[%d] %p: cnt=%d block#=%llu state=0x%lx\n",
@@ -258,7 +259,7 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 
 		folio_lock(folio);
 		if (unlikely(!folio_test_dirty(folio)))
-			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
+			NILFS_FOLIO_BUG(folio, "inconsistent dirty state");
 
 		dfolio = filemap_grab_folio(dmap, folio->index);
 		if (unlikely(IS_ERR(dfolio))) {
@@ -268,7 +269,7 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 			break;
 		}
 		if (unlikely(!folio_buffers(folio)))
-			NILFS_PAGE_BUG(&folio->page,
+			NILFS_FOLIO_BUG(folio,
 				       "found empty page in dat page cache");
 
 		nilfs_copy_folio(dfolio, folio, true);
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 968b311d265b..7e1a2c455a10 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -37,7 +37,7 @@ struct buffer_head *nilfs_grab_buffer(struct inode *, struct address_space *,
 void nilfs_forget_buffer(struct buffer_head *);
 void nilfs_copy_buffer(struct buffer_head *, struct buffer_head *);
 bool nilfs_folio_buffers_clean(struct folio *);
-void nilfs_page_bug(struct page *);
+void nilfs_folio_bug(struct folio *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
@@ -49,7 +49,7 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff);
 
-#define NILFS_PAGE_BUG(page, m, a...) \
-	do { nilfs_page_bug(page); BUG(); } while (0)
+#define NILFS_FOLIO_BUG(folio, m, a...) \
+	do { nilfs_folio_bug(folio); BUG(); } while (0)
 
 #endif /* _NILFS_PAGE_H */
-- 
2.42.0

