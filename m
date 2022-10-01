Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4915F1C7B
	for <lists+linux-nilfs@lfdr.de>; Sat,  1 Oct 2022 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJANrn (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 1 Oct 2022 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJANrm (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sat, 1 Oct 2022 09:47:42 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D542FC0F
        for <linux-nilfs@vger.kernel.org>; Sat,  1 Oct 2022 06:47:41 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so4421785ion.1
        for <linux-nilfs@vger.kernel.org>; Sat, 01 Oct 2022 06:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=wWqRs2lvuhafIzGCHY32E35K0kv47TyBxT5iP6LlkjI=;
        b=H4xBfDrEC2/UaB7BIsB5h3/yaPSw63oz7Xo8DvCVwEmw0nGTcShfaswjfzIUqZ6e4X
         ql3/82gI4kk+b3az/fxQDn9oFkebVHQ9Mrnd8Fuc0+tRHj7/0Z+UXQhVMCX0DiC2u5Uy
         ntrFUPrW8CsKsbP5xUOxR1thHukDPX6dikW2fFUVnOgVOHRYAutPd//Nne6lXmgwFWfv
         Y91dEJ01xXxejmD+YkTz23G8zkjaahnODixDRWjAvFlN2Y5De634rJnb3CPULx5ggwN5
         GfZKd3v2ble+pVbNg/gZi9rILBhRB9PiyYVZ/x8cDzDb4tfxPKvfzr9BrrIZf3g5SrY0
         BwKA==
X-Gm-Message-State: ACrzQf0ts5dPXJh2lFpugVwfPbji1zksNg3XKvU6m9cp2+BwIWThZlu+
        jVP7gRPtrL8QwwkQP/kxEUU20i/J6Q/2RKXjABUOJ3G8GT/m
X-Google-Smtp-Source: AMsMyM79cUKVp1jlCtRp3+JmmB7BlDXfh6JgatmFKU3dpK0mFEjZN6hltNj+w7fl+ayLPsD9J18/ynQoNt8i4LuZznbcug6CHH2o
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f15:b0:6a4:572a:d37d with SMTP id
 q21-20020a0566022f1500b006a4572ad37dmr5704512iow.20.1664632061063; Sat, 01
 Oct 2022 06:47:41 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:47:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae7bd605e9f95a47@google.com>
Subject: [syzbot] WARNING: refcount bug in nilfs_put_root
From:   syzbot <syzbot+7b6d672e5810fec9e6eb@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13ef3998880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=7b6d672e5810fec9e6eb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145c7a1f080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c843ef080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b6d672e5810fec9e6eb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 3038 at lib/refcount.c:87 refcount_dec_and_lock+0x180/0x1ec lib/refcount.c:146
Modules linked in:
CPU: 1 PID: 3038 Comm: syz-executor274 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_dec_and_lock+0x180/0x1ec lib/refcount.c:146
lr : refcount_dec_not_one lib/refcount.c:87 [inline]
lr : refcount_dec_and_lock+0x17c/0x1ec lib/refcount.c:146
sp : ffff800012893a30
x29: ffff800012893a30 x28: ffff80000cc15042 x27: ffff0000cc376640
x26: 0000000000000002 x25: 00000000ffffffff x24: 0000000000000000
x23: 00000000c0000000 x22: 0000000000000000 x21: ffff80000d5eb4a0
x20: ffff0000cc2b5520 x19: ffff80000d8c8000 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c7128000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c7128000
x11: ff808000081c0d5c x10: 0000000000000000 x9 : 7c5041a976250900
x8 : 7c5041a976250900 x7 : ffff80000819545c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 refcount_dec_and_lock+0x180/0x1ec lib/refcount.c:146
 nilfs_put_root+0x30/0x80 fs/nilfs2/the_nilfs.c:797
 nilfs_segctor_destroy fs/nilfs2/segment.c:2747 [inline]
 nilfs_detach_log_writer+0x3b8/0x4d0 fs/nilfs2/segment.c:2810
 nilfs_put_super+0x28/0x9c fs/nilfs2/super.c:468
 generic_shutdown_super+0x8c/0x190 fs/super.c:491
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x26c/0xbe0 kernel/exit.c:795
 do_group_exit+0x60/0xe8 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:934
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 9228
hardirqs last  enabled at (9227): [<ffff8000081befc8>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (9228): [<ffff80000bfb5fbc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:404
softirqs last  enabled at (7974): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (7972): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
