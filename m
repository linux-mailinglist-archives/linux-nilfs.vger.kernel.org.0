Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED265D36F
	for <lists+linux-nilfs@lfdr.de>; Wed,  4 Jan 2023 13:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbjADMzo (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 4 Jan 2023 07:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbjADMz0 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Wed, 4 Jan 2023 07:55:26 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4C37398
        for <linux-nilfs@vger.kernel.org>; Wed,  4 Jan 2023 04:54:54 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f28so16205609qkh.10
        for <linux-nilfs@vger.kernel.org>; Wed, 04 Jan 2023 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=BQfo1+41q2NZR57Q7BFlMODaOza2AgrRvUpAp3daCd4t1w84OEhFtXAM1g7CkVTr/y
         mvXWkJvXCDM96Iy3cSf9E37Th3uZX5TzmwlIsHFzK3DAyLuSjJ8d3uR9drr/ahkzPGkt
         iW+sw+gZOJCd7bumtfoM4UR2xOfXz6tdmGq2f+IJJhoSBazdofAm5Gs9PxuweXnk264c
         knSGf1CtrqZScdeov1GoaGbl2sApMUXYjJGPCObPVA0UTlHx2t6+wdp4VOKHmsqLWM8X
         lQt15zqigA6uJCG+q37n0r4mLK1MKtsniT1i9jhRA9qlN9E2Mf0sYN4W9Jd0n+39BoCK
         yzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=kSysAbDrEpeUwiIRGoT57Bn2zG1WftnZYn5g3IK5M6qiTqM3MdGPhZKIDi/IaVo9WG
         eZalDx8pom/I9HQXVw5iErmVnnFUcTlDXqpsGWXXvIyxqFyiHUWXtuXDQ54L5469rNfr
         RUY2OzJAIlDo8LFmJLe/XmrOCNHSYv5QnUyIZaOkP+cftdZK4YG3F0LIZS24QuLRfyyt
         f/Lfzs/2ku7iftSoazwGMObqU2QdPqV83dQACgyW53i3ur8PeaMSZ23e5kywHIdUTkbi
         tK+d3vrCPzY24tPHAKYpWcoTvpAWFlrwdlCE1oSR1OocD3pQj7a9kyLDdzz5JeqEViZR
         cm7A==
X-Gm-Message-State: AFqh2kpyxvBMaqjYY6XyjyJMAfcgtJ3n2inCoS0BqFuMNeo/FqQwOEFB
        HOut6TFtQ6otIAowMypaCdEjaHEqw6WOFxiAZZSWwe8usRs=
X-Google-Smtp-Source: AMrXdXuKXTvNK0aSB9vnyjtdhrZfKmRzvU9Jw1W0zhcD7x19AMFVNgTh5oL+8ilZBOfTDf/bL64QVz1mYULxa/ftADs=
X-Received: by 2002:ac8:568a:0:b0:3a9:688d:fad2 with SMTP id
 h10-20020ac8568a000000b003a9688dfad2mr1976067qta.646.1672836882017; Wed, 04
 Jan 2023 04:54:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6200:5d91:b0:4a5:78e9:2012 with HTTP; Wed, 4 Jan 2023
 04:54:41 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <mzsophie@gmail.com>
Date:   Wed, 4 Jan 2023 12:54:41 +0000
Message-ID: <CAEoj5=ZpJ15GRz-U33Ocbu5-P3Va+3bNv3476+mmJJ52cwx7tA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Seasons Greetings!

This will remind you again that I have not yet received your reply to
my last message to you.
