Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD667193D
	for <lists+linux-nilfs@lfdr.de>; Wed, 18 Jan 2023 11:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjARKlE (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 18 Jan 2023 05:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjARKj4 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 18 Jan 2023 05:39:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30B37F9AB;
        Wed, 18 Jan 2023 01:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O83tPX7xDqfBHS0UmyQszE340fKZLFsVV7AVtaYRimc=; b=siItTvaO8AsDZE3ndylUPIO/O7
        O8rbSLynnMNtdE+Stj5GPSclr0XcMLZj+dKghCCW91lanRkY7aH4RCo3QLiVUBRy+6YnE08rYe474
        nYyWYpyVKCaiYpK2GGKX0C9Il9QGUIdNlez4FB93mChOl/ONhLOg14psRvpOcZfD0/x88ZoKZRjx4
        Y9z9UDYRy4b0bASegjboX45Xi47n6T065RATsSq713wYwK/3AzncosVsQt3BXdHtlCUbg84/3QCkr
        obJDhpJGPXGRphz9ppkZYpG43bea+N0N/sTKMifzKhDvT4kVfxWKRrlPE5UM2N1ShnUoiRJGYZTmr
        eeFJ4fCQ==;
Received: from 213-147-167-250.nat.highway.webapn.at ([213.147.167.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI4z2-0009zZ-Qn; Wed, 18 Jan 2023 09:43:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 4/9] shmem: remove shmem_get_partial_folio
Date:   Wed, 18 Jan 2023 10:43:24 +0100
Message-Id: <20230118094329.9553-5-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118094329.9553-1-hch@lst.de>
References: <20230118094329.9553-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Add a new SGP_FIND mode for shmem_get_partial_folio that works like
SGP_READ, but does not check i_size.  Use that instead of open coding
the page cache lookup in shmem_get_partial_folio.  Note that this is
a behavior change in that it reads in swap cache entries for offsets
outside i_size, possibly causing a little bit of extra work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 46 ++++++++++++----------------------------
 2 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d09d54be4ffd99..7ba160ac066e5e 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -105,6 +105,7 @@ enum sgp_type {
 	SGP_CACHE,	/* don't exceed i_size, may allocate page */
 	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
 	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
+	SGP_FIND,	/* like SGP_READ, but also read outside i_size */
 };
 
 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
diff --git a/mm/shmem.c b/mm/shmem.c
index 9e1015cbad29f9..e9500fea43a8dc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -877,27 +877,6 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	}
 }
 
-static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
-{
-	struct folio *folio;
-
-	/*
-	 * At first avoid shmem_get_folio(,,,SGP_READ): that fails
-	 * beyond i_size, and reports fallocated pages as holes.
-	 */
-	folio = __filemap_get_folio(inode->i_mapping, index,
-					FGP_ENTRY | FGP_LOCK, 0);
-	if (!xa_is_value(folio))
-		return folio;
-	/*
-	 * But read a page back from swap if any of it is within i_size
-	 * (although in some cases this is just a waste of time).
-	 */
-	folio = NULL;
-	shmem_get_folio(inode, index, &folio, SGP_READ);
-	return folio;
-}
-
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -957,7 +936,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		goto whole_folios;
 
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
-	folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
+	folio = NULL;
+	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_FIND);
 	if (folio) {
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		folio_mark_dirty(folio);
@@ -971,14 +951,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio = NULL;
 	}
 
-	if (!same_folio)
-		folio = shmem_get_partial_folio(inode, lend >> PAGE_SHIFT);
-	if (folio) {
-		folio_mark_dirty(folio);
-		if (!truncate_inode_partial_folio(folio, lstart, lend))
-			end = folio->index;
-		folio_unlock(folio);
-		folio_put(folio);
+	if (!same_folio) {
+		folio = NULL;
+		shmem_get_folio(inode, lend >> PAGE_SHIFT, &folio, SGP_FIND);
+		if (folio) {
+			folio_mark_dirty(folio);
+			if (!truncate_inode_partial_folio(folio, lstart, lend))
+				end = folio->index;
+			folio_unlock(folio);
+			folio_put(folio);
+		}
 	}
 
 whole_folios:
@@ -1900,7 +1882,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		if (folio_test_uptodate(folio))
 			goto out;
 		/* fallocated folio */
-		if (sgp != SGP_READ)
+		if (sgp != SGP_READ && sgp != SGP_FIND)
 			goto clear;
 		folio_unlock(folio);
 		folio_put(folio);
@@ -1911,7 +1893,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	 * SGP_NOALLOC: fail on hole, with NULL folio, letting caller fail.
 	 */
 	*foliop = NULL;
-	if (sgp == SGP_READ)
+	if (sgp == SGP_READ || sgp == SGP_FIND)
 		return 0;
 	if (sgp == SGP_NOALLOC)
 		return -ENOENT;
-- 
2.39.0

