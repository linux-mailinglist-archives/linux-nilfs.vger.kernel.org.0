Return-Path: <linux-nilfs+bounces-694-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F94A79C8F
	for <lists+linux-nilfs@lfdr.de>; Thu,  3 Apr 2025 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00E13A6630
	for <lists+linux-nilfs@lfdr.de>; Thu,  3 Apr 2025 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423023F26A;
	Thu,  3 Apr 2025 07:06:23 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381AE1A239E
	for <linux-nilfs@vger.kernel.org>; Thu,  3 Apr 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663983; cv=none; b=PngNN5GjfbSQUAcDmhfYDSZy9tkQ9GDcn/diwd3EnPNbLX3xa4KHmYtyTYH4hAciaAG/uTYn8q/fjE1dvsB3rYBLpQ+j8AVtG2MTX86Msw1sEmYbhxwfCVdlb4WAyVkglykwjtwsKymh8mAY85fYhs7NjRgXbZtcgPGpliSHYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663983; c=relaxed/simple;
	bh=rgdstKn60sD1Okf2hAloIZB3CTc4wYl85c4OrwQ3qJI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F5AH9hV67OycuH92W0Zg2H84DdYpZ163QXkm7L57gW+wQLmvP5iCg2f270LR7FffQYlG+bP1Ljr1yP+JHqeMXrHORR2p+inq9IEgq35X/IBGSa0yUgJ6FpgRASytzIcRi4iKux5vuRXD99U7QGdNHsvWQkMNr+ZFv9STbuRm0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43d1df18bso7407135ab.0
        for <linux-nilfs@vger.kernel.org>; Thu, 03 Apr 2025 00:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743663981; x=1744268781;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vFLX8CB9J1hm9b0MG16a4Sih7/+Grqg2geKmMLii7Y=;
        b=Offq+BqG+zb514tKArz0JFnHdu6jVkJa9lurbYQoaRODAuCaEbKQ0Hmo/dYHxLWvlL
         VZIVbWqXvBOkyvjBRA0Ei7Wtl6dEdZlClc4exLEfq+pcBVFj3STvOLuC78kvThnn3XnM
         2fDZtoQD/DIoOVaVH7aq84t4Zy70Jhto40QnZL4kHdgHLEoegOjdqdqKaFves9kG9n77
         59zpOzEBvC6cH/z/VLz68RBznewrlrjWzmF/2sv5EGL0qaIP2TpeeTrF5YJbg2z0xgfa
         YfiDad/qLLLkM+IZt6w0dXzXvMP6/yRu0VF4JMqzy6YNnIdGcaTqR+SCTPp1mHbCjch9
         VZdg==
X-Forwarded-Encrypted: i=1; AJvYcCVWEE5w8TqGAeb7odq23pivyXyUDumqwwDCkJSRTudiZrqWRBPqrUevigS0dTwtiXbK8Ijtb0V7bU/GsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHr3fHAsywTXsYBgtQmJ8qPzPN42I6APBwjaZ2MUpFfsgGkX/+
	Ng5HV6gB3hXgN2KtTBcLJlHAn7QqwTOn9FI8wBmA+MXsRyWBk8ZGx946gxLbuvX78zMffEx1ief
	bd/6Mu5W4dhy6WaZWdqviOUy2Cx/1ShXUuML9lHsNXF9+D4fC4nnZREs=
X-Google-Smtp-Source: AGHT+IFXGxgA6l2MUKszTI6qTYG2bWbrfzzFe7UZow8mndTDS1q4BqGgogI9ec6oVPUw+7KMi7bbAfankREseWxp76VG2QApMSfY
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194c:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d5e08edf07mr219711355ab.1.1743663981333; Thu, 03 Apr 2025
 00:06:21 -0700 (PDT)
Date: Thu, 03 Apr 2025 00:06:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ee336d.050a0220.9040b.014f.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Apr 2025)
From: syzbot <syzbot+list3fa35a27aadd3050311b@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 2       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 1       No    possible deadlock in nilfs_evict_inode (3)
                  https://syzkaller.appspot.com/bug?extid=cfb767df63e683c533af

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

