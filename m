Return-Path: <linux-nilfs+bounces-662-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F4A23BEC
	for <lists+linux-nilfs@lfdr.de>; Fri, 31 Jan 2025 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D1168987
	for <lists+linux-nilfs@lfdr.de>; Fri, 31 Jan 2025 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DB1195FE8;
	Fri, 31 Jan 2025 10:07:28 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD4199384
	for <linux-nilfs@vger.kernel.org>; Fri, 31 Jan 2025 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318048; cv=none; b=ihYeJfwF1rDRb9kca8GBUoYM4AyaoBNa067hHQGY26Yx/O3lbTTnu+sjRF5rutDHyjDAB9bRVw437lmQbFOiLK5RSCByZB2teKo28YQ3YIZkYA7VpCtinpuHT65gbHpXRSGOYREQlyEtTpllwEwmJgN688yjaKJR0SgxYl9wkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318048; c=relaxed/simple;
	bh=DXG8pKlNLgjPS3BPFcbodfMnoXMpVjHszsc4cTN2uV8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hzDtIzFw4uW6KMU8VfqDPt/RifAdv8qBlXLV80mKTYpkNDY8t4QU+AZlKZFpVYy3z3quTc7Cp19YYOO+WZXVs7KlsVPPy0l9Fg8Hen9kgrZ1CYf/WgEEY4INnJS7RZg+hTntUPDzhbWZAqbYxA93i9Us+RxnbPyeaHXzJDO0Hgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8498a21afc2so115326439f.1
        for <linux-nilfs@vger.kernel.org>; Fri, 31 Jan 2025 02:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738318045; x=1738922845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwUorlrZ8ktt05OjgOA/eExZcbhdaaXaK8Q7w1Q0dRg=;
        b=Lgab906ia6WgHJXGZmBYBzIfkcNf1U18nt/2rzaZ7K7ScTlT8eHiiDA2FmeoqufKSj
         HXfoIvnt8VDxth8V6qXxAn+n7UGaReGG2VcxNZZQayc7S3U6xkvmjtJuPWuNNrj6k4iY
         oa50DbPanEtzpZx+NlLNmr0LhQ9nMI2eJQNi8XzPLHuUJag5XlDRWvclUqD5OMbpYlIv
         mIQ14yMh2RdDuln7lbNp6APXEsFaXJ7fprEguJ4B4qaYgnpivL+TQ2ffxv8PyJGToP2z
         eLi2ba6VHGtKaI+7lW0bveGgUPd7ECixaUcRF+xpU3PKRNjUe7JCE6ULslTCTC/5XfbZ
         DgAg==
X-Forwarded-Encrypted: i=1; AJvYcCUp3XSrEOvYBuIE0sxGPzy6lnpYz6vH3A2HVqZ8gDqqlirBZHF2jxPcopYyPLYEarb9UbaceqfyM8wNmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHEgZg0AwDslVTS6LXCBriI5CsaTpq5o4iE4I5L42BzJkE1HHG
	t5hml2tmSc29J7HgnDVg8HQxQL0qwK/PMt/Vv+nUg3Q3c9KRsBpt/8yZXgiwrkP6e3MObOGq5eR
	Lxguk2ItHzLthQ6nsb5R3Xtde9gm8PTrI5PR/hPvHIZl7I5IrOHbqK10=
X-Google-Smtp-Source: AGHT+IE5uylcSF75NfSvd2alp7HamPcRT8jxqnE7umuCkCCmzpZrlh6L7IFse9KZr2KSfdwFYKggofD3eo9mSZ1eVDBctyFzPItA
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c269:0:b0:3d0:137a:8c9d with SMTP id
 e9e14a558f8ab-3d0137a8ddcmr22150745ab.8.1738318045564; Fri, 31 Jan 2025
 02:07:25 -0800 (PST)
Date: Fri, 31 Jan 2025 02:07:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679ca0dd.050a0220.d7c5a.0041.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Jan 2025)
From: syzbot <syzbot+list7e775aa95a724108e231@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 3 were fixed.
In total, 5 issues are still open and 60 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 4       No    WARNING in nilfs_rename
                  https://syzkaller.appspot.com/bug?extid=de6c4b3beb823e112ead
<3> 2       Yes   INFO: task hung in find_inode (2)
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

