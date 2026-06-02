Return-Path: <linux-nilfs+bounces-1624-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ikl6G3AbH2pPgAAAu9opvQ
	(envelope-from <linux-nilfs+bounces-1624-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Tue, 02 Jun 2026 20:05:36 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA44630ECA
	for <lists+linux-nilfs@lfdr.de>; Tue, 02 Jun 2026 20:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-nilfs+bounces-1624-lists+linux-nilfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nilfs+bounces-1624-lists+linux-nilfs=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9E31301945F
	for <lists+linux-nilfs@lfdr.de>; Tue,  2 Jun 2026 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3931AABC;
	Tue,  2 Jun 2026 18:05:32 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF631987D
	for <linux-nilfs@vger.kernel.org>; Tue,  2 Jun 2026 18:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423532; cv=none; b=GJ/elWHL/pdRAqtW8d+XnZU/L56OqVcOhwW8M4FE+78eA1wF/RGQ4tIgK/+aMNMqz5+Z9sKMEidq0UHF8Ho+cT1lb81clneyb0Y4CsJtSc81km2Humf+bFlvdUybnZcSAWF57BPA7oN/c0Pi2a+B/rQ/776VBv9EMVCbpgBIR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423532; c=relaxed/simple;
	bh=WzpzICU25Zv9ZOEmPM50g75dhf+S24LnaiTzHypvvKA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GROWFrj0jR5UyQ5gy2DZyq7aoUR5UqyqAOVA+wJqc+2whUq0xEh5dd0J8fSu2pHkb3aidAqgIfYoNnii6/b0jOldtswvxGyaUdM1Y2vTWQMrUYaOV6T+Wr6l4Ncq/avuMY78WD4QigGzkqT/E6ITcqbW08x1jYz0q21BPpgJols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69e412347c1so1080103eaf.3
        for <linux-nilfs@vger.kernel.org>; Tue, 02 Jun 2026 11:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780423530; x=1781028330;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsexvP+uYpzrCbvDssZc+HgWdqJyuCaNaIHqOPAMe4w=;
        b=pu84fTStJikD/2Z5/sxLcCuqHSD+4UelEVZEx3nfsQQsY2RmzNGFwrWMn94Z8uWBfW
         6yH5yEzL597hZ56ghBf7sqL49ZOBIsqOq69GR5YyeGfgzCmPY051YUkcShsa4HZMYlSb
         cAGNAxCC+5HO+k0Txs0b32mzECQ5BmR0Pv5g7O/dTAC4VE18TFo6J8HHsiD2BjSUmXdf
         YWl6a4gMxoaxsrxz+TuSZUpOT0kyiNLbGD0zbKC94aDxa5DB0GM4U9yMAPkMg/KNXdI9
         zGBDoLRSAWKq646HIM3izflM3X7gkKVO/umDLkxgU91Kj+wSXKEaMZWvqGidKKnGyBFf
         Ed2A==
X-Forwarded-Encrypted: i=1; AFNElJ8Hbwpi9oDWQxXl0d3iZLJFfc6Y3YuTkDHPQ0wpnZEzHy4PCDiyI1HetlyFDALD6wpKz7U32ikAhPleKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxrAOksa+DzJD8YatpcGHdEi4s3wr10WWaXzYZP/i3VfgmdoE
	muGXObo/d7qsD2KWJetJmDT87yk6dbXBkWqvuaOtzYO2rFzeg3dEar50I/PLhe/k/Ma2X75f13Z
	wYRMZalc4XxeHrdHSXl+OaVsIzDD2KG4tqWpTHO02odZKl8TVsDtMcHZS5dQ=
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:82a:b0:69e:337e:5a7c with SMTP id
 006d021491bc7-69e47e64fe9mr137336eaf.11.1780423530311; Tue, 02 Jun 2026
 11:05:30 -0700 (PDT)
Date: Tue, 02 Jun 2026 11:05:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1f1b6a.fbc46276.3c3783.0009.GAE@google.com>
Subject: [syzbot] [nilfs?] WARNING in nilfs_segctor_abort_construction (3)
From: syzbot <syzbot+5957361606d7b750b874@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b4166e8ea5fbf7e3];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1624-lists,linux-nilfs=lfdr.de,5957361606d7b750b874];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:konishi.ryusuke@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-nilfs@vger.kernel.org,m:slava@dubeyko.com,m:syzkaller-bugs@googlegroups.com,m:konishiryusuke@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-nilfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,dubeyko.com,googlegroups.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-nilfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs];
	RCPT_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCA44630ECA

Hello,

syzbot found the following issue on:

HEAD commit:    8fde5d1d47f6 Merge tag 'acpi-7.1-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bd1ab6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4166e8ea5fbf7e3
dashboard link: https://syzkaller.appspot.com/bug?extid=5957361606d7b750b874
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8fde5d1d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d8eca02a966/vmlinux-8fde5d1d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01e3e901b0a4/bzImage-8fde5d1d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5957361606d7b750b874@syzkaller.appspotmail.com

NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
NILFS error (device loop0): nilfs_bmap_lookup_at_level: broken bmap (inode number=4)
NILFS error (device loop0): nilfs_bmap_lookup_at_level: broken bmap (inode number=5)
------------[ cut here ]------------
ret
WARNING: fs/nilfs2/segment.c:1507 at nilfs_cancel_segusage fs/nilfs2/segment.c:1507 [inline], CPU#0: segctord/5339
WARNING: fs/nilfs2/segment.c:1507 at nilfs_segctor_abort_construction+0xd7d/0xde0 fs/nilfs2/segment.c:1873, CPU#0: segctord/5339
Modules linked in:
CPU: 0 UID: 0 PID: 5339 Comm: segctord Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:nilfs_cancel_segusage fs/nilfs2/segment.c:1507 [inline]
RIP: 0010:nilfs_segctor_abort_construction+0xd7d/0xde0 fs/nilfs2/segment.c:1873
Code: 8b 05 67 50 84 0f 48 3b 84 24 a0 00 00 00 75 3e 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 8a ca f7 07 cc e8 64 47 11 fe 90 <0f> 0b 90 e9 cc f9 ff ff e8 56 47 11 fe 90 0f 0b 90 e9 60 fb ff ff
RSP: 0018:ffffc900039ef5e0 EFLAGS: 00010293
RAX: ffffffff83b47fdc RBX: ffff88800e4ac2c8 RCX: ffff88801fb1ca80
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
RBP: ffffc900039ef6d0 R08: ffff8880436efa07 R09: 1ffff110086ddf40
R10: dffffc0000000000 R11: ffffed10086ddf41 R12: 0000000000000000
R13: ffff88800e4ac338 R14: ffff888046f765b0 R15: 00000000fffffffb
FS:  0000000000000000(0000) GS:ffff88808c893000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe074a99e3a CR3: 000000000bb60000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nilfs_segctor_do_construct+0x6e3f/0x76c0 fs/nilfs2/segment.c:2186
 nilfs_segctor_construct+0x17b/0x690 fs/nilfs2/segment.c:2462
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2570 [inline]
 nilfs_segctor_thread+0x6c0/0xdc0 fs/nilfs2/segment.c:2684
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

