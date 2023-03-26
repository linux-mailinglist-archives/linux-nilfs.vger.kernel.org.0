Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD086C9459
	for <lists+linux-nilfs@lfdr.de>; Sun, 26 Mar 2023 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCZMwQ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 26 Mar 2023 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZMwQ (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 26 Mar 2023 08:52:16 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D102D1BD0
        for <linux-nilfs@vger.kernel.org>; Sun, 26 Mar 2023 05:52:14 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id g17so5210322vst.10
        for <linux-nilfs@vger.kernel.org>; Sun, 26 Mar 2023 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679835134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82K7b4UZGSbufNasMeAJ1MlSiuU4N9WB+LwOslC2/tg=;
        b=Olpmyt0wegSXXCZ7UsovSYO868k8YS187MZSZfH/CeuhcGyebTgAURtNJejzL07eb+
         2tAXPlN1ZcpwVblWK7XxM1I8l9rZX34C2frHeQ3DRz1Gh1lScteUhu+jii1eQklpUR8A
         EnaDW52JZ3iGBbBDyOxCHQjhOWmvtxNAlMhcXuZPBTAfmRwZ0AJmuCRjCERS2aPqNhwo
         9QRs6fHm+Iq3il4yXmZnwCBdu5eNBbs9aqx5Vu40FcbE57g8+YICgxSJSLzOBTZ/6Z+I
         LFgsH4gBMOf8sXKet/atQ55kVxp9NcH8M9x1JoSfCfFxvkMdLmkTdQ8tH85HefRd2bb8
         ekZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679835134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82K7b4UZGSbufNasMeAJ1MlSiuU4N9WB+LwOslC2/tg=;
        b=JkVuBsqadb0P+m2nf/frAnqUkLYYmLpEH6mrBz7csSUzVzmJxDA30y+6QkR2w3MHns
         pYblZLqvfkgJLCO9Weft2DVRGN9yl0wXxZp3HTc46POIIyzvCblTbRSHBETn16Lx7T9r
         jPzEjYttVWPd+Wg2zFOYsrtDe6hZf7VBM2UVkgpGnkB8JAgopvWCmKn+q4huQk99En+B
         nJ1hW9jlGFmUWqfWjKjeg1L6grG/0hmhFbdbejF0bFMcSVIfkk+eL3o8juxMrG74pPf0
         7WyVzCba0QgF2zHdcgg8Z0snH8Z0yuADTiEGqYD38a0UmX+F7JvSlQWI2C3QwI6CBiv8
         jNWg==
X-Gm-Message-State: AAQBX9dH0MVtJgLYwEg8g8fCL/nCVNSosKNcqyOq8y8/l63eBRZ0sye8
        //dRSdubBN833eyBqu7RKFoGH6zQrsHDt/QdT70=
X-Google-Smtp-Source: AKy350Yq91wMLhv/3p0WARMdwwg9a8106IcuxKDuBC6a+awbz1drHUORhQFdWrNf9xysid/8Ww0790W9Z8YblT9jJAM=
X-Received: by 2002:a67:c089:0:b0:426:7bc6:4cb2 with SMTP id
 x9-20020a67c089000000b004267bc64cb2mr3505442vsi.7.1679835133785; Sun, 26 Mar
 2023 05:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000d710705f63f014c@google.com> <6c1d39bc-b19b-becf-821e-8cc9db8b4167@I-love.SAKURA.ne.jp>
 <CAKFNMokJ0_n6y3Wrc87WfhKA02ay4dqP7R_4XnonqDCj_Tuqcg@mail.gmail.com>
 <1103c7b0-0e46-4a92-74ee-920bf9599a80@I-love.SAKURA.ne.jp> <85f48e7e-a1dc-69ac-4e28-7449036cc8b3@I-love.SAKURA.ne.jp>
In-Reply-To: <85f48e7e-a1dc-69ac-4e28-7449036cc8b3@I-love.SAKURA.ne.jp>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 26 Mar 2023 21:51:57 +0900
Message-ID: <CAKFNMokp_mRP2mWTKBZZZ=QuiWWwVb+tDfhD6XrE4xcucSBq0A@mail.gmail.com>
Subject: Re: [PATCH v3] nilfs2: initialize "struct nilfs_binfo_dat"->bi_pad field
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

On Sun, Mar 26, 2023 at 7:27=E2=80=AFPM Tetsuo Handa wrote:
>
> nilfs_btree_assign_p() and nilfs_direct_assign_p() are not initializing
> "struct nilfs_binfo_dat"->bi_pad field, causing uninit-value reports
> when being passed to CRC function.
>
> Reported-by: syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.co=
m>
> Link: https://syzkaller.appspot.com/bug?extid=3D048585f3f4227bb2b49b
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Changes in v3:
>   Also fix nilfs_btree_assign_p().
>
> Changes in v2:
>   Use memset() for initialization, suggested by Ryusuke Konishi.
>
>  fs/nilfs2/btree.c  | 1 +
>  fs/nilfs2/direct.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index 2681a449edc1..13592e82eaf6 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -2219,6 +2219,7 @@ static int nilfs_btree_assign_p(struct nilfs_bmap *=
btree,
>         /* on-disk format */
>         binfo->bi_dat.bi_blkoff =3D cpu_to_le64(key);
>         binfo->bi_dat.bi_level =3D level;
> +       memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));
>
>         return 0;
>  }
> diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
> index a35f2795b242..4c85914f2abc 100644
> --- a/fs/nilfs2/direct.c
> +++ b/fs/nilfs2/direct.c
> @@ -314,6 +314,7 @@ static int nilfs_direct_assign_p(struct nilfs_bmap *d=
irect,
>
>         binfo->bi_dat.bi_blkoff =3D cpu_to_le64(key);
>         binfo->bi_dat.bi_level =3D 0;
> +       memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));
>
>         return 0;
>  }
> --
> 2.34.1

Thank you for your cooperation, Handa-san.

I'll send this upstream, adding a Reported-by tag of the preceding report.

Thanks,
Ryusuke Konishi
