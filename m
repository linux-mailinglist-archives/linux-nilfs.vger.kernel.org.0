Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49E5ED2EB
	for <lists+linux-nilfs@lfdr.de>; Wed, 28 Sep 2022 04:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiI1COu (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 27 Sep 2022 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiI1COs (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 27 Sep 2022 22:14:48 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA81BEB0
        for <linux-nilfs@vger.kernel.org>; Tue, 27 Sep 2022 19:14:46 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id u23-20020a6be917000000b0069f4854e11eso6838111iof.2
        for <linux-nilfs@vger.kernel.org>; Tue, 27 Sep 2022 19:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jxWTRqbRPKGPYpBmAfR36n9pl4vJjsakwjOuyOKfhrA=;
        b=NEJZBxS3HLOsm2ewUnJessZP0vi2WLYWlygEJYuGVjo/J30J86VJ8HIUg+NvbV8IY6
         FMrkrGSXE53y5uwyLxNvEz+Iohh55UgJGJq0+Gz9aOvjkAS0ojx8xQrxiGOqFi3SPtWE
         JIEJqw/sSa6raKcGt4rRS5Ti3jVPvTRJmD5Hx3KJKnCfN69Sot0rcJeLhDc4+Y7hbEVr
         mP1C9HZfyb2mov19Rr7B8gesNqeH/4EY7oy/XJR3yJstafPLVFW5/ryagm4G/aZ9yYnv
         7EMsFuIV22HcthGdeFFI6rjQ1OJoz9bsvL9Ticm/bNoJzjXq/4GutHuKxTypTrPI5k/G
         IDpg==
X-Gm-Message-State: ACrzQf3m3aTGAFfjjueqYL1+dExiQj5B3xu6/5RgZXitHMslgWqC/NaN
        ldyyyf2iN9olhS0Z017iDTJH0TECIa9LfQBPnkJAbrbkyVLT
X-Google-Smtp-Source: AMsMyM485wCZzw6H3UiPMrfJ1LvuaGb4VkODqRSNiGJEU9lwZAy42+Jt3vnAuOR4mmeLGVNGEfFsXhuqXEX0JdlJbuqlvp+T7SPu
MIME-Version: 1.0
X-Received: by 2002:a92:c24e:0:b0:2f8:13b3:9f3 with SMTP id
 k14-20020a92c24e000000b002f813b309f3mr9252915ilo.189.1664331286208; Tue, 27
 Sep 2022 19:14:46 -0700 (PDT)
Date:   Tue, 27 Sep 2022 19:14:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a6b6705e9b3533d@google.com>
Subject: [syzbot] WARNING in nilfs_segctor_do_construct
From:   syzbot <syzbot+fbb3e0b24e8dae5a16ee@syzkaller.appspotmail.com>
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

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17870cdf080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=fbb3e0b24e8dae5a16ee
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbb3e0b24e8dae5a16ee@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3320 at fs/nilfs2/segment.c:879 nilfs_segctor_create_checkpoint fs/nilfs2/segment.c:879 [inline]
WARNING: CPU: 1 PID: 3320 at fs/nilfs2/segment.c:879 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1197 [inline]
WARNING: CPU: 1 PID: 3320 at fs/nilfs2/segment.c:879 nilfs_segctor_collect fs/nilfs2/segment.c:1497 [inline]
WARNING: CPU: 1 PID: 3320 at fs/nilfs2/segment.c:879 nilfs_segctor_do_construct+0x45ac/0x69b0 fs/nilfs2/segment.c:2039
Modules linked in:
CPU: 1 PID: 3320 Comm: segctord Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:nilfs_segctor_create_checkpoint fs/nilfs2/segment.c:879 [inline]
RIP: 0010:nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1197 [inline]
RIP: 0010:nilfs_segctor_collect fs/nilfs2/segment.c:1497 [inline]
RIP: 0010:nilfs_segctor_do_construct+0x45ac/0x69b0 fs/nilfs2/segment.c:2039
Code: ff ff e8 27 7b 55 fe 41 83 fc ea 74 18 e8 4c 7e 55 fe 44 89 e6 bf fe ff ff ff e8 0f 7b 55 fe 41 83 fc fe 75 07 e8 34 7e 55 fe <0f> 0b e8 2d 7e 55 fe e9 3c de ff ff e8 23 7e 55 fe 48 8b 44 24 30
RSP: 0018:ffffc9000b897b40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888030627000 RCX: 0000000000000000
RDX: ffff88802da60000 RSI: ffffffff832715cc RDI: 0000000000000005
RBP: ffff8880306272d0 R08: 0000000000000005 R09: 00000000fffffffe
R10: 00000000fffffffe R11: 0000000000000001 R12: 00000000fffffffe
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888021df8800
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8bbee45fc8 CR3: 0000000032ce7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000003b DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2373
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2481 [inline]
 nilfs_segctor_thread+0x3c3/0xf30 fs/nilfs2/segment.c:2564
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
