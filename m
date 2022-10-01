Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48685F1C32
	for <lists+linux-nilfs@lfdr.de>; Sat,  1 Oct 2022 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAMlQ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 1 Oct 2022 08:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJAMlP (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sat, 1 Oct 2022 08:41:15 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BEE11C23
        for <linux-nilfs@vger.kernel.org>; Sat,  1 Oct 2022 05:41:13 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 291Cf6HB076561;
        Sat, 1 Oct 2022 21:41:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Sat, 01 Oct 2022 21:41:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 291Cf5To076558
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Oct 2022 21:41:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4ac809f9-a414-e936-0da1-f943e0551ef2@I-love.SAKURA.ne.jp>
Date:   Sat, 1 Oct 2022 21:41:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] nilfs: check filetype/uid/gid at
 nilfs_read_inode_common()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org
Cc:     syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000eb0ba805e9d6e30e@google.com>
 <f1438f46-a52d-707b-4ef9-ab29525f1c98@I-love.SAKURA.ne.jp>
In-Reply-To: <f1438f46-a52d-707b-4ef9-ab29525f1c98@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 2022/10/01 20:24, Tetsuo Handa wrote:
> syzbot is reporting lockdep warning followed by NULL pointer dereference
> at nilfs_bmap_lookup_at_level() [1], for a crafted filesystem which
> contains raw_inode->i_mode == 0 is poisoning checkpoint inode at
> nilfs_read_inode_common() from nilfs_ifile_read() from
> nilfs_attach_checkpoint() from nilfs_fill_super() from nilfs_mount().
> Check that filetype/uid/gid are valid as well as i_nlink is valid.
> 
> Link: https://syzkaller.appspot.com/bug?extid=2b32eb36c1a825b7a74c [1]
> Reported-by: syzot <syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This patch solves crash but I don't know whether this patch is correct.

Hmm, since bmap->b_sem and bmap->b_ops are initialized by nilfs_bmap_read(),
and nilfs_bmap_read() is called from nilfs_read_inode_common() only if
S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)
is true, I guess that the caller needs to verify that the returned inode is
a regular file? But where to add that check?

