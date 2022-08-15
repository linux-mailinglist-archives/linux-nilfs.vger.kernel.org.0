Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB359304C
	for <lists+linux-nilfs@lfdr.de>; Mon, 15 Aug 2022 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiHONye (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 15 Aug 2022 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHONyd (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 15 Aug 2022 09:54:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4221824
        for <linux-nilfs@vger.kernel.org>; Mon, 15 Aug 2022 06:54:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c28so6680407lfh.3
        for <linux-nilfs@vger.kernel.org>; Mon, 15 Aug 2022 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=86Hytperb3E14EJa5HiVkGPyx/1oPSgRX5LsRpbwPDs=;
        b=IIAM/+vlwipei5CDmjCVcQsUoSF1bpzVXM/f84xCDhUylP+1vHQ4aI98LSLhvgZYjD
         eGSxhaBUUdI43CXcenwmjFGmAnbKiWverCYgRjfMw3JKyvf5DJvxLqqzcFkHG/0ZiU8H
         A3pejU8G0E0Xs71BLA8w8dvoB0vTYbMBEy8AOAp0eU/6vUxFwS5N17KmX0cbYRa6T1dJ
         ellsod+xWpwk+bLoDG96N0+3cO3Iam3//o8FNWqbU/q9aC9tBvdLXvF4IBZ+CPY4go/3
         ph+v5hWbaLmiiFnNW+eXZ+XxVn3nsMxcO4XEWot+2/pRNBVbpaTD3o0hCqhAMPCbrgoG
         Jvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=86Hytperb3E14EJa5HiVkGPyx/1oPSgRX5LsRpbwPDs=;
        b=pFb/pozAfc/2ATjIveJwOHzA1JrwTuILMBeQ4sN+PwbQfU6cXGzsdaIo+3vwvTGyvR
         Yc9qgXiN8lN9IyAIP0HkAPDf3aAtL8up3G/2GlNjcyMcyP84CggLHK59gQYLPf3afGo9
         d3J8uwO2q17Xdc47t8uOxb5AnOb33iXZ6PnEsI9PHGZ1hDbdjZ4c1gft2eKFVp2OTXnm
         B/NZ5zgss8GVdg88yCa4p+7t7AVGojrKWABZvEb8NpvkQeVFl/daYbHjF4HVsNFMyW9D
         bdYsnFbX16hfuh8Nm5ansRH8f5bw1opqZt9lGewFtVsgmpmU44itcYZd8QLqfztE1WYa
         T/bQ==
X-Gm-Message-State: ACgBeo13MlORkpduMm3OwfGdguX6fTgL+ZB26sN7GUk5NRkvkUpXLHf5
        irF9K7yiRCQI+19YvMAOg8T8rpjzJ0LQogiUimk=
X-Google-Smtp-Source: AA6agR7tg8wZ0a98VU3JkW4/nNXGi3Pb2rSaHc6tgGjpcQtRn7beS1lz69xfLM1ioJbwmyhxP9HzGkuDNCkkeA0HMS8=
X-Received: by 2002:ac2:52a5:0:b0:48b:2905:21ed with SMTP id
 r5-20020ac252a5000000b0048b290521edmr5206046lfm.120.1660571669762; Mon, 15
 Aug 2022 06:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <34e8df4a.848e1.182a1264256.Coremail.stitch@zju.edu.cn> <Yvovz7FKlHLNpNaf@kroah.com>
In-Reply-To: <Yvovz7FKlHLNpNaf@kroah.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 15 Aug 2022 22:54:12 +0900
Message-ID: <CAKFNMonPnmC+q3JUyNtL0dkMtTv2EOD4fy45SKfBoQo_J_-ySA@mail.gmail.com>
Subject: Re: [vs] KASAN: use-after-free in nilfs_mdt_destroy
To:     =?UTF-8?B?6K645ZiJ6K+a?= <stitch@zju.edu.cn>
Cc:     Greg KH <gregkh@linuxfoundation.org>, viro@zeniv.linux.org.uk,
        security@kernel.org, linux-distros@vs.openwall.org,
        syzkaller@googlegroups.com, linux-nilfs@vger.kernel.org
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

Hi,

> And again, as this is public, why notify us and not just work to solve
> this in public with the developers involved?
>
> thanks,

Thank you for reporting.

This looks like a nilfs2 specific bug rather than a vfs problem.
I'd like to send a patch that fixes this on the nilfs2 side.

Thanks,
Ryusuke Konishi

On Mon, Aug 15, 2022 at 8:36 PM Greg KH wrote:
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
> thanks,
>
> greg k-h
