Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217557817E1
	for <lists+linux-nilfs@lfdr.de>; Sat, 19 Aug 2023 09:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbjHSHDz (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 19 Aug 2023 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343980AbjHSHDW (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 19 Aug 2023 03:03:22 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164C4487
        for <linux-nilfs@vger.kernel.org>; Sat, 19 Aug 2023 00:03:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 5614622812f47-3a6f3ef3155so1179362b6e.1
        for <linux-nilfs@vger.kernel.org>; Sat, 19 Aug 2023 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692428597; x=1693033397;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9kydyMnwD//o0quRqImkimRYfrWW9k+FT8t/oHoxyE8=;
        b=nLON0lFU1HFxhxnwtvUZc9wvmWS7rbdnt2RdpqIoCtsDwWwHx0Gyjn1xZGSC5eb2FC
         WmmpNW+ObIBj4H3oVA528E09LKJ9Oh4DAMKSu6pEL6PL1RhqFN61P9gLSK/8SD4vx9bP
         JUWK2MGIfhLYg/xJvX06ahmCeb/lUSvcNrFKmvYLJLEYQO5IwjUSUqLNIk0w8cK+2/XQ
         dSqtK5eCnXC+wrkDAzHrF00pkROWtcttibp6ntDQXOVUlo6vsHjNyWdY7UHT1JYeF2xL
         PB0ef0uQvzc5mw6gaoXP2KOWKvpRua/iGaOI4B4VGugPnWVRf5iIcCLUY0NkKk3Xl8rO
         5wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692428597; x=1693033397;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kydyMnwD//o0quRqImkimRYfrWW9k+FT8t/oHoxyE8=;
        b=Nnuk2az/sBuE8URW1fZqhqD8GlX3ZCHCwwR857myv51+w5drIF2AGyogXPHMJyaOxh
         oCLXOSAyPbCijkQCl2vAEgnH12fvyydVv8vn/d9nRSP5k1WhYYrJk5p4VygPK6gaw/IJ
         UHEp68TJleHf6AxdSiuZu8mbejvMecabtdQP/7b7oW+0rPCyMXfOjjMFXsZ+usz8lDS5
         O4wjWdOEXqNKp6McPoZVK6JIKges/49RMmkDo6ycVLmyJpd2XP067vmsEQCJiVn+zOpn
         iRp9tMGeXTJM/FChVSvPCzFOCsgh+ISIigH8ZeEopChSjhRN8Bz5qUdRIq52Cr/3ne80
         rSGw==
X-Gm-Message-State: AOJu0YyFAOxuspU3B6ElPma5SQt4k25c2BOQb1CBi5SKl8iGYOqUoJDb
        BkHRFxpU8zM1VahqfQLrYBSNPPmGy6jzONvW7OM134OchRde6g==
X-Google-Smtp-Source: AGHT+IHBFHux9W7amy752XAKQ4G+pXj9K8KLABgekYkKVjTaNiUovhqWPJjy5q7mdLIzANUAVG24gzrYlmHT6Kjn7Kk=
X-Received: by 2002:a81:8782:0:b0:589:a9fc:ffcd with SMTP id
 x124-20020a818782000000b00589a9fcffcdmr1407212ywf.20.1692428576106; Sat, 19
 Aug 2023 00:02:56 -0700 (PDT)
MIME-Version: 1.0
Reply-To: razumkoykhailo@gmail.com
Sender: mrtombaba@gmail.com
Received: by 2002:a05:7000:5395:b0:4f4:2174:eed4 with HTTP; Sat, 19 Aug 2023
 00:02:55 -0700 (PDT)
From:   "Mr.Razum Khailo" <razumkoykhailo@gmail.com>
Date:   Sat, 19 Aug 2023 00:02:55 -0700
X-Google-Sender-Auth: TD1SbUwALQWUaG93zNo0ky4SaO8
Message-ID: <CADXgghn2t3mU_VvtZDjHwnbadg2QnVcJ30yFd0kN8SL6NDhY1g@mail.gmail.com>
Subject: Greetings from Ukraine,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_USD,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:242 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrtombaba[at]gmail.com]
        *  2.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

R3JlZXRpbmdzwqBmcm9twqBVa3JhaW5lLA0KDQpNci7CoFJhenVta292wqBNeWtoYWlsbyzCoGFu
wqBlbnRyZXByZW5ldXLCoGJ1c2luZXNzbWFuwqBmcm9twqBPZGVzc2ENClVrcmFpbmUuwqBXaXRo
aW7CoGHCoHllYXLCoHBsdXPCoHNvbWXCoG1vbnRoc8Kgbm93LMKgbW9yZcKgdGhhbsKgOC4ywqBt
aWxsaW9uDQpwZW9wbGXCoGFyb3VuZMKgdGhlwqBjaXRpZXPCoG9mwqBtecKgY291bnRyecKgVWty
YWluZcKgaGF2ZcKgYmVlbsKgZXZhY3VhdGVkwqB0bw0KYcKgc2FmZcKgbG9jYXRpb27CoGFuZMKg
b3V0wqBvZsKgdGhlwqBjb3VudHJ5LMKgbW9zdMKgZXNwZWNpYWxsecKgY2hpbGRyZW7CoHdpdGgN
CnRoZWlywqBwYXJlbnRzLMKgbnVyc2luZ8KgbW90aGVyc8KgYW5kwqBwcmVnbmFudMKgd29tZW4s
wqBhbmTCoHRob3NlwqB3aG/CoGhhdmUNCmJlZW7CoHNlcmlvdXNsecKgd291bmRlZMKgYW5kwqBu
ZWVkwqB1cmdlbnTCoG1lZGljYWzCoGF0dGVudGlvbi7CoEnCoHdhc8KgYW1vbmcNCnRob3NlwqB0
aGF0wqB3ZXJlwqBhYmxlwqB0b8KgZXZhY3VhdGXCoHRvwqBvdXLCoG5laWdoYm91cmluZ8KgY291
bnRyaWVzwqBhbmTCoEnigJltDQpub3fCoGluwqB0aGXCoHJlZnVnZWXCoGNhbXDCoG9mwqBUZXLC
oEFwZWzCoEdyb25pbmdlbsKgaW7CoHRoZcKgTmV0aGVybGFuZHMuDQoNCknCoG5lZWTCoGHCoGZv
cmVpZ27CoHBhcnRuZXLCoHRvwqBlbmFibGXCoG1lwqB0b8KgdHJhbnNwb3J0wqBtecKgaW52ZXN0
bWVudA0KY2FwaXRhbMKgYW5kwqB0aGVuwqByZWxvY2F0ZcKgd2l0aMKgbXnCoGZhbWlseSzCoGhv
bmVzdGx5wqBpwqB3aXNowqBJwqB3aWxsDQpkaXNjdXNzwqBtb3JlwqBhbmTCoGdldMKgYWxvbmcu
wqBJwqBuZWVkwqBhwqBwYXJ0bmVywqBiZWNhdXNlwqBtecKgaW52ZXN0bWVudA0KY2FwaXRhbMKg
aXPCoGluwqBtecKgaW50ZXJuYXRpb25hbMKgYWNjb3VudC7CoEnigJltwqBpbnRlcmVzdGVkwqBp
bsKgYnV5aW5nDQpwcm9wZXJ0aWVzLMKgaG91c2VzLMKgYnVpbGRpbmfCoHJlYWzCoGVzdGF0ZXMs
wqBtecKgY2FwaXRhbMKgZm9ywqBpbnZlc3RtZW50DQppc8KgKCQzMMKgTWlsbGlvbsKgVVNEKcKg
LsKgVGhlwqBmaW5hbmNpYWzCoGluc3RpdHV0aW9uc8KgaW7CoG15wqBjb3VudHJ5DQpVa3JhaW5l
wqBhcmXCoGFsbMKgc2hvdMKgZG93bsKgZHVlwqB0b8KgdGhlwqBjcmlzaXPCoG9mwqB0aGlzwqB3
YXLCoG9uwqBVa3JhaW5lDQpzb2lswqBiecKgdGhlwqBSdXNzaWFuwqBmb3JjZXMuwqBNZWFud2hp
bGUswqBpZsKgdGhlcmXCoGlzwqBhbnnCoHByb2ZpdGFibGUNCmludmVzdG1lbnTCoHRoYXTCoHlv
dcKgaGF2ZcKgc2/CoG11Y2jCoGV4cGVyaWVuY2XCoGluwqB5b3VywqBjb3VudHJ5LMKgdGhlbsKg
d2UNCmNhbsKgam9pbsKgdG9nZXRoZXLCoGFzwqBwYXJ0bmVyc8Kgc2luY2XCoEnigJltwqBhwqBm
b3JlaWduZXIuDQoNCknCoGNhbWXCoGFjcm9zc8KgeW91csKgZS1tYWlswqBjb250YWN0wqB0aHJv
dWdowqBwcml2YXRlwqBzZWFyY2jCoHdoaWxlwqBpbsKgbmVlZA0Kb2bCoHlvdXLCoGFzc2lzdGFu
Y2XCoGFuZMKgScKgZGVjaWRlZMKgdG/CoGNvbnRhY3TCoHlvdcKgZGlyZWN0bHnCoHRvwqBhc2vC
oHlvdcKgaWYNCnlvdcKga25vd8KgYW55wqBsdWNyYXRpdmXCoGJ1c2luZXNzwqBpbnZlc3RtZW50
wqBpbsKgeW91csKgY291bnRyecKgacKgY2FuDQppbnZlc3TCoG15wqBtb25lecKgc2luY2XCoG15
wqBjb3VudHJ5wqBVa3JhaW5lwqBzZWN1cml0ecKgYW5kwqBlY29ub21pYw0KaW5kZXBlbmRlbnTC
oGhhc8KgbG9zdMKgdG/CoHRoZcKgZ3JlYXRlc3TCoGxvd2VywqBsZXZlbCzCoGFuZMKgb3VywqBj
dWx0dXJlwqBoYXMNCmxvc3TCoGluY2x1ZGluZ8Kgb3VywqBoYXBwaW5lc3PCoGhhc8KgYmVlbsKg
dGFrZW7CoGF3YXnCoGZyb23CoHVzLsKgT3VywqBjb3VudHJ5DQpoYXPCoGJlZW7CoG9uwqBmaXJl
wqBmb3LCoG1vcmXCoHRoYW7CoGHCoHllYXLCoG5vdy4NCg0KSWbCoHlvdcKgYXJlwqBjYXBhYmxl
wqBvZsKgaGFuZGxpbmfCoHRoaXPCoGJ1c2luZXNzwqBwYXJ0bmVyc2hpcCzCoGNvbnRhY3TCoG1l
DQpmb3LCoG1vcmXCoGRldGFpbHMswqBJwqB3aWxswqBhcHByZWNpYXRlwqBpdMKgaWbCoHlvdcKg
Y2FuwqBjb250YWN0wqBtZQ0KaW1tZWRpYXRlbHkuwqBZb3XCoG1hecKgYXPCoHdlbGzCoHRlbGzC
oG1lwqBhwqBsaXR0bGXCoG1vcmXCoGFib3V0wqB5b3Vyc2VsZi4NCkNvbnRhY3TCoG1lwqB1cmdl
bnRsecKgdG/CoGVuYWJsZcKgdXPCoHRvwqBwcm9jZWVkwqB3aXRowqB0aGXCoGJ1c2luZXNzLsKg
ScKgd2lsbA0KYmXCoHdhaXRpbmfCoGZvcsKgeW91csKgcmVzcG9uc2UuwqBNecKgc2luY2VyZcKg
YXBvbG9naWVzwqBmb3LCoHRoZQ0KaW5jb252ZW5pZW5jZS4NCg0KDQpUaGFua8KgeW91IQ0KDQpN
ci4gUmF6dW1rb3bCoE15a2hhaWxvLg0K
