Return-Path: <linux-nilfs+bounces-562-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575359DB41A
	for <lists+linux-nilfs@lfdr.de>; Thu, 28 Nov 2024 09:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE022811C8
	for <lists+linux-nilfs@lfdr.de>; Thu, 28 Nov 2024 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C414E2CD;
	Thu, 28 Nov 2024 08:47:25 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD920150981
	for <linux-nilfs@vger.kernel.org>; Thu, 28 Nov 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783645; cv=none; b=CEHI0CotqQqyf8/ht7E6zFqNTigKqSD0qWW/SWfybx8bC2aC5Y60jgWDijUut5QENwHN31Ku4NJCfDjOtEdXECMiKaWWHW41fe4VO5TonSNgxjsivCCN1refkFIuugiJS9tGtKmjvB2JJrZBxro3foi4SSsMaeo1EYRjs8f8FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783645; c=relaxed/simple;
	bh=Pca183OBl8FGMspJO7SMBxHQPtal3qDjSfjePNjko2I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VrlTFa83Iqzg9H7qDAxupq64Vo5rTq6GBh5BYSNQIVEFjUW8hp5n2eWPVGWcYxql+HcWPM9F7GryZjFeK1ElTnamtaZkQkR4PNV53EOUfFZ0XlDZWoY7B8bPEop/ULHl1Z+YV4KghSIkRwQoZSGcHOXdIdIlRF7iHsmxsmY21hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso5813625ab.1
        for <linux-nilfs@vger.kernel.org>; Thu, 28 Nov 2024 00:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783643; x=1733388443;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVjcYXdzLEjJ1m8Iin2QdgSd2iibSrWMeaPwAgjOnCA=;
        b=GyxbKERqG01FYGA2vKrZzfq9pq2K9Pi10aRtc/IA5VzX+6VF7h/r7kSJ6rue7Nd8oX
         NTgodHm6iLMDURCGmJn+9WDmZ58964hed7/9yVEwJTiwcd6IV+TDkdgC3Uy/cZdVKwe8
         0ZNgR2zQb3OYzqkL0J/ugIzkn4AZ9bfaeMrxP9kM+vus0FVXxnESaNOKjaUVcQRJzPhy
         lS8ugBK5oSE3Yzzrfb8869qNdl12FBy8z+hIPoZtKsIvxQ2AcHS7XwOq7TpPDpjyF+sr
         LSSkM06+lAVsqgxpFh3AdpxpsDAonsG0NX3bXtEUJr3D4a6Ws+guIVkyOXN7u3dmJ5sX
         dTeA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQi8RwwgN7MitZ1iNNAm7KCeAwp5JNqdjy6EVmxJZ39UZIwnizwFnmFp5vLab4990KegGDZVCEqegFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+Ca0zLy3oxWF9sX3i2BfmHCsZUDPXT8nHlkaI9LwNPQ1KSvj
	hiteUyo91luAP5c51mUCR3Gk4BgqWURcYS92dj3ujlBL/81B0ORGF+R4DWLZHZl+PbIfYzXfWmx
	yHgZE2q6twETgwJ8yC7RxgUlYA3bVIggo/pVUFGVgMVllukXd11dgnSw=
X-Google-Smtp-Source: AGHT+IH9xQ8maDYHcsFRdkYH6RK1SoW9NhEUmzUOkRXlhmFN+1WwtgOscNaosnBb9ZbFujAhXnfFjkh7EHDwtdVeOKkySJc6xf5M
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3a7:764c:42fc with SMTP id
 e9e14a558f8ab-3a7c55ea494mr60286825ab.21.1732783642929; Thu, 28 Nov 2024
 00:47:22 -0800 (PST)
Date: Thu, 28 Nov 2024 00:47:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67482e1a.050a0220.253251.0077.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Nov 2024)
From: syzbot <syzbot+list9b171c1cfab8f0c64d5f@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 55 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 9748    Yes   WARNING in mark_buffer_dirty (6)
                  https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
<2> 7       Yes   WARNING in nilfs_rmdir
                  https://syzkaller.appspot.com/bug?extid=9260555647a5132edd48
<3> 2       Yes   WARNING in nilfs_btree_propagate (2)
                  https://syzkaller.appspot.com/bug?extid=b2b14916b77acf8626d7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

