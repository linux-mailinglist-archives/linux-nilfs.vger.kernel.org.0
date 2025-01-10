Return-Path: <linux-nilfs+bounces-644-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A836CA0847C
	for <lists+linux-nilfs@lfdr.de>; Fri, 10 Jan 2025 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3731E3A8414
	for <lists+linux-nilfs@lfdr.de>; Fri, 10 Jan 2025 01:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392F200BA8;
	Fri, 10 Jan 2025 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZkHKYSE"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C51E3762;
	Fri, 10 Jan 2025 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471248; cv=none; b=LKeehINnM+y55VahV16IPxFufSOZ4noBFERFjOILcwJbTnR0s07xKoDMAOBKit6oP9TKYmrXveHR5nKUcv1c5jJ6oSMxtnpcG6zk3Vtjk4r1p2PnLLcYhICKXR18++u+pG/so8YQJgzMLegKJUQ1alk03BsC0/Lpw+XbAK/AbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471248; c=relaxed/simple;
	bh=B7AOjlEN4f9PenMzS3QG2jk13yRYtpv+NUivoZZo+80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK3vmIAraefPGubN4heAcpemjd3rVJES90RVLcceIPVCmiSlDPOoLkZrnoCAzFdRYo3vCB/iJ1p2ObK16KD0pGuhoApXZW/geVjzN5gVwNKbLkY5aDFvyDhbsOqALQzUPIHhgf0ciP4yKj0FNSC3ZD8uJvjXbfEtFJ1N+j4o9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZkHKYSE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163b0c09afso26008415ad.0;
        Thu, 09 Jan 2025 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736471245; x=1737076045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqxJb771NpgFVcAuX7/lIQSQ+/075Ocecyr1eSiiqeo=;
        b=AZkHKYSE9TBIaJrCPZl7AbaQ7rqI7MgQEPhR+vFeZ23Dc7zi+xVyivD8uI/kHrDZtQ
         hVVGTZl1Sc6atfxWP3I5+OkrW6xuW5URvNApX5LqM2fTkYp7PaXB/ajrQE9gN27cFlXm
         NTeqZrqJok1qAuwcjbQHaxIYZHzBlI68uhRwYdVUaSj+xwi/8+20koRGOMxYEdfZxSe1
         8QoS5ukXYCKRIkwYTyHCvgxO+iRcKrq+iLu0qJKDK2qBHcVc3vpHZQXtzvhZ89WU2asS
         kXziL6ZVh3SkAam5QhxKq3qd86QImCUbHJRAoquyq1y1YToZbqDZqegWC1GdMy8RTrRf
         tzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736471245; x=1737076045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqxJb771NpgFVcAuX7/lIQSQ+/075Ocecyr1eSiiqeo=;
        b=SMnqsc2hH+uRz4gJ1Ypwy6n5RhqgnfC1pj9bzB+6sTPI5eCYSQ1KI1kDCpC8mWYBF8
         4xTsS49CWeothz3qpREJiZmH8zfHewkKYtoExBDzsKIzGQUiztXTh8Mb0D9+81I4DMsU
         lrnFMtFB5n/Wvjov8txDEkjIKgIjigy/M3DpkN0Htp0Y2kPnevY7gOOjA2duVZ6cuMsi
         iAcvfeAzMDAktd3IWmEVq/jmmSZ6dKm+p6tnWAvX6gwmfIVakkVUkk0R7xaFiTDGmeuo
         Me/FGRd9AhrQYFg6Nx2cohtPFbZm7Pevp5C2ERTeMZhuWShAWcSvNbET0nvJWU7v4RCo
         vgFw==
