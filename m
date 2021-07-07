Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40733BE5D8
	for <lists+linux-nilfs@lfdr.de>; Wed,  7 Jul 2021 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhGGJvO (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 7 Jul 2021 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhGGJvN (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Wed, 7 Jul 2021 05:51:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB8C061574;
        Wed,  7 Jul 2021 02:48:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1276771pjo.3;
        Wed, 07 Jul 2021 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2sqf29MwIsxeWDT0t0R5S9OePoQazEMxBf+PD2U0zE=;
        b=Ji36AMmabqBix+JbKaIJmKJc375HAYOsCqQtYvbjZFTF5hsWZugikIc3GSnybGvWjH
         DEvbSEd+cpQ6Lp7/aWBZL7FTdQfpLtSjAtjFgFYthYkpkLd2cdxJu4uOpC0oAQBL6lC5
         WyJIJu80GCdnYo3wgequ++lIH/kF7r/5xRdpRn8wM9uxmu4Y54mnQpxgTIWifP3/sgTP
         T+Mnh5IkGEfzNmsAhbsnKXvMnJs+bvboFx857eltixVOP6WnhqGpNWFwCHAGymZ4V731
         dqImpfR/ED1inaF3DETPPVAkJp6oUk+n1n0JapB9ZD+g9cHWNFGl5lKtt+jfjRyNwKhS
         YbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j2sqf29MwIsxeWDT0t0R5S9OePoQazEMxBf+PD2U0zE=;
        b=fyP3dx1eWLJwHIwx9I1JpVHTi+x+gMRVGt4N1Sz4R5wJ5+hsvgg9blOReJYnAes1X1
         ZXz77fiLge7BGCyu910a2piRg6aLBx3R1TbMst7O0kt2Fl89z/PPScaJLA508eCvE+qc
         j3dsrovo9sKZo5rVggYePfX4hoUv2Qxv97dueKutK+e3un1FbQQqJ7+56I3JEMm75xXF
         fQu2kfL3wVHsupoglEsKev9pdK/77ivxOuE1Ma0HgQIfWv5TdCWhlfUEfjA/T3uotIAK
         8EAKxGXmfJywQAYAreCJUj4RI9OcvAaepppQoL/Q+PE/nQEAcectkbUazO4Z+kKn3jSy
         LlZg==
X-Gm-Message-State: AOAM530xb1RwRaxoXRnRUUpKs6IGeRMm+C3sXgwZlgownp4QLwL/s1ho
        Ic4vFv7ExV/ZVFTR8zhKjUs=
X-Google-Smtp-Source: ABdhPJzDgmM1uzjTKZKoyjb8WqtrBDB6LeC+Mox1w7n99jnG9C5CP4UVuIS+haBOHNg8hQQBqICbnw==
X-Received: by 2002:a17:90a:6d82:: with SMTP id a2mr25052716pjk.150.1625651313147;
        Wed, 07 Jul 2021 02:48:33 -0700 (PDT)
Received: from carrot.localdomain (i60-35-90-140.s42.a014.ap.plala.or.jp. [60.35.90.140])
        by smtp.gmail.com with ESMTPSA id gd19sm80137pjb.38.2021.07.07.02.48.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 02:48:31 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] nilfs2: fix memory leak in nilfs_sysfs_create_device_group
Date:   Wed,  7 Jul 2021 18:48:21 +0900
Message-Id: <1625651306-10829-2-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Nanyong Sun <sunnanyong@huawei.com>

Reported by syzkaller:
BUG: memory leak
unreferenced object 0xffff888100ca8988 (size 8):
comm "syz-executor.1", pid 1930, jiffies 4294745569 (age 18.052s)
hex dump (first 8 bytes):
6c 6f 6f 70 31 00 ff ff loop1...
backtrace:
[<000000009d9e0ac4>] slab_alloc_node mm/slub.c:2972 [inline]
[<000000009d9e0ac4>] slab_alloc mm/slub.c:2980 [inline]
[<000000009d9e0ac4>] __kmalloc_track_caller+0x164/0x330 mm/slub.c:4644
[<00000000b1825477>] kstrdup+0x36/0x70 mm/util.c:60
[<00000000fa081499>] kstrdup_const+0x35/0x60 mm/util.c:83
[<0000000024d13570>] kvasprintf_const+0xf1/0x180 lib/kasprintf.c:48
[<0000000024b69715>] kobject_set_name_vargs+0x56/0x150 lib/kobject.c:289
[<000000003fedac3d>] kobject_add_varg lib/kobject.c:384 [inline]
[<000000003fedac3d>] kobject_init_and_add+0xc9/0x150 lib/kobject.c:473
[<000000002795bd99>] nilfs_sysfs_create_device_group+0x150/0x7d0 fs/nilfs2/sysfs.c:986
[<00000000567fa12d>] init_nilfs+0xa21/0xea0 fs/nilfs2/the_nilfs.c:637
[<00000000082e7458>] nilfs_fill_super fs/nilfs2/super.c:1046 [inline]
[<00000000082e7458>] nilfs_mount+0x7b4/0xe80 fs/nilfs2/super.c:1316
[<00000000adc3fd88>] legacy_get_tree+0x105/0x210 fs/fs_context.c:592
[<00000000a98c45b8>] vfs_get_tree+0x8e/0x2d0 fs/super.c:1498
[<00000000e96282d3>] do_new_mount fs/namespace.c:2905 [inline]
[<00000000e96282d3>] path_mount+0xf9b/0x1990 fs/namespace.c:3235
[<000000003d2eb1b0>] do_mount+0xea/0x100 fs/namespace.c:3248
[<00000000e1ce771a>] __do_sys_mount fs/namespace.c:3456 [inline]
[<00000000e1ce771a>] __se_sys_mount fs/namespace.c:3433 [inline]
[<00000000e1ce771a>] __x64_sys_mount+0x14b/0x1f0 fs/namespace.c:3433
[<000000007c7f81e8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
[<000000007c7f81e8>] do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
[<00000000fd23ff06>] entry_SYSCALL_64_after_hwframe+0x44/0xae

If kobject_init_and_add return with error, then the cleanup of kobject
is needed because memory may be allocated in kobject_init_and_add
without freeing.
And the place of cleanup_dev_kobject should use kobject_put to free
the memory associated with the kobject. As the section "Kobject removal"
of "Documentation/core-api/kobject.rst" says, kobject_del() just makes
the kobject "invisible", but it is not cleaned up. And no more cleanup
will do after cleanup_dev_kobject, so kobject_put is needed here.

Reported-by: Hulk Robot <hulkci@huawei.com>
Link: https://lkml.kernel.org/r/20210629022556.3985106-2-sunnanyong@huawei.com
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
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
1.8.3.1

