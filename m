Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765C5BBD65
	for <lists+linux-nilfs@lfdr.de>; Sun, 18 Sep 2022 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIRKTW (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 18 Sep 2022 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIRKTU (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 18 Sep 2022 06:19:20 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D123BED
        for <linux-nilfs@vger.kernel.org>; Sun, 18 Sep 2022 03:19:19 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id f76so12739393vkf.7
        for <linux-nilfs@vger.kernel.org>; Sun, 18 Sep 2022 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PTy2g9gMwuuuc0N3NJwfX+XF29AY4XkRQy1vR3LUZrU=;
        b=Yo2pJRKl/CGIzL3lppn5fWNXwRgwlgnKiTuPLtFOrVPaTBjHpWbRckNKv0TlID1KIH
         /XYfaXxqL4EAp9AeyrL52133nsiQRA7vtw2Ytzih/v3xECssowkHiVXkWY10LyGxRwtd
         ESvbj9Sis8BrwbMsqGH+MPjb30i8TlUyMnM4YfYyS8gcMhe+Oq/TcooXXdiP6Im6sgPy
         rIMracezU2cnI5SBKAzmO3X6c7ZZTxXGmVz907R8w1GgDvFYQNPAh9fvVby8/E2sbhIN
         /tfAunAPvfegkLF/Kpjq1Q5S08Y7oKlomcCxwLLiQzqTNNngU8f7fUgoK8+UkMAqYGRy
         MB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PTy2g9gMwuuuc0N3NJwfX+XF29AY4XkRQy1vR3LUZrU=;
        b=bCfCKbSjyN2+KpzYFJN6m3tbnCEa9sJR1eJLa8L04I1kDOHaqzaLrLx6GeWIMT0Crs
         AbieJdg8KAj8Du2njz1BoE0S1y858oHf8GZd6WJ3xAAIaJjmqir9VrNcbLpfVQc71yHY
         F2Y0d4NfbcbsvF+TGbnEQeTqIS0TH69GjtMgf2ufXDIaEr27ugVJMz6gRhj/rVwEyd8e
         2ZNaW+c4q2xvTnqMuyzZnq0mGw7deKUq9nva/RraZZjsBQsk9Y6fJMyyzasrw9G7/YlJ
         Il+DenOeya66XewUo8phVDo0NUeWr88QDKnM0kFkdKeOCykYjQhqjdqQoO9+VD+x2Cyz
         jgHg==
X-Gm-Message-State: ACrzQf3xkdDpSqa3RiwyKwzJiFhxCUHlNDIDRX+u04YfJ7aYg8TPY6ZN
        t74xkT4PO4tIwTmvVjn0uCXsR0x2vUy1eP81C7o=
X-Google-Smtp-Source: AMsMyM6jNdpwO0Gsjs16svcKe83EU8dEPdt5cqrWijEpupBIjP9YP9EhrPCjm2CLWc+l54F89wwdzuuqLC6yFccRJSM=
X-Received: by 2002:a1f:7cc9:0:b0:3a2:f9f:e712 with SMTP id
 x192-20020a1f7cc9000000b003a20f9fe712mr4353957vkc.23.1663496358718; Sun, 18
 Sep 2022 03:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000095339805e8d6958e@google.com> <de81bf82-3ddf-4875-381d-e52949046b25@I-love.SAKURA.ne.jp>
 <f3b88739-148c-323c-2458-4b9d6bf9c592@I-love.SAKURA.ne.jp>
In-Reply-To: <f3b88739-148c-323c-2458-4b9d6bf9c592@I-love.SAKURA.ne.jp>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 18 Sep 2022 19:19:01 +0900
Message-ID: <CAKFNMo=XjvQjoSo+N-MJGv5h4FPnjVm6bGaJm0QkO8GxjMNtTg@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in kernfs_put_active
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+258ad6d2cb6685e145bc@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Sun, Sep 18, 2022 at 3:26 PM Tetsuo Handa wrote:
> On 2022/09/18 0:50, Tetsuo Handa wrote:
> > I don't know whether crafted filesystem image is used is relevant to this problem.
> > But I think a bug is inside NILFS2 filesystem code.
>
> I confirmed that use of crafted filesystem image is irrelevant to this problem.
> You can reproduce this problem using fault injection patch
>
> ----------
> diff --git a/fs/inode.c b/fs/inode.c
> index ba1de23c13c1..dfde0cadd51e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -192,6 +192,10 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>         inode->i_wb_frn_history = 0;
>  #endif
>
> +       if (!strcmp(current->comm, "my_touch")) {
> +               inode->i_security = NULL;
> +               goto out;
> +       }
>         if (security_inode_alloc(inode))
>                 goto out;
>         spin_lock_init(&inode->i_lock);
> ----------
>
> and script which uses freshly created clean filesystem image.
>
> ----------
> cp -p /bin/touch my_touch
> dd if=/dev/zero of=nilfs.img bs=134221824 count=1
> mkfs.nilfs2 nilfs.img
> while date; do mount -o loop -t nilfs2 nilfs.img /mnt/; ./my_touch /mnt/file; umount -d /mnt/; done
> ----------
<snip>

Thank you for your help, Handa-san.

The first oops inserted by your injection patch is already reported by
[1], and the bug fix is queued in the for-next branch of vfs tree [2].
  Take a look at the patch titled "fs: fix UAF/GPF bug in
nilfs_mdt_destroy" in the
latest linux-next or vfs/for-next.

[1] https://lore.kernel.org/all/CAFcO6XOcf1Jj2SeGt=jJV59wmhESeSKpfR0omdFRq+J9nD1vfQ@mail.gmail.com/T/#u
 (report)
[2] https://lkml.kernel.org/r/20220816040859.659129-1-dzm91@hust.edu.cn
(vfs patch)

The correction was done for inode_init_always() instead of fixing
nilfs2.   Please refer to [3] for the background.

[3] https://lkml.kernel.org/r/20220815175114.23576-1-konishi.ryusuke@gmail.com
     (discussion of how to fix it.  The nilfs2 patch itself was withdrawn)

I confirmed that the patch [2] fixes the second oops as well.

I'm not sure if the patch [2] fixes the originally reported problem,
but it will be fixed if it's the same.

Thanks,
Ryusuke Konishi
