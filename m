Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756EE174030
	for <lists+linux-nilfs@lfdr.de>; Fri, 28 Feb 2020 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1TUI (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 28 Feb 2020 14:20:08 -0500
Received: from 13thmonkey.org ([80.100.255.32]:64138 "EHLO
        dropje.13thmonkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgB1TUH (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 28 Feb 2020 14:20:07 -0500
Received: by dropje.13thmonkey.org (Postfix, from userid 103)
        id 6702EC1EB14; Fri, 28 Feb 2020 20:20:04 +0100 (CET)
Date:   Fri, 28 Feb 2020 20:20:04 +0100
From:   Reinoud Zandijk <reinoud@NetBSD.org>
To:     linux-nilfs@vger.kernel.org
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: Re: Qemu (Re: NiLFS support on Pinebook)
Message-ID: <20200228192004.GA7355@dropje.13thmonkey.org>
References: <20200226102235.GA2060@dropje.13thmonkey.org>
 <20200227.001457.2102675267682326035.konishi.ryusuke@lab.ntt.co.jp>
 <20200228105503.GA345@dropje.13thmonkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228105503.GA345@dropje.13thmonkey.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi Ryusuke,

On Fri, Feb 28, 2020 at 11:55:03AM +0100, Reinoud Zandijk wrote:
> Can you recommend a lightweigth linux distro with nilfs support that runs fast
> in `unaided' Qemu?  I.e. with only the `tcg' acceleration and with no
> graphics?

I've settled for a Debian without graphics and it works quite well AND it has
NiLFS2 support!

Testing it on one of my older test NiLFS2 images I had around it paniced when
I did this:

qemu-system-x86_64 -drive file=root.debian.fs,format=raw -accel
  tcg,thread=multi -smp cpus=4 -m 4096 -drive
  file=/usr/tmp/nilfs.4g.img,format=raw
....
    mount.nilfs2 /dev/sdb1 /mnt
    touch /mnt/UDF
wait a second or two
    CRASH

Note that /mnt/UDF exists and is a directory. It gives a NULL pointer
dereference at 0xa8
Call trace:
    __test_set_page_writeback+0x38c/0x3f0
    nilfs_segctor_do_construct+0x190f
    nilfs_segctor_construct+0x1f5
    nilfs_segctor_thread+0x127
....
RIP: 0010:percpu_counter_add_batch+0x04
....

Do you like to receive a copy of this image? It used to work fine and should
only be touched by your NiLFS code.

With regards,
Reinoud

