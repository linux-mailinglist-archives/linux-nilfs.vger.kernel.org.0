Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF116FC67
	for <lists+linux-nilfs@lfdr.de>; Wed, 26 Feb 2020 11:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBZKkI (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 26 Feb 2020 05:40:08 -0500
Received: from 13thmonkey.org ([80.100.255.32]:65161 "EHLO
        dropje.13thmonkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgBZKkI (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 26 Feb 2020 05:40:08 -0500
Received: by dropje.13thmonkey.org (Postfix, from userid 103)
        id 0D1CFC1EB14; Wed, 26 Feb 2020 11:40:07 +0100 (CET)
Date:   Wed, 26 Feb 2020 11:40:07 +0100
From:   Reinoud Zandijk <reinoud@NetBSD.org>
To:     linux-nilfs <linux-nilfs@vger.kernel.org>
Subject: NiLFS support on Pinebook
Message-ID: <20200226104006.GA19476@dropje.13thmonkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Dear folks, dear Ryusuke,

I am trying to use NiLFS2 on my Pinebook that identifies itself as GNU/Linux
on aarch64. It allows me to install nilfs-tools wich seem to work fine but
when i mount a partition it gives the error "mount.nilfs2: cannot find or load
nilfs2 filesystem". Does this mean the linux kernel has no nilfs2 module
shipped with it, but only the tools?

How can I install the nilfs2 filesystem? Or is that up to the distribution and
out of my control?

With regards, Reinoud

