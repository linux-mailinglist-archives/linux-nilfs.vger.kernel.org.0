Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C837E5956F3
	for <lists+linux-nilfs@lfdr.de>; Tue, 16 Aug 2022 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiHPJr3 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 16 Aug 2022 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiHPJrD (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 16 Aug 2022 05:47:03 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33181901A
        for <linux-nilfs@vger.kernel.org>; Tue, 16 Aug 2022 01:35:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31f445bd486so132847007b3.13
        for <linux-nilfs@vger.kernel.org>; Tue, 16 Aug 2022 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=FMUX1ca5qhsOzjLJCdGy9/aUl/PcngAKP1Q59U2m9jw=;
        b=n/tVJwbfPpK8pmRi/mUkTlRYcBg3snZ+3io5/uWNXWWIsGMarWtT4bwSp78kaRbEeO
         0PEuc1pZiXvOpJSDn5GzVdtKYn9GLS7OgNFuTBCIHkGO4BImoS6Pc78burXmiZFPjjaq
         /V4u5urQLJBJECSZnZP3kyksl7wAZliXNThFwtO85aUazaAN9TZP1KUPRLDOpO+oLdWG
         OW+MTPl+h3JiMT3MEzILafl0FK2HBVvwTR7RLkAzTFiTApjInCKKO6leEfBLsDKyBsN0
         6fX4R2buiWqkbcxKwvmMjv18D0ZXtn9c48AMiC5tSPqbR+NZNWd7x2BsWeNgxC6KMOlk
         MQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=FMUX1ca5qhsOzjLJCdGy9/aUl/PcngAKP1Q59U2m9jw=;
        b=wqRJk1rV7AH41jY4+3H4zKWSrpd4JDycggxXTAeoL0kCEIdH6sQaSIMh3ulfSggQO7
         0m8Tg8hql66iEZz0l2UXoLWCuWDxVyephXdAp0TJQVXhIUtG5TyzV+cXFw/SsaWsPQZ8
         yCQzytVQtecDnZBLmDh4Q6VyZ3XUMGAn2uJSb5FtwBITzBbYpchUK/85hupIL5L85oKh
         a8D0ribIuWk7mY4Mw8JRW7iE2Zsvszx2SaERe3ZOCHfyjyBluSqwtn2THsl14gjJyMrh
         qQJowzrAVkYu7euuWOMBZO+oED7xjdKRzSH+DwYsvEDGWp3GjBWIJ3iPAZZCQqrNkdXw
         eBdQ==
X-Gm-Message-State: ACgBeo24JXLVUBNm/nNhgozLZDvkNwIzStWtF6y+I0n6DwRxIy18bTBo
        PRDrsWDjvoJywk1U/pkvRRcZ7/rwTbogUur+vPA=
X-Google-Smtp-Source: AA6agR4WsWApWLCkxY1TBXnqHkZVb3PghWfhIkFqa1qTmdA690WGastHqOsBA+lLNqSNhFcvpPCzu4RlyloCmQNWnV4=
X-Received: by 2002:a81:7702:0:b0:328:297a:fdcb with SMTP id
 s2-20020a817702000000b00328297afdcbmr15823520ywc.335.1660638910801; Tue, 16
 Aug 2022 01:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <34e8df4a.848e1.182a1264256.Coremail.stitch@zju.edu.cn> <Yvovz7FKlHLNpNaf@kroah.com>
In-Reply-To: <Yvovz7FKlHLNpNaf@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 16 Aug 2022 10:35:00 +0200
Message-ID: <CAKXUXMy94SkUA9jU69H9Mdkzo4gui+3kTc2YoqaeoXmCHYKzGA@mail.gmail.com>
Subject: Re: [vs] KASAN: use-after-free in nilfs_mdt_destroy
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?6K645ZiJ6K+a?= <stitch@zju.edu.cn>, security@kernel.org,
        linux-distros@vs.openwall.org,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Mon, Aug 15, 2022 at 1:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 15, 2022 at 06:56:55PM +0800, =E8=AE=B8=E5=98=89=E8=AF=9A wro=
te:
> > Hi developers,
> >
> > We may found a flaw in the fs module which can lead to UAF write or DoS=
.
> > We would appreciate a CVE ID if this is a security issue.
>
> As our documentation states, us at security@kernel.org do not assign
> CVEs or deal with them at all.
>
> >
> > HEAD commit: 3d7cb6b04c3f Linux-5.19
> > git tree: upstream
> > console output:https://drive.google.com/file/d/1PoH9PUdMilsrKtq1oGHu_sh=
M3dggNFAB/view?usp=3Dsharing
> > kernel config: https://drive.google.com/file/d/1wgIUDwP5ho29AM-K7HhysST=
fWFpfXYkG/view?usp=3Dsharing
> > syz repro: https://drive.google.com/file/d/19N1Xh8TVoSUr_2J8j-bWXktL21S=
vRx_9/view?usp=3Dsharing
> > C reproducer: https://drive.google.com/file/d/1R1rYseY7JBDCSfLAP4pjSCoM=
Vgkr7l5b/view?usp=3Dsharing
> >
> > Description
> > In alloc_inode, inode_init_always could return -NOMEM if
> > security_inode_alloc fails. In its error handling, i_callback and
> > nilfs_free_inode will be called. However, because inode->i_private is
> > not initialized due to the failure of security_inode_alloc, the functio=
n
> > nilfs_is_metadata_file_inode can return true and nilfs_mdt_destroy will
> >
> >
> > be executed to lead to GPF bug.
> >
> >
> >
> >
> > Someone found the similar problem: https://groups.google.com/g/syzkalle=
r-bugs/c/z2WroC3_BSw.
>
> Great, can you work on this in public on that thread then?  Have you
> tested the proposed patch that is provided there to see if it solves it
> or not?
>
> > Fix this bug by moving the assignment of inode->i_private before securi=
ty_inode_alloc.
>
> That's what the existing patch looks to do, does that work?
>
> And again, as this is public, why notify us and not just work to solve
> this in public with the developers involved?
>

Hi all,

this email was sent to security@kernel.org, where the emails are
supposed to remain undisclosed in a private email list with curated
participants, but it was also sent to the public mailing lists
syzkaller@googlegroups.com and linux-nilfs@vger.kernel.org. So the
whole communication is already public and disclosed. I guess there are
really no measures needed now for anyone to keep anything further
"secret due to security" and all efforts can be simply put in
understanding the reported issue, the known patch and the next steps
in the usual public channels.

Just to add to Greg's advice, it was public from the beginning, so
there really was not the need to have security@kernel.org in the loop.

I would like to understand which statements in the kernel's patch
submission guidelines got you to report to security@kernel.org. Can
you point to those parts of the documentation? Then, we can think
about how to improve those and see if that improvement helps others
avoid such potential process issues in the future.


Best regards,

Lukas