X-Forwarded-Encrypted: i=1; AJvYcCV71+2sPAUSrLSFMM4pRk9XDQYW5+0FPEciRlNguS71F6CrlA7C6WCW4xsll/G7vKn/wOYxoo01WrmfZUM=@vger.kernel.org, AJvYcCWt18d0IveyGMGoPypJ6/O8kogPaItGe3vzaFX5NPo0j6llIiMehOICjh7hJg/rsakcNdbBy32SzOZvNEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WYX9BGQc6JwFT0CW0ieX91Ah9ljDPUV7ut6wvgbo+HLSFNcf
	+W05ZxXrVY3COwvIVF4Zu1ud2E6XL9UUGAvNbuKZD52e3ISoCllI
X-Gm-Gg: ASbGncvbiXT7T03mNDUg71JX+qgEZ4aUSBcaONoMxT2ZnHIwPJQOXnzXrjpbxqMQj1/
	Zg/5Kr0qEgkp8rDDuPx/3pLtNLiO1xGFtQqyFwhQn4SM6xqLp046dLjyrCnjamkEU0t2WwE7Tc/
	pEKTWAC7keyOxmqRC8XrOfD++WhtzYmjmoJD0vPenxQsOnEdiA9YJ1ohTaY9Gis5AYjoc2YZLBa
	vc6MgolGC3crkFnQHqzCctWOlO2s/25KurVEu1cePMGGRI7xV3bvWeFr/1dARwJV8dyqDIyolcn
	ONOD8W7UXUUApCUUMnJJTPdAZHuL
X-Google-Smtp-Source: AGHT+IGvWz4r4oQJQ3t5hGLJVlBcF9b8YKQQN7fvXQtjPQMg92tygbx/OhMxIJUxPj5DSmxAOBVsDg==
X-Received: by 2002:a05:6a20:c799:b0:1e1:72ce:fefc with SMTP id adf61e73a8af0-1e88d11cb13mr16671379637.22.1736471244607;
        Thu, 09 Jan 2025 17:07:24 -0800 (PST)
