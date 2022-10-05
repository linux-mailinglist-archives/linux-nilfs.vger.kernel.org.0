Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FED5F5117
	for <lists+linux-nilfs@lfdr.de>; Wed,  5 Oct 2022 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJEIox (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 5 Oct 2022 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJEIon (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Wed, 5 Oct 2022 04:44:43 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDFB5F65
        for <linux-nilfs@vger.kernel.org>; Wed,  5 Oct 2022 01:44:41 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so6055300ilv.8
        for <linux-nilfs@vger.kernel.org>; Wed, 05 Oct 2022 01:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mOh268Wk17ISYAxouxu7muWjraM81l+aStizQFajsq0=;
        b=7RZs7x8wigZKozmqyR2IA984N5UPZD35iKytPON0pWbaW+L8phOmJOfMEjzk0riYlg
         TpcgpPLqQO54Q9v5AAkPACCfOaqneMNreu/p8IK5yF4qmnzgd3ayx3LBp72tHhwc5JJ8
         tvuvYpDuNaY5bIjSMQS8GpPQfDnP+ezNgeKqg+ZJMCySq9w07tFVlbSlp4XT8ffoL5J/
         yxumCYE+Yjjfa7+CLtxTKhJijI04TbQ3e+NDRh9aqP7eitr/wD2mZJkoA5FMf01o+cKQ
         k+ZP8lhAdZURZOhkALSD78dgahYE0XyydIyUsvomyvDPUxOjPef53Nca6t9ObvelLXwd
         j6Ig==
X-Gm-Message-State: ACrzQf2aY89qzysu6Geb/gjyisWAIeNSOosb9vfGdItHYALuO3TagRkm
        Z09SsXO2y8GgMYQm/U5uM/crfEaBXl6tsZhw0QfezkUsdwC4
X-Google-Smtp-Source: AMsMyM5/TfSDT99ZDnmMVQ507JxnFpL0gdqeC06k+60+jf4GW1GIYHmiw2ZUh6hbTge668wki97vz6vy5waiM6mW377SzT/52el/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3724:b0:362:e8cb:755a with SMTP id
 k36-20020a056638372400b00362e8cb755amr7577626jav.226.1664959480676; Wed, 05
 Oct 2022 01:44:40 -0700 (PDT)
Date:   Wed, 05 Oct 2022 01:44:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000694b7b05ea45963e@google.com>
Subject: [syzbot] memory leak in nilfs_sysfs_create_device_group
From:   syzbot <syzbot+2e2f697dbd0f429d5dae@syzkaller.appspotmail.com>
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

HEAD commit:    a5088ee7251e Merge tag 'thermal-6.1-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153f2492880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21254cf9c7c084e0
dashboard link: https://syzkaller.appspot.com/bug?extid=2e2f697dbd0f429d5dae
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1556a368880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2d2c6d22fae/disk-a5088ee7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c66d2393267/vmlinux-a5088ee7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f2050cc3fa6c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e2f697dbd0f429d5dae@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888119526520 (size 32):
  comm "syz-executor.4", pid 4168, jiffies 4294949450 (age 9.260s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 34 00 00 00 00 00 00 00 00 00 00 00  loop4...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814c5b86>] kstrdup+0x36/0x70 mm/util.c:61
    [<ffffffff814c5c13>] kstrdup_const+0x53/0x80 mm/util.c:84
    [<ffffffff823af0e2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff824a442b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
    [<ffffffff824a48ad>] kobject_add_varg lib/kobject.c:352 [inline]
    [<ffffffff824a48ad>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
    [<ffffffff81e217ba>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
    [<ffffffff81e0a03c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
    [<ffffffff81df608b>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
    [<ffffffff81df608b>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
    [<ffffffff8164f4ab>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff815e8c48>] vfs_get_tree+0x28/0x100 fs/super.c:1530
    [<ffffffff8162cbd7>] do_new_mount fs/namespace.c:3040 [inline]
    [<ffffffff8162cbd7>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
    [<ffffffff8162d7be>] do_mount fs/namespace.c:3383 [inline]
    [<ffffffff8162d7be>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff8162d7be>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff8162d7be>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
    [<ffffffff845ebbf5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845ebbf5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
