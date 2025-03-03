Return-Path: <linux-nilfs+bounces-686-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F600A4BC8C
	for <lists+linux-nilfs@lfdr.de>; Mon,  3 Mar 2025 11:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959B816FCD3
	for <lists+linux-nilfs@lfdr.de>; Mon,  3 Mar 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DAC1F2369;
	Mon,  3 Mar 2025 10:39:30 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA41F0E2C
	for <linux-nilfs@vger.kernel.org>; Mon,  3 Mar 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998370; cv=none; b=EoTA6w67We+txU/emrzk8nNhkilayLRFrwKgw0/AwvcwfJ++a7Z/dT7RGPHKCoJi053dhDi7/Y6s73WtVszCe8tEHBN3s1JkOBiolgN+v67PeImKksOXvHZ5irp4ETBzPbUG4afArmbCY3ZE+zR4PHW+GrkhxV7FYWsE0AMK1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998370; c=relaxed/simple;
	bh=90NedZ4Khg1tX2c3RBe9hmd9ZkT5kxT+0JlDT5i+PDM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jdsY3udx++maAA0LSFLWZxMsP+KjFLxtmCOmwNYNXX4bKp4ZpH3M6y8aUG1XiwPt7rqveJL0nAX+Gt5YqKoDArZ9O5P8Q+Kr2DRPpmrO/Tj2UF5lrIpZX1ZXtayIALirQPTkFLrtdUwuUA4gt+yuYIszUF4Z8eC2sThNGgRGSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-855a5457110so406932439f.3
        for <linux-nilfs@vger.kernel.org>; Mon, 03 Mar 2025 02:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998368; x=1741603168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yx2X3YMfRhmckUUpY5mpeveL25sIpLwo96OtO/Bfk+U=;
        b=hj21hVxqXe5D+O5pUQ1WpHJ0/Yts/av8mdBSQb4CZF0mgNHvj2jnv1e0JmbIXu/cqX
         8GX9t1Prq7sW+S8Ihd4YaEBggsUx6UiNG6I5u2lsyw1NoXT1KUbP3XeR77t8wytLsGEm
         wf5OHXpUY/gZ3gqng9F9uwsRBJ+Nf522eTL2MXXmjQu0CxN0rXjcbn01QKYDkbAWsBzh
         oqJw5wXSAuNWLf8xoJpjbmO1yaMdjjdvn+mdpR1bP7EUGbpS6Z9IC7BSfP0HVZq3YeSX
         pA1yHAM7YXWnreDUYRYpPfn/UoPO54K4Z1xP1iOOBeANmcqBA5LQbjm7UKe4QPF3aLpe
         sLEg==
X-Forwarded-Encrypted: i=1; AJvYcCXEPLb1+yuEIYjtj+mYVOSDaxbanbJw0kEaw1fv9ojFk8eOZcH6MrIlYxbXExaLxa/3UruY2NjCf/sHAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kLEHRbS3BKQj1HBSzUnsM7suxqeeZ7O2IRsKkkHhaHsn9MFN
	xmzX1gQIlLcuB2AALo0UGzYv6ryUv2HJEUpF0jwWV/dydj+BXQdK6GCZIekwzd094P7M1mLUj5H
	s+5vxYmbLu6U2Wn7jCq3shP4xNTZG0yvaNXQC97StinL7OV64KpuVXC0=
X-Google-Smtp-Source: AGHT+IFiTwFGAjNBROqwDLCtVMeqyIEGryfGDay6c8a6zPiDcT2KKOpnWLTTDcnMd1J12jZaozpL/pUxD2mLRyQBsScqPn06sVE5
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:3d0:4700:db0f with SMTP id
 e9e14a558f8ab-3d3e6e6d719mr129288035ab.12.1740998368321; Mon, 03 Mar 2025
 02:39:28 -0800 (PST)
Date: Mon, 03 Mar 2025 02:39:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c586e0.050a0220.1dee4d.0125.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Mar 2025)
From: syzbot <syzbot+list2c89da5b557d9a067af8@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 2       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 2       No    possible deadlock in nilfs_bmap_clear (2)
                  https://syzkaller.appspot.com/bug?extid=4d7417d6eb8b36554c0d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