Received: from carrot.. (i114-186-237-30.s41.a014.ap.plala.or.jp. [114.186.237.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31ddb9e4b4sm1862834a12.70.2025.01.09.17.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 17:07:23 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Brian G ." <gissf1@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -v2 6/7] nilfs2: add missing return value kernel-doc descriptions
Date: Fri, 10 Jan 2025 10:01:49 +0900
Message-ID: <20250110010530.21872-7-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110010530.21872-1-konishi.ryusuke@gmail.com>
References: <CAKFNMoksY6f5NtVwmn6K0K2QKTvdjq+s0FbdgLvHzS3YueKqYQ@mail.gmail.com>
 <20250110010530.21872-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a number of kernel-doc comments for functions that are missing
return values, which also causes a number of warnings when the kernel-doc
script is run with the "-Wall" option.

Fix this issue by adding proper return value descriptions, and improve
code maintainability.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/alloc.c     | 67 +++++++++++++++++++++++++++++++++++++++++--
 fs/nilfs2/alloc.h     |  2 ++
 fs/nilfs2/cpfile.c    |  2 ++
 fs/nilfs2/dat.c       |  2 ++
 fs/nilfs2/ifile.c     |  2 ++
 fs/nilfs2/inode.c     |  4 +++
 fs/nilfs2/mdt.c       |  4 +++
 fs/nilfs2/page.c      |  8 +++---
 fs/nilfs2/recovery.c  | 30 +++++++++++++++++++
 fs/nilfs2/segment.c   |  8 ++++++
 fs/nilfs2/sufile.c    |  8 ++++++
 fs/nilfs2/sufile.h    |  6 ++++
 fs/nilfs2/super.c     | 10 ++++++-
 fs/nilfs2/the_nilfs.c | 14 +++++++++
 14 files changed, 160 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index ba3e1f591f36..6b506995818d 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -21,6 +21,8 @@
  * nilfs_palloc_groups_per_desc_block - get the number of groups that a group
  *					descriptor block can maintain
  * @inode: inode of metadata file using this allocator
+ *
+ * Return: Number of groups that a group descriptor block can maintain.
  */
 static inline unsigned long
 nilfs_palloc_groups_per_desc_block(const struct inode *inode)
@@ -32,6 +34,8 @@ nilfs_palloc_groups_per_desc_block(const struct inode *inode)
 /**
  * nilfs_palloc_groups_count - get maximum number of groups
  * @inode: inode of metadata file using this allocator
+ *
+ * Return: Maximum number of groups.
  */
 static inline unsigned long
 nilfs_palloc_groups_count(const struct inode *inode)
@@ -43,6 +47,8 @@ nilfs_palloc_groups_count(const struct inode *inode)
  * nilfs_palloc_init_blockgroup - initialize private variables for allocator
  * @inode: inode of metadata file using this allocator
  * @entry_size: size of the persistent object
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_palloc_init_blockgroup(struct inode *inode, unsigned int entry_size)
 {
@@ -78,6 +84,9 @@ int nilfs_palloc_init_blockgroup(struct inode *inode, unsigned int entry_size)
  * @inode: inode of metadata file using this allocator
  * @nr: serial number of the entry (e.g. inode number)
  * @offset: pointer to store offset number in the group
+ *
+ * Return: Number of the group that contains the entry with the index
+ * specified by @nr.
  */
 static unsigned long nilfs_palloc_group(const struct inode *inode, __u64 nr,
 					unsigned long *offset)
@@ -93,8 +102,8 @@ static unsigned long nilfs_palloc_group(const struct inode *inode, __u64 nr,
  * @inode: inode of metadata file using this allocator
  * @group: group number
  *
- * nilfs_palloc_desc_blkoff() returns block offset of the descriptor
- * block which contains a descriptor of the specified group.
+ * Return: Index number in the metadata file of the descriptor block of
+ * the group specified by @group.
  */
 static unsigned long
 nilfs_palloc_desc_blkoff(const struct inode *inode, unsigned long group)
@@ -111,6 +120,9 @@ nilfs_palloc_desc_blkoff(const struct inode *inode, unsigned long group)
  *
  * nilfs_palloc_bitmap_blkoff() returns block offset of the bitmap
  * block used to allocate/deallocate entries in the specified group.
+ *
+ * Return: Index number in the metadata file of the bitmap block of
+ * the group specified by @group.
  */
 static unsigned long
 nilfs_palloc_bitmap_blkoff(const struct inode *inode, unsigned long group)
@@ -125,6 +137,8 @@ nilfs_palloc_bitmap_blkoff(const struct inode *inode, unsigned long group)
  * nilfs_palloc_group_desc_nfrees - get the number of free entries in a group
  * @desc: pointer to descriptor structure for the group
  * @lock: spin lock protecting @desc
+ *
+ * Return: Number of free entries written in the group descriptor @desc.
  */
 static unsigned long
 nilfs_palloc_group_desc_nfrees(const struct nilfs_palloc_group_desc *desc,
@@ -143,6 +157,9 @@ nilfs_palloc_group_desc_nfrees(const struct nilfs_palloc_group_desc *desc,
  * @desc: pointer to descriptor structure for the group
  * @lock: spin lock protecting @desc
  * @n: delta to be added
+ *
+ * Return: Number of free entries after adjusting the group descriptor
+ * @desc.
  */
 static u32
 nilfs_palloc_group_desc_add_entries(struct nilfs_palloc_group_desc *desc,
@@ -161,6 +178,9 @@ nilfs_palloc_group_desc_add_entries(struct nilfs_palloc_group_desc *desc,
  * nilfs_palloc_entry_blkoff - get block offset of an entry block
  * @inode: inode of metadata file using this allocator
  * @nr: serial number of the entry (e.g. inode number)
+ *
+ * Return: Index number in the metadata file of the block containing
+ * the entry specified by @nr.
  */
 static unsigned long
 nilfs_palloc_entry_blkoff(const struct inode *inode, __u64 nr)
@@ -238,6 +258,12 @@ static int nilfs_palloc_get_block(struct inode *inode, unsigned long blkoff,
  * @blkoff: block offset
  * @prev: nilfs_bh_assoc struct of the last used buffer
  * @lock: spin lock protecting @prev
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EIO	- I/O error (including metadata corruption).
+ * * %-ENOENT	- Non-existent block.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_palloc_delete_block(struct inode *inode, unsigned long blkoff,
 				     struct nilfs_bh_assoc *prev,
@@ -258,6 +284,8 @@ static int nilfs_palloc_delete_block(struct inode *inode, unsigned long blkoff,
  * @group: group number
  * @create: create flag
  * @bhp: pointer to store the resultant buffer head
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_palloc_get_desc_block(struct inode *inode,
 				       unsigned long group,
@@ -277,6 +305,8 @@ static int nilfs_palloc_get_desc_block(struct inode *inode,
  * @group: group number
  * @create: create flag
  * @bhp: pointer to store the resultant buffer head
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_palloc_get_bitmap_block(struct inode *inode,
 					 unsigned long group,
@@ -294,6 +324,8 @@ static int nilfs_palloc_get_bitmap_block(struct inode *inode,
  * nilfs_palloc_delete_bitmap_block - delete a bitmap block
  * @inode: inode of metadata file using this allocator
  * @group: group number
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_palloc_delete_bitmap_block(struct inode *inode,
 					    unsigned long group)
@@ -312,6 +344,8 @@ static int nilfs_palloc_delete_bitmap_block(struct inode *inode,
  * @nr: serial number of the entry (e.g. inode number)
  * @create: create flag
  * @bhp: pointer to store the resultant buffer head
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_palloc_get_entry_block(struct inode *inode, __u64 nr,
 				 int create, struct buffer_head **bhp)
@@ -328,6 +362,8 @@ int nilfs_palloc_get_entry_block(struct inode *inode, __u64 nr,
  * nilfs_palloc_delete_entry_block - delete an entry block
  * @inode: inode of metadata file using this allocator
  * @nr: serial number of the entry
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_palloc_delete_entry_block(struct inode *inode, __u64 nr)
 {
@@ -397,6 +433,9 @@ size_t nilfs_palloc_entry_offset(const struct inode *inode, __u64 nr,
  * @bsize: size in bits
  * @lock: spin lock protecting @bitmap
  * @wrap: whether to wrap around
+ *
+ * Return: Offset number within the group of the found free entry, or
+ * %-ENOSPC if not found.
  */
 static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 					    unsigned long target,
@@ -438,6 +477,9 @@ static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
  * @inode: inode of metadata file using this allocator
  * @curr: current group number
  * @max: maximum number of groups
+ *
+ * Return: Number of remaining descriptors (= groups) managed by the descriptor
+ * block.
  */
 static unsigned long
 nilfs_palloc_rest_groups_in_desc_block(const struct inode *inode,
@@ -453,6 +495,8 @@ nilfs_palloc_rest_groups_in_desc_block(const struct inode *inode,
  * nilfs_palloc_count_desc_blocks - count descriptor blocks number
  * @inode: inode of metadata file using this allocator
  * @desc_blocks: descriptor blocks number [out]
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_palloc_count_desc_blocks(struct inode *inode,
 					    unsigned long *desc_blocks)
@@ -473,6 +517,8 @@ static int nilfs_palloc_count_desc_blocks(struct inode *inode,
  *					MDT file growing
  * @inode: inode of metadata file using this allocator
  * @desc_blocks: known current descriptor blocks count
+ *
+ * Return: true if a group can be added in the metadata file, false if not.
  */
 static inline bool nilfs_palloc_mdt_file_can_grow(struct inode *inode,
 						    unsigned long desc_blocks)
@@ -487,6 +533,12 @@ static inline bool nilfs_palloc_mdt_file_can_grow(struct inode *inode,
  * @inode: inode of metadata file using this allocator
  * @nused: current number of used entries
  * @nmaxp: max number of entries [out]
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EIO	- I/O error (including metadata corruption).
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-ERANGE	- Number of entries in use is out of range.
  */
 int nilfs_palloc_count_max_entries(struct inode *inode, u64 nused, u64 *nmaxp)
 {
@@ -518,6 +570,13 @@ int nilfs_palloc_count_max_entries(struct inode *inode, u64 nused, u64 *nmaxp)
  * @inode: inode of metadata file using this allocator
  * @req: nilfs_palloc_req structure exchanged for the allocation
  * @wrap: whether to wrap around
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EIO	- I/O error (including metadata corruption).
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-ENOSPC	- Entries exhausted (No entries available for allocation).
+ * * %-EROFS	- Read only filesystem
  */
 int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 				     struct nilfs_palloc_req *req, bool wrap)
@@ -710,6 +769,8 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
  * nilfs_palloc_prepare_free_entry - prepare to deallocate a persistent object
  * @inode: inode of metadata file using this allocator
  * @req: nilfs_palloc_req structure exchanged for the removal
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_palloc_prepare_free_entry(struct inode *inode,
 				    struct nilfs_palloc_req *req)
@@ -754,6 +815,8 @@ void nilfs_palloc_abort_free_entry(struct inode *inode,
  * @inode: inode of metadata file using this allocator
  * @entry_nrs: array of entry numbers to be deallocated
  * @nitems: number of entries stored in @entry_nrs
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 {
diff --git a/fs/nilfs2/alloc.h b/fs/nilfs2/alloc.h
index 3f115ab7e9a7..046d876ea3e0 100644
--- a/fs/nilfs2/alloc.h
+++ b/fs/nilfs2/alloc.h
@@ -21,6 +21,8 @@
  *
  * The number of entries per group is defined by the number of bits
  * that a bitmap block can maintain.
+ *
+ * Return: Number of entries per group.
  */
 static inline unsigned long
 nilfs_palloc_entries_per_group(const struct inode *inode)
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index a1c0c09f61e2..aaab0ae90261 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -1124,6 +1124,8 @@ int nilfs_cpfile_get_stat(struct inode *cpfile, struct nilfs_cpstat *cpstat)
  * @cpsize: size of a checkpoint entry
  * @raw_inode: on-disk cpfile inode
  * @inodep: buffer to store the inode
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_cpfile_read(struct super_block *sb, size_t cpsize,
 		      struct nilfs_inode *raw_inode, struct inode **inodep)
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index c57445e62298..c5664035b3e3 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -481,6 +481,8 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
  * @entry_size: size of a dat entry
  * @raw_inode: on-disk dat inode
  * @inodep: buffer to store the inode
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 		   struct nilfs_inode *raw_inode, struct inode **inodep)
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index bae9d7d9a424..e1e050dfbbc2 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -146,6 +146,8 @@ int nilfs_ifile_get_inode_block(struct inode *ifile, ino_t ino,
  * @ifile: ifile inode
  * @nmaxinodes: current maximum of available inodes count [out]
  * @nfreeinodes: free inodes count [out]
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_ifile_count_free_inodes(struct inode *ifile,
 				    u64 *nmaxinodes, u64 *nfreeinodes)
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 228bfffa5d22..e8015d24a82c 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -68,6 +68,8 @@ void nilfs_inode_sub_blocks(struct inode *inode, int n)
  *
  * This function does not issue actual read request of the specified data
  * block. It is done by VFS.
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_get_block(struct inode *inode, sector_t blkoff,
 		    struct buffer_head *bh_result, int create)
@@ -141,6 +143,8 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
  * address_space_operations.
  * @file: file struct of the file to be read
  * @folio: the folio to be read
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_read_folio(struct file *file, struct folio *folio)
 {
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 3f7510beebbb..2f850a18d6e7 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -519,6 +519,8 @@ void nilfs_mdt_set_entry_size(struct inode *inode, unsigned int entry_size,
  * nilfs_mdt_setup_shadow_map - setup shadow map and bind it to metadata file
  * @inode: inode of the metadata file
  * @shadow: shadow mapping
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_mdt_setup_shadow_map(struct inode *inode,
 			       struct nilfs_shadow_map *shadow)
@@ -540,6 +542,8 @@ int nilfs_mdt_setup_shadow_map(struct inode *inode,
 /**
  * nilfs_mdt_save_to_shadow_map - copy bmap and dirty pages to shadow map
  * @inode: inode of the metadata file
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_mdt_save_to_shadow_map(struct inode *inode)
 {
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 899686d2e5f7..806b056d2260 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -135,8 +135,7 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
  * nilfs_folio_buffers_clean - Check if a folio has dirty buffers or not.
  * @folio: Folio to be checked.
  *
- * nilfs_folio_buffers_clean() returns false if the folio has dirty buffers.
- * Otherwise, it returns true.
+ * Return: false if the folio has dirty buffers, true otherwise.
  */
 bool nilfs_folio_buffers_clean(struct folio *folio)
 {
@@ -500,8 +499,9 @@ void __nilfs_clear_folio_dirty(struct folio *folio)
  * This function searches an extent of buffers marked "delayed" which
  * starts from a block offset equal to or larger than @start_blk.  If
  * such an extent was found, this will store the start offset in
- * @blkoff and return its length in blocks.  Otherwise, zero is
- * returned.
+ * @blkoff and return its length in blocks.
+ *
+ * Return: Length in blocks of found extent, 0 otherwise.
  */
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 4063f084e75d..22aecf6e2344 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -88,6 +88,8 @@ static int nilfs_warn_segment_error(struct super_block *sb, int err)
  * @check_bytes: number of bytes to be checked
  * @start: DBN of start block
  * @nblock: number of blocks to be checked
+ *
+ * Return: 0 on success, or %-EIO if an I/O error occurs.
  */
 static int nilfs_compute_checksum(struct the_nilfs *nilfs,
 				  struct buffer_head *bhs, u32 *sum,
@@ -126,6 +128,11 @@ static int nilfs_compute_checksum(struct the_nilfs *nilfs,
  * @sr_block: disk block number of the super root block
  * @pbh: address of a buffer_head pointer to return super root buffer
  * @check: CRC check flag
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EINVAL	- Super root block corrupted.
+ * * %-EIO	- I/O error.
  */
 int nilfs_read_super_root_block(struct the_nilfs *nilfs, sector_t sr_block,
 				struct buffer_head **pbh, int check)
@@ -176,6 +183,8 @@ int nilfs_read_super_root_block(struct the_nilfs *nilfs, sector_t sr_block,
  * @nilfs: nilfs object
  * @start_blocknr: start block number of the log
  * @sum: pointer to return segment summary structure
+ *
+ * Return: Buffer head pointer, or NULL if an I/O error occurs.
  */
 static struct buffer_head *
 nilfs_read_log_header(struct the_nilfs *nilfs, sector_t start_blocknr,
@@ -195,6 +204,13 @@ nilfs_read_log_header(struct the_nilfs *nilfs, sector_t start_blocknr,
  * @seg_seq: sequence number of segment
  * @bh_sum: buffer head of summary block
  * @sum: segment summary struct
+ *
+ * Return: 0 on success, or one of the following internal codes on failure:
+ * * %NILFS_SEG_FAIL_MAGIC	    - Magic number mismatch.
+ * * %NILFS_SEG_FAIL_SEQ	    - Sequence number mismatch.
+ * * %NIFLS_SEG_FAIL_CONSISTENCY    - Block count out of range.
+ * * %NILFS_SEG_FAIL_IO		    - I/O error.
+ * * %NILFS_SEG_FAIL_CHECKSUM_FULL  - Full log checksum verification failed.
  */
 static int nilfs_validate_log(struct the_nilfs *nilfs, u64 seg_seq,
 			      struct buffer_head *bh_sum,
@@ -238,6 +254,9 @@ static int nilfs_validate_log(struct the_nilfs *nilfs, u64 seg_seq,
  * @pbh: the current buffer head on summary blocks [in, out]
  * @offset: the current byte offset on summary blocks [in, out]
  * @bytes: byte size of the item to be read
+ *
+ * Return: Kernel space address of current segment summary entry, or
+ * NULL if an I/O error occurs.
  */
 static void *nilfs_read_summary_info(struct the_nilfs *nilfs,
 				     struct buffer_head **pbh,
@@ -300,6 +319,11 @@ static void nilfs_skip_summary_info(struct the_nilfs *nilfs,
  * @start_blocknr: start block number of the log
  * @sum: log summary information
  * @head: list head to add nilfs_recovery_block struct
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_scan_dsync_log(struct the_nilfs *nilfs, sector_t start_blocknr,
 				struct nilfs_segment_summary *sum,
@@ -571,6 +595,12 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
  * @sb: super block instance
  * @root: NILFS root instance
  * @ri: pointer to a nilfs_recovery_info
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EINVAL	- Log format error.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_do_roll_forward(struct the_nilfs *nilfs,
 				 struct super_block *sb,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 05c24b971464..94f45281253c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -250,6 +250,8 @@ int nilfs_transaction_begin(struct super_block *sb,
  * nilfs_transaction_commit() sets a timer to start the segment
  * constructor.  If a sync flag is set, it starts construction
  * directly.
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_transaction_commit(struct super_block *sb)
 {
@@ -405,6 +407,8 @@ static void *nilfs_segctor_map_segsum_entry(struct nilfs_sc_info *sci,
 /**
  * nilfs_segctor_reset_segment_buffer - reset the current segment buffer
  * @sci: nilfs_sc_info
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_segctor_reset_segment_buffer(struct nilfs_sc_info *sci)
 {
@@ -1315,6 +1319,8 @@ static int nilfs_segctor_collect_blocks(struct nilfs_sc_info *sci, int mode)
  * nilfs_segctor_begin_construction - setup segment buffer to make a new log
  * @sci: nilfs_sc_info
  * @nilfs: nilfs object
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_segctor_begin_construction(struct nilfs_sc_info *sci,
 					    struct the_nilfs *nilfs)
@@ -2454,6 +2460,8 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
  * nilfs_segctor_construct - form logs and write them to disk
  * @sci: segment constructor object
  * @mode: mode of log forming
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_segctor_construct(struct nilfs_sc_info *sci, int mode)
 {
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 623d417a54eb..47d01255a8fb 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -133,6 +133,8 @@ static void nilfs_sufile_mod_counter(struct buffer_head *header_bh,
 /**
  * nilfs_sufile_get_ncleansegs - return the number of clean segments
  * @sufile: inode of segment usage file
+ *
+ * Return: Number of clean segments.
  */
 unsigned long nilfs_sufile_get_ncleansegs(struct inode *sufile)
 {
@@ -500,6 +502,8 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
  * nilfs_sufile_mark_dirty - mark the buffer having a segment usage dirty
  * @sufile: inode of segment usage file
  * @segnum: segment number
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 {
@@ -559,6 +563,8 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
  * @segnum: segment number
  * @nblocks: number of live blocks in the segment
  * @modtime: modification time (option)
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 				   unsigned long nblocks, time64_t modtime)
@@ -1195,6 +1201,8 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
  * @susize: size of a segment usage entry
  * @raw_inode: on-disk sufile inode
  * @inodep: buffer to store the inode
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_sufile_read(struct super_block *sb, size_t susize,
 		      struct nilfs_inode *raw_inode, struct inode **inodep)
diff --git a/fs/nilfs2/sufile.h b/fs/nilfs2/sufile.h
index 127ab01a47ea..cd6f28ab3521 100644
--- a/fs/nilfs2/sufile.h
+++ b/fs/nilfs2/sufile.h
@@ -58,6 +58,8 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range);
  * nilfs_sufile_scrap - make a segment garbage
  * @sufile: inode of segment usage file
  * @segnum: segment number to be freed
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static inline int nilfs_sufile_scrap(struct inode *sufile, __u64 segnum)
 {
@@ -68,6 +70,8 @@ static inline int nilfs_sufile_scrap(struct inode *sufile, __u64 segnum)
  * nilfs_sufile_free - free segment
  * @sufile: inode of segment usage file
  * @segnum: segment number to be freed
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static inline int nilfs_sufile_free(struct inode *sufile, __u64 segnum)
 {
@@ -80,6 +84,8 @@ static inline int nilfs_sufile_free(struct inode *sufile, __u64 segnum)
  * @segnumv: array of segment numbers
  * @nsegs: size of @segnumv array
  * @ndone: place to store the number of freed segments
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static inline int nilfs_sufile_freev(struct inode *sufile, __u64 *segnumv,
 				     size_t nsegs, size_t *ndone)
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index eca79cca3803..badc2cbc895e 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -309,6 +309,8 @@ int nilfs_commit_super(struct super_block *sb, int flag)
  * This function restores state flags in the on-disk super block.
  * This will set "clean" flag (i.e. NILFS_VALID_FS) unless the
  * filesystem was not clean previously.
+ *
+ * Return: 0 on success, %-EIO if I/O error or superblock is corrupted.
  */
 int nilfs_cleanup_super(struct super_block *sb)
 {
@@ -339,6 +341,8 @@ int nilfs_cleanup_super(struct super_block *sb)
  * nilfs_move_2nd_super - relocate secondary super block
  * @sb: super block instance
  * @sb2off: new offset of the secondary super block (in bytes)
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 {
@@ -420,6 +424,8 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
  * nilfs_resize_fs - resize the filesystem
  * @sb: super block instance
  * @newsize: new size of the filesystem (in bytes)
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 int nilfs_resize_fs(struct super_block *sb, __u64 newsize)
 {
@@ -987,7 +993,7 @@ static int nilfs_attach_snapshot(struct super_block *s, __u64 cno,
  * nilfs_tree_is_busy() - try to shrink dentries of a checkpoint
  * @root_dentry: root dentry of the tree to be shrunk
  *
- * This function returns true if the tree was in-use.
+ * Return: true if the tree was in-use, false otherwise.
  */
 static bool nilfs_tree_is_busy(struct dentry *root_dentry)
 {
@@ -1033,6 +1039,8 @@ int nilfs_checkpoint_is_mounted(struct super_block *sb, __u64 cno)
  *
  * This function is called exclusively by nilfs->ns_mount_mutex.
  * So, the recovery process is protected from other simultaneous mounts.
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int
 nilfs_fill_super(struct super_block *sb, struct fs_context *fc)
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 1bcaf85506d3..cb01ea81724d 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -165,6 +165,9 @@ static void nilfs_clear_recovery_info(struct nilfs_recovery_info *ri)
  * containing a super root from a given super block, and initializes
  * relevant information on the nilfs object preparatory for log
  * scanning and recovery.
+ *
+ * Return: 0 on success, or %-EINVAL if current segment number is out
+ * of range.
  */
 static int nilfs_store_log_cursor(struct the_nilfs *nilfs,
 				  struct nilfs_super_block *sbp)
@@ -225,6 +228,13 @@ static int nilfs_get_blocksize(struct super_block *sb,
  * load_nilfs() searches and load the latest super root,
  * attaches the last segment, and does recovery if needed.
  * The caller must call this exclusively for simultaneous mounts.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EINVAL	- No valid segment found.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-EROFS	- Read only device or RO compat mode (if recovery is required)
  */
 int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 {
@@ -394,6 +404,8 @@ static unsigned long long nilfs_max_size(unsigned int blkbits)
  * nilfs_nrsvsegs - calculate the number of reserved segments
  * @nilfs: nilfs object
  * @nsegs: total number of segments
+ *
+ * Return: Number of reserved segments.
  */
 unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 {
@@ -405,6 +417,8 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 /**
  * nilfs_max_segment_count - calculate the maximum number of segments
  * @nilfs: nilfs object
+ *
+ * Return: Maximum number of segments
  */
 static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
 {
-- 
2.43.0


