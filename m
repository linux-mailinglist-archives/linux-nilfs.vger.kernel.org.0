Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08C5F1C7C
	for <lists+linux-nilfs@lfdr.de>; Sat,  1 Oct 2022 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJANro (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 1 Oct 2022 09:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJANrn (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sat, 1 Oct 2022 09:47:43 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FCDAA37E
        for <linux-nilfs@vger.kernel.org>; Sat,  1 Oct 2022 06:47:42 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y187-20020a6bc8c4000000b006a4014e192fso4497329iof.21
        for <linux-nilfs@vger.kernel.org>; Sat, 01 Oct 2022 06:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LkZmD0MSB/n/gLXz0NqVrY/D9pza6FMHcgyThWenpPY=;
        b=B6NVjENsjzgqtIipvODSSJE4NPxGiz2KndCpVIwJi+qQ3i7ZEpvi/j+JbLC237UA0t
         TQFI5oaP5/g1z1hH5vIDmCSs33+pTvTaUW6Pe4LcCdKcEqOQMEoANqt03DRmbSo2Xlt+
         UgGNhBezvG0jPEJs6O999kzRJ1O9D4EMem/a7oc6prMs8e8fVT9i98BDMTFKAUA8bk1V
         c02W+WsjbgBlLv1RSMuK7hG3V3nbWfefmsWqWf8m2/JYvQ8f/gceU6aLslY3kS0WymOz
         ke03FK/cq0MFovBCOPtHm+cz9y7D2ZVA1cEHQbR1aamq3Q5BICvEfX4YkuEG2TZsN1OR
         OytQ==
X-Gm-Message-State: ACrzQf1zwAV49452Syim1FIQhUcpkZn3G4Jzc3YwwoeJCGoTui9r9XZX
        W4Bu9wuWhpzyU4vj5v+WcBMnOiRKp1852waxGpTTPBnpX7mO
X-Google-Smtp-Source: AMsMyM5UCbRlBp2o3b+Z0xlOzKEvjeDYBrfntXPgqdA/CFF93qqAfO3MGBuyagMjUtfPWPLpPHe6gxMUmCzoJauZJpGJvmJEEBPd
MIME-Version: 1.0
X-Received: by 2002:a92:db0a:0:b0:2f7:f807:760a with SMTP id
 b10-20020a92db0a000000b002f7f807760amr6210015iln.20.1664632061293; Sat, 01
 Oct 2022 06:47:41 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:47:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1fdd605e9f95a77@google.com>
Subject: [syzbot] KASAN: use-after-free Read in nilfs_test_metadata_dirty
From:   syzbot <syzbot+2ff4a42302a8dd97efc6@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    70575e77839f Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ea1fa8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=2ff4a42302a8dd97efc6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b897ef080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131b8598880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d99310e4b1b7/disk-70575e77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef3a5647354c/vmlinux-70575e77.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ff4a42302a8dd97efc6@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
==================================================================
BUG: KASAN: use-after-free in nilfs_test_metadata_dirty+0x39/0x210 fs/nilfs2/segment.c:813
Read of size 8 at addr ffff88814012ae30 by task syz-executor314/3615

CPU: 0 PID: 3615 Comm: syz-executor314 Not tainted 6.0.0-rc7-syzkaller-00180-g70575e77839f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 nilfs_test_metadata_dirty+0x39/0x210 fs/nilfs2/segment.c:813
 nilfs_segctor_confirm+0x78/0x2d0 fs/nilfs2/segment.c:837
 nilfs_segctor_destroy fs/nilfs2/segment.c:2729 [inline]
 nilfs_detach_log_writer+0x4c1/0xbd0 fs/nilfs2/segment.c:2810
 nilfs_put_super+0x4b/0x150 fs/nilfs2/super.c:468
 generic_shutdown_super+0x128/0x300 fs/super.c:491
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x55e/0x20a0 kernel/exit.c:795
 do_group_exit+0x23b/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7c0b111689
Code: Unable to access opcode bytes at RIP 0x7f7c0b11165f.
RSP: 002b:00007ffc6dfe57a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7c0b18c3f0 RCX: 00007f7c0b111689
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: bb1414ac6dfe5827
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7c0b18c3f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 3615:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x97/0x310 mm/slub.c:3289
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 nilfs_find_or_create_root+0x142/0x4f0 fs/nilfs2/the_nilfs.c:747
 nilfs_attach_checkpoint+0xcd/0x4a0 fs/nilfs2/super.c:519
 nilfs_fill_super+0x2e8/0x5d0 fs/nilfs2/super.c:1064
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3615:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kfree+0xda/0x210 mm/slub.c:4567
 nilfs_evict_inode+0xe5/0x3d0 fs/nilfs2/inode.c:908
 evict+0x2a4/0x620 fs/inode.c:665
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x658/0x700 fs/inode.c:748
 generic_shutdown_super+0x94/0x300 fs/super.c:480
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x55e/0x20a0 kernel/exit.c:795
 do_group_exit+0x23b/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88814012ae00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 256-byte region [ffff88814012ae00, ffff88814012af00)

The buggy address belongs to the physical page:
page:ffffea0005004a80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14012a
head:ffffea0005004a80 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000010200 ffffea0005004a00 dead000000000003 ffff888012041b40
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 6972671988, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2103
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 kmem_cache_alloc_trace+0x25f/0x310 mm/slub.c:3287
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 bus_add_driver+0xde/0x600 drivers/base/bus.c:602
 driver_register+0x2e9/0x3e0 drivers/base/driver.c:246
 do_one_initcall+0x1b9/0x3e0 init/main.c:1296
 do_initcall_level+0x168/0x218 init/main.c:1369
 do_initcalls+0x4b/0x8c init/main.c:1385
 kernel_init_freeable+0x3f1/0x57b init/main.c:1623
 kernel_init+0x19/0x2b0 init/main.c:1512
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88814012ad00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88814012ad80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88814012ae00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88814012ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88814012af00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
