Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C757E1737
	for <lists+linux-nilfs@lfdr.de>; Sun,  5 Nov 2023 23:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjKEWAp (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 5 Nov 2023 17:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKEWAm (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sun, 5 Nov 2023 17:00:42 -0500
X-Greylist: delayed 5206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:00:39 PST
Received: from SMTP-HCRC-200.brggroup.vn (mail.hcrc.vn [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD7FA
        for <linux-nilfs@vger.kernel.org>; Sun,  5 Nov 2023 14:00:39 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 4E44D19804;
        Mon,  6 Nov 2023 01:58:14 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 473A2197E2;
        Mon,  6 Nov 2023 01:58:14 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id D497A1B8254D;
        Mon,  6 Nov 2023 01:58:15 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id e0jygQuMQv1w; Mon,  6 Nov 2023 01:58:15 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 9D6AB1B8254A;
        Mon,  6 Nov 2023 01:58:15 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 9D6AB1B8254A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210695;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=pLRfGjm8NJTj8at+9nadRGTBzMWlU7En+d14Gtckj9XS7cy+6WqeaBcTtFsrh/S/8
         iPxwVC8+IruhngnKx6qZl4yLUG/1SuFKc8I6e1fDwDzpN5WX5ZvvYX/d0JaG/HmcBm
         SgYnhbbZoqscJ2aA//SE939u8T0tnhctEQAhEgdxvk61Pwal8DivUR6Whjg8DiKbZN
         9dINjd0rVt3enZAGzz7j2N3p4489QPfWFiZ0U1tJx5Fnxx2qvhDMgWR5qTxzDQPWNi
         3ucvpdI5P3NjyQyFPRvMS8CGCqgo44DAw6N94ld5Xqh7L0XbWWAqqjz0IQF8Pom23m
         z/IJiT5phnHTA==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H8RlEriALc5V; Mon,  6 Nov 2023 01:58:15 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 4A5A61B8223A;
        Mon,  6 Nov 2023 01:58:09 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:58 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185809.4A5A61B8223A@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

