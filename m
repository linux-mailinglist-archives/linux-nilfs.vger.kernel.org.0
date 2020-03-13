Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C51184F10
	for <lists+linux-nilfs@lfdr.de>; Fri, 13 Mar 2020 19:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMS5N (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 13 Mar 2020 14:57:13 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:45590 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMS5N (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 13 Mar 2020 14:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dgBaw7d5ChDmyOuhZ9dexHK2X+tah/N3o86zmBB4rXo=; b=qQ7j80iFAFcEA19LutJTdaFYex
        omDwyXNzRULzHvrW1iH/3SGmlrwDDo2JFD12G6gWUvCaW/D3an/gVMS7eKqH5scuy6wmgsF7Wcz17
        7D3yBuh/xapEDMftyGD/cSJ36FqO0X9kix/nt8GJOSWnXmk4qP0XJglzptn9blBcYPKXf5RaJ7Jgg
        eIeJXV1gsswT10tfYtxcRGujI7FXqQ/bN8Dr7lu6ue0e9W0V0nuOhWnposovpazwLOxGv4uSteDHK
        3ZAkd6Kx4rzpzAkYLtjSm137KdwkMaTbg0v2HbxhVLhB90PwGfBtQeMcYpQ+y9jBlDEOVxDWcq7V5
        wbcIpSAg==;
Received: from w-50.cust-u6066.ip.static.uno.uk.net ([95.172.224.50]:41938 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <postmaster@mail.for.sabi.co.uk>)
        id 1jCpUd-0004wp-PA
        for linux-nilfs@vger.kernel.org; Fri, 13 Mar 2020 18:57:11 +0000
Received: from from [127.0.0.1] (helo=base.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)(Exim 4.86_2 2)
        id 1jCpUX-0005ma-JL
        for <linux-nilfs@vger.kernel.org>; Fri, 13 Mar 2020 18:57:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24171.55169.327616.643008@base.ty.sabi.co.uk>
Date:   Fri, 13 Mar 2020 18:57:05 +0000
To:     Linux fs NILFS <linux-nilfs@vger.kernel.org>
Subject: Re: null pointer dereferenced with Ubuntu kernel 4.15
In-Reply-To: <20200309184240.GA14772@dropje.13thmonkey.org>
References: <24166.20345.583274.370928@base.ty.sabi.co.uk>
        <20200309184240.GA14772@dropje.13thmonkey.org>
X-Mailer: VM 8.2.0b under 24.5.1 (x86_64-pc-linux-gnu)
From:   pg@nilfs.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - azure.uno.uk.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mail.for.sabi.co.uk
X-Get-Message-Sender-Via: azure.uno.uk.net: authenticated_id: sabity@sabi.unospace.net
X-Authenticated-Sender: azure.uno.uk.net: sabity@sabi.unospace.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

>> Dear NILFSers I am perplexed because on upgrading my standard
>> Ubuntu LTS kernel "4.15.0-88-generic" I keep getting null
>> pointer dereferences as per attached kernel messages, and this
>> did not happen with the previous version "4.15.0-72-generic".

> I have these too, it looks like something in the linux kernel
> must hsve changed and tgey didn't test or looked for issues in
> the nilfs code.

That's my guess too, but it is a bit strange that it happens
between two minor versions of the same base kernel. But then
Debian and Ubuntu backport stuff to their kernels, so that's
probably why.

> It only starts here with writing on a previously written
> volume. A new volume works fine.

I have checked and that happens here too: if I recreated and
reload the volume no problems, but on the next reboot and mount
the problem reappears. I guess I'll try deleting the last
checkpoint to see if that helps, and/or looking at what changes
between the -72 and -88 versions of the 4.15.0 kernel if
anything seems related (there will be lots of changes I guess
though).
