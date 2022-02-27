Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB94C5F3C
	for <lists+linux-nilfs@lfdr.de>; Sun, 27 Feb 2022 22:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiB0V4a (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 27 Feb 2022 16:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiB0V43 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 27 Feb 2022 16:56:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111166E4D5
        for <linux-nilfs@vger.kernel.org>; Sun, 27 Feb 2022 13:55:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s13so12597633wrb.6
        for <linux-nilfs@vger.kernel.org>; Sun, 27 Feb 2022 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=bjlGuub+IuYbM5VbMwzwikwhgii3WM+pPSrDV10hnDWHxjHBzW/HoRzF75V4FkUlrV
         n/egZy0FECXorU1cNqc4dpeG5c9dKTzoKlyoeZj7x/Ljd0oF1bTXGMSXilz62lD5HcFy
         gPG5f5SaPYc8RtX5C68dV44HE0KYbUnFQxqpeLUeJ94GZlqpkhF6v/Nlt5GKdNaxg7aH
         oyrtrIKWTShB3rZZm8mOeNzdhfZlloUlbh0/hKz1ajBfmLgmkAA+5EdHr3QSSpHNPrtC
         ZUFJT2CLschbfQpn0Bmyfx/WIiqCoUJ4Bh1Hn6kTEz7euTuSKu+CW9AfZ4ZG1ndbx8hP
         kPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=0qXEG4fc14rl+VYqy1AdI9MtFp6TdmTpxrbt6egUvoH2EH1PArLnZpKVhGWVVYkupt
         ef/BUBNjVWsMEKh5OiJyYQ2N34tiAoLDlj/ksbkvLpmQep9nEdLqjn6zfHsbqp/F9Vb0
         2e5b6YkAjkxZWC6G/PHtMDbBU1om01Lyh0xNSkHxCRjM0yI1GKJZD36GEC75SPiWMV29
         W5a2C5EZ8IsaHN6ZjPSgsLc6IlGOcdnkfsOm/e/wwyEuK7DevzKcLX8oVS3qVSaTvmxB
         Vtx6Ja+sr6rvXJm+434Lam750ZnkFSpjv1nPX8e60ij6UdXbKL6MJMpMKfCbZSJMee1G
         p2zA==
X-Gm-Message-State: AOAM533Yu7DjMh/LfRa/He8/QcgxVzz6rPSQMxD4wgS4wegw44dCIZI+
        JbT2ttllntPb3xi+gCeLOkg=
X-Google-Smtp-Source: ABdhPJwfcrHUTmra8dBMLOSxGftNkRSRjMXRtEvC7aABHS+tGwtLczTI+wqcsJJA7hAuJL73jfI/7g==
X-Received: by 2002:adf:a58a:0:b0:1ef:603f:fb58 with SMTP id g10-20020adfa58a000000b001ef603ffb58mr10144192wrc.472.1645998950690;
        Sun, 27 Feb 2022 13:55:50 -0800 (PST)
Received: from [192.168.0.133] ([5.193.9.142])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0037e9868e364sm13244215wmq.33.2022.02.27.13.55.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 27 Feb 2022 13:55:50 -0800 (PST)
Message-ID: <621bf366.1c69fb81.14b70.c0e1@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <dr5mike77@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Mon, 28 Feb 2022 01:55:42 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com
