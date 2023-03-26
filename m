Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECB6C92FD
	for <lists+linux-nilfs@lfdr.de>; Sun, 26 Mar 2023 09:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCZHjJ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 26 Mar 2023 03:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZHjH (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 26 Mar 2023 03:39:07 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E43868B
        for <linux-nilfs@vger.kernel.org>; Sun, 26 Mar 2023 00:39:06 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id b6so1698711vsu.12
        for <linux-nilfs@vger.kernel.org>; Sun, 26 Mar 2023 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679816345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1qkueFPEburKL4fcmEm1XFr6AUNk26OA4X3ROKq40A=;
        b=bIZeluxnQimqBzImm8//QWIaxoJyb+DG5Oo0XP5rHet5DfQDymuNgiHmHQYNI2OlnO
         Oc3PRzDvAn6iAx+dbAXvkDmIgZyzEr++WOlx0X6obYQx5GIudB7f75bvtNfvYF3K2Hf0
         K0FnWw7OZu8W+Co97kd34m6D7NyC442ntwSMfaS7MlxqjX+FjiyyRTJ1I0lTk0Ru7UpH
         kLnsHSB1r9Z88t5+ztIfowKzVkGVDIFyxnWZayzMEdLF+p8FsU+XBrGgyMfUrsSGiZfs
         Dj53+r9xPw2K8k33rm5e+o7h2GB7tRQkw9M1eUdiF1ieUcDi+A0kKTv37MkVsReJYK+6
         jebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679816345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1qkueFPEburKL4fcmEm1XFr6AUNk26OA4X3ROKq40A=;
        b=dzmXmnmnFLnDsY7/MFqEcCmpY8HCKlWpwj0gHKNDd9V6bBPMd8XjvKC9f15w9E1V63
         1xw3mExjwiqfzeTUab7lwH+A2d6qxwPdQSyh+zF6oEu/CQpW0iGCYksLj56h44SZSF6O
         NHrx6KVwXA6p3pzHuhpGx7ZNCE8B9qYHH9n0//8479zXYrOjp9zVKHkVzcy2NjysKHAv
         uAhnyZrutkkb3KKdajNuQH6ESJSd7vuUejrWTZ2jt+PG9mP4xZxBo+hvrPbrBMOH+Wr0
         1G+IZ639AGrWKX+yqvfxoRVDW2RzSAGSrTM4YY97hGyCO69RlUfj7e4ZdPvvBaRYLOaw
         KcZA==
X-Gm-Message-State: AAQBX9f0pSVIwZigutMILpXow/ILjY2C8AH3EIdyPry4gt7LQ5He7m2N
        ExNb9o5ybitnWVTFe6/3JDwCFIRoeJGtduWs7p4=
X-Google-Smtp-Source: AKy350ZMj6pXD9N/lCPrQ9hStwvHd6qLFfkBmJjcL5xprRf6Pmceig/4R4FLszCwsmDdXdupmC+AeAJnliw+Q+apC28=
X-Received: by 2002:a05:6102:4711:b0:425:f1e7:fecf with SMTP id
 ei17-20020a056102471100b00425f1e7fecfmr3855728vsb.7.1679816345004; Sun, 26
 Mar 2023 00:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000d710705f63f014c@google.com> <6c1d39bc-b19b-becf-821e-8cc9db8b4167@I-love.SAKURA.ne.jp>
In-Reply-To: <6c1d39bc-b19b-becf-821e-8cc9db8b4167@I-love.SAKURA.ne.jp>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 26 Mar 2023 16:38:48 +0900
Message-ID: <CAKFNMokJ0_n6y3Wrc87WfhKA02ay4dqP7R_4XnonqDCj_Tuqcg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix incomplete initialization in nilfs_direct_assign_p()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, glider@google.com,
        linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Sun, Mar 26, 2023 at 3:32=E2=80=AFPM Tetsuo Handa wrote:
>
> syzbot is reporting uninit value at nilfs_add_checksums_on_logs() [1], fo=
r
> nilfs_direct_assign_p() from nilfs_direct_assign() from nilfs_bmap_assign=
()
> does not initialize "struct nilfs_binfo_dat"->bi_pad field.
>
> We need to initialize sizeof("union nilfs_binfo"->bi_dat) bytes if
> nilfs_write_dat_node_binfo() from nilfs_segctor_assign() copies it
> and nilfs_add_checksums_on_logs() passes it to CRC function.
>
> Reported-by: syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.co=
m>
> Link: https://syzkaller.appspot.com/bug?extid=3D048585f3f4227bb2b49b [1]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> I'm not sure whether this can fix the bug, for a reproducer is not yet
> available...
>
>  fs/nilfs2/direct.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
> index a35f2795b242..4358b4581ec4 100644
> --- a/fs/nilfs2/direct.c
> +++ b/fs/nilfs2/direct.c
> @@ -313,7 +313,8 @@ static int nilfs_direct_assign_p(struct nilfs_bmap *d=
irect,
>         nilfs_direct_set_ptr(direct, key, blocknr);
>
>         binfo->bi_dat.bi_blkoff =3D cpu_to_le64(key);
> -       binfo->bi_dat.bi_level =3D 0;

> +       /* initialize bi_pad field together while assigning bi_level fiel=
d */
> +       *(u64 *) &binfo->bi_dat.bi_level =3D (u64) 0;

Could you change this just to the initialization using bi_pad below?

     memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));

This is not efficient depending on the compiler, but I'd rather avoid
the non-intuitive initialization using the above cast and use a
straightforward initialization.

This does not eliminate the problem, but it does fix one, so I'll send
it upstream.

Thanks,
Ryusuke Konishi
