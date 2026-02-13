Return-Path: <linux-nilfs+bounces-1130-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE/MD4njjmluFgEAu9opvQ
	(envelope-from <linux-nilfs+bounces-1130-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Fri, 13 Feb 2026 09:40:41 +0100
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E59134242
	for <lists+linux-nilfs@lfdr.de>; Fri, 13 Feb 2026 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A19E8302DE03
	for <lists+linux-nilfs@lfdr.de>; Fri, 13 Feb 2026 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2933D518;
	Fri, 13 Feb 2026 08:40:38 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DD33D508
	for <linux-nilfs@vger.kernel.org>; Fri, 13 Feb 2026 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972038; cv=none; b=CoTB0x8T2uhPe5jAlkaeIay3RAh7qZmeoydn0pUH9G6JjG1ONjjaYNbd7dNeELphwW8dUwdIgQTeqBA5HlkmC5EdaoOp3IVkCYANchSUKoj9vtQkLLDkPbRlAmiYKZOW21egU/cio7S7nSYlPiqxbbJhMEHRMlsniEA2Lvs+iyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972038; c=relaxed/simple;
	bh=WDhD5psvG2AxZ2QvGXE9hgYo1EyBLCsNzkxK3MfoUfs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N1nz80P8bDstrHtK2EITAaNob7VlzScF34RBk7pL0p/SszMLTBqRovdVRmzPNOOAeP86wuCgO6vow9AYcxkUIUSB0oXSQT8OwLb7/grY+s8zB2bhNyEBCAN+MuI4R0AyUZhSyH7SMVO51UZ0DJHwdpJ+n1T7ZcdW/oroputFA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6751720c676so5881891eaf.3
        for <linux-nilfs@vger.kernel.org>; Fri, 13 Feb 2026 00:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770972036; x=1771576836;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scCZZg3Vh0JswBMR2QvcF/nq06ybDJkUtCTpqsIgIlc=;
        b=mq3rkg/c3QhmAem8P7lXx5wJ2GDVVDx78XCDfEuEfHdLFRkcrdIkescg/u3WZ2Uo3s
         9sLZvo9vbJdBVyaWRFgZRniB75B5klioYWaBbk4Ssg8PZjkw4yf/7+/uRzt3GhqsHfV3
         xp7qYtibZSDpKG4yWZnDAWrXyYy+1vuVDov19ZfdRSt8maw2wtX57x6TpMzbaEnRjeKB
         1d4vLeRUPpSsXtan1LwcrSUAlmg3MongSxhQ2T+KjBgaqrrk3Ao0t3RfZY7ms4m5b1g+
         feAD7t1ScKApjvzuKuFtPO2DSzyuo4ZheevkR6BVJFZLT0mh4LzqT9eDecjVSGhNYuiE
         tcZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCQQMARp00WkQhxolUfIiFzx0wwmO5kLvdz2EIQtKPTGlXpnKQi/zGkdigpkx7Dt6sNxZsQDFmGyfUOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lTd03yJcwNcsm1LZsxXczlaPyFpXr+ls03n5cehiWLBx4OTQ
	UC73QlgHUekdpqxae/MjscxQ6RS+sQ7kAKykJ2RT3vjfX7qAk6YeiOzwa5R6vy8czcce9fn4sXY
	4Rdp1eilVs/5kJHTqQkX5irtCSeb6ImHw3cz9O8UYrmvWcekvs7GvjS/HU5M=
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dcb:b0:66e:ce9a:f404 with SMTP id
 006d021491bc7-67766cc3384mr364732eaf.13.1770972036192; Fri, 13 Feb 2026
 00:40:36 -0800 (PST)
Date: Fri, 13 Feb 2026 00:40:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698ee384.a70a0220.2c38d7.00ba.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Feb 2026)
From: syzbot <syzbot+list9d8018bad17431b2d4e0@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-1130-lists,linux-nilfs=lfdr.de,list9d8018bad17431b2d4e0];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,dubeyko.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-nilfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: B1E59134242
X-Rspamd-Action: no action

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 14      Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 12      Yes   WARNING in nilfs_rename (2)
                  https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
<3> 5       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

