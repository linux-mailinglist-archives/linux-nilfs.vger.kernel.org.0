Return-Path: <linux-nilfs+bounces-361-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F7B902A4B
	for <lists+linux-nilfs@lfdr.de>; Mon, 10 Jun 2024 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D312869F0
	for <lists+linux-nilfs@lfdr.de>; Mon, 10 Jun 2024 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5454DA09;
	Mon, 10 Jun 2024 20:56:27 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3A17545
	for <linux-nilfs@vger.kernel.org>; Mon, 10 Jun 2024 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052987; cv=none; b=OGg+REOmb6OVup/dMibJNTeXM85fU7vIOL4XPcMlrNsGQgZpqEXxtmOpzvJytzM9si8Fe8oYm4aLOrIbfw+UacXnJAf0j7CvC3RlsnO2c+tRYLYq+1GUe6+MEbMvPH7bPsECQeH9KdHcrNfWLae2fvb+4PllYyBbaN3Ywwu2F3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052987; c=relaxed/simple;
	bh=kM1qAszBlDyRnI1jvPB95Jl9MkOal4zQa4ihed3rjjo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vv5hGpSrcLFpone+mijk2LJ4SSqaHTUZupgqywm4wFJFV/OCve2EKuXIOiX44sUHaHdkjaLlUvAo8xBxFPs4XjBdGgbjSGAGoXoS8NkCHU+I2rEBasJGeMqD8VfY3F1C7zP56NXedU0CO5BLupNi+2Vv2bIDWuTc1borTBU7T/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37596e877e9so30425895ab.3
        for <linux-nilfs@vger.kernel.org>; Mon, 10 Jun 2024 13:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718052985; x=1718657785;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H65LHHWxLLyJW3/ZC8B5eQIifhgG1a6hoslfkmbgRYk=;
        b=hvYldQDZwv09RSOylq/BxlcacrDyi61lLObK+Ov6fpua0V3wPfHhA3UrKulgw4kTAC
         1//0ANgP+ec6pZt/MSgD54HCjDTUyx83QW6zq5kPBIETnJjBs+P+piWp+Bz4fYOh0Ak7
         6AW0lD9SKq9bjqtjgN0+Icbze1jzlefLiVKgOiituz/1dVGAgovloMwMwv+e9CCV8Cg7
         +mTqsD1TnY0oTPx47Vth6OfVgsQRCF17J+xseg6Bp02pstblCCKjLLiQHFd3SMlLfg1Y
         aVho4C1kBGV5xu6qGoFnecJYxY7HoFfc91gwXkwDyUqwWUkUh6nPlAIvxYqjXEe8SZIu
         JC2A==
X-Forwarded-Encrypted: i=1; AJvYcCU1bo1fMrc4HzvFafYGwarQ3ylzPiEwgu6WhZLVzrAMNXIURJRLogGniVs2BaSKXX1xJFpmwhK3s4tlFWrY15qv14gtTB6SVGSmn7s=
X-Gm-Message-State: AOJu0YzA6DEnhsTwzMHWsYKgq/77WsbgQanXbNbd9Yd+EWL5O+Z37OeS
	h/tYOdeNVDxcpTHK7lBkXD4vSkAbtNjLSJxalPgfZuLvstVgNO9q2IEL3Pykzn9p5yNMbIcYkXA
	i9oxYyqMSpRq6TTdpBc2NkkH7z0oTB2aswMecCctfbwFHxzvfVZ5MtSI=
X-Google-Smtp-Source: AGHT+IHH23tGS+7xmiqVcfrPcaI2EeWrQEl2seOkIXBLJiqfSkdCr+QLeYC76PG6jsf0DFcOUqi550KrzDGSuvPER6nyvDp22Hgu
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:374:8aa0:23e4 with SMTP id
 e9e14a558f8ab-3758030e51bmr6945835ab.2.1718052985047; Mon, 10 Jun 2024
 13:56:25 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:56:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e11eb6061a8f6107@google.com>
Subject: [syzbot] Monthly nilfs report (Jun 2024)
From: syzbot <syzbot+listf46d964ba2cb22ab21f2@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 2 were fixed.
In total, 7 issues are still open and 45 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 70      No    possible deadlock in nilfs_evict_inode (2)
                  https://syzkaller.appspot.com/bug?extid=c48f1971ba117125f94c
<2> 32      Yes   KASAN: slab-use-after-free Read in lru_add_fn
                  https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
<3> 13      No    possible deadlock in nilfs_dirty_inode (3)
                  https://syzkaller.appspot.com/bug?extid=ca73f5a22aec76875d85
<4> 8       Yes   WARNING in filemap_unaccount_folio
                  https://syzkaller.appspot.com/bug?extid=026119922c20a8915631

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

