Return-Path: <linux-nilfs+bounces-792-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A15BFB40444
	for <lists+linux-nilfs@lfdr.de>; Tue,  2 Sep 2025 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9264E4E3F0F
	for <lists+linux-nilfs@lfdr.de>; Tue,  2 Sep 2025 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF633009EF;
	Tue,  2 Sep 2025 13:36:36 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3703112DF
	for <linux-nilfs@vger.kernel.org>; Tue,  2 Sep 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820196; cv=none; b=u4MyFN+aY26GTdoeFOm9kCVRCWUK9XXGoiXPaG6v4q5YYaP/rJZWiVYr4XEL57JGY7Mme9heVxTC1nuuKT+P49/L0kWy19+1WpezBic7PieSrbjlp2XuigCg68TelsC06+FjqVNScEAL2Rp7Id4TpgqtFIrgy123/e+GqD/X6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820196; c=relaxed/simple;
	bh=XU12tgy5cFtNfHDTSDSMaY0YEy+aNz1anhwqSwHvSdU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fUVqhfzuwVbYX+7z2jbBpX0Xbyw/JutnC8dEhuV5H7f7RmpJlVS8WvnVmPKU1181O71DZy5LuMzUHedG0zfllJ7JC7/1f4xXJeCmv6KJZq9bV2l5u8fU+LWibjSJjJP+9D88OCI/4Hmt3lj1ickNJpHA6OW4lI0jnizDjqFzN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8873696cda9so153159439f.1
        for <linux-nilfs@vger.kernel.org>; Tue, 02 Sep 2025 06:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756820194; x=1757424994;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ4WUckzf+thXGnhKppJ/Gc49Jj6gD+28ZH2a1rykdY=;
        b=idxJG1NJcELeBQLBmXvRFZhEcnkGirV/06UXiPlK/kMCdFrPtaW9WDYqke1yAJ8mWs
         hlz+FP7HuXL7BDs25geh/4VUPr+9a52h6WVMhOlzuBz/wJhVnfGXacxAbmROvO6l2jPp
         ONvJIkRO57vqRXUErUS/AeV890tyk2tdhvRnxyiYnjbNF9lBLgl13wMQOJy5l7e+CZJ2
         fD/uNeloziE/FcWt7m54wu2Yx00cpbe+Taypb9CgOvUByA6MPMHi4bKfPCMWMLHlnVxk
         UqkyT8LXVR8pelr122Id0nS52RusmDu+LLtLNF2PxSJMTBMBD/pr+dwMP9MahGPx+5kX
         guIA==
X-Forwarded-Encrypted: i=1; AJvYcCX++KYc5gd6Y362VAMIhyvpGPKgFZjBtBlHxQS/7MNk0fjA2a0PkFipqnLptB0XOJDl0nhHHk0JhfaKXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkgTUzd3WgcDROBNsjARV/c38n+6V725d9lDfydpGPb5tHayA
	YRBVxcZ0ztXF4KbVWgpXEx40nGCLpM/S4Z+6rp2IYFDZu4kAh9J/L5cLyqw1SkfdKzuvz+/myNF
	Qllp7wNvZU7kudsSb7vdPhOWf4w/ESHYOxwgAb+8o16cmh6EnKFJL3Gfxfjg=
X-Google-Smtp-Source: AGHT+IFqPcNrz9BJatttRCnPm1PX4Yoqp4tnOBpH54zRujZhTQz5Xkn9SOm3Mya0CC8xwe1f0Pkl0io72pYDe6J3PAmtDXeSiVNJ
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:3e9:9070:b0bb with SMTP id
 e9e14a558f8ab-3f401fcf87fmr224323215ab.15.1756820193804; Tue, 02 Sep 2025
 06:36:33 -0700 (PDT)
Date: Tue, 02 Sep 2025 06:36:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b6f2e1.050a0220.3db4df.01d0.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Sep 2025)
From: syzbot <syzbot+list9215b00f957a8e369653@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 3       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 2       Yes   INFO: task hung in mISDN_ioctl
                  https://syzkaller.appspot.com/bug?extid=5d83cecd003a369a9965
<4> 2       No    WARNING in nilfs_rename (2)
                  https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

