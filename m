Return-Path: <linux-nilfs+bounces-271-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2598A4C46
	for <lists+linux-nilfs@lfdr.de>; Mon, 15 Apr 2024 12:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFDE288420
	for <lists+linux-nilfs@lfdr.de>; Mon, 15 Apr 2024 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE4447A7F;
	Mon, 15 Apr 2024 10:09:31 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E4645944
	for <linux-nilfs@vger.kernel.org>; Mon, 15 Apr 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175771; cv=none; b=FF8a+1Dp530J4h48h43+ClwsAIcDpDeG1hY4tKVjvSz3qBaD0KRFSb85830MBBgiMYS4hRSXJzeZPedpY9C4QKJZDSnAhWemJgvZqJJ0nwicyAO8XyYDkeoUu0VaGGZ1jr/Xt3bnMGtBZNsal+jgwhDuV6Kr0YlaU5PGFBVsO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175771; c=relaxed/simple;
	bh=y4cKMP+HingK/hArn6PPFVwM1YyhHRIgShZw2DxBL6I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mhs1vRWMtyhwswjlg+Uho2NrFpR77M45HO4xUufBztFIdxnGwNwvQ0o+RSHFh6RH8q36yi73ZXpwZp7tyOrVqTtf7EezUvICNT78ToVrHw1DedGm8Z5evEIuKwDLgeaEAReSgxPPOoWHANFwdMonys9Oykg7rdP57zqLysCkjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so323331839f.3
        for <linux-nilfs@vger.kernel.org>; Mon, 15 Apr 2024 03:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175768; x=1713780568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gdxc4wAAvYszVKlmAWW/tRckxl7eELxzR6qaL6OzyB4=;
        b=LBGg/W0lECdSAVbP74Lvks13oxFoeqZJ21c+6HmMzBmxC6t66o4xaCZeUmgTp//isH
         CXGCRNt3nYZ5gEy1vCNPRpdk5WY//DqKnjC+DoEI5t0KQBzG1pZBwVOslkgr9hwVzRw2
         QUw+6zIeWkGZSPBkL+NaO6rkHoo+thb4IQMz4QyHgwZY8hRkCTk1ZXODAAcIeLFBP0k3
         F9kVxSFMwOAw0CUdPle/Yp0ORtqDu+3VbABXBUlNe8rnT06X6/lSZXjIEYhdZV/5Qj9d
         40Ebjsyjy4npnUu2Gv6xx/2toNBsMU0hMvdSlJPD30vJ6HOxZOu0en6qfs/39UeFEAiT
         Nr1w==
X-Forwarded-Encrypted: i=1; AJvYcCUfBfscfBfG+HDHSPcbKr2XzS8EMewlFE9Rq4v7ZHIhBd3Xq0qOp0DR7I52mVGs1DYu1lAvA2RJPTXB1xto/7+Wc2x5Cd7V1t2gjuw=
X-Gm-Message-State: AOJu0YyErOdk8iQNbow18aY1QBVSsrfUlCOzlrPpOYkx0fd0dx/7Jmwq
	mPctsCEpEeLp0hI7GP3f2Ke2THrnZHSauh/q4HeAOYxVZHyaKiR8J2Nee/YclBUR2t8khnkGa/v
	cNrevV+Tz3pswXBONxJt9vGIGr/acLO9evItSR56Rrx81Kp0tBSidU8U=
X-Google-Smtp-Source: AGHT+IGYKAoPgLVFYAkgWpMm+HuMLUObNZwm5//U16Jh0CP9KJYtChWsoZmx4BwTC+Zk4F2qWWDYhcz2A3pMU2sQFKoJrArQ7lfF
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8728:b0:482:fccf:d8a8 with SMTP id
 iw40-20020a056638872800b00482fccfd8a8mr279504jab.0.1713175768630; Mon, 15 Apr
 2024 03:09:28 -0700 (PDT)
Date: Mon, 15 Apr 2024 03:09:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000209c9506161fd1d4@google.com>
Subject: [syzbot] [nilfs?] UBSAN: array-index-out-of-bounds in nilfs_add_link
From: syzbot <syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1777792b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=2e22057de05b9f3b30d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1176600b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15141b43180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/de3bc2f4acaf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/nilfs2/dir.c:257:18
index 15 is out of range for type 'unsigned char[15]'
CPU: 0 PID: 5057 Comm: syz-executor165 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
 nilfs_set_de_type fs/nilfs2/dir.c:257 [inline]
 nilfs_add_link+0xb39/0xb80 fs/nilfs2/dir.c:501
 nilfs_link+0x136/0x220 fs/nilfs2/namei.c:192
 vfs_link+0x4f5/0x690 fs/namei.c:4608
 do_linkat+0x356/0x760 fs/namei.c:4679
 __do_sys_linkat fs/namei.c:4707 [inline]
 __se_sys_linkat fs/namei.c:4704 [inline]
 __x64_sys_linkat+0xdd/0xf0 fs/namei.c:4704
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0624efc679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6dc40a98 EFLAGS: 00000246 ORIG_RAX: 0000000000000109
RAX: ffffffffffffffda RBX: 00007fff6dc40c68 RCX: 00007f0624efc679
RDX: 0000000000000004 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007f0624f70610 R08: 0000000000000000 R09: 00007fff6dc40c68
R10: 0000000020000640 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff6dc40c58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

