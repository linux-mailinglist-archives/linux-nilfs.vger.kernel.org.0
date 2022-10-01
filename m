Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE95F1CCF
	for <lists+linux-nilfs@lfdr.de>; Sat,  1 Oct 2022 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJAOfQ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 1 Oct 2022 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJAOfP (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sat, 1 Oct 2022 10:35:15 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C9399DE
        for <linux-nilfs@vger.kernel.org>; Sat,  1 Oct 2022 07:35:12 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 291EZ3kY099483;
        Sat, 1 Oct 2022 23:35:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sat, 01 Oct 2022 23:35:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 291EYuxE099467
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Oct 2022 23:35:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7d6a80dc-940c-8a64-020d-4a524913512a@I-love.SAKURA.ne.jp>
Date:   Sat, 1 Oct 2022 23:34:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] nilfs: check filetype/uid/gid at
 nilfs_read_inode_common()
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000eb0ba805e9d6e30e@google.com>
 <f1438f46-a52d-707b-4ef9-ab29525f1c98@I-love.SAKURA.ne.jp>
 <4ac809f9-a414-e936-0da1-f943e0551ef2@I-love.SAKURA.ne.jp>
 <CAKFNMom4G5jzSZ_i-kKnykzkhDags+XKYbRZD-cu_FeTVrFMwg@mail.gmail.com>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAKFNMom4G5jzSZ_i-kKnykzkhDags+XKYbRZD-cu_FeTVrFMwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 2022/10/01 23:28, Ryusuke Konishi wrote:
> I think the former is fine because we don't have the idea to add
> metadata file inodes other
> than file type.   If you make a revised patch, I will approve or
> handle it.   Or if you are busy,
> I will take over the fix.

Please take over the fix. Thank you.

