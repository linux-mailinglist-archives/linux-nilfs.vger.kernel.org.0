Return-Path: <linux-nilfs+bounces-781-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C41AED979
	for <lists+linux-nilfs@lfdr.de>; Mon, 30 Jun 2025 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D231A3A7732
	for <lists+linux-nilfs@lfdr.de>; Mon, 30 Jun 2025 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8D253F27;
	Mon, 30 Jun 2025 10:11:34 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D9254B14
	for <linux-nilfs@vger.kernel.org>; Mon, 30 Jun 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278294; cv=none; b=Bz7pXZg9Qo1hHwi5Q8uOlJIYj39qEN2kOUJX3wLs0fgXBQIIOj9hV5Ru1RQOiUUDEttARNEV5TZx+DY8GOUMhEox5eTjjo4ZYKH5dI290CMKHLhxuGQfXT26US2Pwv7uwZMN9K9R42QZBcko8V1tbEHuQHmg7/ffhTvL1MH8gBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278294; c=relaxed/simple;
	bh=VCXKrRSd2CpJaoagZoPqOGMjsSSSy+qFo9PLjXhB7FI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O6tUg/TcUVicKwO61yC4SdZLS7LhGRDn3+5PML7mMmdl9QNV7P1STk1+YfW9UPmL0YFbaswCXnoA5Qv34ithDlmcmPP20SCSLPnvz0rPXskWo7CScS3+eu1CYVNT9g/eLVx9vCW5E1Cn+pxFpquGYDMJb+MJ1U0iSxe3Efm4LIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2e9e6146so11656355ab.3
        for <linux-nilfs@vger.kernel.org>; Mon, 30 Jun 2025 03:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278292; x=1751883092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKf8t8VNsTOPB7f/2BZaxEBK4BZFnLX2PjQ2WNNVbQs=;
        b=C7y4ZjfPzYWckmXDq4UCZ/6pP286kuMMBbOpJeIPMb00o+mYharApu3UWMZJdfeUVL
         LEZ2K4oMcdVZgOtCelk48d/L9p6FVbFfvqaIFzkNnXOVUOWVQuqzRsyROgLjnpJOp1Zs
         pBQRsJdswrxxSrL40gNWRp0EnV0NHbNQI7+tU2T10AF/1OhFoLxaMQ9ijQA7kkCoQ6+r
         ON+nR7Ff/RWMnpMVtlZh76JjjKsVq2hlE/eyOUPZRrXAvdUA5M8XifAaGh+z4Sgf718t
         Z6xO+BdZ1+xXRHkfN0xLvuOZU31EeUTqwJ2GFAs9B4omphGWyVyZRirin9juujMNY/08
         TGfw==
X-Forwarded-Encrypted: i=1; AJvYcCWs9kOitsUl6xr57THZuQGe6mnkwK72zAe7I7otwNPvKTZv4XC/o8NwCNHRtplEWtrkbXzdou6mOVOCJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiaH3W4HwCOT+/b7ErLeExF9GA//1NDRN8U4Wk1sq+Q83Vi6ox
	JpHlYGxu+90IISal7zkOWZNab3Ngy56K2NVwOTg0F0r3/czrY7MYjKQgaC++znVX3pA8XwXuMf0
	yJZXPaeLI0gLUVB+sVcqFOCYrQ2dnt0k0PBxqpQsKbYu8UbiVoa4Nb21p+A4=
X-Google-Smtp-Source: AGHT+IETtP5L0eB7lb+QCOerQPj+ZJtdwT5xUzB95f9FWfz7MdArtJs11cRmz8dA1pVRX6a5Cb5mXpP3PS4OY3C9FVwboM99+jhY
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:3df:3afa:28d6 with SMTP id
 e9e14a558f8ab-3df4ab56adfmr131218195ab.2.1751278291992; Mon, 30 Jun 2025
 03:11:31 -0700 (PDT)
Date: Mon, 30 Jun 2025 03:11:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686262d3.a70a0220.d08a1.0003.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Jun 2025)
From: syzbot <syzbot+list293dd5cbecebc40b22f2@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 2       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 2       Yes   INFO: task hung in mISDN_ioctl
                  https://syzkaller.appspot.com/bug?extid=5d83cecd003a369a9965

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

