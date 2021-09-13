Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F374040A011
	for <lists+linux-nilfs@lfdr.de>; Tue, 14 Sep 2021 00:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbhIMWgt (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 13 Sep 2021 18:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244995AbhIMWfv (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 13 Sep 2021 18:35:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F93A61159;
        Mon, 13 Sep 2021 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631572475;
        bh=hujX+/AVkFDSEqUNv4FYuodgoDg05PAT3zgDqU4iPn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H03L3dCvp0ulO2Wqvub/ERiwEM0rDPLxnkVFtuJwyUkAOd8/SKk7CR4l9r7LzMkww
         eDD1CPmfHzt1FQTLtZ/8V9L9PeaIL+n0rQZPlrDAYOYPyq5ugr9esmQPWqjBPeDOx4
         OKwNWoUR5B60HPPQ+2MMwVcOczKgn8hOiKw7YQK36npCB4TKuftXNaFqRekQoW7mVS
         k5KR5TQ2oeiHBT6t3U64+KdvKf2M2jUkRf99E+32X9mUONsuagakxBfgbqaO3PDQoz
         BteWHn0d5TsvnOXTNOax1NhALtLWJ74HMpP6WREZh3GM1yHEvXVtuFovaKsVI6Et+w
         CpoZL4gBaGvRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nanyong Sun <sunnanyong@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-nilfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 14/19] nilfs2: fix memory leak in nilfs_sysfs_create_device_group
Date:   Mon, 13 Sep 2021 18:34:10 -0400
Message-Id: <20210913223415.435654-14-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913223415.435654-1-sashal@kernel.org>
References: <20210913223415.435654-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Nanyong Sun <sunnanyong@huawei.com>

[ Upstream commit 5f5dec07aca7067216ed4c1342e464e7307a9197 ]

Patch series "nilfs2: fix incorrect usage of kobject".

This patchset from Nanyong Sun fixes memory leak issues and a NULL
pointer dereference issue caused by incorrect usage of kboject in nilfs2
sysfs implementation.

This patch (of 6):

Reported by syzkaller:

  BUG: memory leak
  unreferenced object 0xffff888100ca8988 (size 8):
  comm "syz-executor.1", pid 1930, jiffies 4294745569 (age 18.052s)
  hex dump (first 8 bytes):
  6c 6f 6f 70 31 00 ff ff loop1...
  backtrace:
    kstrdup+0x36/0x70 mm/util.c:60
    kstrdup_const+0x35/0x60 mm/util.c:83
    kvasprintf_const+0xf1/0x180 lib/kasprintf.c:48
    kobject_set_name_vargs+0x56/0x150 lib/kobject.c:289
    kobject_add_varg lib/kobject.c:384 [inline]
    kobject_init_and_add+0xc9/0x150 lib/kobject.c:473
    nilfs_sysfs_create_device_group+0x150/0x7d0 fs/nilfs2/sysfs.c:986
    init_nilfs+0xa21/0xea0 fs/nilfs2/the_nilfs.c:637
    nilfs_fill_super fs/nilfs2/super.c:1046 [inline]
    nilfs_mount+0x7b4/0xe80 fs/nilfs2/super.c:1316
    legacy_get_tree+0x105/0x210 fs/fs_context.c:592
    vfs_get_tree+0x8e/0x2d0 fs/super.c:1498
    do_new_mount fs/namespace.c:2905 [inline]
    path_mount+0xf9b/0x1990 fs/namespace.c:3235
    do_mount+0xea/0x100 fs/namespace.c:3248
    __do_sys_mount fs/namespace.c:3456 [inline]
    __se_sys_mount fs/namespace.c:3433 [inline]
    __x64_sys_mount+0x14b/0x1f0 fs/namespace.c:3433
    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
    entry_SYSCALL_64_after_hwframe+0x44/0xae

If kobject_init_and_add return with error, then the cleanup of kobject
is needed because memory may be allocated in kobject_init_and_add
without freeing.

And the place of cleanup_dev_kobject should use kobject_put to free the
memory associated with the kobject.  As the section "Kobject removal" of
"Documentation/core-api/kobject.rst" says, kobject_del() just makes the
kobject "invisible", but it is not cleaned up.  And no more cleanup will
do after cleanup_dev_kobject, so kobject_put is needed here.

Link: https://lkml.kernel.org/r/1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/1625651306-10829-2-git-send-email-konishi.ryusuke@gmail.com
Reported-by: Hulk Robot <hulkci@huawei.com>
Link: https://lkml.kernel.org/r/20210629022556.3985106-2-sunnanyong@huawei.com
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 9c6c0e2e5880..b6a48492fed2 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -999,7 +999,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
 				    "%s", sb->s_id);
 	if (err)
-		goto free_dev_subgroups;
+		goto cleanup_dev_kobject;
 
 	err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
 	if (err)
@@ -1036,9 +1036,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	nilfs_sysfs_delete_mounted_snapshots_group(nilfs);
 
 cleanup_dev_kobject:
-	kobject_del(&nilfs->ns_dev_kobj);
-
-free_dev_subgroups:
+	kobject_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
 
 failed_create_device_group:
-- 
2.30.2

