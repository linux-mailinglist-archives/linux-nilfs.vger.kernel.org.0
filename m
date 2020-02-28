Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96E21735AE
	for <lists+linux-nilfs@lfdr.de>; Fri, 28 Feb 2020 11:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgB1KzH (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 28 Feb 2020 05:55:07 -0500
Received: from 13thmonkey.org ([80.100.255.32]:64523 "EHLO
        dropje.13thmonkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KzG (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 28 Feb 2020 05:55:06 -0500
Received: by dropje.13thmonkey.org (Postfix, from userid 103)
        id 9ED9CC1EB14; Fri, 28 Feb 2020 11:55:03 +0100 (CET)
Date:   Fri, 28 Feb 2020 11:55:03 +0100
From:   Reinoud Zandijk <reinoud@NetBSD.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Reinoud Zandijk <reinoud@NetBSD.org>, linux-nilfs@vger.kernel.org
Subject: Qemu (Re: NiLFS support on Pinebook)
Message-ID: <20200228105503.GA345@dropje.13thmonkey.org>
References: <20200226102235.GA2060@dropje.13thmonkey.org>
 <20200227.001457.2102675267682326035.konishi.ryusuke@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227.001457.2102675267682326035.konishi.ryusuke@lab.ntt.co.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Thu, Feb 27, 2020 at 12:14:57AM +0900, Ryusuke Konishi wrote:
> Hi Reinoud,
> 
> > when i mount a partition it gives the error "mount.nilfs2: cannot find or load
> > nilfs2 filesystem". Does this mean the linux kernel has no nilfs2 module
> > shipped with it, but only the tools?
> 
> We see this message if nilfs2 kernel module (nilfs2.ko) doesn't exists in
> /lib/modules/$(uname -r)/... .
> 
> Some distros don't have nilfs2 module (e.g. RHEL/CentOS), and some
> need an extra package like kernel-modules-extra (e.g. Fedora).
> 
> I don't know that is there in the Pinebook.

Problem with pinebook is that there are distro's around to test but they seem
to like the 3.10 kernel too much and update all but the kernel. The linux
headers they ship are for 4.x and 5.x so no use for compiling the kernel
module itself.

Can you recommend a lightweigth linux distro with nilfs support that runs fast
in `unaided' Qemu?  I.e. with only the `tcg' acceleration and with no
graphics?

Thanks in advance,
Reinoud

