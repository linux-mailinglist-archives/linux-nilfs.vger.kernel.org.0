Return-Path: <linux-nilfs+bounces-577-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A409FE190
	for <lists+linux-nilfs@lfdr.de>; Mon, 30 Dec 2024 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB5F1881C79
	for <lists+linux-nilfs@lfdr.de>; Mon, 30 Dec 2024 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9933F6;
	Mon, 30 Dec 2024 01:15:24 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F525948D
	for <linux-nilfs@vger.kernel.org>; Mon, 30 Dec 2024 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735521324; cv=none; b=ZU72bT0uKrkCg0KctzHWpoRm82/g12iSaKg+vjLeVReq3s65L7C7ybBG7WxxOuwk2D9PqIEv+lLZQctYSRFR/LmcmxTx7pl+JH73M5GRK2rnloUq2D3Rcmc68OIdDyrgiBzLn/dVpE9f5Nd9GRv/exWkPJXsUbG+cqqzR7AoNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735521324; c=relaxed/simple;
	bh=2qsrPxQ4/TnljPhC3e9T7HL5yyS6M7NdyL7bkLjK3N8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hvo6c1cbXi1ZzJhsW2YdMWQVgIg0+qijzeXnFZ3tfmzzpcMisGIhXukbyvI0nRPebMHPOvkCjm+6exICfSKwssyhDmjETAUZ/JjSfccvrkidNy6epNAWb++7drhBe7mnU4E39kdYZiJ/Xm1lol0G4PFlvq9Ow+pLSRy8Kayp84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so74639185ab.0
        for <linux-nilfs@vger.kernel.org>; Sun, 29 Dec 2024 17:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735521322; x=1736126122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Q7Yx1ykdPNr/zNJ+aeqsvOslVv39BiAHooNuKhschA=;
        b=edwoP2pLV1TlpbzWtfDFTFWKpPXhLesnsEso5UJkSCrjLjP/UzoCmd66lYPQnD1F2P
         XEV44WTcbEytOIEFcUIt0UYClAUST1yVUkJexhle9Cw9hLVKvg3MStuRF1H9TieijChb
         UVXfK++I46+9sTyzWRjtp+UhJS28zmjSsamqpd/xQGWRXQqzFdtnNCY8bbJhUNFxCN/j
         DXwXRGxm0cdsj275kxvPWONwDJh0jqyOmnnhSkwp6c+VuZeLfYWoBoHX5OnXVMMQe5sQ
         QaYX5h41tWTTANjOh7pAwUhuU2FjKzbhDqOHn7xGc/KW0ioJ6B4GidKVmw0PjSrcfR1y
         rcUg==
X-Forwarded-Encrypted: i=1; AJvYcCVpyj37Gusmw/KyeTnSpHcCYz0l/mzu2tzO8x3umzaFEUs5aPYdV29R+xmyb3SfT+5HbWVu9qaB0NdHHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2nmwpofNaFOPk6ehfFT1TDso7H0yqECivgdmSVjS/xT0ZKLNq
	jZH1wcS9zrPyqRGF2rhYzEtZHLtaVmJOZf2nBAQ4VH4rkbCP4n/VydW8PROGYMJVgCtiC0HLMbX
	D6pVURpSa6/6ZzN6VZmIRA9SnSxZ9/OAf8s62RimpvbNwzQCRh40jFmo=
X-Google-Smtp-Source: AGHT+IFKtFGaqePh6jqrV+0nz9puMqKJ0NJ8dZc7Oky0yBhBIIdKWvKHESrfC407QbqjT2FcACqA1WQmkM1DpiD1eY+MPDNOsk9U
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0d:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3c2d2783efdmr234544455ab.13.1735521321870; Sun, 29 Dec 2024
 17:15:21 -0800 (PST)
Date: Sun, 29 Dec 2024 17:15:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6771f429.050a0220.2f3838.04b1.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Dec 2024)
From: syzbot <syzbot+list99087fe8e73d8e0de54e@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 3 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 57 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 21      Yes   kernel BUG in nilfs_delete_entry
                  https://syzkaller.appspot.com/bug?extid=32c3706ebf5d95046ea1
<2> 4       Yes   WARNING in mnt_ns_release
                  https://syzkaller.appspot.com/bug?extid=5b9d613904b2f185f2fe
<3> 1       No    WARNING in nilfs_rename
                  https://syzkaller.appspot.com/bug?extid=de6c4b3beb823e112ead

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

