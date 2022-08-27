Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4558C5A3598
	for <lists+linux-nilfs@lfdr.de>; Sat, 27 Aug 2022 09:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiH0HaA (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 27 Aug 2022 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiH0H37 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 27 Aug 2022 03:29:59 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0690546DA2
        for <linux-nilfs@vger.kernel.org>; Sat, 27 Aug 2022 00:29:58 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id x12so1318905uaf.0
        for <linux-nilfs@vger.kernel.org>; Sat, 27 Aug 2022 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=41kW5fOWjdzzcQ6HaiOHsjJFnjWCo4jg2HDR0g9ZrRI=;
        b=hL2uH7mv80FXMcIBGMBne3Obb1N8gGai5+Cw70WtC9qZNUlgCAHbRE443uermX06s8
         1a8PdzdxlNWaGHtG6tzEikVEMRkCZbj7zPF3L5VI/pg/Q740Ps+Znip2kOoia9TiQ2m9
         3zv+H/jRYNEgS+ukvVx3aTZ5KoYDawf0YPEawbT2gfHbctj05KgVPTiZknuJUbCk132y
         XGFLh3IRv5uEook0dz8Bje5/+6vUu3MAExvkXpVMhBK1QRDowaahUI6wvpWliUq32LI/
         +AmI//+kZuGKrfpduk9OgOvQTtNDU4+Fpsv2XwJFTFgJkYCGPT8HQudqrCCFCZkoGkDB
         SPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=41kW5fOWjdzzcQ6HaiOHsjJFnjWCo4jg2HDR0g9ZrRI=;
        b=fyO1I9qYLZGaty5qcB1ddLlkb+bPnLPFVHUg1AVjVOKvxSAjMnft/nMVdoO3YrV3dr
         +FbClFfSIUs9lQKbL3lbByhTQh0u/mSExNNpjqRlpekY5g33AD8I9jKbtXEPPpY/GNdB
         XhnFdau2INxOVSABADj1mhOZA/4Xx0PBUegm1SydVhRLaEddNlBYXILyXy/ocrnE/uGD
         lJh3KGpA45xNYOGlx6fqqj0lb95ujQQj85ZuKzW9S7ypWNEWtNJMV+XfDWfnRNJZRmAN
         IftgPJZRqf7JST6+J/u3KBrCfCH6S2i1zrscWD+PGANmo22xrshzHkEKwk/9AkRXBJ8t
         gb7w==
X-Gm-Message-State: ACgBeo3mkos5R2FWUSeCEnKhKve7GfVvChO+P+gebBS/l1u6F+aSDDyu
        g8c2PqMRoZGiyN7ZdRhwK0cbE7PINPEyWibemle607cwHMXYVA==
X-Google-Smtp-Source: AA6agR4dxUQOKcoeKrAMJn1hWv+u9PpRrlsNqTB/UXeHCyGKU2Hr5l4RWCGb1TR2nYfdakCN3LBVidBgVLteDHCJK4Q=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr2732113otv.26.1661584951054; Sat, 27
 Aug 2022 00:22:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6850:604c:b0:32a:7951:35f0 with HTTP; Sat, 27 Aug 2022
 00:22:30 -0700 (PDT)
Reply-To: abdwabbom447@gmail.com
From:   Maddah Hussain <klimowiczd0@gmail.com>
Date:   Sat, 27 Aug 2022 00:22:30 -0700
Message-ID: <CA+ARbHTGmWKjeivSgq9ofEgKefx=wtjE-W9aaTgHU=faR+L4dQ@mail.gmail.com>
Subject: Get Back to me(URGENT)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:92b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abdwabbom447[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [klimowiczd0[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [klimowiczd0[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 SCC_BODY_URI_ONLY No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.
Maddah Hussain
