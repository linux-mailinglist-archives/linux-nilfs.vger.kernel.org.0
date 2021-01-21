Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D72FEDF0
	for <lists+linux-nilfs@lfdr.de>; Thu, 21 Jan 2021 16:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbhAUPDb (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 21 Jan 2021 10:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbhAUPDI (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 21 Jan 2021 10:03:08 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABE6C061756
        for <linux-nilfs@vger.kernel.org>; Thu, 21 Jan 2021 07:02:27 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a10so3013613ejg.10
        for <linux-nilfs@vger.kernel.org>; Thu, 21 Jan 2021 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mA1JBPDD0fnbcYxnsbbdLiImCHIJu79VjpXqSMkQprU=;
        b=VasqO5UVWpmqNkQEbfT/O+dA5bIvvtRFp3CK9+oKUQlQr0vU5dCesoY9C4zK76cQv+
         PKqyzxn5j0oHSNbO3TyYiBYlZ/hDSyt7VdlmDA/XXWYsoJYg9OVuOKWSvcBJHX3BT/A/
         E45dz3sZQnVz4bdtSfqzcUB1VaLfB37a4j8ECtuBj5OaDl2ouddWr5wRLmwjNUMspwdQ
         DvtLfIGjYqsit7sme5OG+9ZiLTs0J6QXU0ewV9MlmP7UDV4amHJrf2c4GPblufgC/0wD
         OhPSI/n8B4+zV3X0bdNnRLBY3HdIc3kiaVTS5GMwxYNLS2U1FMIRx8f0+0FFezIPm05J
         Gp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA1JBPDD0fnbcYxnsbbdLiImCHIJu79VjpXqSMkQprU=;
        b=fq+gbhKoP3CRgeBBarsY8jg1Dmd0NDhX2kLLfRxZRaANYHGscDudafMmAno2KAgCZh
         16RW62Jy6S3FNN5sBaRY5j43hG/jgZ376Y2Vn6M8IyRrO/jt4gMrOqUh/RabUrhvzCar
         zFp+3LwdOWE8pMPYy8TW+xj4AcTz/SAwOuQWZHHNXv40Ro3XVJBLWpDkrcmpuN5YG0gp
         fKhSDT5seHfuXyNn7eV07ufzBG07xX2tdozkroImpJMtOJddr4TdLK/xW/CR9jgwS1Ea
         WAkwAiWMOGxGTxvMvLWCu48PtRCD1BeS2qGFAnzMxNyEqN2s7kLeQ8sQqLRaOM9yfkBS
         9byg==
X-Gm-Message-State: AOAM531ZuVzof6j9QiWqk2M7lWGLra15E76qc+6jlyGzBYlvb46sS3+6
        oIVrldgO4l99Koxn8SwlbADEkaLS6q/FshZ3rKE=
X-Google-Smtp-Source: ABdhPJxW0dsNIWsdnpT/ZJ6Szh7sonhbc8TGgsj6u8GRR/j/lxpuid2PijewWDIDGd1hixwVjvPvPVU7CVvx8npwCS4=
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr9210315ejb.202.1611241346306;
 Thu, 21 Jan 2021 07:02:26 -0800 (PST)
MIME-Version: 1.0
References: <ab9c4da7-428d-1ed4-c3a6-07d6d90815ba@eurek.it>
In-Reply-To: <ab9c4da7-428d-1ed4-c3a6-07d6d90815ba@eurek.it>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 22 Jan 2021 00:02:14 +0900
Message-ID: <CAKFNMokm-Ciz+---m+sqG10e+JERSH8mhHdnOJppZPgk=T2d+w@mail.gmail.com>
Subject: Re: Strange issue on disk usage with nilfs2 and df command
To:     gianluca <gianlucarenzi@eurek.it>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

Can you try "sudo lssu -l -p 60" ?

This shows the percentage of live blocks for every in-use segment
at the time.
("Live block" here means in-use block, which is not reclaimable
 with GC.  If you are using snapshots of NILFS, this pushes up the
 number of live blocks)

"df" command reports disk usage based on the percentage of in-use
segments instead of actual live blocks.  "lssu -l" may give more hints
about disk usage.

Regards,
Ryusuke Konishi

On Sat, Jan 16, 2021 at 12:13 AM gianluca <gianlucarenzi@eurek.it> wrote:
>
> Hello,
> I am facing a little annoying issue in a Debian Stretch 9.13 (armel)
> board with rootfilesystem with nilfs2 type.
>
> The system has a iMX28 CPU with 256MB DDR2 Ram and 4GB emmC flash storage.
>
> The system has /var /run /tmp in tempfs ramdisk.
>
> In the beginning the filesystem is full at 50% so about 2Gb.
> All the remaining space is technically empty.
>
> The application is writing the same sqlite3 database every 30s or 60s
> dipending on the configuration (it writes few kilobytes every time, so
> the database size increase very little each time).
>
> The rootfs is mounted with: noatime,nodiratime,rw in the /etc/fstab
> configuration file.
>
> The nilfs tools are 2.2.6 as per Debian Stretch version.
>
> The Linux Kernel is 4.9.78 vanilla.
>
> The cleaner configuration file is the standard vanilla Debian version
> with some changes:
>
> protection_period is 60 (original has 3600)
>
> The min_clean_segments is 10% (90% of usage of the disk triggers the
> start of garbage collector)
>
> The max_clean_segments is 20% (80% of usage of the disk triggers the
> stop of the garbage collector)
>
> But in my board it seems something goes partially wrong.
>
> After some days/week of usage:
>
> 1- the garbage collector is a running state (nilfs-clean -l)
>
> 2- The usage is 90% (df command)
>
> After some time the gc goes in idle but the disk space still at 90%.
>
> If I create a big file to increase the usage of the storage up to 95% of
> real disk space, the gc starts after a while, and it remains running
> forever.
>
> If I delete this big file, it runs for a while, then the space returns
> to 90%. But using lsblk it gives me the 80% or less of filesystem usage.
>
> What the heck is happening?
>
> The GC is working as expected, but it gives me wrong status or wrong
> disk usage (df)...
>
> Weird
>
> Anybody has issued this problem yet?
>
> Regards
> --
> Eurek s.r.l.                          |
> Electronic Engineering                | http://www.eurek.it
> via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
> p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
