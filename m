Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9965BBD76
	for <lists+linux-nilfs@lfdr.de>; Sun, 18 Sep 2022 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIRKn2 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 18 Sep 2022 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIRKn1 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 18 Sep 2022 06:43:27 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D0140A3
        for <linux-nilfs@vger.kernel.org>; Sun, 18 Sep 2022 03:43:26 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28IAhHPf030230;
        Sun, 18 Sep 2022 19:43:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 18 Sep 2022 19:43:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28IAhFeX030225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 18 Sep 2022 19:43:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <29200a14-e722-2d1e-66a2-c07b105036e8@I-love.SAKURA.ne.jp>
Date:   Sun, 18 Sep 2022 19:43:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 kernfs_put_active
Content-Language: en-US
To:     syzbot <syzbot+258ad6d2cb6685e145bc@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org
References: <00000000000095339805e8d6958e@google.com>
 <de81bf82-3ddf-4875-381d-e52949046b25@I-love.SAKURA.ne.jp>
 <f3b88739-148c-323c-2458-4b9d6bf9c592@I-love.SAKURA.ne.jp>
 <CAKFNMo=XjvQjoSo+N-MJGv5h4FPnjVm6bGaJm0QkO8GxjMNtTg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAKFNMo=XjvQjoSo+N-MJGv5h4FPnjVm6bGaJm0QkO8GxjMNtTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 2022/09/18 19:19, Ryusuke Konishi wrote:
> I'm not sure if the patch [2] fixes the originally reported problem,
> but it will be fixed if it's the same.

Will be fixed. Thank you.

#syz fix: fs: fix UAF/GPF bug in nilfs_mdt_destroy

