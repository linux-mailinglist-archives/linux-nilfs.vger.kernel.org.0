Return-Path: <linux-nilfs+bounces-804-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5697BB8B86
	for <lists+linux-nilfs@lfdr.de>; Sat, 04 Oct 2025 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CC874E00D0
	for <lists+linux-nilfs@lfdr.de>; Sat,  4 Oct 2025 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA321ADCB;
	Sat,  4 Oct 2025 09:17:30 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED01D90AD
	for <linux-nilfs@vger.kernel.org>; Sat,  4 Oct 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759569450; cv=none; b=AoCabm5twB7jFFIqurdEIbU4rzXFB1kbEB1QOEdWPrlBfTS4qRkjT4GN4WoC6e7CZiby4bHkf/aaJ9e2hXxgER74yRKslmB8hMYmTywsFzVNOMxNYPjm+Wv+skQkmqy+WTEnFsnSB3KvNEjhJTnuZ23uJVhRfpZBXYm4w/KEYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759569450; c=relaxed/simple;
	bh=h55S7+UKs6SEE8xfVRiy/8Pruq0+NinfBkohqQ3QxEA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z9WGDizE6yGeCKxrD0mhKPWOe0zAFYOTtZOHzx2OwEFYB+U6Lw6ua3PcwObmAOGeGXTbOkeDd3FCs6NUsN9Zps/5oK9I/XhXdn7WRSjk0y5kW/mg1VOe800TqdR/dtCgqSaHEh9ltodvSWHGd7TXZA9+Vye37TLeknvyNDV2MuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42e7b963212so56358485ab.3
        for <linux-nilfs@vger.kernel.org>; Sat, 04 Oct 2025 02:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759569447; x=1760174247;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIG6oZNTDpYclLfV7No+nENFcYt4Th02KE4t59yzIOI=;
        b=FsXwx8TJ/v1hUlm3wy9f++rB5lnu95GJJv2g0TnmBsotjaxlyGpBBEpod+fBU/B2IQ
         Id07m+mY1YckGy/3vwp47aBrzscLaMsXtBsrb0s8etZlPucPCsXu5fOXjqpMbZWWS43S
         zbS86HedxOrxUrEuR2i6BNByChtf0F9iUA/HwpbVDUgJPQoX7ZTsIrAK78tVHMCDKWGY
         phe6ZKivt018yb52yIqK3bhLHce1I1mSaujUVHgVbxJjj3Gvrt4N5Indfrxb0PYHyqGW
         QfShImOFEHg3Xk9/htoYRH9Jtwd0t8w20H1nGG7/znlN79GxJxUC7eL+8GiANooWJpLL
         ZvYg==
X-Forwarded-Encrypted: i=1; AJvYcCWVm+ReteMMiX1xZH5Hu0PIUVx5jKEXjzSk89AFPpQmJsrytPMCQGJ2+hPrMj76sjiQZzR/7l2GiYMsvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEkTTZcBK7l6Mwjrn4S5nJ9kjCWVq3sXkEQ6uscTXl3F6IrWp
	aTkGEFwz5fJUH1R75HdbrdNzKQkcETras5loGlIzTduFfx+LNThgoL1eKlRwUsp7Wj0AiMFo3+N
	KLiuHmHngPcYqqCZGFjblnEG1DAcm7dXpbTErlH4fn0YimdIbd43bHipztRY=
X-Google-Smtp-Source: AGHT+IG+svriUzw2DiMwSyLn1M5GTJ/87nULoyQvu6EYW2Pfe/unhigyNbS1LMDqpSUTCx7ZhfVPJhDz/E4xBvM+Rf/eBz5e+CSh
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:427:be36:2974 with SMTP id
 e9e14a558f8ab-42e7acfca92mr74974265ab.5.1759569447693; Sat, 04 Oct 2025
 02:17:27 -0700 (PDT)
Date: Sat, 04 Oct 2025 02:17:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e0e627.a00a0220.102ee.011c.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Oct 2025)
From: syzbot <syzbot+list7fdc58f8e19ec0678b0e@syzkaller.appspotmail.com>
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
<1> 6       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 3       No    WARNING in nilfs_rename (2)
                  https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
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

