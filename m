Return-Path: <linux-nilfs+bounces-190-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED944847B52
	for <lists+linux-nilfs@lfdr.de>; Fri,  2 Feb 2024 22:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC76284C78
	for <lists+linux-nilfs@lfdr.de>; Fri,  2 Feb 2024 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85485929;
	Fri,  2 Feb 2024 21:05:25 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009381759
	for <linux-nilfs@vger.kernel.org>; Fri,  2 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907925; cv=none; b=aNP+cxKs1NxNVM5nARlnO9KYJv7S3IzD2o56bR4f2OmERs0HLdJauAmXLCvq8tl+6AxMe+Yjfeu7VWAULpZ7G6X4EH4svWRtNfKBTxksfjnTbZgCoFuJwfZ2sWSAi3pxEAqUEob/gRjIseItc3QBMjqw36fWU6HRenYSKlT69ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907925; c=relaxed/simple;
	bh=zVEZF3UmOBGaFQWlFwsyEckv1Kv26SyyTDwlsRJ2Ctk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jBpM/6k4+zCyyyYKKbJhKQYGbXcNkVZQort/MSBP5a3tZvTyMn9I8jp1tKRqUn0vHnIkcfOdbLntkgI5pJVzCPDwORd3/POftukLw7UyKbYpP3pkP8apKcb4NRXIzdV/DEB0sigsvgkReQnDhCy5VSJxC6aejZuILcFvQ3rW4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf2a953988so197557639f.3
        for <linux-nilfs@vger.kernel.org>; Fri, 02 Feb 2024 13:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbpB9CkzBKZ5YTB7Sbfot3j8a0vy9QxqN92wrcvFWh0=;
        b=Wl+yfusebTx3320uTd5JU2i55leGxnk6UeirKEGabq2VZXW8NetLViryTcg7qtW72Y
         smdEZrAbZ/1vZiSfCl5qbLuo2I6V7eb9t7zGVN7qB4sGd/DLcSrTXeY5TN3NOvwATBBs
         tFT7YwbLJx32xpff0GcaEFAXYZSSF5M+p1BI68Idzh9/Fr7cmZnpUi9qUVu5N7SXUVP7
         Y5+GtsFpGQoUYMBggsMlMguaNQ0ud6Mz04rraSP6JtWVLInWIPW28AM0sme6Fb9FBKFg
         bneTeHJQ0Svegwltt29da8D9XGkVp3iIoUi2j27JMN2deZXzNdWppeBupAcMrrmZ1uO2
         X9jw==
X-Gm-Message-State: AOJu0Yw6XOsLliYSvxcG0I5GDB+6dn6PIZRulqoVCwACzLhS5WawazTq
	vXSHcs3/Q8PWSSyaMkdujVRzu7iwMsIFFsCXIeKxlI3nwkfohuyyNlIFpt1gBOK8/VQ1D+giTj6
	APyaPH4wYplYqnHMtihgtWeTW9eUzt/WxokjTc/p3c63N/pocjj14vik=
X-Google-Smtp-Source: AGHT+IEI8OXCfeauopidytDzSIZbNGtVMQpXAP1br3oXmhVIQDyUj9v/vVb7+FQJTlApf+zfmh2v1Juc07EX1h3FuRAuwJBtuQTI
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:363:32d1:80ce with SMTP id
 t14-20020a056e02160e00b0036332d180cemr733331ilu.5.1706907923416; Fri, 02 Feb
 2024 13:05:23 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000708ebb06106c7865@google.com>
Subject: [syzbot] Monthly nilfs report (Feb 2024)
From: syzbot <syzbot+lista589ce3cf9a23bf25db5@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 475     Yes   kernel BUG at fs/buffer.c:LINE!
                  https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
<2> 114     Yes   INFO: task hung in nilfs_detach_log_writer
                  https://syzkaller.appspot.com/bug?extid=e3973c409251e136fdd0
<3> 24      No    KMSAN: uninit-value in nilfs_add_checksums_on_logs (2)
                  https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

