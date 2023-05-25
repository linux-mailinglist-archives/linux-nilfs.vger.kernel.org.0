Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D802710FBC
	for <lists+linux-nilfs@lfdr.de>; Thu, 25 May 2023 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjEYPgs (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 25 May 2023 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbjEYPgr (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 25 May 2023 11:36:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8482699
        for <linux-nilfs@vger.kernel.org>; Thu, 25 May 2023 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1685029003; x=1685633803; i=schwidom@gmx.net;
 bh=l1HpxwgYBwJMik7MEg3PiDhT6iVJvQDPw/OFM6Zsphk=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=WC/Ek5VQJh2NjxYpiOn2m/lGnN795oTU16lG0POh2oeCpJf5WQZ04YQJIozuQ5AQxWKCeLX
 hFl5hhBKZexR6SpIZCZASiewq9ytZwfwPfSAOkgf11gNwRfh4REqEu9E5uby7gAyAGsnPrC+h
 MHrDgFVp43whi1foB0KY0FT2jyqvJZsovm26V66jwRj4+4s9WVRaLVG146qETVbO/mNWsAjcs
 Fd2+XaYtDo+BBAbLyzQGKLwJ4Y0tZXjle0zEPm3l8ahpp8jsxdesik06C4knFsA9iXp7vBU7+
 Qwzj8nld2lOYsK1f9gHzhoRXC6BdJYp5fqp/8kzYXzLA+mjciolA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian64 ([46.114.178.189]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1qYFua1uJP-00cRal for
 <linux-nilfs@vger.kernel.org>; Thu, 25 May 2023 17:36:43 +0200
Received: from ox by debian64 with local (Exim 4.92)
        (envelope-from <schwidom@gmx.net>)
        id 1q2Cje-0003qf-Jp
        for linux-nilfs@vger.kernel.org; Thu, 25 May 2023 17:18:38 +0200
Date:   Thu, 25 May 2023 17:18:38 +0200
From:   Frank Schwidom <schwidom@gmx.net>
To:     linux-nilfs@vger.kernel.org
Subject: Is it possible to restore the state of a nilfs2 partition after
 deleting files?
Message-ID: <20230525151838.GA5174@debian64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
X-Provags-ID: V03:K1:g1mw5aLChO2mtJKNwcbF3Hwqq41+RjzXZIiME+PBPheqwq1tICe
 Ft2PYC8iOSVRGyO55r70/qyXz0BgLruXVwL0ijlrtzm/KgRSZPIkNfKng/CflhOnHZ+r2t2
 1BaZJe5EqSc+I2z15vR+PO1kd4vnTkcI79R3eVZKjRRO6xPtmWJlOfy1CJv39J+oSN9d/Px
 2bJqCRSGXVD2+/1MxMq+w==
UI-OutboundReport: notjunk:1;M01:P0:cGlf33+hblk=;IVzUXS1mSEvJzlz9F0XTFSCidkR
 vhJUwcYXMmi/xi9ddW5cJSME1sy15Qwk/utRa+qQEEqBEAJ3LH7Nlwkqn+2pUsWz1pznT/KJ7
 tM180/uHtvOozt4bClSRWrwTQX6y2D1JxHYvv0mNC5Ma+tRRWzv5YV98XqX1v/gDuFtxYH2BS
 BrOFaDkzuJWIt5I429itG5QJ86Ay+qhyi09f8MJz7uXd7k7P20jTfesK7ug7txX4224OuLcur
 70LN/0c/osqP1g95yRwu01J1Dka3p0puxoBy+e6sSyyRU6eKe+neMnpFOmL+11PY9XznES8qV
 kSIpvEkJ6X47GDJdkYyXu/Mj/XVgUb1w4D7Tcdq9dy43LTNRTZEM64bxQssjhJDVP/V/HxcOY
 9h68BAyDWElgy9GZIO88zse+CbeeYrlmSD9cuD5y5gFjJu1Tl69m6TIqWs4BXL6KaLtbHw7e+
 8b0/mHddqjt5dDdVhnV1dnoRBy8o3C+dDE/vlwSKrrkFe/Arv/PR2EfVOdOSG6WaBVwE8bpXL
 fi12z9KqpCKPFu3O5HhxiLOCKaanBO/yUGSuYtgVXJrwZTs9CX5NrImjAzL92L5zSeHMO+WAQ
 w4/byK1UW5uxWx32uluT353u+p7jeg8SuMrav3lEFTtzYEWgTdfQTWBVhN0Js3+SLgL3ieNnF
 EdzyoUp1OizfZst7GM53Mn+1B9znfNQSLFr093/BqdWgZNqs/4L4pJmnV9PnQlQzAHru84Z36
 M7DcZWimD4s54rutC5/8QWzXsOSS5Izmj1V/YOnz2im2x/I24P4PgcViU4SezSbT54YcOTzfn
 FWBjpKUhxyM/kK/+TfV2DqE7VvFqmIeEt4uqJg86wG/UHUvbx5EJuDOe5Es1G33462hQEXzQ6
 A/Zh2fM0H5oo4d9hqzYxUxrX71uVEw8/FGJVJCBeDFxqFQhKB2VDOGkSuUEkinhhwbhU3iJoG
 N/AuDAYKH5Yo7L2MEiQZkWsW3KI=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

is it anyhow possible to set the state of a nilfs2 partition to the latest
checkpoint or snapshot?

(I am using nilfs-tools 2.2.7-1 on
Linux debian64 5.10.0-0.deb10.16-amd64 #1 SMP Debian 5.10.127-2~bpo10+1 (2=
022-07-28) x86_64 GNU/Linux)

Thanks in advance,
Frank
