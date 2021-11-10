Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91E44C2B9
	for <lists+linux-nilfs@lfdr.de>; Wed, 10 Nov 2021 15:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhKJOKK (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 10 Nov 2021 09:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhKJOKI (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 10 Nov 2021 09:10:08 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B303C061764;
        Wed, 10 Nov 2021 06:07:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id br15so2526279lfb.9;
        Wed, 10 Nov 2021 06:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uptP5ttU6YIWtTP4WKGZwM4dSf9/Bmub/rlFTDC27k4=;
        b=iXyiasBGVIuq5DuAjv+AORV9xK8GfbiM0SdhG6QYvy4QGUY/x89bsd7rb/p2+4dXjE
         cnecRXU8K/Au334lMLyAx8hyHr6npMjl0bx7R2TRv4WcukFKlIwfr0vrdlfmNNpSNq0w
         8j78YUzytdZkU6PU6RbKXxtdDNChBN50ZatFuQ16Q/NNFG0Lmuq0TrUmq+bbYjXiCUGu
         lwdySmNyKjCZTTnQg7dw6DJP8Qdz3uQs9qCPkw74AII/Nmrz+7ld4T/m4JJFTXJZzNz2
         u3RBDD6IwSXRXiYnbCI2vfUJErM3OwQe/jmApRBtqSbtZlaPAP6UOUA2ak8pe8oP0qq6
         Rf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uptP5ttU6YIWtTP4WKGZwM4dSf9/Bmub/rlFTDC27k4=;
        b=VUOiM1IzEPPjhMyh00kRlAAOlcNarh4yPYiQxW5dzCRPVvJ2jFUoqCPEcRBEs7hIy/
         pmN8xHFNEEwtkhSoEHfjsbIJ9SM5bnrN/Vh/Vbsiv5/lgAhFg+QAib1zghotx3Lbdr36
         MUb+782OabvQhjMMx/dzqVq2c5645arJ5D0B+gBbvxDUqsrIOfX/rslzcyvVXPKlbXcl
         QN2jVVk7SI77Nz4Ve0dU+MIy1OiIqlUDKgC1wOl0RoI/oIh/W37G/vmCRAN//qCS+wV6
         D3AxuVlABbNq4tjRDAy0DXp6Nmuf07GH6pYtrDjWHxklbeyVB68FRN10QoNN0m5nYD4s
         RYtQ==
X-Gm-Message-State: AOAM530ESeaO6FjLggG9dUZQ5Kx5mD4Ng+m+fot1ZoYd3XO4ZWrBLKAX
        t5cFYel7ubWTncmmh3e47WFarFMPGnou8Im/+Ww=
X-Google-Smtp-Source: ABdhPJwgyfnjruH4T9LGo5FKEHUnEKpWtt4NROA7f2oO6qUjSSb4VE085YW1aw8Fk9sP0ZYC/Ov+eVt/9wNJWLmIz6Y=
X-Received: by 2002:ac2:5f0d:: with SMTP id 13mr15441357lfq.627.1636553239450;
 Wed, 10 Nov 2021 06:07:19 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsasF+eDp4_dtvTBr9Thg-9RyYOQg3nwvRFuu+r3XecHig@mail.gmail.com>
 <YYsm+3NnNH/VaaM1@casper.infradead.org>
In-Reply-To: <YYsm+3NnNH/VaaM1@casper.infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 10 Nov 2021 23:07:07 +0900
Message-ID: <CAKFNMon7WkjF3wKD640nH1uXX=TWop2UfrS=Y0Mawf6rFYvY7Q@mail.gmail.com>
Subject: Re: WARNING in __folio_mark_dirty
To:     Matthew Wilcox <willy@infradead.org>, Hao Sun <sunhao.th@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Wed, Nov 10, 2021 at 10:57 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Nov 10, 2021 at 09:20:38AM +0800, Hao Sun wrote:
> > Hello,
> >
> > When using Healer to fuzz the latest Linux kernel, the following crash
> > was triggered.
>
> It's still a bug in nilfs, just like the last time this was reported.

Sorry, this looks like an existing issue of nilfs.  I will look into it.

Regards,
Ryusuke Konishi

> > HEAD commit: 6b75d88fa81b Merge branch 'i2c/for-current'
> > git tree: upstream
> > console output: https://paste.ubuntu.com/p/C22bhzvZP6/
> > kernel config: https://paste.ubuntu.com/p/b62Hp7BfJn/
> > C reproducer: https://paste.ubuntu.com/p/2mchRNDJr4/
> > Syzlang reproducer: https://paste.ubuntu.com/p/xM3DQ2f5Qz/
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> >
> > NILFS (loop10): segctord starting. Construction interval = 5 seconds,
> > CP frequency < 30 seconds
> > ------------[ cut here ]------------
> > WARNING: CPU: 3 PID: 18327 at include/linux/backing-dev.h:269
> > inode_to_wb include/linux/backing-dev.h:269 [inline]
> > WARNING: CPU: 3 PID: 18327 at include/linux/backing-dev.h:269
> > folio_account_dirtied mm/page-writeback.c:2460 [inline]
> > WARNING: CPU: 3 PID: 18327 at include/linux/backing-dev.h:269
> > __folio_mark_dirty+0xab2/0xe80 mm/page-writeback.c:2509
> > Modules linked in:
> > CPU: 3 PID: 18327 Comm: segctord Not tainted 5.15.0+ #6
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > RIP: 0010:inode_to_wb include/linux/backing-dev.h:269 [inline]
> > RIP: 0010:folio_account_dirtied mm/page-writeback.c:2460 [inline]
> > RIP: 0010:__folio_mark_dirty+0xab2/0xe80 mm/page-writeback.c:2509
> > Code: ff ff ff 48 8d 78 70 e8 8c 69 96 07 31 ff 89 c6 89 44 24 10 e8
> > ff 52 d8 ff 8b 44 24 10 85 c0 0f 85 13 fa ff ff e8 8e 51 d8 ff <0f> 0b
> > e9 07 fa ff ff e8 82 51 d8 ff e8 9d 6a 96 07 31 ff 41 89 c7
> > RSP: 0018:ffffc900076ef7c0 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: ffff88802c478378 RCX: ffff88802fc33980
> > RDX: 0000000000000000 RSI: ffff88802fc33980 RDI: 0000000000000002
> > RBP: ffffea0000b7ca80 R08: ffffffff819f0012 R09: 0000000000000000
> > R10: 0000000000000005 R11: fffff9400016f950 R12: 0000000000000246
> > R13: ffff88802c478138 R14: 0000000000000001 R15: 0000000000000001
> > FS: 0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000056054d573c18 CR3: 0000000021c4e000 CR4: 0000000000350ee0
> > Call Trace:
> > <TASK>
> > __set_page_dirty include/linux/pagemap.h:784 [inline]
> > mark_buffer_dirty+0x501/0x6a0 fs/buffer.c:1108
> > nilfs_btree_propagate_p fs/nilfs2/btree.c:1889 [inline]
> > nilfs_btree_propagate+0x4ba/0xce0 fs/nilfs2/btree.c:2085
> > nilfs_bmap_propagate+0x73/0x170 fs/nilfs2/bmap.c:337
> > nilfs_collect_dat_data+0x45/0xd0 fs/nilfs2/segment.c:625
> > nilfs_segctor_apply_buffers+0x149/0x480 fs/nilfs2/segment.c:1009
> > nilfs_segctor_scan_file+0x3d9/0x570 fs/nilfs2/segment.c:1058
> > nilfs_segctor_collect_blocks+0xa33/0x2fb0 fs/nilfs2/segment.c:1224
> > nilfs_segctor_collect fs/nilfs2/segment.c:1494 [inline]
> > nilfs_segctor_do_construct+0x1228/0x5ef0 fs/nilfs2/segment.c:2036
> > nilfs_segctor_construct+0x79f/0xb10 fs/nilfs2/segment.c:2372
> > nilfs_segctor_thread_construct fs/nilfs2/segment.c:2480 [inline]
> > nilfs_segctor_thread+0x3be/0xe40 fs/nilfs2/segment.c:2563
> > kthread+0x405/0x4f0 kernel/kthread.c:327
> > ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > </TASK>
> >
