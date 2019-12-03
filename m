Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADD9110657
	for <lists+linux-nilfs@lfdr.de>; Tue,  3 Dec 2019 22:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLCVOM (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 3 Dec 2019 16:14:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32812 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfLCVOM (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Tue, 3 Dec 2019 16:14:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id v140so4640416oie.0
        for <linux-nilfs@vger.kernel.org>; Tue, 03 Dec 2019 13:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ElSux9umEKAWJ51UvfVX8n7bopQlWtixAgQlw1rXIM=;
        b=Wx9Z7XM6wAySvhPO5C5C+bu9rU5SKwZ9dDpB3lvEeU4xPyr2N/alLlPmGqEM1YkyEr
         0h+uKK9T48tP+yMusmmEREVnY+Bxo4kXrDaj0imYPQXb7Ywod6MwhLHshxYDAhxj6fsy
         E44nT+YOEsBjYkWuc4OzhcZ5DK2Ea491/gp0z5hcTkMwTqpnQxuTLRuTKCsRQoGaDoFI
         xNZfL6vWRMqZPlialYmLB52BWxim7YhteyY5kLMMv2K/A4Dv+LDrg8nYtEQa3GKF3EyQ
         z+qPlRmvyCHZ7lhTqsT5/IXeNr7cSynmnm3MrfrbM8pQBofa33ZviYHvcviFAXUbhVNB
         vNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ElSux9umEKAWJ51UvfVX8n7bopQlWtixAgQlw1rXIM=;
        b=kxwhYeS4yVnD38EhH/lHqz1LUGygF1xfaXG+T1HXtnvUaU96HT+17h3eKqDhxZuoZe
         XfK6SuVsOgSyJy2CzDppv1xMIvbxyNjYdDyWvBGjO2YY8tU7jvMy9ShZ2lEP8CVTEPJv
         /lTSY3h4umhgBf2fYbksrcRSCMbFjQuJsHiBs/cp7rCud0OoQPbQOFMNLDEBDpfN+hKz
         gF0zXRKXDFa7Wa2V2FOTzqOtWpA9H0MtBupmL+fv5nqNKHezk9ut9pM1mb/qeyzuV3IP
         LjTDmou7690C0BFhLseVl2yG1ZH1QxloGByaH5M7dgelVU30huq0CG/gEZ9k/46DOw+z
         6lJQ==
X-Gm-Message-State: APjAAAVb5wJaXfKwrGC2MNRkOZlFCJh72jIjcIe/ApdZ74I3NyUHCEh+
        4QSi2GjaD67dGG8/c0dqRwrDn1QN9WdYDyiux9u7c4tj
X-Google-Smtp-Source: APXvYqxsDbPwcyzF8OTcEO3aNmnBNaIWTul4gg9S5jwDzBVwwExP4rvb0SFenAmeglJRwWsLl5pX6sSXlCYHten1kU4=
X-Received: by 2002:aca:c7cb:: with SMTP id x194mr59522oif.157.1575407651356;
 Tue, 03 Dec 2019 13:14:11 -0800 (PST)
MIME-Version: 1.0
References: <70b53768-11db-dd75-38c9-5d1786ae88e9@daneng.org>
 <CAKFNMoks2DGE=BeEXR60DTXSXWbsfPogGReD8EjV=YqyMjTMjA@mail.gmail.com>
 <CAKFNMomjWkNvHvHkEp=Jv_BiGPNj=oLEChyoXX1yCj5xctAkMA@mail.gmail.com> <67cba1e3-89cb-db0d-43c3-fa4bdfba0781@waltonhoops.com>
In-Reply-To: <67cba1e3-89cb-db0d-43c3-fa4bdfba0781@waltonhoops.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 4 Dec 2019 06:13:59 +0900
Message-ID: <CAKFNMom+u6yPO-hO5jmdAmUUbbZYqLVF2uGVaFYXcJ-+YzQTTQ@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00000000000000a8
To:     Walton Hoops <me@waltonhoops.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        Tomas Hlavaty <tom@logand.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

Yes, I also confirmed that it hits on the
mainline as well.

Unfortunately, the cause of the issue is not trivial.

Anyway, thanks for reporting.

Regards,
Ryusuke Konishi

On Wed, Dec 4, 2019 at 1:20 AM Walton Hoops <me@waltonhoops.com> wrote:
>
> FYI, Arch got 5.4.1 this morning, and it looks like the issue is still
> present.
>
> On 11/20/19 12:34 AM, Ryusuke Konishi wrote:
> > As the result of bisection,  it turned out that commit
> > f4bdb2697ccc9cecf1a9de86905c309ad901da4c on 5.3.y
> > ("mm/filemap.c: don't initiate writeback if mapping has no dirty pages"=
)
> > triggers the crash.
> >
> > This patch was back ported from upstream kernel 5.4-rc1, and
> > applied to 4.19.84 as well.
> >
> > Will look into the change further and why it doesn't hit latest
> > kernels (5.4-rc8, etc).
> >
> > Regards,
> > Ryusuke Konishi
> >
> >
> >
> >
> >
> >
> > On Wed, Nov 20, 2019 at 12:46 AM Ryusuke Konishi
> > <konishi.ryusuke@gmail.com> wrote:
> >>
> >> Yeah,  this looks a regression of the 5.3.11 stable kernel.
> >>
> >> I could reproduce the crash with 5.3.11.
> >>
> >> 5.3, 5.3.10 and 5.4-rc8 all worked fine.
> >>
> >> The regression would be identified by bisecting commits
> >> between kernel 5.3.10 and 5.3.11.
> >>
> >> Thanks,
> >> Ryusuke Konishi
> >>
> >> 2019=E5=B9=B411=E6=9C=8819=E6=97=A5(=E7=81=AB) 23:40 <linux-nilfs-ml.v=
ia.forwarder@neverbox.com>:
> >>>
> >>> I believe I have the same issue as Walton Hoops.
> >>>
> >>> I do not have a serial console, and all my filesystems are NILFS2,
> >>>
> >>> so I do not currently have an easy means to capture the crash.
> >>>
> >>> However, I experienced the same Kernel BUG on upgrading to kernel 5.1=
1
> >>>
> >>> from 5.10. Reverting back to 5.10 results in a clean boot.
> >>>
> >>> The actual kernels I use are the Ubuntu 'mainline kernels'
> >>>
> >>> 5.3.10-050310-generic works
> >>>
> >>> 5.3.11-050311-generic crashes with Kernel BUG.
> >>>
> >>> So I suspect a change between those two versions has triggered the pr=
oblem.
> >>>
> >>>
