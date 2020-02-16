Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F3F16019E
	for <lists+linux-nilfs@lfdr.de>; Sun, 16 Feb 2020 05:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBPEAM (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 15 Feb 2020 23:00:12 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32876 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBPEAM (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 15 Feb 2020 23:00:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so13609650oig.0;
        Sat, 15 Feb 2020 20:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZumH7VSrBkKR9NuOEmDOA6BzNCZCemt1XDqhscI/Rg8=;
        b=oCKRXQmLkUaU9aBBVuQLL49iWPzXFYxZff6uobWah6jW+qQ07eqAIwApdkyYiYi5Ap
         wLI95FcbLBhSE/mfgqdXZxfE1zmhlR3hDWg323ma/ErVn2kVy0472MdERY5RalCIQKn1
         XOVWcSl19OfC5BgJHqkcJzD/mh/4pC8FNo+cxTkzOxqqh7A2UNbONOv6COOsdxoUO5hx
         0htoYl6MMNcJ3MeF6RzyyPhDadoQDUwpC0UATY1VzRMq5MPnxWMezdkaTkwlDAtwswgH
         p6ezQNFoZvTuB3/sqZ85+E4qZOeoXDWds/h9/yCa2+B0Qd+7J5jLC4ojKK7I2X9sJuoz
         OQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZumH7VSrBkKR9NuOEmDOA6BzNCZCemt1XDqhscI/Rg8=;
        b=R0lshnfrdZdGe51i9I7iJI/yHJEloZnIhUBUqWrsNrG92bOu7Pl1vvtpvVL5qXoGet
         VoR8SgY5ICIuBcT57pgDnqrfrO4fk6dTNzztSYJhIxnukDHbkptMHDhX3md5VyprRrZh
         jQ5Opg7tkzQfIFoyyF9kY69QqgvRr5mWrUCh5itljditUWGPfTHti0+7yvA2v/mdwfgl
         alKZjlsuHv32RtlBQPyqy4moFC0TccHJ6DDQuy+BVfYxpmB0N2JXbZ2+nQCs0MC3+xKO
         SWpHNLulIfaSw9v/0qbNp9EYe2OOygo1Z9sJ3oEubL/dpZU+8wV6Fh/OQoxS+U24TIuv
         JCaA==
X-Gm-Message-State: APjAAAUnrumNxByewSHYkTASLzT9Km8Ie0pD1jYkK6LsqNkLAGEN/Mnk
        tADBtOnmhztm7yMXvYobwUzIx8YjHO4P+FOtIk0=
X-Google-Smtp-Source: APXvYqxXE4L+9tdQlq9Ap72wyc2lDsVufYTW8S5atcrR68GhBF8HhicXwwLx/LsVLq2BuvWl0nXYUujLjVkcL+EWQKI=
X-Received: by 2002:aca:d954:: with SMTP id q81mr6429692oig.157.1581825611084;
 Sat, 15 Feb 2020 20:00:11 -0800 (PST)
MIME-Version: 1.0
References: <CAKFNMo=k1wVHOwXhTLEOJ+A-nwmvJ+sN_PPa8kY8fMxrQ4R+Jw@mail.gmail.com>
 <20200123.225827.1155989593018204741.hermes@ceres.dti.ne.jp>
 <20200210.224609.499887311281343618.hermes@ceres.dti.ne.jp> <20200216.111029.687350152614907818.hermes@ceres.dti.ne.jp>
In-Reply-To: <20200216.111029.687350152614907818.hermes@ceres.dti.ne.jp>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 16 Feb 2020 12:59:59 +0900
Message-ID: <CAKFNMo=ddKezZ7_q8R0N6Ldzqbf=J6NsOvfHQ2N2XLZdeiYCjg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
 00000000000000a8 in nilfs_segctor_do_construct
To:     ARAI Shun-ichi <hermes@ceres.dti.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        "Brian G." <gissf1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Thank you Arai-san,

Your method with loopback device worked to reproduce the issue
even where the bug doesn't easily hit for physical devices.

Regards,
Ryusuke Konishi

On Sun, Feb 16, 2020 at 11:11 AM ARAI Shun-ichi <hermes@ceres.dti.ne.jp> wrote:
>
> And,
>
> In <20200210.224609.499887311281343618.hermes@ceres.dti.ne.jp>;
>    ARAI Shun-ichi <hermes@ceres.dti.ne.jp> wrote
>    as Subject "Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct":
>
> > Hi,
> >
> > FYI, reporting additional test results.
> >
> > I reproduced this problem with clean NILFS2 fs in previous mail.
> > "clean" means that "make filesystem before every tests."
> > In this mail, I tried to reproduct with/without VG/LV, LUKS, loopback.
> >
> > * Not reproduced
> >  USB stick - primary partition - NILFS2
> >  USB stick - primary partition - VG/LV - NILFS2
> >  USB stick - primary partition - VG/LV - LUKS - NILFS2
> >  USB stick - primary partition - LUKS - VG/LV - NILFS2
> >  USB stick - primary partition - LUKS - VG/LV - LUKS - NILFS2
> >  /tmp (tmpfs) - regular file - NILFS2 (loopback mount, kernel 4.19.82)
> >  USB stick - primary partition(512MiB) - NILFS2
> >
> > * Reproduced (always, immediately)
> >  /tmp (tmpfs) - regular file - NILFS2 (loopback mount)
> >  USB stick - primary partition - ext4 - regular file - NILFS2 (loopback mount)
>
> this loopback problem is seen in Kernel 5.5.4.
>
> > Test conditions:
> >  kernel 4.19.86 (same as previous test)
> >  NILFS2/ext4 filesystem, VG/LV, LUKS were made with default parameters
> >  size of "primary partition" in USB stick is approx. 14GiB
> >  size of "regular file" is approx. 512MiB
> >  "reproduce": mount NILFS2, touch file, sync
