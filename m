Return-Path: <linux-nilfs+bounces-323-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A38BCECD
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 May 2024 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438621F24281
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 May 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CC77F30;
	Mon,  6 May 2024 13:18:35 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760F763F0
	for <linux-nilfs@vger.kernel.org>; Mon,  6 May 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001515; cv=none; b=gartACD8KXPH2IZoX6Gw5yA9Xpkcra0aSnX8KYsTsoJ5OZs0DIwswlrK1V2F7jb7UaY7CE+CfGKtitxRpVEyS0JTX94OVKQcLcli4nKAMmRpLlLDZ5pYIOx05SYOy8XKn4zNjh+iO0QjnYbP/NqqViTBt8FeTwsYmqL17rzI9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001515; c=relaxed/simple;
	bh=xMKAHgLWffPEg/68jPEYeY/o4qLcUtR75HNtHwrSP5s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U59h+S9HhBwZYRVCT3Xn9E8QkoLMSaLnTJ3wkEUDARegQNo+ckMvML+2uB3IMmTyRrdxBfC/ZmJGLBrlZu5LqFM1aSrUtxGH2VYsVtT47knVkPTYMNBUh6wUyNLUHi5p4+1D17YLoR+P4OeWi6it33AS3ySUAbBMo0WjGbmWddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ded1e919d2so140393539f.1
        for <linux-nilfs@vger.kernel.org>; Mon, 06 May 2024 06:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001513; x=1715606313;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TxmHB0vl67W1+zyEJ27WmnVys+63ysAGw/jZhHVYa4=;
        b=TtYzk6gfxsWgd/Fwoyo3Ial3T38UR1Aoefs+C6WZ5wsGsSu4eKWX4V4azq/AqF6468
         xosvYDTr1le9tOUcnDBObgTi6t2r9a1GiElkpK/DoEoWWZjifbdB5X9W3pRVZQh3vlLo
         3DCOQtDgSV2mxGjmID4x6p7htLA4KCcOpDWehATn9kucY1p8uINqMm1KkOhQ2ziJYZuA
         ZXKM7gsFF3e2c8fmVZ/2A9IT3cFTVsN0os7MYa4H4wPdJCYr9ZZHv66UdtCv9OnY6r+t
         zS2J6pBMKRZuLBctrCiQEzMVyvosIcJxuSeZMszfphRsveZiukkdGpIBDOfEXBVviSZi
         3xkg==
X-Forwarded-Encrypted: i=1; AJvYcCUsrK+fLBZflhJytklAvjIYKfxLFGXoX+xtvFDmhkthV5Lkc/JSMrM2RgqU0ucS7ZXXHQ+02KVYobLnXjez1/PV7szE9ymo2aprcUk=
X-Gm-Message-State: AOJu0YwGMfz4kNb4yd4dLtdvYGtzKa4leA3I5Gqj6rHWIiIU4mUOGm/m
	Yn9SizI8dfK/PE4OrmCMpD3CAQHk1SSAV4GpNqaS9d9qqdNtFwMnAMkYm1nOT6mZ/0q8MSwHz5r
	3lFOzHy92C+gtYX2fqz5vZh+SO7BU/zEpMLy7qw9uWfh/va/ZMCGXQys=
X-Google-Smtp-Source: AGHT+IHGkWCaHpJLl9dzq0QN3kR9qdOorczrF9G3kwxMgooiBGozHiWJRAmpHqOhax011rNPJQiAoVBofoiRpuhW7X96ozD4h239
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8516:b0:488:8715:313 with SMTP id
 is22-20020a056638851600b0048887150313mr249593jab.0.1715001513193; Mon, 06 May
 2024 06:18:33 -0700 (PDT)
Date: Mon, 06 May 2024 06:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbc4600617c8e744@google.com>
Subject: [syzbot] Monthly nilfs report (May 2024)
From: syzbot <syzbot+listf1bffba7342098843795@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 3 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 127     Yes   KMSAN: uninit-value in nilfs_add_checksums_on_logs (2)
                  https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048
<2> 3       No    INFO: task hung in nilfs_segctor_thread (2)
                  https://syzkaller.appspot.com/bug?extid=c8166c541d3971bf6c87
<3> 1       No    possible deadlock in nilfs_dirty_inode (3)
                  https://syzkaller.appspot.com/bug?extid=ca73f5a22aec76875d85

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

