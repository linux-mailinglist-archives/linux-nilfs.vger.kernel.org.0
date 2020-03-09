Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA56817E764
	for <lists+linux-nilfs@lfdr.de>; Mon,  9 Mar 2020 19:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCISmm (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 9 Mar 2020 14:42:42 -0400
Received: from 13thmonkey.org ([80.100.255.32]:60892 "EHLO
        dropje.13thmonkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCISmm (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Mon, 9 Mar 2020 14:42:42 -0400
Received: by dropje.13thmonkey.org (Postfix, from userid 103)
        id C3772C1EB14; Mon,  9 Mar 2020 19:42:40 +0100 (CET)
Date:   Mon, 9 Mar 2020 19:42:40 +0100
From:   Reinoud Zandijk <reinoud@NetBSD.org>
To:     Peter Grandi <pg@nilfs.list.sabi.co.UK>
Cc:     Linux fs NILFS <linux-nilfs@vger.kernel.org>
Subject: Re: null pointer dereferenced with Ubuntu kernel 4.15
Message-ID: <20200309184240.GA14772@dropje.13thmonkey.org>
References: <24166.20345.583274.370928@base.ty.sabi.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24166.20345.583274.370928@base.ty.sabi.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

I have these too, it looks like something in the linux kernel must hsve
changed and tgey didn't test or looked for issues in the nilfs code. It only
starts here with writing on a previously written volume. A new volume works
fine.


On Mon, Mar 09, 2020 at 02:15:21PM +0000, Peter Grandi wrote:
> Dear NILFSers I am perplexed because on upgrading my standard
> Ubuntu LTS kernel "4.15.0-88-generic" I keep getting null
> pointer dereferences as per attached kernel messages, and this
> did not happen with the previous version "4.15.0-72-generic".

