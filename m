Return-Path: <linux-nilfs+bounces-507-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0EE99A77E
	for <lists+linux-nilfs@lfdr.de>; Fri, 11 Oct 2024 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8E92832EB
	for <lists+linux-nilfs@lfdr.de>; Fri, 11 Oct 2024 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892D194A66;
	Fri, 11 Oct 2024 15:25:31 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53467194A4C
	for <linux-nilfs@vger.kernel.org>; Fri, 11 Oct 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660331; cv=none; b=c27SBQGfe+6URSIb64zEmituKlPr287IG7suFGMrxMywxB/180xZ7Swma+8oHKMzrOFMf/rEIMFE6vZKvpeiXPFzC4zi5nsfvxKX7Bm8YFi5dY9Nel9cn4Q3DT8eTRqnd9YIt23RdepAgXFTc0GkQoJkcUrxMsuDNJo/tBHR6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660331; c=relaxed/simple;
	bh=yTcImAvSrPOfIo8sqUv7ec8p025b7a6EU+kbzxfFlZo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JXRKZk0eKtzrnKC9Hyy4tACo05q17grmCF7V3HSZ21OycsCdAS61JiXv/uN3MsNyIGPf/lSNkRTh1uBlIQKkWkTiZkt6I5h9l5InNRT7GAGmiOyj9Ed9UqcHSB5/qeCdr9PIKZjvMx4sQXrRpbxm2Y5RarlJnVFUglw7PIGUIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ae775193so16759335ab.1
        for <linux-nilfs@vger.kernel.org>; Fri, 11 Oct 2024 08:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660329; x=1729265129;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8GqyG4q9XKhcH6uWn9ylQYKUk2Itw869FNns+eJ65A=;
        b=M3AhbAaMXm93FD1q++R6YlnyJ+lPDp00eAzJ2XJ2MXFJBKd2Jq82VC9LP9+CluwqF4
         wUVk2NsG/iw6De+Yn4Ix4mDTS8jerQ4M77LNIy0476OOw0MYQ8Gp506hxGr33K8BN9fr
         I2WeEw73GyvJNYOVX4yoh0gCz6vqOMe6T8xOHR9/ZeNnFYdR9RxEsM92dWSotkpc2lx1
         EP25gcEKljkUL2a/lqDBL3gcHhP3ZVvZE++OvQ6at8q3BAA364QEwgAchsGi13He1zjN
         +3ObKUt1kJu3Ks60b13Zq3KljxFNLuGsZ1f2my7aNoIh8/+j+/LLY1SFFnMKQ7tBfLZ0
         4kgA==
X-Forwarded-Encrypted: i=1; AJvYcCUJQNcasLhvK8Q2i6HkxkVirMpk3OzTWhYzb2htUMWN3wvZlL0u7k0Fk3+/UEO7D9ulN4ItfHwMyVikog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrcqYY/vG0CasRn1Lro0kcW2JPkEte9gbaTT4FD5iOkkB7E+G
	Gw8qBAs5VnKcdJrpzQDxz+KtoZtFs7UvFnPZu/8zMASmDYnXeDuXJNsHdopSW/1vCtVMN3Ek9UQ
	LOgqRxqxrxQH3P0DeijB4RXX4JfdokDOUm91UA0GiR6NW4GuQPsF7cuc=
X-Google-Smtp-Source: AGHT+IEOWThoXLfZK7qpqPffhr9j8Wn1xh4UoCp/mFqdQDb4BAxqr8ZXdUs6MdbhjnnKmpZeS2z7njUlvriI3LFZH8sSp2iPMGoR
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4a:b0:3a3:49f0:f425 with SMTP id
 e9e14a558f8ab-3a3b5c73ef8mr28733595ab.0.1728660329361; Fri, 11 Oct 2024
 08:25:29 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:25:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67094369.050a0220.4cbc0.000c.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Oct 2024)
From: syzbot <syzbot+listac229802b21f5b6f6df2@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 50 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8223    Yes   WARNING in mark_buffer_dirty (6)
                  https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
<2> 16      Yes   kernel BUG in nilfs_delete_entry
                  https://syzkaller.appspot.com/bug?extid=32c3706ebf5d95046ea1
<3> 1       No    WARNING: ODEBUG bug in nilfs_detach_log_writer
                  https://syzkaller.appspot.com/bug?extid=c4b312367c177af55bdd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

