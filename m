Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DC4391C2
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 Oct 2021 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhJYIxi (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 25 Oct 2021 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhJYIxi (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 25 Oct 2021 04:53:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE47C061764;
        Mon, 25 Oct 2021 01:51:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m21so10218331pgu.13;
        Mon, 25 Oct 2021 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPsWpmmt02MG+1s9uq2nw2TFlAnrdyGcJip4pFTiTbA=;
        b=gOQItMuVS6x3uVc0DHUXF9CPlM/PeiB+QgNfwefytQCzbvCEZjYiy+6goXqgL5p8uQ
         fnTzapBuSy0xq2ylpv7FfQlkyeHcrTus5nApj+UH60Xbhifu3tvCAKhOU9+0VOiikeon
         A6wCGnqbUg6MpMOEr7Q9bN3B17lDvRWd3QPS94WSePrQQATXWmkjm/8QnnMIwgWw5wcO
         L4yPfyMYQdSW3GHqcq/CusaqYZ7VpBzQogNMg+js9YdhcSlvbzRQkQbTG38zFqcYTkVz
         LsJkNgmi8WRyPmPbpMk7jfsNvIMrYM7qXqi53Y+zPw2/tNHhKn4YMCaqBsiLoO1OnBbF
         pUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPsWpmmt02MG+1s9uq2nw2TFlAnrdyGcJip4pFTiTbA=;
        b=O9pn2TbmatuAvSEpAqketfGsUrZbg3JudbIC5ONoPoETxFo5deXciIauCzhwMhhxd0
         AVcleGR3qd/ti7nvLLuK2tBXFIkJAotjYu+OpJSRN0RJh2NO0I9iDISOPTYL4bq8Mm4j
         LNbiLs4f7r2a96cF7clbuMLyS3cxpxyJrJOUtqeBPs4VXKOFNcddUF10WVcVsCTzI+p0
         uVFFhKDWZqm3fnBfSyN3mBztUbSfEV9vl3ONHIrqc+6h+Jcf5mwOs18+GDA1GSS9aIDd
         ME3o55nLARqf+IQeD26de0V2/h8KbzgLiBfi8je3XqseVKIpivy16GJeVv7nei6j6QnI
         O3MQ==
X-Gm-Message-State: AOAM530meg+WABM+DHJMcoAWEapUAQtcini1uylZT7ZkYNENWssCJlVO
        9wrAL6PNn+8+jvTaqeKF+gA=
X-Google-Smtp-Source: ABdhPJzaRQkG5ZmJCAt8t9pjtZf4lA0hfi9tp9bxXzOWUhtyl7+6/GgSSVZTrpOjGzevTIFJ4Zx0Rg==
X-Received: by 2002:a63:7010:: with SMTP id l16mr12735487pgc.32.1635151870270;
        Mon, 25 Oct 2021 01:51:10 -0700 (PDT)
Received: from carrot.localdomain (i220-108-45-205.s42.a014.ap.plala.or.jp. [220.108.45.205])
        by smtp.gmail.com with ESMTPSA id j126sm18667378pfd.113.2021.10.25.01.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 01:51:08 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] nilfs2: replace snprintf in show functions with sysfs_emit
Date:   Mon, 25 Oct 2021 17:51:01 +0900
Message-Id: <1635151862-11547-2-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635151862-11547-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1635151862-11547-1-git-send-email-konishi.ryusuke@gmail.com>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Qing Wang <wangqing@vivo.com>

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Link: https://lkml.kernel.org/r/1634095759-4625-1-git-send-email-wangqing@vivo.com
Signed-off-by: Qing Wang <wangqing@vivo.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/sysfs.c | 76 +++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 62f8a7ac19c8..be407072def7 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -95,7 +95,7 @@
 nilfs_snapshot_inodes_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->inodes_count));
 }
 
@@ -103,7 +103,7 @@
 nilfs_snapshot_blocks_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->blocks_count));
 }
 
@@ -116,7 +116,7 @@
 nilfs_snapshot_README_show(struct nilfs_snapshot_attr *attr,
 			    struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, snapshot_readme_str);
+	return sysfs_emit(buf, snapshot_readme_str);
 }
 
 NILFS_SNAPSHOT_RO_ATTR(inodes_count);
@@ -217,7 +217,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 nilfs_mounted_snapshots_README_show(struct nilfs_mounted_snapshots_attr *attr,
 				    struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, mounted_snapshots_readme_str);
+	return sysfs_emit(buf, mounted_snapshots_readme_str);
 }
 
 NILFS_MOUNTED_SNAPSHOTS_RO_ATTR(README);
@@ -255,7 +255,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 
 	ncheckpoints = cpstat.cs_ncps;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ncheckpoints);
+	return sysfs_emit(buf, "%llu\n", ncheckpoints);
 }
 
 static ssize_t
@@ -278,7 +278,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 
 	nsnapshots = cpstat.cs_nsss;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nsnapshots);
+	return sysfs_emit(buf, "%llu\n", nsnapshots);
 }
 
 static ssize_t
@@ -292,7 +292,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -306,7 +306,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static const char checkpoints_readme_str[] =
@@ -322,7 +322,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 nilfs_checkpoints_README_show(struct nilfs_checkpoints_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, checkpoints_readme_str);
+	return sysfs_emit(buf, checkpoints_readme_str);
 }
 
 NILFS_CHECKPOINTS_RO_ATTR(checkpoints_number);
@@ -353,7 +353,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_nsegments);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_nsegments);
 }
 
 static ssize_t
@@ -361,7 +361,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 					struct the_nilfs *nilfs,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_blocks_per_segment);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_blocks_per_segment);
 }
 
 static ssize_t
@@ -375,7 +375,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	ncleansegs = nilfs_sufile_get_ncleansegs(nilfs->ns_sufile);
 	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ncleansegs);
