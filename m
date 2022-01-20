Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8F494F9F
	for <lists+linux-nilfs@lfdr.de>; Thu, 20 Jan 2022 14:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbiATNz7 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 20 Jan 2022 08:55:59 -0500
Received: from mail.hust.edu.cn ([202.114.0.240]:5992 "EHLO hust.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241390AbiATNz6 (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 20 Jan 2022 08:55:58 -0500
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 08:55:58 EST
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 20KDiGAH029221-20KDiGAK029221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 20 Jan 2022 21:44:20 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: nilfs2: fix memory leak in nilfs_sysfs_create_device_group
Date:   Thu, 20 Jan 2022 21:44:14 +0800
Message-Id: <20220120134415.57147-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

The preivous commit 8fd0c1b0647a ("nilfs2: fix memory leak in
nilfs_sysfs_delete_device_group") only handles the memory leak in the
nilfs_sysfs_delete_device_group. However, the similar memory leak still
occurs in the nilfs_sysfs_create_device_group.

Fix it by adding kobject_del when
kobject_init_and_add succeeds, but one of the following calls fails.

Fixes: 8fd0c1b0647a ("nilfs2: fix memory leak in nilfs_sysfs_delete_device_group")
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 fs/nilfs2/sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 379d22e28ed6..0b2db2b499d5 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -995,7 +995,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 
 	err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
 	if (err)
-		goto cleanup_dev_kobject;
+		goto delete_dev_kobject;
 
 	err = nilfs_sysfs_create_checkpoints_group(nilfs);
 	if (err)
@@ -1027,6 +1027,9 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 delete_mounted_snapshots_group:
 	nilfs_sysfs_delete_mounted_snapshots_group(nilfs);
 
+delete_dev_kobject:
+	kobject_del(&nilfs->ns_dev_kobj);
+
 cleanup_dev_kobject:
 	kobject_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
-- 
2.25.1

