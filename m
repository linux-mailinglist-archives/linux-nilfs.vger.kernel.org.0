Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C140E551642
	for <lists+linux-nilfs@lfdr.de>; Mon, 20 Jun 2022 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiFTKv7 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 20 Jun 2022 06:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiFTKv6 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 20 Jun 2022 06:51:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E51180E
        for <linux-nilfs@vger.kernel.org>; Mon, 20 Jun 2022 03:51:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v81so18306051ybe.0
        for <linux-nilfs@vger.kernel.org>; Mon, 20 Jun 2022 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:reply-to:date:message-id:subject:to;
        bh=neTy1KoU2EoT9SsnwpAqaw46wNGviqYunr6QUZlJLWk=;
        b=SkxkGp5e6Mghmg0MQFCuQ5DZX/8C17aYnJbZiQx3lHt2GTEmuOs6QEDv6O7Y6oT7Vu
         Ve9q+28C2fr/Ep+5BiboovlhumjqF5yXTuL6w21/63IEzj7r+SMLxpghA0Ol88cpa5zY
         U17sHouRpNhG7wsOn30ZJxy59s8HrVqpGktgzOLiIssDmto2sOm+AqHg6uEe+elNVrbO
         xUB5KJk39fccNajKaoMmCbCTKOlqP3PKByxVcP9C79AB73G6lS9AJF9AcTY2cWVWH1nW
         ZIG0+PDN0WRI7XnWZjSbw9fykug49Tw450jiXdF2ErHhcFRXZWXfJUJfDVCYcVQhsMTW
         F64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:reply-to:date:message-id
         :subject:to;
        bh=neTy1KoU2EoT9SsnwpAqaw46wNGviqYunr6QUZlJLWk=;
        b=XM3DTK6XK8arGNFKgPCznC3JIGsa/9MlBYqJHR2PuCJ69x7sfR4pLNLCFvtdpoI+9k
         sK8uDLOkQErZwcmX/PX4shF8wm6DM9LC/BXP4dMmDKXjBu7KK6lMuWIoiCeEObPucCrK
         /z+xu/FcVC4SLN+N3YDLOpFbdY28RkLkIVXQTLCLhHsMFITeaj9G36TFOFMCmgnXQFUr
         yQEKppJMBLPNbn0x+uLeWB7j6A/R8ydax73XCpJuIoX1YQnVmBrNyi7gsMyMB+8/pvyj
         aPm3cF3pWpPdp368KLaeHCINv9zRGTXuMGs91udmmCYMpKYJMwIihmx1F29BdWIS8XO8
         Rfug==
X-Gm-Message-State: AJIora8HuUlrJM8GJm07IyBBUwWLXX+5treXUtAIn5xL73X7T0ni1fwi
        J6VSLkWNr6PKLj7qTtxamANeLk3mTzyeI1DQagKexP+d
X-Google-Smtp-Source: AGRyM1s2w2wjIkEwcyXsmNmnhs9b5sQk82GFBAsDy2+roBqff/92fJxDLXN/CBhQ/qGSlENVt5XOmf/KOcBV/INi5NE=
X-Received: by 2002:a25:b00b:0:b0:664:2460:e244 with SMTP id
 q11-20020a25b00b000000b006642460e244mr23983701ybf.19.1655722316812; Mon, 20
 Jun 2022 03:51:56 -0700 (PDT)
Received: from 927538837578 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jun 2022 03:51:56 -0700
MIME-Version: 1.0
From:   "Linux NILFS <linuxnilfs@gmail.com>" <linuxnilfs@gmail.com>
Reply-To: Linux NILFS <linux-nilfs@vger.kernel.org>
Date:   Mon, 20 Jun 2022 03:51:56 -0700
Message-ID: <CAE7Udf-QiGubgqimNeqKHTT5zXNHKJx0tYor9b9XRpZzUgh_fA@mail.gmail.com>
Subject: NILFS utils 2.2.9 was released
To:     linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

A maintenance release that includes fixes for build issues in recent
environments

from https://nilfs.sourceforge.io/en/download.html#2.2.9-u
