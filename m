Return-Path: <linux-nilfs+bounces-249-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C43899A20
	for <lists+linux-nilfs@lfdr.de>; Fri,  5 Apr 2024 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D59B21C3F
	for <lists+linux-nilfs@lfdr.de>; Fri,  5 Apr 2024 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8916130E;
	Fri,  5 Apr 2024 10:01:33 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3D160783
	for <linux-nilfs@vger.kernel.org>; Fri,  5 Apr 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311293; cv=none; b=AP/KYKmsV3iooP4snFWQKiLz5QjoZ/Us7sTxM7MtW6Pzjs16RK3O+sgSsoRycXW5ndZiBlv/BdoSSsyFhMUvkGJDKTRIQzo9/uU8B0u7HrUrVjEspomhb33SVV7FGfquPmJzUNYqDtXTAZ90lD0D/a6cttxReh5nCLGQaswnlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311293; c=relaxed/simple;
	bh=/qOGRDyHKWj/fwIKjQfKdRdDJFVN7A7k5JuEor+MQF8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ILDYAenb0MLZHWexCoxejcRJVFeLI0DgJ05/cswUctY5/Z4/4COGPjGsk8lgrCWYHQSjcChtt9vJASiT7No5Pp15FVeDldDxYuOOo00fuN1KPFEhdVuRvnyNH2Ot/OB3OMVRiC5H5W4JIdMM4nn3h8c7bhEmAOt+8/amB6cnutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-369f5bcab76so17276495ab.0
        for <linux-nilfs@vger.kernel.org>; Fri, 05 Apr 2024 03:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712311290; x=1712916090;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=445TRXAVmjH4O2IS6/Ji32WBWYko0u0kvTDkSdMao+8=;
        b=trZI7bF9UsVm8YOssenRYPjnHRDcZ1X3HsMvCL65hIa8nLpyQnhcctPlfHSVSjxrHH
         OgxodHIq1EM2+9qf1ZarajbZLECzX/5PsKZR4BOjK0u60R+lLcQ+lz/kiYbioyPmVwJb
         78VTEzeDgPzK23A/fpAoeBwCUzV5C7M+YQDzDdQ+pCkTfwPuuXz1SejIlafUI9Sq3XC7
         sFQNqXyAe/kWsT7uom/Z6wrgWPyDLMQsEgGgSbDhsCo6uQy2HpGrpiTcZP72gWb0nkxz
         lPY4QG++WCEV5oy9kVtKeLZyoj4atquMXF68DLrLN3cedc0G9whjiud+nlBFMeGtVbye
         u9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUGbCLnoCluXd/aGERv+XCCwJqdLf6l0cqg3kSPLXCVR0FLZ8qQIXClU6M1N/YQijjxKDYvHwFeAYP1teXw6EWY+Ys4mKK6XtaiYWQ=
X-Gm-Message-State: AOJu0Yxg2s2uJeLIDSwxh038GXqIc9xVk2C/VOc4/sTxMUNZ8JXzxN1b
	S4Xen9sp8ScwPLOtKenqiQ8QNhVojnQUIQtOPE82ltHEvvpwWn2vKg5tUCFM3RxyDDZOg7xksEF
	HsadcloGD4UK69J5i+vT+QRpmC3Z3daRJ4UymxOiiAp0KhpsAU7ZRiKQ=
X-Google-Smtp-Source: AGHT+IF9qeoaTXjy5G7O5FcDTQyaw7YGFi4/1FGYAzCeRse6ENIrye7Iy/ow7UyR1XttBUeTB0TOGll9dM6Ew04QTqIOr3P6KqIq
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:36a:1104:2d42 with SMTP id
 w11-20020a056e02190b00b0036a11042d42mr45597ilu.1.1712311290205; Fri, 05 Apr
 2024 03:01:30 -0700 (PDT)
Date: Fri, 05 Apr 2024 03:01:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032adb00615568aee@google.com>
Subject: [syzbot] [jffs2?] [nilfs?] KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
From: syzbot <syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nilfs@vger.kernel.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ea8b3d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141bc615180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148423e3180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a3126c30eb43/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
Read of size 8 at addr ffff88807e402130 by task jffs2_gcd_mtd0/5063

CPU: 0 PID: 5063 Comm: jffs2_gcd_mtd0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
 jffs2_garbage_collect_pass+0xae/0x2120 fs/jffs2/gc.c:134
 jffs2_garbage_collect_thread+0x651/0x6e0 fs/jffs2/background.c:155
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 5052:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 jffs2_init_fs_context+0x4f/0xc0 fs/jffs2/super.c:313
 alloc_fs_context+0x68a/0x800 fs/fs_context.c:318
 do_new_mount+0x160/0xb40 fs/namespace.c:3331
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5052:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x14a/0x380 mm/slub.c:4390
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff88807e402000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 304 bytes inside of
 freed 4096-byte region [ffff88807e402000, ffff88807e403000)

The buggy address belongs to the physical page:
page:ffffea0001f90000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e400
head:ffffea0001f90000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c42140 ffffea0000937e00 0000000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4727, tgid 4727 (dhcpcd), ts 35281916523, free_ts 35270327271
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x2e5/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x69/0x570 security/security.c:2955
 do_dentry_open+0x327/0x15a0 fs/open.c:942
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_64+0xfb/0x240
page last free pid 4727 tgid 4727 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x95d/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 vfs_fstatat+0x11c/0x190 fs/stat.c:303
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat fs/stat.c:462 [inline]
 __x64_sys_newfstatat+0x117/0x190 fs/stat.c:462
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffff88807e402000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e402080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807e402100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88807e402180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807e402200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

