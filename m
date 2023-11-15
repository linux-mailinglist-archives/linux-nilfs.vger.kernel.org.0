Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20B7E2B3E
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 Nov 2023 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjKFRjn (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 6 Nov 2023 12:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjKFRjW (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Mon, 6 Nov 2023 12:39:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7B171C;
        Mon,  6 Nov 2023 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ie7WsUDR1yLQZBGXEbEvfA+topeFIvEQy56tv9SnL9M=; b=gy3NKUMsQa1ZSOKuTyzxefZC1i
        LxXLQ5ZTVH20hrEbzNInFGAhs6jxB4JkdOdUmgYz4fXoOr1ScLEZUpVVTZdtGPHIVXlnp+4luNbxZ
        1LuK3q5aznQHYMNeHCgOPT9pRnLPh99XfYFsOw4pOacpUcgrGNuaX1ELrLdHUuL9DE6dYuLO+QLjE
        A9SJPebB3ZN7bduRpLp6AeKSC37S9FuSQUvin/jmIfXEPYAE4ibPBQfhpoPE/PcApwZGiGua6ThRu
        vTPSDsYy0e5zz5ZyW6EhX+eYCjp0RP72MU95M+sG1IWXpo9p2xjrV+Tf22KhayXLv0Ny7IbNOov03
        PG+ah0XQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r03Z4-007H7z-3l; Mon, 06 Nov 2023 17:39:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/35] nilfs2: Convert nilfs_segctor_complete_write to use folios
Date:   Mon,  6 Nov 2023 17:38:31 +0000
Message-Id: <20231106173903.1734114-4-willy@infradead.org>
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

Use the new folio APIs, saving five calls to compound_head().
This includes the last callers of nilfs_end_page_io(), so
remove that too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/segment.c | 49 +++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 730062e79bfc..2a058aad5c2d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1778,13 +1778,6 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 	folio_end_writeback(folio);
 }
 
-static void nilfs_end_page_io(struct page *page, int err)
-{
-	if (!page)
-		return;
-	nilfs_end_folio_io(page_folio(page), err);
-}
-
 static void nilfs_abort_logs(struct list_head *logs, int err)
 {
 	struct nilfs_segment_buffer *segbuf;
@@ -1867,7 +1860,7 @@ static void nilfs_set_next_segment(struct the_nilfs *nilfs,
 static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 {
 	struct nilfs_segment_buffer *segbuf;
-	struct page *bd_page = NULL, *fs_page = NULL;
+	struct folio *bd_folio = NULL, *fs_folio = NULL;
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int update_sr = false;
 
@@ -1878,21 +1871,21 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				    b_assoc_buffers) {
 			set_buffer_uptodate(bh);
 			clear_buffer_dirty(bh);
-			if (bh->b_page != bd_page) {
-				if (bd_page)
-					end_page_writeback(bd_page);
-				bd_page = bh->b_page;
+			if (bh->b_folio != bd_folio) {
+				if (bd_folio)
+					folio_end_writeback(bd_folio);
+				bd_folio = bh->b_folio;
 			}
 		}
 		/*
-		 * We assume that the buffers which belong to the same page
+		 * We assume that the buffers which belong to the same folio
 		 * continue over the buffer list.
-		 * Under this assumption, the last BHs of pages is
-		 * identifiable by the discontinuity of bh->b_page
-		 * (page != fs_page).
+		 * Under this assumption, the last BHs of folios is
+		 * identifiable by the discontinuity of bh->b_folio
+		 * (folio != fs_folio).
 		 *
 		 * For B-tree node blocks, however, this assumption is not
-		 * guaranteed.  The cleanup code of B-tree node pages needs
+		 * guaranteed.  The cleanup code of B-tree node folios needs
 		 * special care.
 		 */
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
@@ -1905,16 +1898,16 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 
 			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
-				if (bh->b_page != bd_page) {
-					end_page_writeback(bd_page);
-					bd_page = bh->b_page;
+				if (bh->b_folio != bd_folio) {
+					folio_end_writeback(bd_folio);
+					bd_folio = bh->b_folio;
 				}
 				update_sr = true;
 				break;
 			}
-			if (bh->b_page != fs_page) {
-				nilfs_end_page_io(fs_page, 0);
-				fs_page = bh->b_page;
+			if (bh->b_folio != fs_folio) {
+				nilfs_end_folio_io(fs_folio, 0);
+				fs_folio = bh->b_folio;
 			}
 		}
 
@@ -1928,13 +1921,13 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 		}
 	}
 	/*
-	 * Since pages may continue over multiple segment buffers,
-	 * end of the last page must be checked outside of the loop.
+	 * Since folios may continue over multiple segment buffers,
+	 * end of the last folio must be checked outside of the loop.
 	 */
-	if (bd_page)
-		end_page_writeback(bd_page);
+	if (bd_folio)
+		folio_end_writeback(bd_folio);
 
-	nilfs_end_page_io(fs_page, 0);
+	nilfs_end_folio_io(fs_folio, 0);
 
 	nilfs_drop_collected_inodes(&sci->sc_dirty_files);
 
-- 
2.42.0

