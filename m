Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B375FD408
	for <lists+linux-nilfs@lfdr.de>; Thu, 13 Oct 2022 07:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJMFDN (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 13 Oct 2022 01:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJMFDM (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 13 Oct 2022 01:03:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516F10451E
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Oct 2022 22:03:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a26so1480008ejc.4
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Oct 2022 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PfYWSirR67BTrJN7fdQGoiM+rqlbDrrqo9mIGM6FvQ=;
        b=YqeRHJ0jO+UYTeBDnhpWMQjvffmyWnTt8QNzqjnG6t37CY/9Uh2bhtzsZmKOLk7FZO
         tFFHs/czme1MO6OZSrNDN6h0F6vP9sXw61I97ljX4Ji8nF8duj2yR7QWRhGV/021LPtw
         cpsLMyezmnZBbczLdIhVW1/WizhMePYO+WKKW5NfjvmvpHn5avW4fRKUgwTRUw6fWY2Y
         FayIuhn1PmiW5/RFRkn2qQlHWY3qoduBMy6Tb5t9Nr9HoJGeyMYwQ02T1b53Svs4h1rK
         qJLtR/GtOkot0o5e0Em3O2PflXbWhjlcYKoiTv2wOnWpMKpoYLg+ac1FWsb9sglsB7JR
         Fpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PfYWSirR67BTrJN7fdQGoiM+rqlbDrrqo9mIGM6FvQ=;
        b=PJA2Zl0L+s3Hdx5IVxzy+z6rlXYuEKrIb7y2Z1A970p26eWaaogT5bUfczGuUPT+mO
         HPsS2rRRZwDhOOXgl2QQlTVuHQbCjZsOmjaaSpOm2OvX8RbDOXduAYDH2n8TxEo4KGdT
         dgyGst4dYphvzn+7sgdRth90vrE8REedVrPRPCDnzsQUNdAYpZkpaaj1oSQfwUzPsRfQ
         Ay9LpR58cYCDBecm+qyjdrOZe2quiuwQN9dvf9wWrhMAqHRsqzqG2Fr+kN+aACFWN7h2
         +0CiMCcVeK318m5cniUpI+4TAIV2hVFVPeJK2MOOzHuSwQh3ixr6r+qfAE7UGdwMr+P5
         m9OQ==
X-Gm-Message-State: ACrzQf0Viwa9WJWvQ6nogyFBv0MGuHXtxTTr+Iy4PloE+SU/NOvqG5xk
        fqfoX10N/qZC4YLJh5ngjR9LlardPOzDqwbzpG+uNuJ2
X-Google-Smtp-Source: AMsMyM4B0FeBvaBpBgEEWnyKsz8s2ZXpzGPNeCCeijTdQhlQQXvYTgMbYX3kZuubJvPWrpYhME3KfPRtp+vIjT8rMKA=
X-Received: by 2002:a17:907:2712:b0:78d:a223:729b with SMTP id
 w18-20020a170907271200b0078da223729bmr17419574ejk.443.1665637389962; Wed, 12
 Oct 2022 22:03:09 -0700 (PDT)
Received: from 927538837578 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Oct 2022 22:03:08 -0700
MIME-Version: 1.0
From:   "Linux NILFS <linuxnilfs@gmail.com>" <linuxnilfs@gmail.com>
Reply-To: Linux NILFS <linux-nilfs@vger.kernel.org>
Date:   Wed, 12 Oct 2022 22:03:08 -0700
Message-ID: <CAE7Udf9Wv-GHRUJ1ukGMreanpmEtm0hVVHy8GhOqWz6eX7xP7g@mail.gmail.com>
Subject: Published nilfs2-kmod8.
To:     linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Published nilfs2-kmod8, a standalone kernel module for RHEL 8 clones.
At the moment, it's only available with the latest versions of
AlmaLinux 8, Rocky Linux 8 and CentOS Stream 8.

For details, please see the repository,

ChangeLog file, or commit logs.

from https://nilfs.sourceforge.io/en/index.html#n134
