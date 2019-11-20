Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758C4103538
	for <lists+linux-nilfs@lfdr.de>; Wed, 20 Nov 2019 08:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfKTHe6 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 20 Nov 2019 02:34:58 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41914 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKTHe6 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 20 Nov 2019 02:34:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id e9so21639015oif.8
        for <linux-nilfs@vger.kernel.org>; Tue, 19 Nov 2019 23:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=us1F8n6Sody3T1A1qvMXX8fLRfQjR5mnWXBiIOEjWu4=;
        b=t02p5TAOUDRD3NL+RXfvL/R1wnuXLHqItP4cujoWsqYk2nmYFkCl06ZWIOxJDlizJO
         knnvauioKBiNTw1+Y5H56O/eGybVEhUviaen7PHL0pTAKyp/O4cdxsxCBk8wooMkqZ0x
         CcbSSAt1Th/wemm9e0gdiyj5Nc0NR3iqhPFHuwGDNngTSsMOMp7VWi10AvG9rtCxLJYB
         P8/xkVNV8U2l7c+CU+7q6QvNRM4GlPAstrm0LTSGjQwfZe16dcz1m0DqiYVtV4JbnEYL
         rvu0nm6gB6Rr3cDr26mrzDjqQmVqTdcAS95tK1rpAkkQBTI/TlE1p+rMVpJEu7zohTyK
         iK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=us1F8n6Sody3T1A1qvMXX8fLRfQjR5mnWXBiIOEjWu4=;
        b=hI0+7IujaMkvioW6/LQBhZfUEuiPDMb/1QsinNt3zzDp+ZM0dJDIjjkXirWpeIZNad
         4wDXrTdEbi1PYEf9mcWbUMXRL3A380RqFUonZwSrnmuUzmiEIgEeu29kk6tmAZXFiMAT
         IYyEzfq7q3YvTDipVMlI29/WBokoxBXJH8o45/ZsaPJZq1/w1hKwcMoeKWULPcLOqyY3
         Hwfj2BUVUWhjIY4uI77PBKwlrkM9MRB1GY9yhh6rcFNHduZiNzrC96pgz1FrQblZJOXV
         UODV4DZBzpCA9YoU6aXh/WLCeriOh+wZzaXuoKtQeNcYunI5kX2CcxAdTOaM4Ej+ieyN
         8hZg==
X-Gm-Message-State: APjAAAVKSrYMWzD7+FSPHaLKP2MTG2soFG0iX3oVT0Y8UvsRfd+4YQkZ
        WkCBlbauiWzraGiAbNaO174XsnNrX4bEoXr3/3B7dw==
X-Google-Smtp-Source: APXvYqwPQEsvm8K8WceYjR3RDJI/uwDXhFc2OUUSkcrfB6twYzfKSCRZ234wzyXyWYFNaizoYBXhSILz6ilTUMSj+NI=
X-Received: by 2002:a54:4105:: with SMTP id l5mr1530970oic.135.1574235294859;
 Tue, 19 Nov 2019 23:34:54 -0800 (PST)
MIME-Version: 1.0
References: <70b53768-11db-dd75-38c9-5d1786ae88e9@daneng.org> <CAKFNMoks2DGE=BeEXR60DTXSXWbsfPogGReD8EjV=YqyMjTMjA@mail.gmail.com>
In-Reply-To: <CAKFNMoks2DGE=BeEXR60DTXSXWbsfPogGReD8EjV=YqyMjTMjA@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Nov 2019 16:34:42 +0900
Message-ID: <CAKFNMomjWkNvHvHkEp=Jv_BiGPNj=oLEChyoXX1yCj5xctAkMA@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00000000000000a8
To:     linux-nilfs <linux-nilfs@vger.kernel.org>
Cc:     linux-nilfs-ml.via.forwarder@neverbox.com,
        Walton Hoops <me@waltonhoops.com>,
        Tomas Hlavaty <tom@logand.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

As the result of bisection,  it turned out that commit
f4bdb2697ccc9cecf1a9de86905c309ad901da4c on 5.3.y
("mm/filemap.c: don't initiate writeback if mapping has no dirty pages")
triggers the crash.

This patch was back ported from upstream kernel 5.4-rc1, and
applied to 4.19.84 as well.

Will look into the change further and why it doesn't hit latest
kernels (5.4-rc8, etc).

Regards,
Ryusuke Konishi






On Wed, Nov 20, 2019 at 12:46 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> Yeah,  this looks a regression of the 5.3.11 stable kernel.
>
> I could reproduce the crash with 5.3.11.
>
> 5.3, 5.3.10 and 5.4-rc8 all worked fine.
>
> The regression would be identified by bisecting commits
> between kernel 5.3.10 and 5.3.11.
>
> Thanks,
> Ryusuke Konishi
>
> 2019=E5=B9=B411=E6=9C=8819=E6=97=A5(=E7=81=AB) 23:40 <linux-nilfs-ml.via.=
forwarder@neverbox.com>:
> >
> > I believe I have the same issue as Walton Hoops.
> >
> > I do not have a serial console, and all my filesystems are NILFS2,
> >
> > so I do not currently have an easy means to capture the crash.
> >
> > However, I experienced the same Kernel BUG on upgrading to kernel 5.11
> >
> > from 5.10. Reverting back to 5.10 results in a clean boot.
> >
> > The actual kernels I use are the Ubuntu 'mainline kernels'
> >
> > 5.3.10-050310-generic works
> >
> > 5.3.11-050311-generic crashes with Kernel BUG.
> >
> > So I suspect a change between those two versions has triggered the prob=
lem.
> >
> >
