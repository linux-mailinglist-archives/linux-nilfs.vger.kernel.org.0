Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BC04F70AE
	for <lists+linux-nilfs@lfdr.de>; Thu,  7 Apr 2022 03:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbiDGBVx (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 6 Apr 2022 21:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbiDGBT7 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Wed, 6 Apr 2022 21:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4E186881;
        Wed,  6 Apr 2022 18:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF5661DA8;
        Thu,  7 Apr 2022 01:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4B5C385AB;
        Thu,  7 Apr 2022 01:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649294166;
        bh=whruZRtu8TnRYU/Ue0r/3oiLjyw3gayDtbgCrmdL6UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTwERsCYKx/b0KqDAPgLMR7M+YRyljjvhnjgrZV5KejFzBKhHB1ToT4xcdoct2Red
         GZRgDBd4+giuJzI5h4A/MNI7gkqjKyHpv1ARd7gFnzw1o5pCUBXCVfN9fAMdAXU8dy
         +hM2nm5XRhbUimbY4yr0fIKKnR4L4Ko6/E073xxOTLA4ZZDgRG2P1rX3aet3C0MkFI
         TMFgf77lXONsY3elki7pARXZ73yCUFP4ff6Q38zgaAQs1ameZoSZuvJQxNVlbVItxT
         QelYSJ+B2n8ANV03Ekzv7VX8yjJNvLcOgbFSMOr87AEaY5UKdz2Rb37KxFDvLsWqTk
         /yXkhyho+ay5A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com,
        syzbot+34ef28bb2aeb28724aa0@syzkaller.appspotmail.com,
        Hao Sun <sunhao.th@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-nilfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/17] nilfs2: fix lockdep warnings in page operations for btree nodes
Date:   Wed,  6 Apr 2022 21:15:20 -0400
Message-Id: <20220407011521.115014-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011521.115014-1-sashal@kernel.org>
References: <20220407011521.115014-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

[ Upstream commit e897be17a441fa637cd166fc3de1445131e57692 ]

Patch series "nilfs2 lockdep warning fixes".

The first two are to resolve the lockdep warning issue, and the last one
is the accompanying cleanup and low priority.

Based on your comment, this series solves the issue by separating inode
object as needed.  Since I was worried about the impact of the object
composition changes, I tested the series carefully not to cause
regressions especially for delicate functions such like disk space
reclamation and snapshots.

This patch (of 3):

If CONFIG_LOCKDEP is enabled, nilfs2 hits lockdep warnings at
inode_to_wb() during page/folio operations for btree nodes:

  WARNING: CPU: 0 PID: 6575 at include/linux/backing-dev.h:269 inode_to_wb include/linux/backing-dev.h:269 [inline]
  WARNING: CPU: 0 PID: 6575 at include/linux/backing-dev.h:269 folio_account_dirtied mm/page-writeback.c:2460 [inline]
  WARNING: CPU: 0 PID: 6575 at include/linux/backing-dev.h:269 __folio_mark_dirty+0xa7c/0xe30 mm/page-writeback.c:2509
  Modules linked in:
  ...
  RIP: 0010:inode_to_wb include/linux/backing-dev.h:269 [inline]
  RIP: 0010:folio_account_dirtied mm/page-writeback.c:2460 [inline]
  RIP: 0010:__folio_mark_dirty+0xa7c/0xe30 mm/page-writeback.c:2509
  ...
  Call Trace:
    __set_page_dirty include/linux/pagemap.h:834 [inline]
    mark_buffer_dirty+0x4e6/0x650 fs/buffer.c:1145
    nilfs_btree_propagate_p fs/nilfs2/btree.c:1889 [inline]
    nilfs_btree_propagate+0x4ae/0xea0 fs/nilfs2/btree.c:2085
    nilfs_bmap_propagate+0x73/0x170 fs/nilfs2/bmap.c:337
    nilfs_collect_dat_data+0x45/0xd0 fs/nilfs2/segment.c:625
    nilfs_segctor_apply_buffers+0x14a/0x470 fs/nilfs2/segment.c:1009
    nilfs_segctor_scan_file+0x47a/0x700 fs/nilfs2/segment.c:1048
    nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1224 [inline]
    nilfs_segctor_collect fs/nilfs2/segment.c:1494 [inline]
    nilfs_segctor_do_construct+0x14f3/0x6c60 fs/nilfs2/segment.c:2036
    nilfs_segctor_construct+0x7a7/0xb30 fs/nilfs2/segment.c:2372
    nilfs_segctor_thread_construct fs/nilfs2/segment.c:2480 [inline]
    nilfs_segctor_thread+0x3c3/0xf90 fs/nilfs2/segment.c:2563
    kthread+0x405/0x4f0 kernel/kthread.c:327
    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

