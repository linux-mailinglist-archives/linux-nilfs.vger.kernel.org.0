Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A016B58A2FB
	for <lists+linux-nilfs@lfdr.de>; Fri,  5 Aug 2022 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiHDWAe (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 4 Aug 2022 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiHDWAc (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Thu, 4 Aug 2022 18:00:32 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AD364E0
        for <linux-nilfs@vger.kernel.org>; Thu,  4 Aug 2022 15:00:30 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so402185iol.10
        for <linux-nilfs@vger.kernel.org>; Thu, 04 Aug 2022 15:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=f2Aq/HQcpNyfdVHUFhRZWedlVxHPyLOZz5MBuiByUsk=;
        b=ApueHUV+xOH1NjGCjSW0uyp5xLRBnR1xT7ZkSlJWkFYD6/oVrpfozT8mkVX5dAkXQH
         rRT+feySoEwW+7pF+zHRc0J7eHDbXl2QKUkpFyk00PlEi/y+9lf1kBoynx4u8s3IT0kw
         pxQpjGjX8iyH70tacN9gA4AUnu/AgtPXjjIvdwl0WTESUQ/Mi9aTiWhhNnWZ/3k1byCb
         +JFyOvJAKUs/rCcy5o2ZGqPkR+eO76aLlOc6vLEqkn9y9R0Lx0LKIutF+7BJT868TjCu
         8ijYtXAJrbubS7fCDo4+jncWmEwj1OD55u8IEt/MX5hElJ7PucocwmLVcQnhD+msevaT
         RL+g==
X-Gm-Message-State: ACgBeo35oXca3NrlQeGMCEGThe06sVuJ967qr8AnJ3tf25RygTMWf2vW
        ZhZOs9FfpGJvDr2K3KrvwrD0+Om35oQJsSTqjnOGF1pmD3bY
X-Google-Smtp-Source: AA6agR6UO2jX0H6ux3HhMNmK48a5RJrx/3oBOt3s5qq66mkkN/XpwUWyRNwi9js457ioUD80EldS/JL/fNDyVLs5tImnonGdYwwb
MIME-Version: 1.0
X-Received: by 2002:a92:ce81:0:b0:2dc:fbec:d023 with SMTP id
 r1-20020a92ce81000000b002dcfbecd023mr1625181ilo.155.1659650429687; Thu, 04
 Aug 2022 15:00:29 -0700 (PDT)
Date:   Thu, 04 Aug 2022 15:00:29 -0700
In-Reply-To: <00000000000098972c05e2117b39@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005022af05e5717ac8@google.com>
Subject: Re: [syzbot] memory leak in kobject_set_name_vargs (5)
From:   syzbot <syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b44f2fd87919 Merge tag 'drm-next-2022-08-03' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105fdbca080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=358668a360d9b702
dashboard link: https://syzkaller.appspot.com/bug?extid=7381dc4ad60658ca4c05
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c685ca080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120a0fe2080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 25.990s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 27.260s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 28.520s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 31.000s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 31.040s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c35db80 (size 32):
  comm "syz-executor261", pid 3645, jiffies 4294950822 (age 31.080s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 37 00 00 00 00 00 00 00 00 00 00 00  loop7...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814bf836>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814bf8c3>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff8239c002>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82492b6b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff82492fed>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff82492fed>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e10e8a>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81df964c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81de57ab>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81de57ab>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164981b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e2c68>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff81626e27>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff81626e27>] path_mount+0xc37/0x1120 fs/namespace.c:3370
    [<ffffffff81627a5e>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff81627a5e>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff81627a5e>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff81627a5e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845cad15>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845cad15>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
executing program
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
executing program
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory

