Return-Path: <linux-nilfs+bounces-466-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE7A967C22
	for <lists+linux-nilfs@lfdr.de>; Sun,  1 Sep 2024 22:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E611C20954
	for <lists+linux-nilfs@lfdr.de>; Sun,  1 Sep 2024 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B47C6D1B9;
	Sun,  1 Sep 2024 20:39:24 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73394273F9
	for <linux-nilfs@vger.kernel.org>; Sun,  1 Sep 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725223164; cv=none; b=eepDLgvYYmFBdUCwA2IJf2coydgqVjvNLph6XqrLTHP91QkpaNLLrZYHMEjDp2c1VGy46ZtTdzaohn0yO65xCcM2GpPT6/Fo92v90AjaFadCHXazbJByymeqnSnRActhj7OksLnWSJr3eYZKeSeS+WdKYWzzVd0MrOg9T6GebWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725223164; c=relaxed/simple;
	bh=zVdNKVHpbZRnpytZlzP2HvPNhlSGqzarJG+hVKb2raw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ixzr5bgiDJALNeIb1D1LoWmY8V0UxdgR9HphcolGPvXm85LMLq+3nqMpML+xfPZ/K3aiYwYODInC90he84ZUXZU4LB4QjG+UdYtR+gQ+1LMb+DMsbTKsRLozJP5bRp/GJRNFmroVYTBwoOjcKzy7C10wquzKH37rgAiocJLnOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a330ab764so215781039f.0
        for <linux-nilfs@vger.kernel.org>; Sun, 01 Sep 2024 13:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223161; x=1725827961;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7Jx+9e8vKZXmFDe3Lh781jbbu1xB/DrqqHfXnvqEdE=;
        b=K8Ck//Va2fmw3HM4jrwf5AFeQ7wEaXD9DcpVhM4kchqIYS5Mvn0ebr5uGyotTHD4yX
         7arFHkCOmia1w+p7upyFXda9BoAWNVUeavg3QN38rUONjtdwD0xP3N8/FruE2lhl8grS
         cj/GKNFWIbZ/Z59gmquR6b3XaHzpCY49yzseprHhCxcraUZLGTkmtPSKKtbCfmJtHREH
         fFQCj4R8FVN3aNBDiAIDc5UBrvwgX2fpIYfz8H/XFniMdj4Xqn+xL2ZW35aAu5Yve1Q3
         JgpQszz62FiVHOz45WUEWBPk6rIg4EXdNf8nEQZsyuNL0dvlQIyJ8TO34KrEBNgHz0lF
         F94Q==
X-Forwarded-Encrypted: i=1; AJvYcCXflsi3wUqSvz5dgGWyc29iqAc7pHhFwh52lQf0cDn67oW91FzB2bBRDDCjp/F9n/BjfhzhTKMXryW1+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBxqhlWkY2G8i1kuyJ8tI/FrjUZdZ5I+qYXj7PhL5/bTpfs2p
	yUD+2idbN3WaUpNg5X+CCVYSu378lUEUCw7ZAv9p6WDwcYiKpOBxnErCIr+xsShdTSTGjWtW1pe
	5vuWtq3Gz6n70DaoGVhdwVVENIl5wBZgtpeKru41Vww7QPozaeNid4kA=
X-Google-Smtp-Source: AGHT+IEGxNdvHEGH5w/DmQq4MAz4zwanPBILDDn+HS9WBs0qmOUEAn1gqt+1yCegaSkSkqDNaTQZrORwEqvIFaQArITRYmJWviQb
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13ce:b0:81f:7d7d:89fd with SMTP id
 ca18e2360f4ac-82a2623e7eamr60325539f.1.1725223161607; Sun, 01 Sep 2024
 13:39:21 -0700 (PDT)
Date: Sun, 01 Sep 2024 13:39:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4cf9a062114d132@google.com>
Subject: [syzbot] [nilfs?] general protection fault in nilfs_btree_insert (2)
From: syzbot <syzbot+9bff4c7b992038a7409f@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86987d84b968 Merge tag 'v6.11-rc5-client-fixes' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c2b835980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=9bff4c7b992038a7409f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fcc40d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143f1643980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87692913ef45/disk-86987d84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a27da6973d7f/vmlinux-86987d84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e28d02ce725/bzImage-86987d84.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e3fe6fbe935d/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f5280d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140d280d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=100d280d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bff4c7b992038a7409f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 UID: 0 PID: 5220 Comm: syz-executor243 Not tainted 6.11.0-rc5-syzkaller-00057-g86987d84b968 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:nilfs_btree_get_nonroot_node fs/nilfs2/btree.c:418 [inline]
RIP: 0010:nilfs_btree_prepare_insert fs/nilfs2/btree.c:1091 [inline]
RIP: 0010:nilfs_btree_insert+0x6d3/0x1c10 fs/nilfs2/btree.c:1252
Code: 8d 9f 80 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 ab 89 8a fe 48 8b 1b 48 83 c3 28 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 8e 89 8a fe 4c 89 64 24 28 48 8b
RSP: 0018:ffffc9000352f4e0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: 1ffff1100f66a0ee
RDX: ffff88807d6f9e00 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc9000352f670 R08: ffffffff836d1ea6 R09: 1ffff1100469939a
R10: dffffc0000000000 R11: ffffed100469939b R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88807fbd9680
FS:  0000555573e9d380(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc785a110f8 CR3: 000000007ea40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_bmap_do_insert fs/nilfs2/bmap.c:129 [inline]
 nilfs_bmap_insert+0x25e/0x3c0 fs/nilfs2/bmap.c:155
 nilfs_get_block+0x428/0x8e0 fs/nilfs2/inode.c:101
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2125
 __block_write_begin fs/buffer.c:2174 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2235
 nilfs_write_begin+0xa0/0x110 fs/nilfs2/inode.c:262
 generic_perform_write+0x399/0x840 mm/filemap.c:4019
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4147
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc785999a99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8363c328 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc785999a99
RDX: 0000000000004000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fc785a0d5f0 R08: 0000555573e9e4c0 R09: 0000555573e9e4c0
R10: 0000000000000a83 R11: 0000000000000246 R12: 00007fff8363c350
R13: 00007fff8363c578 R14: 431bde82d7b634db R15: 00007fc7859e203b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_btree_get_nonroot_node fs/nilfs2/btree.c:418 [inline]
RIP: 0010:nilfs_btree_prepare_insert fs/nilfs2/btree.c:1091 [inline]
RIP: 0010:nilfs_btree_insert+0x6d3/0x1c10 fs/nilfs2/btree.c:1252
Code: 8d 9f 80 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 ab 89 8a fe 48 8b 1b 48 83 c3 28 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 8e 89 8a fe 4c 89 64 24 28 48 8b
RSP: 0018:ffffc9000352f4e0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: 1ffff1100f66a0ee
RDX: ffff88807d6f9e00 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc9000352f670 R08: ffffffff836d1ea6 R09: 1ffff1100469939a
R10: dffffc0000000000 R11: ffffed100469939b R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88807fbd9680
FS:  0000555573e9d380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005582b0414000 CR3: 000000007ea40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 9f 80 00 00 00    	lea    0x80(%rdi),%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 ab 89 8a fe       	call   0xfe8a89c7
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 28          	add    $0x28,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 8e 89 8a fe       	call   0xfe8a89c7
  39:	4c 89 64 24 28       	mov    %r12,0x28(%rsp)
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