This is because nilfs2 uses two page caches for each inode and
inode->i_mapping never points to one of them, the btree node cache.

This causes inode_to_wb(inode) to refer to a different page cache than
the caller page/folio operations such like __folio_start_writeback(),
__folio_end_writeback(), or __folio_mark_dirty() acquired the lock.

This patch resolves the issue by allocating and using an additional
inode to hold the page cache of btree nodes.  The inode is attached
one-to-one to the traditional nilfs2 inode if it requires a block
mapping with b-tree.  This setup change is in memory only and does not
affect the disk format.

Link: https://lkml.kernel.org/r/1647867427-30498-1-git-send-email-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/1647867427-30498-2-git-send-email-konishi.ryusuke@gmail.com
Link: https://lore.kernel.org/r/YXrYvIo8YRnAOJCj@casper.infradead.org
Link: https://lore.kernel.org/r/9a20b33d-b38f-b4a2-4742-c1eb5b8e4d6c@redhat.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com
Reported-by: syzbot+34ef28bb2aeb28724aa0@syzkaller.appspotmail.com
Reported-by: Hao Sun <sunhao.th@gmail.com>
Reported-by: David Hildenbrand <david@redhat.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/btnode.c  |  23 ++++++++--
 fs/nilfs2/btnode.h  |   1 +
 fs/nilfs2/btree.c   |  27 ++++++++----
 fs/nilfs2/gcinode.c |   7 +--
 fs/nilfs2/inode.c   | 104 ++++++++++++++++++++++++++++++++++++++------
 fs/nilfs2/mdt.c     |   7 +--
 fs/nilfs2/nilfs.h   |  14 +++---
 fs/nilfs2/page.c    |   7 ++-
 fs/nilfs2/segment.c |   9 ++--
 fs/nilfs2/super.c   |   5 +--
 10 files changed, 154 insertions(+), 50 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 4391fd3abd8f..e00e184b1261 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -20,6 +20,23 @@
 #include "page.h"
 #include "btnode.h"
 
