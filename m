Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75E1712B15
	for <lists+linux-nilfs@lfdr.de>; Fri, 26 May 2023 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjEZQxA (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 26 May 2023 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEZQw7 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 26 May 2023 12:52:59 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A146194
        for <linux-nilfs@vger.kernel.org>; Fri, 26 May 2023 09:52:57 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4394217a8cbso277035137.1
        for <linux-nilfs@vger.kernel.org>; Fri, 26 May 2023 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685119976; x=1687711976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzVX/dRsBr5sMa8u/NKVlw4EJ4PLR20vgYyRYRJxLiY=;
        b=q4MBFpATEPmly2PzO/jnwWBqvdtvMH0m3x4+NPSh0Te+PcGcswVLwChsupBVDJx6Ee
         HsIiVoLhpfb7CjSc23aobzZ1p5G0TR62JLokUv0bTuGUhFfjaClwpYv3MBhSPYWTmVw9
         9GKpnjmwxeUvTD2spTjR9c+CeYd0dwiUixy4NCC73EDl3mXjFBZ8WBGrf0lGWlxolO3U
         PhAXNzs/6Xa/FA2Ou1RRfsQSLm3TxNnPKhIJIDzhAclDdwFDr6cEJB9XMHrS4d+8IrFP
         Hq3WDy2dSRf2Z73yY5A7X6uVGbEKq9ttJnpCVMrdqnOSplk/w2j7RSsqBMmFoCQ8Qp/1
         kJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119976; x=1687711976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzVX/dRsBr5sMa8u/NKVlw4EJ4PLR20vgYyRYRJxLiY=;
        b=f0Zs3w86D/W6oXbJ0oypSa8PFFuM1rxTP0+npIaBph2nv0/oouzCKrDaOiVGGJhtkD
         pLeNeTDU8zxbD/UGiinllpzsaEA/xQiMLsQ7279ps5pqI5VqSq5KEWCtaG21JflvtBGS
         TE7U/vKVu7X36Ti7yX6PzZYeguQCjo+2KqCTVOnyeUGqA0E/xA6Hvt/k8wWxSo7cIEyG
         ac0wG6bCfdNqZGmwGOvjX10QdDz7cvBo57UeqtVEYTnKFe2b1DAwul/+vQITMZGKQEek
         mSAzAEBcArxOYVKnFZCumiKPIBk7pTiB1nU6zqnUnp3vS6fGcBB+XcGsbqLBSBE3JXFZ
         FE3A==
X-Gm-Message-State: AC+VfDz1PpS5JLV64OR7h5lBTHOqXO+Sj/YP4+yQ4JEArf3eVkhRA8JI
        Xl8ln9+F0+tFJuIE3ZW88SvvL/kye+py+GiN3fvy81qVfd8kMA==
X-Google-Smtp-Source: ACHHUZ5MjhEwzrklnUkfQzJ7lcj5mvbT8rMjxVSFS+1bsHBj5wvn9f2JJh3x6Wvx7rErKhVO7ClW3rSQdE/CanD+Xrg=
X-Received: by 2002:a67:e2c7:0:b0:439:558f:4cd2 with SMTP id
 i7-20020a67e2c7000000b00439558f4cd2mr727756vsm.11.1685119976363; Fri, 26 May
 2023 09:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230525151838.GA5174@debian64>
In-Reply-To: <20230525151838.GA5174@debian64>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 27 May 2023 01:52:39 +0900
Message-ID: <CAKFNMok+C43Y1jCzyP-iUXB3rV_X60aui7J4aaa1rK6-ZtCcnw@mail.gmail.com>
Subject: Re: Is it possible to restore the state of a nilfs2 partition after
 deleting files?
To:     Frank Schwidom <schwidom@gmx.net>
Cc:     linux-nilfs@vger.kernel.org
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

On Fri, May 26, 2023 at 12:37=E2=80=AFAM Frank Schwidom wrote:
>
> Hi,
>
> is it anyhow possible to set the state of a nilfs2 partition to the lates=
t
> checkpoint or snapshot?

Unfortunately there is no special command to do that easily.

Instead, since NILFS can mount the current tree at the same time as
the snapshot, it is common to mount them on two directories at the
same time and write back part or all of the snapshot to the current
tree using rsync or so.

If you're expecting native filesystem functionality, sorry for the
inconvenience, but the answer is no.

Regards,
Ryusuke Konishi

>
> (I am using nilfs-tools 2.2.7-1 on
> Linux debian64 5.10.0-0.deb10.16-amd64 #1 SMP Debian 5.10.127-2~bpo10+1 (=
2022-07-28) x86_64 GNU/Linux)
>
> Thanks in advance,
> Frank
