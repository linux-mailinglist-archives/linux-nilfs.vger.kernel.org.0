Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125364823CB
	for <lists+linux-nilfs@lfdr.de>; Fri, 31 Dec 2021 12:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhLaLoG (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 31 Dec 2021 06:44:06 -0500
Received: from SMTP.sabi.co.UK ([185.17.255.29]:39452 "EHLO sabi.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhLaLoF (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 31 Dec 2021 06:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=root.for.sabi.co.uk; s=dkim-00; h=From:References:In-Reply-To:Subject:To:
        Date:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cSkp+ABCvkWd0M5jNg2DD9tD0SeYXQD4TdNrNl2JXZs=; b=lKiosoW6if1rSuQBwP89tYlVkU
        oyovqm25L8NjnobjyATZC1bIJ3DcuWlL84awD7O3pySyhQBIodYBnuRcNYRcTAqvCxWUCIeAR03o6
        xPqB/9zXfibqr5OKQPsVFfTBhIDDyLymeuI9kbyEVBcvZ2K5tArmeJPuRQK7OkhG96XxayUsriE/V
        w4EX0yTDRbVbqIk8Z9ncJETVgZAepPMX7tujfiaqLQaLAm4BStqyvTT1L79tT4YQ34Lhyx2KMB70D
        qeEzFpyEOcKVOb/3MFVBzflRvwuOkAlSGpulaldkY+kuxkOm9CtvAPf6xly62sK5F30NEvicaHmOQ
        dMBUwS3Q==;
Received: from dynamic-089-204-138-234.89.204.138.pool.telefonica.de ([89.204.138.234] helo=sabi.co.uk)
        by sabi.co.uk with esmtpsa(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)(Exim 4.93 id 1n3GKJ-00GK7j-Pr   id 1n3GKJ-00GK7j-Prby authid <sabity>with cram
        for <linux-nilfs@vger.kernel.org>; Fri, 31 Dec 2021 11:44:03 +0000
Received: from [127.0.0.1] (helo=cyme.ty.sabi.co.uk)
        by sabi.co.uk with esmtp(Exim 4.93 5)
        id 1n3GKA-002fQN-Md
        for <linux-nilfs@vger.kernel.org>; Fri, 31 Dec 2021 11:43:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25038.60666.361700.270143@cyme.ty.sabi.co.uk>
Date:   Fri, 31 Dec 2021 11:43:54 +0000
To:     list Linux fs NILFS <linux-nilfs@vger.kernel.org>
Subject: Re: couldn't mount because of unsupported optional features
 (477e7ad1e859f753)
In-Reply-To: <37be5d12-adea-6399-65c3-6d50008c18ff@levsen.org>
References: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
        <25037.40801.808565.662504@cyme.ty.sabi.co.uk>
        <37be5d12-adea-6399-65c3-6d50008c18ff@levsen.org>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
From:   pg@nilfs.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-Blacklisted-At: 
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

[...]
>> use 'lscp /dev/...' to list the checkpoints and try to mount
>> an older checkpoint with 'mount -t nilfs2 -o cp=... /dev/...
>> ...' to mount it and resume work from that. In theory older
>> checkpoints will be fully consistent even if the latest one
>> is corrupted.

> Thanks Peter, it seems both lscp and mount -o cp need a
> functioning super block though.

If the superblock is gone, it is a rather unlucky situation. But
note that NILFS2 has got a redundant copy of the superblock like
most other filesystem types. This is described here:

  https://github.com/nilfs-dev/nilfs2-kmod7/blob/master/fs/nilfs2/the_nilfs.c#L490

This mailing list thread may be particularly relevant:

  https://www.mail-archive.com/linux-nilfs@vger.kernel.org/msg01438.html
  https://www.mail-archive.com/linux-nilfs@vger.kernel.org/msg01239.html
  https://www.mail-archive.com/linux-nilfs@vger.kernel.org/msg01238.html

In my experience it never happened that NILFS2 corrupted a
superblock, so it is most likely an external cause.

> I might dig into this a little deeper, the data isn't that
> important but gaining a correct understanding of NILFS working
> principles is. My understanding so far was that it's quite
> hard for data to become entirely inaccessible.

The same for most other filesystem types, but for log structured
ones it is even harder. The NILFS2 idea is that since all
metadata blocks are checksummed, one can just roll back to a
checkpoint where all checksums work, and then the filesystem is
consistent up to that point. This does not protect against most
cases of data corruption or damage to the superblock or spread
damage to metadata (in the latter case it may be impossible to
find a sequence of segments with valid checksums).

NILFS2 has some interesting recovery logic here:

  https://github.com/nilfs-dev/nilfs2-kmod7/blob/master/fs/nilfs2/recovery.c

> This looks like a good idea, linear scan for segment nodes:
> https://www.spinics.net/lists/linux-nilfs/msg02198.html Could
> be the start of the fsck that never happened.

That is not quite an 'fsck' but a recovery tool; many 'fsck'
implementations also attempt to do a bit of recovery too, but
their primary function is to repair metadata in case of partial
writes, which because of the checksums mentioned above is not
necessary for NILFS2, and the same argument is used for ZFS,
which is "log based" or "log inspired".

I find the lack of 'fack' for NILFS2 and ZFS a mild issue:
whether or not a filesystem type needs a repair too, another
core function of 'fsck' is an auditing tool, to be run
periodically even if there are no known issues (ZFS "resilvering
is not a full audit). But then how many people nowadays run
regularly 'fsck' where it is available as an auditing tool even
if there are no known issues?

One of the most profound quotes in the history of information
engineering:

  "As far as we know, our computer has never had an undetected
  error" Conrad H. Weisert (Union Carbide Corporation) in
  "Datamation" (1969)
