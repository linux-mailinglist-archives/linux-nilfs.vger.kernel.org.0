Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739235BB937
	for <lists+linux-nilfs@lfdr.de>; Sat, 17 Sep 2022 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIQPva (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 17 Sep 2022 11:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIQPv3 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 17 Sep 2022 11:51:29 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1227D26572
        for <linux-nilfs@vger.kernel.org>; Sat, 17 Sep 2022 08:51:27 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28HFpAoe013702;
        Sun, 18 Sep 2022 00:51:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sun, 18 Sep 2022 00:51:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28HFonWf013646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 18 Sep 2022 00:51:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <de81bf82-3ddf-4875-381d-e52949046b25@I-love.SAKURA.ne.jp>
Date:   Sun, 18 Sep 2022 00:50:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 kernfs_put_active
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org
References: <00000000000095339805e8d6958e@google.com>
Content-Language: en-US
Cc:     syzbot <syzbot+258ad6d2cb6685e145bc@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000095339805e8d6958e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

I don't know whether crafted filesystem image is used is relevant to this problem.
But I think a bug is inside NILFS2 filesystem code.

When inode allocation fails due to security_inode_alloc() returning -ENOMEM, some
inconsistent state happens. It seems to me that destruction of partially initialized
inode corrupts kernel memory (and causes various oops depending on timings).

On 2022/09/17 11:53, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17025144880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
> dashboard link: https://syzkaller.appspot.com/bug?extid=258ad6d2cb6685e145bc
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106b8164880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1040a75d080000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/81b491dd5861/disk-a6b44374.raw.xz
> vmlinux: https://storage.googleapis.com/69c979cdc99a/vmlinux-a6b44374.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+258ad6d2cb6685e145bc@syzkaller.appspotmail.com

