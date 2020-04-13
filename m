Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0181A65C1
	for <lists+linux-nilfs@lfdr.de>; Mon, 13 Apr 2020 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgDMLtt (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 13 Apr 2020 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgDMLtq (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 13 Apr 2020 07:49:46 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:49:46 EDT
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3250C00861D
        for <linux-nilfs@vger.kernel.org>; Mon, 13 Apr 2020 04:41:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id u65so4388793pfb.4
        for <linux-nilfs@vger.kernel.org>; Mon, 13 Apr 2020 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qlKWExEze9qCqlwbpw1q4+d2Zjr4ETGVa64TcX+dTlk=;
        b=HxOaFJZljqXQIeSLw7dw+YeTIVe76Yo57NkC3rYQjPPsruaWLZEetJYgTw7mDA7iYw
         4KM/sQKuVdxfTyBgHy0QGrcgvhBAp/s2WR+7lhwMEms7c5U3ARzlxX4w9gHN6kyIVCTo
         InVjjBwajQbgYMLlLr/dGAnfAOq75HLmi2bmQShdg5UrDH6ZNHdmpjirCjsFE3E+W3lI
         4HPNdhIk9GHy3wOVy8qt79oLhQ3V0WJ+l2R8YfTk5No8OB207Mc1ssyzLdiNdU6iDIon
         HSnId1sWR9JHq8BkscMOY+TVCS7WuDDdfTSRJRDObUGUY3pKdsd/NGq97n4qtv5szVJr
         IEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=qlKWExEze9qCqlwbpw1q4+d2Zjr4ETGVa64TcX+dTlk=;
        b=ODy2ZdtjcmEVUoC0LIBGnmDYHG5+tnixzIoq/scN4iz4GJ5Ewd67Pn3OVKjRW6dF/F
         71loyzQWVfqwFFv9cfpmT3s4lk4f2W/BAlUsImboPaxuB9ZTJuJzJVH6uqB5XtnQeMnf
         gkG1GAgCXE8UFwUYq03dVpIwyGdW4wG54zWFFuHP6ikEO9R1iLh71MrORJ2SV2XbNog4
         2KDyZfa6mbmOEcInvv8XhqdqQAz1wWlc+qqjmNrONFONzZdEhkuVy5uem+Uxbc2jFhNj
         k3GGh6OTgXj89VxldyB6KzAV94udxUX5KQRMbZj3vxejBLLzLJ+5wSeuJr3bAuFRATW+
         DqNw==
X-Gm-Message-State: AGi0PuYTapUBhAT0AgSmywWlCnh7yuIU/9OzgMvc5rYBs7WBO1xQuvmv
        nbwodjiptOUQkeNbsaVigO56tPPcGvpzt1G/yvgCtwg=
X-Google-Smtp-Source: APiQypJ8Xf5JZIaJmuakcegBHklRN/w3ObzOY1fG2hZhiF0393fUgrxf6qaSVcLD5pLEm/4TEQgoj9oGK8tQ5EeyGAU=
X-Received: by 2002:a05:6e02:c8f:: with SMTP id b15mr14965961ile.35.1586778068198;
 Mon, 13 Apr 2020 04:41:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5e49:0:0:0:0:0 with HTTP; Mon, 13 Apr 2020 04:41:07
 -0700 (PDT)
Reply-To: mgbenin903@gmail.com
From:   Barrister Robert Richter UN-Attorney at Law Court-Benin 
        <info.zennitbankplcnigerian@gmail.com>
Date:   Mon, 13 Apr 2020 13:41:07 +0200
Message-ID: <CABHzvrm3rWryg1yAooKeHwdxzrKD47PRAEfC+ay1A6i5z3Wdiw@mail.gmail.com>
Subject: I have already sent you first payment US$5000.00 this morning through
 MONEY Gram service.it is available to pick up in address now.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

ATTN DEAR BENEFICIARY.

GOOD NEWS.

I have already sent you first payment US$5000.00 this morning through
MONEY Gram service.it is available to pick up in address now.

So we advise you to Contact This Money Gram office to pick up your
transfer $US5000.00 today.


Note that your compensation payment funds is total amount $US2.800,000
Million Dollars.We have instructed the Money Gram Agent,Mr. James
Gadner to keep sending the transfer to you daily, but the maximum
amount you will be receiving everyday is US$5000.00. Contact Agent now
to pick up your first payment $US5000.00 immediately.

Contact Person, Mr. James Gadner, Dir. Money Gram Benin.
Email: mgbenin903@gmail.com
Telephone Numbers: +229 62819378/ +229 98477762

HERE IS YOUR PAYMENT DETAILS FOR THE FIRST =C2=A3US5000.00 SENT TODAY.

Track View Website link:
https://secure.moneygram.com/track
Sender=E2=80=99s First name: David
Sender=E2=80=99s Last Name: Joiner
Money Transfer Control Number (MTCN) (REFERENCE)# 26046856

Contact the Mmoney Gram Urgent and reconfirm your address to the
office before, they will allow you to pick up the transfer today.

HERE IS WHAT REQUIRED OF YOU.

YOUR FULL NAME---------
ADDRESS--------------
COUNTRY-----------------------------
TELEPHONE NUMBERS-----------------

Note, I paid the transfer fee for you, but only you are required to
send to the office is $75 only,Been Your Payment File activation fee,
Send once you contact the office,before you can able to pick up your
transfer today.

Let me know once you pick up first payment today.

Barrister Robert Richter UN-Attorney at Law Court-Benin
