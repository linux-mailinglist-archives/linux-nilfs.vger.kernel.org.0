Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29A45B1922
	for <lists+linux-nilfs@lfdr.de>; Thu,  8 Sep 2022 11:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIHJqU (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 8 Sep 2022 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIHJqU (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Thu, 8 Sep 2022 05:46:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C07EDFF5D
        for <linux-nilfs@vger.kernel.org>; Thu,  8 Sep 2022 02:46:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b16so23496702edd.4
        for <linux-nilfs@vger.kernel.org>; Thu, 08 Sep 2022 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=93ghi4l8pMNtxXocmybwcVFaw2Qy/YsSmcGD+5j2BJM=;
        b=ebi6qzu0yv56u73+nYxDbeOWW8gjKgi0uhgDj6qHPU2mS9u2suPWoxUWo8hYoV+eGH
         7HwCJDumKJlmHLOXKFUzELFNTtG1ZGZubP09GDGfRxlhNvXZskMYYtgvlq1orKG3GwFi
         pOkzBse50HxE/547lyAqNVY3nYuRnreqTjOH1lp36bTo/9XxbU4s8jO1jmI8+RwprQfV
         n2Z3e7dk69+VHekN0Q1+5Xsv4l99ZuoVPZCT248AA6VSmeSzlfLfkdgH8VoekhULjFP5
         IYRWFl5r7d9ZN+IifpFcOE0MwVA4khQWmGYX4f2qmRMMkvUNpmuZnwgipCzCWbYv1vZh
         rRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=93ghi4l8pMNtxXocmybwcVFaw2Qy/YsSmcGD+5j2BJM=;
        b=Npy9Z5p21YSWUDPl79l/cQmK6Kewx0s39uNjH4tVngGZHUWz2CNVX2TXJlLo3FVxuU
         dMwtC+tlOQhdxlTdn+Y8u4c/lDpbD2f1WA2Wjy4yl4xm01Z81g4Cl5JqVeGXJiddQxOL
         G+fxPCJKWedpsx9r3zBGIRLBSGC2uPFo57zN/osxX7rL8StTGBjVLJe7on1NX3hrV8Jk
         Dl6yB2ulhDqw1aVdN1hFzAGlRA76WkUX0ZPkHEGRA/qkcx9ejrQzczb7z1+ofAT6DjGZ
         6CKEGkE1u/aw4ig3BITRHssRcAqcb9q0gYwsN5+48J+mg/F50ug+uVrLPu9U2xQMspMf
         v5+Q==
X-Gm-Message-State: ACgBeo33n3IvPvEKHoTbydRQ27p+HZ+AgC4Hl/oanAD7eHqQfgbrcNYY
        UUobPPCCIosJGI35F4wrv1mKNlMwSINbu8IUhsc=
X-Google-Smtp-Source: AA6agR6GoUVszKWq+K2eMlCGBRmXO/cIVRiodZSymPRPVby1p1t6E8k0U6/YTswH925yisUDcfsILDGH4pJ5e6GrX/8=
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id
 p8-20020a056402500800b00440941a93c3mr6381254eda.47.1662630377846; Thu, 08 Sep
 2022 02:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:3a18:b0:741:3e2d:f59e with HTTP; Thu, 8 Sep 2022
 02:46:16 -0700 (PDT)
Reply-To: Dietmarhoppdonation86@aol.com
From:   Dietmar Hopp <attamafidelis9@gmail.com>
Date:   Thu, 8 Sep 2022 02:46:16 -0700
Message-ID: <CAL3rR9kwVP+e2-2Tox-qbUnakZ9+qVNP1JDEJjCUSCSx3hLdLA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:529 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5116]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dietmarhoppdonation86[at]aol.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [attamafidelis9[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [attamafidelis9[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

--=20
Gr=C3=BC=C3=9Fe, herzlichen Gl=C3=BCckwunsch, Sie wurden soeben angenommen,=
 eine
Spende von 1.200.000,00 Euro zu erhalten, f=C3=BCr weitere Informationen
antworten Sie bitte zur=C3=BCck
