Return-Path: <linux-nilfs+bounces-212-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B08871D17
	for <lists+linux-nilfs@lfdr.de>; Tue,  5 Mar 2024 12:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0BF1C21A09
	for <lists+linux-nilfs@lfdr.de>; Tue,  5 Mar 2024 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9654BD2;
	Tue,  5 Mar 2024 11:10:30 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3E59B46
	for <linux-nilfs@vger.kernel.org>; Tue,  5 Mar 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637030; cv=none; b=WeyvEWUUGZmOJg9JkFC2O6RDUaO23OAy/rmr9Tirk3yeQ9n7cj0i8kfCre1iu7d4/eSkD06sJJcgrG/Xbe7aghKhPACvoKIDR3S49JJvH+qjtna/2cw+x8bFv1BtZARYyEAG9lbwhPsffTWzbWxonTRI3xliqM3tIh9mMlFijEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637030; c=relaxed/simple;
	bh=BXOQkk5olt74C94h33NTV9i2V/Q9HqDyz/O+CEXh1HY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jE5F7s2dmyqKYRUcPyVVoI+kxIuyOgnN+EuVv9e7IgP5swM7XlY/y0rcHhs3DG6yu/7CyFSm11t8d5zFkdirSPdER0VLQmgL4SKrzkl2Ipb715MaVuUv2rtRVmuPJSOj1aWbyCo5BZGqgGvoWCtZt1+fbFaz0LZ/ydcLROF6dls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c49d118546so438810239f.0
        for <linux-nilfs@vger.kernel.org>; Tue, 05 Mar 2024 03:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637028; x=1710241828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZ0/Itsp5CIk9SaibL6YFHotYuDJFiS2lp5mxLTrQQ0=;
        b=BKhaZySeY9YRsjX5gcdxMHRe5KOYcN3E1h/YH52jpoKPCbDGIZVU4gqFq9WuukTfdD
         SKSUm50bip3BZMjtlqQ2XucvXGLCykU9zhcXJY0+jol8w2adQqNVvQrpX6RcqjvNLxBs
         mTDe9euIY68eHEgrRqi8nlddnfIR7hIaLrD6ROMQENmrL9S3nOoD829QczYg3Jgp7l5/
         099KQYO9E3xz392tdNg+PGKw1qgC14LPPSCXtPHsno6RjKdkBmXylKdlpf3s9vA4TRRS
         8NQuV1TkRxgOSCpSJ3e/VT5g3elaaksealBHMFBc6MMa+k8usmik0Hpk1mtLcAnQqRe5
         eNEw==
X-Forwarded-Encrypted: i=1; AJvYcCUkkIak6eLKzEsj2y5uqjTFT8bWDKyINyKvtElphkroK7prz6XniNnyFW3g/kSvBJntMheOhDwOVLj07KvsZtTYYIogx3067P9Aak8=
X-Gm-Message-State: AOJu0YzNRSJ5wcP/FmWBzdOyTaNbMFDCY8MQp8VUvKbAjxlt7VFC1Oe0
	5iUqSxpEwDZCDxBXQYQIx2zWdNqSIY4TDV6dVEzRJcePvxwpEtEWtmFMmrQOlWHAo1aXUPVnjWo
	iIoKbn6JcW5nS6lbCngAqycFjmRoOC6BPNP5ilwhUcn5LSshQbw48iRg=
X-Google-Smtp-Source: AGHT+IEkDKMPalaS3u5F/HnzHGSmuawi/P6xdricveo8Z9ruAUVx4O+VU7/q5mtCXnql//n5980GJWYA5eaIaYm4Fvqu1Lm/PxFf
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:19b:b0:474:e322:67ee with SMTP id
 a27-20020a056638019b00b00474e32267eemr24361jaq.3.1709637027968; Tue, 05 Mar
 2024 03:10:27 -0800 (PST)
Date: Tue, 05 Mar 2024 03:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf45e60612e7e380@google.com>
Subject: [syzbot] Monthly nilfs report (Mar 2024)
From: syzbot <syzbot+list9e420ad857ee3276c149@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 8 issues are still open and 39 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 518     Yes   kernel BUG at fs/buffer.c:LINE!
                  https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
<2> 116     Yes   INFO: task hung in nilfs_detach_log_writer
                  https://syzkaller.appspot.com/bug?extid=e3973c409251e136fdd0
<3> 2       No    INFO: task hung in nilfs_segctor_thread (2)
                  https://syzkaller.appspot.com/bug?extid=c8166c541d3971bf6c87

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

