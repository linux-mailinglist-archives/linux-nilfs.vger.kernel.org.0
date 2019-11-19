Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4010288C
	for <lists+linux-nilfs@lfdr.de>; Tue, 19 Nov 2019 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfKSPrD (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 19 Nov 2019 10:47:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39913 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbfKSPrC (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 19 Nov 2019 10:47:02 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so19351337oif.6
        for <linux-nilfs@vger.kernel.org>; Tue, 19 Nov 2019 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mvfmrMILpK+f/dD1M08MFnN5BxhblSO344ylAMvdgpQ=;
        b=Eo3TDn23QibZMhhtvHWkT8FEXy7Fv0byYcuNaKNnNg1UcHK2PoC40nUOqqb5pwU47m
         iuAYGdJx7yBLIIIhJUo1KHLmiS5C8Cu3jK9PtAZtKm0xFFy45N2P4z/ypQRf2OWfHjG5
         w2/pN4QksOctSRhS+thdjMGJaHp2LZ+d1Z61+uSRkR/K3W5fVENjKLXaNoNwTbmc+hHg
         W5ucaiDUO3YPoyiv9J8+oIFnQkpUDBkT16RBAKRXCi3CuAfACA+kMM55ci3Kt9c10wZs
         YbrQNYlMLmP8uWpG0cyUiUH7RsLsQ8xEScI8gPjdnDliLQqDFAXEBxo7r37SFe7sh+As
         z8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mvfmrMILpK+f/dD1M08MFnN5BxhblSO344ylAMvdgpQ=;
        b=rs/29IHcRhylsXQFq1PfXjSxI5XeGi++N1z4qhb/B2pvqjxl/EpMyu6ufvtVuNDKQS
         TdRzPQ4BHD4KUbdoogxUih61Gs0+Ivv8YE5CsvV9dO8x/o2SXDphsblBbFQ2rthc/zql
         Ft9zYT2JzZlphHgnXbUTGO4Stxx20hVbioTO94KDbXLq1Bodsn2d+6xsAR+J0EIkSquz
         MPBxKxQbElpk6WQBZM0BGPCbNFUD39lGYFAh0vfBbkvnw1Erjb9QJDWB3ZajOe+lMvuy
         7KtLSj9JheLmub8EiI1zTZmPBxbS09Zdxtl8DKS9Jo1lHkQJWwAbCz34LmVHQWAf0joK
         RXsQ==
X-Gm-Message-State: APjAAAVSWl/h/3d8irLH0MqOloDOMtf9zVNxssYFWD+84knZywW8fx5f
        v5WMtlXtLPe2VNUofF+SUSJmBB/C3d+R2NkAi4s=
X-Google-Smtp-Source: APXvYqzHpqTVJeZDN+sFd+mKaGQU+/XaJ9l0HNQVJ+Xz58UaFlqdR/ti/Q2ehhZjQGLboqM76/aemDKssUuhaoFf+7A=
X-Received: by 2002:a54:4105:: with SMTP id l5mr4697418oic.135.1574178421160;
 Tue, 19 Nov 2019 07:47:01 -0800 (PST)
MIME-Version: 1.0
References: <70b53768-11db-dd75-38c9-5d1786ae88e9@daneng.org>
In-Reply-To: <70b53768-11db-dd75-38c9-5d1786ae88e9@daneng.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 20 Nov 2019 00:46:49 +0900
Message-ID: <CAKFNMoks2DGE=BeEXR60DTXSXWbsfPogGReD8EjV=YqyMjTMjA@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00000000000000a8
To:     linux-nilfs-ml.via.forwarder@neverbox.com
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Yeah,  this looks a regression of the 5.3.11 stable kernel.

I could reproduce the crash with 5.3.11.

5.3, 5.3.10 and 5.4-rc8 all worked fine.

The regression would be identified by bisecting commits
between kernel 5.3.10 and 5.3.11.

Thanks,
Ryusuke Konishi

2019=E5=B9=B411=E6=9C=8819=E6=97=A5(=E7=81=AB) 23:40 <linux-nilfs-ml.via.fo=
rwarder@neverbox.com>:
>
> I believe I have the same issue as Walton Hoops.
>
> I do not have a serial console, and all my filesystems are NILFS2,
>
> so I do not currently have an easy means to capture the crash.
>
> However, I experienced the same Kernel BUG on upgrading to kernel 5.11
>
> from 5.10. Reverting back to 5.10 results in a clean boot.
>
> The actual kernels I use are the Ubuntu 'mainline kernels'
>
> 5.3.10-050310-generic works
>
> 5.3.11-050311-generic crashes with Kernel BUG.
>
> So I suspect a change between those two versions has triggered the proble=
m.
>
>
