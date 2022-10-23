Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A56091A5
	for <lists+linux-nilfs@lfdr.de>; Sun, 23 Oct 2022 09:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJWH3w (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 23 Oct 2022 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJWH3v (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 23 Oct 2022 03:29:51 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F520F50
        for <linux-nilfs@vger.kernel.org>; Sun, 23 Oct 2022 00:29:45 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id j29-20020a056e02219d00b002f9b13c40c5so6829562ila.21
        for <linux-nilfs@vger.kernel.org>; Sun, 23 Oct 2022 00:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqOGkezo0U22Xce8RPh+7hXBEwsf+0p4mBHQDweMHfw=;
        b=yCBDL0NWTWl5C6M+AkOXyrAPAmYl2DGuQQG0YhOIs1MnOoHQSmtK/Lfco3eflvQGe9
         YsbRxxHK77DEiwlM6PH8nibhc5JvgKR/D5LMcIP90QeO6hvchgg7u4vf8nAoCq9EPLWD
         xJm15A6zOTYr1wG7aFS2Jd9V1e9OyLLkYzjjtdu0uLYw8Lq213dH55g8lHKY9V8njiZ9
         NsblKJ93+kHfv3rVPXnT62J8pZssEQAQiqbaak8naadN5KdatW0a13QKq0eWRcvtrOrt
         AbvRPB3G2C+TRr/9QT21TV14mvDR1gqKpEvxi9e6UQiSmlixHxYPol+Nkn45cMh5JW0j
         fm1g==
X-Gm-Message-State: ACrzQf3+80Ge15Jy/h4Qyc9hyMv8tzUHmEuakyPe7OR0lUBauuAuuu9A
        UDfAeYPL2Bbyh0NHnkFqF2abq9bCWrACvYvUeNDdMUxtM4Ol
X-Google-Smtp-Source: AMsMyM47QyhdtuzM9oB307S2JGkCaBqZOmbTCE1fpY4WOd0sPdY81mhKYdHcX9oHVFBGC2ZEIuKDnLQU3950phm/PAg3PtlnPeKG
MIME-Version: 1.0
X-Received: by 2002:a5d:9ac1:0:b0:6a3:1938:e6b0 with SMTP id
 x1-20020a5d9ac1000000b006a31938e6b0mr17024715ion.186.1666510184715; Sun, 23
 Oct 2022 00:29:44 -0700 (PDT)
Date:   Sun, 23 Oct 2022 00:29:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000931cf305ebaea35d@google.com>
Subject: [syzbot] WARNING: locking bug in nilfs_cpfile_get_checkpoint
From:   syzbot <syzbot+e567d760e00a7a29512b@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10581572880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=e567d760e00a7a29512b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e8d05a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114a1022880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e10e77b79957/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e567d760e00a7a29512b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 4135 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
WARNING: CPU: 0 PID: 4135 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
Modules linked in:
CPU: 0 PID: 4135 Comm: syz-executor168 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff800012d9b820
x29: ffff800012d9b900 x28: 0000000000000002 x27: ffff0000c1f14fd0
x26: ffff0000c954eb70 x25: ffff0000c1f15a00 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: ffffff555651563c x18: 0000000000000026
x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff0000c1f14f80
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 1e098b7dd4c21b00
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000016
Call trace:
 check_wait_context kernel/locking/lockdep.c:4727 [inline]
 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
 nilfs_cpfile_get_checkpoint+0xa8/0x404 fs/nilfs2/cpfile.c:230
 nilfs_attach_checkpoint+0xb8/0x1c8 fs/nilfs2/super.c:528
 nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
 nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 2345
hardirqs last  enabled at (2345): [<ffff800008161dac>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (2345): [<ffff800008161dac>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (2344): [<ffff80000bfc0a34>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
softirqs last  enabled at (1180): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1178): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
BUG: sleeping function called from invalid context at arch/arm64/mm/fault.c:593
in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 4135, name: syz-executor168
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 2345
hardirqs last  enabled at (2345): [<ffff800008161dac>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (2345): [<ffff800008161dac>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (2344): [<ffff80000bfc0a34>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
softirqs last  enabled at (1180): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1178): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
CPU: 0 PID: 4135 Comm: syz-executor168 Tainted: G        W          6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 __might_resched+0x208/0x218 kernel/sched/core.c:9892
 __might_sleep+0x48/0x78 kernel/sched/core.c:9821
 do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:593
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:821
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:366
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:426
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4728 [inline]
 __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
 nilfs_cpfile_get_checkpoint+0xa8/0x404 fs/nilfs2/cpfile.c:230
 nilfs_attach_checkpoint+0xb8/0x1c8 fs/nilfs2/super.c:528
 nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
 nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001071a6000
[00000000000000b8] pgd=0800000107366003, p4d=0800000107366003, pud=080000010ab71003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4135 Comm: syz-executor168 Tainted: G        W          6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff800012d9b820
x29: ffff800012d9b900 x28: 0000000000000002 x27: ffff0000c1f14fd0
x26: ffff0000c954eb70 x25: ffff0000c1f15a00 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: ffffff555651563c x18: 0000000000000026
x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff0000c1f14f80
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 000000000004163c
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000016
Call trace:
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4728 [inline]
 __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
 nilfs_cpfile_get_checkpoint+0xa8/0x404 fs/nilfs2/cpfile.c:230
 nilfs_attach_checkpoint+0xb8/0x1c8 fs/nilfs2/super.c:528
 nilfs_fill_super+0x154/0x2f8 fs/nilfs2/super.c:1064
 nilfs_mount+0x370/0x52c fs/nilfs2/super.c:1317
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: b002db8a 91056210 9106614a b9400329 (3942e114) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b002db8a 	adrp	x10, 0x5b71000
   4:	91056210 	add	x16, x16, #0x158
   8:	9106614a 	add	x10, x10, #0x198
   c:	b9400329 	ldr	w9, [x25]
* 10:	3942e114 	ldrb	w20, [x8, #184] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