+	return sysfs_emit(buf, "%lu\n", ncleansegs);
 }
 
 static ssize_t
@@ -395,7 +395,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 		return err;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sustat.ss_ndirtysegs);
+	return sysfs_emit(buf, "%llu\n", sustat.ss_ndirtysegs);
 }
 
 static const char segments_readme_str[] =
@@ -411,7 +411,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segments_readme_str);
+	return sysfs_emit(buf, segments_readme_str);
 }
 
 NILFS_SEGMENTS_RO_ATTR(segments_number);
@@ -448,7 +448,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	last_pseg = nilfs->ns_last_pseg;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)last_pseg);
 }
 
@@ -463,7 +463,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	last_seq = nilfs->ns_last_seq;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_seq);
+	return sysfs_emit(buf, "%llu\n", last_seq);
 }
 
 static ssize_t
@@ -477,7 +477,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -491,7 +491,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	seg_seq = nilfs->ns_seg_seq;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", seg_seq);
+	return sysfs_emit(buf, "%llu\n", seg_seq);
 }
 
 static ssize_t
@@ -505,7 +505,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	segnum = nilfs->ns_segnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", segnum);
+	return sysfs_emit(buf, "%llu\n", segnum);
 }
 
 static ssize_t
@@ -519,7 +519,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	nextnum = nilfs->ns_nextnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nextnum);
+	return sysfs_emit(buf, "%llu\n", nextnum);
 }
 
 static ssize_t
@@ -533,7 +533,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	pseg_offset = nilfs->ns_pseg_offset;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", pseg_offset);
+	return sysfs_emit(buf, "%lu\n", pseg_offset);
 }
 
 static ssize_t
@@ -547,7 +547,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static ssize_t
@@ -575,7 +575,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	ctime = nilfs->ns_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ctime);
+	return sysfs_emit(buf, "%llu\n", ctime);
 }
 
 static ssize_t
@@ -603,7 +603,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	nongc_ctime = nilfs->ns_nongc_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nongc_ctime);
+	return sysfs_emit(buf, "%llu\n", nongc_ctime);
 }
 
 static ssize_t
@@ -617,7 +617,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	ndirtyblks = atomic_read(&nilfs->ns_ndirtyblks);
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ndirtyblks);
+	return sysfs_emit(buf, "%u\n", ndirtyblks);
 }
 
 static const char segctor_readme_str[] =
@@ -654,7 +654,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 nilfs_segctor_README_show(struct nilfs_segctor_attr *attr,
 			  struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segctor_readme_str);
+	return sysfs_emit(buf, segctor_readme_str);
 }
 
 NILFS_SEGCTOR_RO_ATTR(last_pseg_block);
@@ -723,7 +723,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	sbwtime = nilfs->ns_sbwtime;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sbwtime);
+	return sysfs_emit(buf, "%llu\n", sbwtime);
 }
 
 static ssize_t
@@ -737,7 +737,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	sbwcount = nilfs->ns_sbwcount;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sbwcount);
+	return sysfs_emit(buf, "%u\n", sbwcount);
 }
 
 static ssize_t
@@ -751,7 +751,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 	sb_update_freq = nilfs->ns_sb_update_freq;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sb_update_freq);
+	return sysfs_emit(buf, "%u\n", sb_update_freq);
 }
 
 static ssize_t
@@ -799,7 +799,7 @@ void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 nilfs_superblock_README_show(struct nilfs_superblock_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, sb_readme_str);
+	return sysfs_emit(buf, sb_readme_str);
 }
 
 NILFS_SUPERBLOCK_RO_ATTR(sb_write_time);
@@ -834,7 +834,7 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
 	u32 major = le32_to_cpu(sbp[0]->s_rev_level);
 	u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
 
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n", major, minor);
+	return sysfs_emit(buf, "%d.%d\n", major, minor);
 }
 
 static
@@ -842,7 +842,7 @@ ssize_t nilfs_dev_blocksize_show(struct nilfs_dev_attr *attr,
 				 struct the_nilfs *nilfs,
 				 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", nilfs->ns_blocksize);
+	return sysfs_emit(buf, "%u\n", nilfs->ns_blocksize);
 }
 
 static
@@ -853,7 +853,7 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 	u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", dev_size);
+	return sysfs_emit(buf, "%llu\n", dev_size);
 }
 
 static
@@ -864,7 +864,7 @@ ssize_t nilfs_dev_free_blocks_show(struct nilfs_dev_attr *attr,
 	sector_t free_blocks = 0;
 
 	nilfs_count_free_blocks(nilfs, &free_blocks);
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)free_blocks);
 }
 
@@ -875,7 +875,7 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
 {
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 
-	return snprintf(buf, PAGE_SIZE, "%pUb\n", sbp[0]->s_uuid);
+	return sysfs_emit(buf, "%pUb\n", sbp[0]->s_uuid);
 }
 
 static
@@ -903,7 +903,7 @@ static ssize_t nilfs_dev_README_show(struct nilfs_dev_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, dev_readme_str);
+	return sysfs_emit(buf, dev_readme_str);
 }
 
 NILFS_DEV_RO_ATTR(revision);
@@ -1047,7 +1047,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
 					    struct attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n",
+	return sysfs_emit(buf, "%d.%d\n",
 			NILFS_CURRENT_REV, NILFS_MINOR_REV);
 }
 
@@ -1060,7 +1060,7 @@ static ssize_t nilfs_feature_README_show(struct kobject *kobj,
 					 struct attribute *attr,
 					 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, features_readme_str);
+	return sysfs_emit(buf, features_readme_str);
 }
 
 NILFS_FEATURE_RO_ATTR(revision);
-- 
1.8.3.1

