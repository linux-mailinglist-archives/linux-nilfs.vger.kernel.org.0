Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9511B784E9C
	for <lists+linux-nilfs@lfdr.de>; Wed, 23 Aug 2023 04:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHWCRi (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 22 Aug 2023 22:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjHWCRf (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 22 Aug 2023 22:17:35 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:17:32 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CBCF8
        for <linux-nilfs@vger.kernel.org>; Tue, 22 Aug 2023 19:17:32 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-57-64e553c67790
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id C4.42.10987.6C355E46; Wed, 23 Aug 2023 05:33:10 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=GW7rV5lhcvKVYOKtZgp++/XPAWYRgbymzXyxsYHF/Eu7cdjAKpisVVf8w7h1NNAfU
          Pn1x4EVV8BZ8SXDqZ4/L+O6oakVEvNykfIeEqbvll2u/4WSIgB3uwxnwPdr9dUV/Z
          IEXMwlvKg6nLSs5AotijdOhDYu4cYs8sanz8QyGv4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=iQ/pGWbE2yKLLi0AIXZyZwDKe13VlTN2JsZ3TTjofUIxrgTTZCDuj0GLUthTKUojQ
          fBNDkfMmD6EtsXsJvkspAAyrySBaGL1xnb2obk46ppquMj1S/JjnMp6sl0GNEDXm5
          8SOWTQNR3bYc/PaNhKcJL2G/awHUGX8p0yuYV/pKI=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:04 +0500
Message-ID: <C4.42.10987.6C355E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-nilfs@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:18 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW/dY8NMUg/W3xC3+TDdxYPT4vEku
        gDGKyyYlNSezLLVI3y6BK2PJugssBbuZK9r6F7E0MD5m6mLk5JAQMJG4dv0pM4gtJLCHSWLi
        P/MuRi4OFoHVzBIvZ95ggXAeMkvMPPyaEcQREmhmlHi5ch5YC6+AtUTrhH9gNrOAnsSNqVPY
        IOKCEidnPmGBiGtLLFv4GqiGA8hWk/jaVQISFhYQk/g0bRk7iC0iIC/x6NNDsFY2AX2JFV+b
        GUFsFgFViWXn/7BAXCclsfHKerYJjPyzkGybhWTbLCTbZiFsW8DIsopRorgyNxEYaMkmesn5
        ucWJJcV6eaklegXZmxiBQXi6RlNuB+PSS4mHGAU4GJV4eH+ue5IixJpYBtR1iFGCg1lJhFf6
        +8MUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry2Qs+ShQTSE0tSs1NTC1KLYLJMHJxSDYwbLQss
        bskVPpCVyuyZa8O06mug/898jVR7rffS7NmKKUfMp7rENzzs8lv0VX3LO3MLyWtCYk08O/i+
        dddbitx7omGz7x3Lop7/NtpHM26wmn53m1gXMCv71OGua2t5rxkah9f939N9oSy7/o5lhbyZ
        rMGfnWsENK1Pz8h20fy7KFyE9dveZiWW4oxEQy3mouJEAMCHnds+AgAA
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

