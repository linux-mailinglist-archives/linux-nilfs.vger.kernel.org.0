Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C413481C20
	for <lists+linux-nilfs@lfdr.de>; Thu, 30 Dec 2021 13:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhL3Mf1 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 30 Dec 2021 07:35:27 -0500
Received: from SMTP.sabi.co.UK ([185.17.255.29]:38558 "EHLO sabi.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239200AbhL3Mf1 (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 30 Dec 2021 07:35:27 -0500
X-Greylist: delayed 2079 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Dec 2021 07:35:26 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=root.for.sabi.co.uk; s=dkim-00; h=From:References:In-Reply-To:Subject:To:
        Date:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OqfxSnE34cCa6rzncHoYPxmUtQMKd5EINhfIEla3Z2U=; b=QoC+IaGsW0/Ae3LrXvPtYB4GQl
        967M1rRA3aA+pnidiKccRlsrtyMg+VhAZ9HXGeSxRXd8MTeKycasUbSqFNEq8oQgIkbHD7wmHtHjy
        MVNYRhHEteU4cHjSn3O384rZ6D/fSVQOU7gWWeOMmaZ9mY+9VawXGZB6EYcC6fTrsO/ONLhpFUP+h
        JYc/Ncok/EHIxolw1W6VxmfGxdWS4+4inHp4nYvEOzecS2lgp4Y/PlDhZl2juyrZGlichfN0gbCDv
        OahXzOoCOzM6fQFWQHcpa3M6SShgoeORXNkEw+ikjgoykD4Tmb3F3ccNYiKseaLi44N2zC6tdw7mU
        hILAdYMw==;
Received: from dynamic-089-204-139-128.89.204.139.pool.telefonica.de ([89.204.139.128] helo=sabi.co.uk)
        by sabi.co.uk with esmtpsa(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)(Exim 4.93 id 1n2u6w-00GHbX-52   id 1n2u6w-00GHbX-52by authid <sabity>with cram
        for <linux-nilfs@vger.kernel.org>; Thu, 30 Dec 2021 12:00:46 +0000
Received: from [127.0.0.1] (helo=cyme.ty.sabi.co.uk)
        by sabi.co.uk with esmtp(Exim 4.93 5)
        id 1n2u6k-002V0D-Pl
        for <linux-nilfs@vger.kernel.org>; Thu, 30 Dec 2021 12:00:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25037.40801.808565.662504@cyme.ty.sabi.co.uk>
Date:   Thu, 30 Dec 2021 12:00:33 +0000
To:     list Linux fs NILFS <linux-nilfs@vger.kernel.org>
Subject: Re: couldn't mount because of unsupported optional features (477e7ad1e859f753)
In-Reply-To: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
References: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
From:   pg@nilfs.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-Blacklisted-At: 
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

> Trying to mount a NILFS partition

To be pedantic, but it matters, it is "block device" in UNIX-like
systems, and more "NILFS2 instance", as here could be multiple
NILFS2 instances even in a single block device (but that is a
very rare setup usually requiring 'losetup' mounts).

> fails with "couldn't mount because of unsupported optional
> features (477e7ad1e859f753)". [...]

That does not look a lucky situation. You can use 'lscp
/dev/...'  to list the checkpoints and try to mount an older
checkpoint with 'mount -t nilfs2 -o cp=... /dev/... ...' to
mount it and resume work from that. In theory older checkpoints
will be fully consistent even if the latest one is corrupted.

Unless that  message means that the NILFS2 instance is corrupted
because of "issues" (usually hardware, most common with block
devices on USB storage devices).