+
+/**
+ * nilfs_init_btnc_inode - initialize B-tree node cache inode
+ * @btnc_inode: inode to be initialized
+ *
+ * nilfs_init_btnc_inode() sets up an inode for B-tree node cache.
+ */
+void nilfs_init_btnc_inode(struct inode *btnc_inode)
+{
+	struct nilfs_inode_info *ii = NILFS_I(btnc_inode);
+
+	btnc_inode->i_mode = S_IFREG;
+	ii->i_flags = 0;
+	memset(&ii->i_bmap_data, 0, sizeof(struct nilfs_bmap));
+	mapping_set_gfp_mask(btnc_inode->i_mapping, GFP_NOFS);
+}
+
 void nilfs_btnode_cache_clear(struct address_space *btnc)
 {
 	invalidate_mapping_pages(btnc, 0, -1);
@@ -29,7 +46,7 @@ void nilfs_btnode_cache_clear(struct address_space *btnc)
 struct buffer_head *
 nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 {
-	struct inode *inode = NILFS_BTNC_I(btnc);
+	struct inode *inode = btnc->host;
 	struct buffer_head *bh;
 
 	bh = nilfs_grab_buffer(inode, btnc, blocknr, BIT(BH_NILFS_Node));
@@ -57,7 +74,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 			      struct buffer_head **pbh, sector_t *submit_ptr)
 {
 	struct buffer_head *bh;
-	struct inode *inode = NILFS_BTNC_I(btnc);
+	struct inode *inode = btnc->host;
 	struct page *page;
 	int err;
 
@@ -157,7 +174,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 				    struct nilfs_btnode_chkey_ctxt *ctxt)
 {
 	struct buffer_head *obh, *nbh;
-	struct inode *inode = NILFS_BTNC_I(btnc);
+	struct inode *inode = btnc->host;
 	__u64 oldkey = ctxt->oldkey, newkey = ctxt->newkey;
 	int err;
 
diff --git a/fs/nilfs2/btnode.h b/fs/nilfs2/btnode.h
index 0f88dbc9bcb3..05ab64d354dc 100644
--- a/fs/nilfs2/btnode.h
+++ b/fs/nilfs2/btnode.h
@@ -30,6 +30,7 @@ struct nilfs_btnode_chkey_ctxt {
 	struct buffer_head *newbh;
 };
 
+void nilfs_init_btnc_inode(struct inode *btnc_inode);
 void nilfs_btnode_cache_clear(struct address_space *);
 struct buffer_head *nilfs_btnode_create_block(struct address_space *btnc,
 					      __u64 blocknr);
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 23e043eca237..919d1238ce45 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -58,7 +58,8 @@ static void nilfs_btree_free_path(struct nilfs_btree_path *path)
 static int nilfs_btree_get_new_block(const struct nilfs_bmap *btree,
 				     __u64 ptr, struct buffer_head **bhp)
 {
-	struct address_space *btnc = &NILFS_BMAP_I(btree)->i_btnode_cache;
+	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
+	struct address_space *btnc = btnc_inode->i_mapping;
 	struct buffer_head *bh;
 
 	bh = nilfs_btnode_create_block(btnc, ptr);
@@ -470,7 +471,8 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
 				   struct buffer_head **bhp,
 				   const struct nilfs_btree_readahead_info *ra)
 {
-	struct address_space *btnc = &NILFS_BMAP_I(btree)->i_btnode_cache;
+	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
+	struct address_space *btnc = btnc_inode->i_mapping;
 	struct buffer_head *bh, *ra_bh;
 	sector_t submit_ptr = 0;
 	int ret;
@@ -1742,6 +1744,10 @@ nilfs_btree_prepare_convert_and_insert(struct nilfs_bmap *btree, __u64 key,
 		dat = nilfs_bmap_get_dat(btree);
 	}
 
+	ret = nilfs_attach_btree_node_cache(&NILFS_BMAP_I(btree)->vfs_inode);
+	if (ret < 0)
+		return ret;
+
 	ret = nilfs_bmap_prepare_alloc_ptr(btree, dreq, dat);
 	if (ret < 0)
 		return ret;
@@ -1914,7 +1920,7 @@ static int nilfs_btree_prepare_update_v(struct nilfs_bmap *btree,
 		path[level].bp_ctxt.newkey = path[level].bp_newreq.bpr_ptr;
 		path[level].bp_ctxt.bh = path[level].bp_bh;
 		ret = nilfs_btnode_prepare_change_key(
-			&NILFS_BMAP_I(btree)->i_btnode_cache,
+			NILFS_BMAP_I(btree)->i_assoc_inode->i_mapping,
 			&path[level].bp_ctxt);
 		if (ret < 0) {
 			nilfs_dat_abort_update(dat,
@@ -1940,7 +1946,7 @@ static void nilfs_btree_commit_update_v(struct nilfs_bmap *btree,
 
 	if (buffer_nilfs_node(path[level].bp_bh)) {
 		nilfs_btnode_commit_change_key(
-			&NILFS_BMAP_I(btree)->i_btnode_cache,
+			NILFS_BMAP_I(btree)->i_assoc_inode->i_mapping,
 			&path[level].bp_ctxt);
 		path[level].bp_bh = path[level].bp_ctxt.bh;
 	}
@@ -1959,7 +1965,7 @@ static void nilfs_btree_abort_update_v(struct nilfs_bmap *btree,
 			       &path[level].bp_newreq.bpr_req);
 	if (buffer_nilfs_node(path[level].bp_bh))
 		nilfs_btnode_abort_change_key(
-			&NILFS_BMAP_I(btree)->i_btnode_cache,
+			NILFS_BMAP_I(btree)->i_assoc_inode->i_mapping,
 			&path[level].bp_ctxt);
 }
 
@@ -2135,7 +2141,8 @@ static void nilfs_btree_add_dirty_buffer(struct nilfs_bmap *btree,
 static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 					     struct list_head *listp)
 {
-	struct address_space *btcache = &NILFS_BMAP_I(btree)->i_btnode_cache;
+	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
+	struct address_space *btcache = btnc_inode->i_mapping;
 	struct list_head lists[NILFS_BTREE_LEVEL_MAX];
 	struct pagevec pvec;
 	struct buffer_head *bh, *head;
@@ -2189,12 +2196,12 @@ static int nilfs_btree_assign_p(struct nilfs_bmap *btree,
 		path[level].bp_ctxt.newkey = blocknr;
 		path[level].bp_ctxt.bh = *bh;
 		ret = nilfs_btnode_prepare_change_key(
-			&NILFS_BMAP_I(btree)->i_btnode_cache,
+			NILFS_BMAP_I(btree)->i_assoc_inode->i_mapping,
 			&path[level].bp_ctxt);
 		if (ret < 0)
 			return ret;
 		nilfs_btnode_commit_change_key(
-			&NILFS_BMAP_I(btree)->i_btnode_cache,
+			NILFS_BMAP_I(btree)->i_assoc_inode->i_mapping,
 			&path[level].bp_ctxt);
 		*bh = path[level].bp_ctxt.bh;
 	}
@@ -2399,6 +2406,10 @@ int nilfs_btree_init(struct nilfs_bmap *bmap)
 
 	if (nilfs_btree_root_broken(nilfs_btree_get_root(bmap), bmap->b_inode))
 		ret = -EIO;
+	else
+		ret = nilfs_attach_btree_node_cache(
+			&NILFS_BMAP_I(bmap)->vfs_inode);
+
 	return ret;
 }
 
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index aa3c328ee189..114774ac2185 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -126,9 +126,10 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 int nilfs_gccache_submit_read_node(struct inode *inode, sector_t pbn,
 				   __u64 vbn, struct buffer_head **out_bh)
 {
+	struct inode *btnc_inode = NILFS_I(inode)->i_assoc_inode;
 	int ret;
 
-	ret = nilfs_btnode_submit_block(&NILFS_I(inode)->i_btnode_cache,
+	ret = nilfs_btnode_submit_block(btnc_inode->i_mapping,
 					vbn ? : pbn, pbn, REQ_OP_READ, 0,
 					out_bh, &pbn);
 	if (ret == -EEXIST) /* internal code (cache hit) */
@@ -170,7 +171,7 @@ int nilfs_init_gcinode(struct inode *inode)
 	ii->i_flags = 0;
 	nilfs_bmap_init_gc(ii->i_bmap);
 
-	return 0;
+	return nilfs_attach_btree_node_cache(inode);
 }
 
 /**
@@ -185,7 +186,7 @@ void nilfs_remove_all_gcinodes(struct the_nilfs *nilfs)
 		ii = list_first_entry(head, struct nilfs_inode_info, i_dirty);
 		list_del_init(&ii->i_dirty);
 		truncate_inode_pages(&ii->vfs_inode.i_data, 0);
-		nilfs_btnode_cache_clear(&ii->i_btnode_cache);
+		nilfs_btnode_cache_clear(ii->i_assoc_inode->i_mapping);
 		iput(&ii->vfs_inode);
 	}
 }
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 671085512e0f..b0a0822e371c 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -28,12 +28,14 @@
  * @cno: checkpoint number
  * @root: pointer on NILFS root object (mounted checkpoint)
  * @for_gc: inode for GC flag
+ * @for_btnc: inode for B-tree node cache flag
  */
 struct nilfs_iget_args {
 	u64 ino;
 	__u64 cno;
 	struct nilfs_root *root;
-	int for_gc;
+	bool for_gc;
+	bool for_btnc;
 };
 
 static int nilfs_iget_test(struct inode *inode, void *opaque);
@@ -322,7 +324,8 @@ static int nilfs_insert_inode_locked(struct inode *inode,
 				     unsigned long ino)
 {
 	struct nilfs_iget_args args = {
-		.ino = ino, .root = root, .cno = 0, .for_gc = 0
+		.ino = ino, .root = root, .cno = 0, .for_gc = false,
+		.for_btnc = false
 	};
 
 	return insert_inode_locked4(inode, ino, nilfs_iget_test, &args);
@@ -534,6 +537,13 @@ static int nilfs_iget_test(struct inode *inode, void *opaque)
 		return 0;
 
 	ii = NILFS_I(inode);
+	if (test_bit(NILFS_I_BTNC, &ii->i_state)) {
+		if (!args->for_btnc)
+			return 0;
+	} else if (args->for_btnc) {
+		return 0;
+	}
+
 	if (!test_bit(NILFS_I_GCINODE, &ii->i_state))
 		return !args->for_gc;
 
@@ -545,15 +555,15 @@ static int nilfs_iget_set(struct inode *inode, void *opaque)
 	struct nilfs_iget_args *args = opaque;
 
 	inode->i_ino = args->ino;
-	if (args->for_gc) {
+	NILFS_I(inode)->i_cno = args->cno;
+	NILFS_I(inode)->i_root = args->root;
+	if (args->root && args->ino == NILFS_ROOT_INO)
+		nilfs_get_root(args->root);
+
+	if (args->for_gc)
 		NILFS_I(inode)->i_state = BIT(NILFS_I_GCINODE);
-		NILFS_I(inode)->i_cno = args->cno;
-		NILFS_I(inode)->i_root = NULL;
-	} else {
-		if (args->root && args->ino == NILFS_ROOT_INO)
-			nilfs_get_root(args->root);
-		NILFS_I(inode)->i_root = args->root;
-	}
+	if (args->for_btnc)
+		NILFS_I(inode)->i_state |= BIT(NILFS_I_BTNC);
 	return 0;
 }
 
@@ -561,7 +571,8 @@ struct inode *nilfs_ilookup(struct super_block *sb, struct nilfs_root *root,
 			    unsigned long ino)
 {
 	struct nilfs_iget_args args = {
-		.ino = ino, .root = root, .cno = 0, .for_gc = 0
+		.ino = ino, .root = root, .cno = 0, .for_gc = false,
+		.for_btnc = false
 	};
 
 	return ilookup5(sb, ino, nilfs_iget_test, &args);
@@ -571,7 +582,8 @@ struct inode *nilfs_iget_locked(struct super_block *sb, struct nilfs_root *root,
 				unsigned long ino)
 {
 	struct nilfs_iget_args args = {
-		.ino = ino, .root = root, .cno = 0, .for_gc = 0
+		.ino = ino, .root = root, .cno = 0, .for_gc = false,
+		.for_btnc = false
 	};
 
 	return iget5_locked(sb, ino, nilfs_iget_test, nilfs_iget_set, &args);
@@ -602,7 +614,8 @@ struct inode *nilfs_iget_for_gc(struct super_block *sb, unsigned long ino,
 				__u64 cno)
 {
 	struct nilfs_iget_args args = {
-		.ino = ino, .root = NULL, .cno = cno, .for_gc = 1
+		.ino = ino, .root = NULL, .cno = cno, .for_gc = true,
+		.for_btnc = false
 	};
 	struct inode *inode;
 	int err;
@@ -622,6 +635,68 @@ struct inode *nilfs_iget_for_gc(struct super_block *sb, unsigned long ino,
 	return inode;
 }
 
+/**
+ * nilfs_attach_btree_node_cache - attach a B-tree node cache to the inode
+ * @inode: inode object
+ *
+ * nilfs_attach_btree_node_cache() attaches a B-tree node cache to @inode,
+ * or does nothing if the inode already has it.  This function allocates
+ * an additional inode to maintain page cache of B-tree nodes one-on-one.
+ *
+ * Return Value: On success, 0 is returned. On errors, one of the following
+ * negative error code is returned.
+ *
+ * %-ENOMEM - Insufficient memory available.
+ */
+int nilfs_attach_btree_node_cache(struct inode *inode)
+{
+	struct nilfs_inode_info *ii = NILFS_I(inode);
+	struct inode *btnc_inode;
+	struct nilfs_iget_args args;
+
+	if (ii->i_assoc_inode)
+		return 0;
+
+	args.ino = inode->i_ino;
+	args.root = ii->i_root;
+	args.cno = ii->i_cno;
+	args.for_gc = test_bit(NILFS_I_GCINODE, &ii->i_state) != 0;
+	args.for_btnc = true;
+
+	btnc_inode = iget5_locked(inode->i_sb, inode->i_ino, nilfs_iget_test,
+				  nilfs_iget_set, &args);
+	if (unlikely(!btnc_inode))
+		return -ENOMEM;
+	if (btnc_inode->i_state & I_NEW) {
+		nilfs_init_btnc_inode(btnc_inode);
+		unlock_new_inode(btnc_inode);
+	}
+	NILFS_I(btnc_inode)->i_assoc_inode = inode;
+	NILFS_I(btnc_inode)->i_bmap = ii->i_bmap;
+	ii->i_assoc_inode = btnc_inode;
+
+	return 0;
+}
+
+/**
+ * nilfs_detach_btree_node_cache - detach the B-tree node cache from the inode
+ * @inode: inode object
+ *
+ * nilfs_detach_btree_node_cache() detaches the B-tree node cache and its
+ * holder inode bound to @inode, or does nothing if @inode doesn't have it.
+ */
+void nilfs_detach_btree_node_cache(struct inode *inode)
+{
+	struct nilfs_inode_info *ii = NILFS_I(inode);
+	struct inode *btnc_inode = ii->i_assoc_inode;
+
+	if (btnc_inode) {
+		NILFS_I(btnc_inode)->i_assoc_inode = NULL;
+		ii->i_assoc_inode = NULL;
+		iput(btnc_inode);
+	}
+}
+
 void nilfs_write_inode_common(struct inode *inode,
 			      struct nilfs_inode *raw_inode, int has_bmap)
 {
@@ -770,7 +845,8 @@ static void nilfs_clear_inode(struct inode *inode)
 	if (test_bit(NILFS_I_BMAP, &ii->i_state))
 		nilfs_bmap_clear(ii->i_bmap);
 
-	nilfs_btnode_cache_clear(&ii->i_btnode_cache);
+	if (!test_bit(NILFS_I_BTNC, &ii->i_state))
+		nilfs_detach_btree_node_cache(inode);
 
 	if (ii->i_root && inode->i_ino == NILFS_ROOT_INO)
 		nilfs_put_root(ii->i_root);
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 700870a92bc4..3a1200220b97 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -531,7 +531,7 @@ int nilfs_mdt_save_to_shadow_map(struct inode *inode)
 		goto out;
 
 	ret = nilfs_copy_dirty_pages(&shadow->frozen_btnodes,
-				     &ii->i_btnode_cache);
+				     ii->i_assoc_inode->i_mapping);
 	if (ret)
 		goto out;
 
@@ -622,8 +622,9 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
 	nilfs_clear_dirty_pages(inode->i_mapping, true);
 	nilfs_copy_back_pages(inode->i_mapping, &shadow->frozen_data);
 
-	nilfs_clear_dirty_pages(&ii->i_btnode_cache, true);
-	nilfs_copy_back_pages(&ii->i_btnode_cache, &shadow->frozen_btnodes);
+	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true);
+	nilfs_copy_back_pages(ii->i_assoc_inode->i_mapping,
+			      &shadow->frozen_btnodes);
 
 	nilfs_bmap_restore(ii->i_bmap, &shadow->bmap_store);
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 42395ba52da6..3b646d377237 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -28,7 +28,7 @@
  * @i_xattr: <TODO>
  * @i_dir_start_lookup: page index of last successful search
  * @i_cno: checkpoint number for GC inode
- * @i_btnode_cache: cached pages of b-tree nodes
+ * @i_assoc_inode: associated inode (B-tree node cache holder or back pointer)
  * @i_dirty: list for connecting dirty files
  * @xattr_sem: semaphore for extended attributes processing
  * @i_bh: buffer contains disk inode
@@ -43,7 +43,7 @@ struct nilfs_inode_info {
 	__u64 i_xattr;	/* sector_t ??? */
 	__u32 i_dir_start_lookup;
 	__u64 i_cno;		/* check point number for GC inode */
-	struct address_space i_btnode_cache;
+	struct inode *i_assoc_inode;
 	struct list_head i_dirty;	/* List for connecting dirty files */
 
 #ifdef CONFIG_NILFS_XATTR
@@ -75,13 +75,6 @@ NILFS_BMAP_I(const struct nilfs_bmap *bmap)
 	return container_of(bmap, struct nilfs_inode_info, i_bmap_data);
 }
 
-static inline struct inode *NILFS_BTNC_I(struct address_space *btnc)
-{
-	struct nilfs_inode_info *ii =
-		container_of(btnc, struct nilfs_inode_info, i_btnode_cache);
-	return &ii->vfs_inode;
-}
-
 /*
  * Dynamic state flags of NILFS on-memory inode (i_state)
  */
@@ -98,6 +91,7 @@ enum {
 	NILFS_I_INODE_SYNC,		/* dsync is not allowed for inode */
 	NILFS_I_BMAP,			/* has bmap and btnode_cache */
 	NILFS_I_GCINODE,		/* inode for GC, on memory only */
+	NILFS_I_BTNC,			/* inode for btree node cache */
 };
 
 /*
@@ -264,6 +258,8 @@ struct inode *nilfs_iget(struct super_block *sb, struct nilfs_root *root,
 			 unsigned long ino);
 extern struct inode *nilfs_iget_for_gc(struct super_block *sb,
 				       unsigned long ino, __u64 cno);
+int nilfs_attach_btree_node_cache(struct inode *inode);
+void nilfs_detach_btree_node_cache(struct inode *inode);
 extern void nilfs_update_inode(struct inode *, struct buffer_head *, int);
 extern void nilfs_truncate(struct inode *);
 extern void nilfs_evict_inode(struct inode *);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index d7fc8d369d89..98d21ad9a073 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -450,10 +450,9 @@ void nilfs_mapping_init(struct address_space *mapping, struct inode *inode)
 /*
  * NILFS2 needs clear_page_dirty() in the following two cases:
  *
- * 1) For B-tree node pages and data pages of the dat/gcdat, NILFS2 clears
- *    page dirty flags when it copies back pages from the shadow cache
- *    (gcdat->{i_mapping,i_btnode_cache}) to its original cache
- *    (dat->{i_mapping,i_btnode_cache}).
+ * 1) For B-tree node pages and data pages of DAT file, NILFS2 clears dirty
+ *    flag of pages when it copies back pages from shadow cache to the
+ *    original cache.
  *
  * 2) Some B-tree operations like insertion or deletion may dispose buffers
  *    in dirty state, and this needs to cancel the dirty state of their pages.
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 91b58c897f92..eb3ac7619088 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -738,15 +738,18 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 					    struct list_head *listp)
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
-	struct address_space *mapping = &ii->i_btnode_cache;
+	struct inode *btnc_inode = ii->i_assoc_inode;
 	struct pagevec pvec;
 	struct buffer_head *bh, *head;
 	unsigned int i;
 	pgoff_t index = 0;
 
+	if (!btnc_inode)
+		return;
+
 	pagevec_init(&pvec);
 
-	while (pagevec_lookup_tag(&pvec, mapping, &index,
+	while (pagevec_lookup_tag(&pvec, btnc_inode->i_mapping, &index,
 					PAGECACHE_TAG_DIRTY)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			bh = head = page_buffers(pvec.pages[i]);
@@ -2410,7 +2413,7 @@ nilfs_remove_written_gcinodes(struct the_nilfs *nilfs, struct list_head *head)
 			continue;
 		list_del_init(&ii->i_dirty);
 		truncate_inode_pages(&ii->vfs_inode.i_data, 0);
-		nilfs_btnode_cache_clear(&ii->i_btnode_cache);
+		nilfs_btnode_cache_clear(ii->i_assoc_inode->i_mapping);
 		iput(&ii->vfs_inode);
 	}
 }
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 5729ee86da9a..b5bc9f0c6a40 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -151,7 +151,8 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
 	ii->i_bh = NULL;
 	ii->i_state = 0;
 	ii->i_cno = 0;
-	nilfs_mapping_init(&ii->i_btnode_cache, &ii->vfs_inode);
+	ii->i_assoc_inode = NULL;
+	ii->i_bmap = &ii->i_bmap_data;
 	return &ii->vfs_inode;
 }
 
@@ -1375,8 +1376,6 @@ static void nilfs_inode_init_once(void *obj)
 #ifdef CONFIG_NILFS_XATTR
 	init_rwsem(&ii->xattr_sem);
 #endif
-	address_space_init_once(&ii->i_btnode_cache);
-	ii->i_bmap = &ii->i_bmap_data;
 	inode_init_once(&ii->vfs_inode);
 }
 
-- 
2.35.1

