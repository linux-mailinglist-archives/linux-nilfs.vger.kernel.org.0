Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B789B595637
	for <lists+linux-nilfs@lfdr.de>; Tue, 16 Aug 2022 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiHPJ2k (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 16 Aug 2022 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiHPJ2K (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 16 Aug 2022 05:28:10 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BC6584
        for <linux-nilfs@vger.kernel.org>; Tue, 16 Aug 2022 00:46:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-324ec5a9e97so130424467b3.7
        for <linux-nilfs@vger.kernel.org>; Tue, 16 Aug 2022 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=8Yukm6IoZYfpPJpaCKSecWUw9Ym3RfYDxea1L/nbqQA=;
        b=foDsXYEoPlUb/3s0pJVmWr41mvJxNdCtFj7cxcOA7+TD/0UNLGuSQIV1pNK8wlnMln
         qzpvPrU9YFagd52yAdTnFRvLQuRY9JesFOixMtNJcVs38Y5U2urxcG9E0OszpJEt+4lY
         83b9MuU1dOq/9s5t5kATCmD2vSTvoNyjWof+fRLmJLO6KzB+C5qN2e1hENirub8KcRun
         ZVFDMtOnqrAczuor6FCsyzsb6cgNiLwjYB++BJZvp3xizVGiDzjNWJl52J8PlSb1wleg
         ahH/AU+U2a1qKMJJQQRmZI9SZkVV3arUNWzZDJfDijiIaRwKFjusRiufV6ZLMzOxPIHr
         VTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=8Yukm6IoZYfpPJpaCKSecWUw9Ym3RfYDxea1L/nbqQA=;
        b=6mMkVl5BY3WbacLd+erEGJqM8ci4KQbzpzmqaO9MpUdsDYkJdSRnVtmcx+X8EmoWbV
         jufO7AXTJpfT6SFWJvCAlJOPoFul8iI3f9uJuBTgFVOhD8az/HUDyg31c3B5M4b4AwUO
         tJHdq0eT+53PP0X78XinmvFdjdd21AIEDEZV5yp5QLzZB3seQA3tPpoAfWR4DYazClk0
         EDTf7Kplh9+VG/RxvluqkI/KzEgGQey8jqrRGNMgdqkZ16rK5PeIy04GaHWtSnUnO4mu
         k1oh0OEmV6+K9xOrlt5hTKNh2zWAb+0VsjB+SeuX00ewT3BtSIkwghx8Q641qzz3LTNy
         lsMQ==
X-Gm-Message-State: ACgBeo1z/MvVRIz/93VoHNYI/lwBCEDDkQwCFvSO5/Y7GQSj3OA+FrRM
        1CguVcvgbwHdOrEe5T2yXfr6bSgEgXFPAEFVxd0=
X-Google-Smtp-Source: AA6agR5wMEbLcyv32G/LmYo2OqnAlBoDwgE+nLVbGG/BYVCy+3QG5ILvTU9SOqsAM68XeD7nfT88lVMCd83OsFdf6lw=
X-Received: by 2002:a0d:d841:0:b0:31f:4450:2104 with SMTP id
 a62-20020a0dd841000000b0031f44502104mr16216404ywe.70.1660635974222; Tue, 16
 Aug 2022 00:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <34e8df4a.848e1.182a1264256.Coremail.stitch@zju.edu.cn> <8C0C088A-11A4-4D0E-93B9-CA70F0040341@oracle.com>
In-Reply-To: <8C0C088A-11A4-4D0E-93B9-CA70F0040341@oracle.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 16 Aug 2022 15:46:04 +0800
Message-ID: <CAFcO6XN-m2VvV0FCLGBSiTLKZ0mj_WESqz=ZVPWdpmECJuv-+w@mail.gmail.com>
Subject: Re: [vs-plain] KASAN: use-after-free in nilfs_mdt_destroy
To:     John Haxby <john.haxby@oracle.com>
Cc:     =?UTF-8?B?6K645ZiJ6K+a?= <stitch@zju.edu.cn>,
        "security@kernel.org" <security@kernel.org>,
        "linux-distros@vs.openwall.org" <linux-distros@vs.openwall.org>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>
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

Hi, there is a patch for this issue.
https://lore.kernel.org/linux-fsdevel/20220816040859.659129-1-dzm91@hust.ed=
u.cn/T/#u


On Tue, Aug 16, 2022 at 3:36 PM John Haxby <john.haxby@oracle.com> wrote:
>
>
>
> > On 15 Aug 2022, at 11:56, =E8=AE=B8=E5=98=89=E8=AF=9A <stitch@zju.edu.c=
n> wrote:
> >
> > Hi developers,
> >
> > We may found a flaw in the fs module which can lead to UAF write or DoS=
.
> > We would appreciate a CVE ID if this is a security issue.
> >
>
> Confirming that your message made it through to linux-distros, but you ha=
ven't mentioned a date when this would be made public.  However,
>
> > Someone found the similar problem: https://groups.google.com/g/syzkalle=
r-bugs/c/z2WroC3_BSw.
> >
> > Fix this bug by moving the assignment of inode->i_private before securi=
ty_inode_alloc.
>
> There's already a public discussion about that and if, indeed, that's the=
 same bug then you should take this to oss-security as simply a rediscovery=
 of an existing bug.
>
> I'll leave it to Red Hat to decide whether to allocate a CVE number for t=
his issue. It needs significant privileges to exploit it; the only real que=
stion is whether you could use those privileges to crash the machine anyway=
.
>
> jch
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller/8C0C088A-11A4-4D0E-93B9-CA70F0040341%40oracle.com.



--=20
Active Defense Lab of Venustech
