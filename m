Return-Path: <linux-nilfs+bounces-46-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B627FA2BA
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 15:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD07281792
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D418027;
	Mon, 27 Nov 2023 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlJmnaVh"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4701BC;
	Mon, 27 Nov 2023 06:31:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfaaa79766so21654435ad.3;
        Mon, 27 Nov 2023 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095489; x=1701700289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/T4u+44sUSgL7jMIOqkqh2vRw9RREOIECbOfKqfV6Q=;
        b=JlJmnaVhDJtwC5aYAOxjyqPsxqI719U3yl9x5xaC2n0QSoO+MVNvTp2OyP60ql31+t
         bPMLCFpTpHA5zgyc8t/nwOP6A1iFxb6GyNW6/XJ4axqzFuwXNePfLJXQdo6UTHeqWqPN
         gIMRg4QDyGf8jOh3q8RQh1OdZpDRW5+DNoejCmzSaVtAUhd9FF3xlc4CIKhYXP057UWB
         ITYdVubedInsQb7itxGK70omHTDz7e5AvCUFWANPBEwMJUUIhqZV9cnSUW+2iC39lEnt
         bZBXYedwmlzF7SlmQw6eWc50OXd9FE5PIij5HhX6WWLLc33nCeIdYGMBOs0KpFpRE/vB
         sUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095489; x=1701700289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/T4u+44sUSgL7jMIOqkqh2vRw9RREOIECbOfKqfV6Q=;
        b=aHlbfrDmgRc5slkWA+az1NAv1nBjGs2Qk0sSk7GQTfivz1bqzO0fzjQxqsNK5wmQzh
         ormzmtOnXSEgdHfsERvfVsauInDfCSH2rSS2BYe2hzLhvC/ycn8DsXJrHGgBL4+ExM6p
         +8i08FDx8Ft3Bk4eg2uPKxpsm5MiH4Jo5Oi+nGdB90a983F3kdEhV0Gpa5La52Ek81sU
         2Fk9FNFCuJo4Z2wJ2p8cW9CYy1/tP1fq7JVMywzLiYBGnThmhFaWz7sdtOb4kOGAHLFG
         wLBDrsSFcXhJIS9MWmHAkGbpO58PftQKcMBOOFVE8eMObnWBUHpZqjVyRs69jZW3D2C1
         lpoA==
X-Gm-Message-State: AOJu0YyydEsL5D9Lie0RQv0fjQOP5pZhsak5LVqrQo8zO+hDX909htMg
	X0BzOC/4SU3321FHXoZa+a7f8XgJ58U=
X-Google-Smtp-Source: AGHT+IEfeLVUq+ehWCvhqGM9q4W7M00oiClsnZ2lTmK6F//m+CHsj83PQYWmGYbYHdUEfX8OUHq1IQ==
X-Received: by 2002:a17:902:ce84:b0:1cf:b7ea:fea with SMTP id f4-20020a170902ce8400b001cfb7ea0feamr8629251plg.1.1701095488835;
        Mon, 27 Nov 2023 06:31:28 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:28 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] nilfs2: Convert nilfs_prepare_chunk() and nilfs_commit_chunk() to folios
Date: Mon, 27 Nov 2023 23:30:35 +0900
Message-Id: <20231127143036.2425-17-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

All callers now have a folio, so convert these two functions.
Saves one call to compound_head() in unlock_page().

[ konishi.ryusuke: resolved conflicts in nilfs_{set_link,delete_entry} ]

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index ff0a009a292f..bc846b904b68 100644
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
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
@@ -485,7 +484,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 got_it:
 	from = offset_in_folio(folio, de);
 	to = from + rec_len;
-	err = nilfs_prepare_chunk(&folio->page, from, to);
+	err = nilfs_prepare_chunk(folio, from, to);
 	if (err)
 		goto out_unlock;
 	if (de->inode) {
@@ -500,7 +499,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 	memcpy(de->name, name, namelen);
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
-	nilfs_commit_chunk(&folio->page, folio->mapping, from, to);
+	nilfs_commit_chunk(folio, folio->mapping, from, to);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	nilfs_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
@@ -542,12 +541,12 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct folio *folio)
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
 	return err;
@@ -568,7 +567,7 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	err = nilfs_prepare_chunk(&folio->page, 0, chunk_size);
+	err = nilfs_prepare_chunk(folio, 0, chunk_size);
 	if (unlikely(err)) {
 		folio_unlock(folio);
 		goto fail;
@@ -589,7 +588,7 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
 	memcpy(de->name, "..\0", 4);
 	nilfs_set_de_type(de, inode);
 	kunmap_local(kaddr);
-	nilfs_commit_chunk(&folio->page, mapping, 0, chunk_size);
+	nilfs_commit_chunk(folio, mapping, 0, chunk_size);
 fail:
 	folio_put(folio);
 	return err;
-- 
2.34.1


