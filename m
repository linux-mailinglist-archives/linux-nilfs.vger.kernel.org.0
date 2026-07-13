Return-Path: <linux-nilfs+bounces-1656-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jo6SKNG3VGoFqAMAu9opvQ
	(envelope-from <linux-nilfs+bounces-1656-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Mon, 13 Jul 2026 12:02:57 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06752749979
	for <lists+linux-nilfs@lfdr.de>; Mon, 13 Jul 2026 12:02:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nilfs+bounces-1656-lists+linux-nilfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nilfs+bounces-1656-lists+linux-nilfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 575DC305DE67
	for <lists+linux-nilfs@lfdr.de>; Mon, 13 Jul 2026 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708873E44F0;
	Mon, 13 Jul 2026 09:59:07 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831863EAC76;
	Mon, 13 Jul 2026 09:59:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936747; cv=none; b=siUjZOl3WbsiX5JL/U0b+3ZpsdaHY5bX/w61h681BZ/APQzBhlSkx/0YNS63Xwj/CAK8JA6kIRIqw1sE3LHAtoDVlcTqxi4ihehAq7LUsexYlcm0DJH5YIM42D2aMfAYYjtg5eIY2sOpgDmWG2qI6jSafkdzUN1wGBP9f9XsjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936747; c=relaxed/simple;
	bh=YlBUt7nswou5vInVDSmKtqY9HvPOSjwm7fdwyXD7ni0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNVQXCijAn3ESbV65SiHnbCv9SoZnj7sXffsyeibZsvmgvaJQjyyCGwdqMxofsEM9rmRPJkefTCaZEcebqQchJNRluqvHWCS3Ij15C5iF901d2c+m6TUeIMfe7rOlsy5PGa8GM2hnZrr7wMrGGTD5GFxAhXlslvAEka6tsdQlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 05AEC68BFE; Mon, 13 Jul 2026 11:58:58 +0200 (CEST)
Date: Mon, 13 Jul 2026 11:58:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Dave Kleikamp <shaggy@kernel.org>,
	Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, ocfs2-devel@lists.linux.dev
Subject: Re: removing the remaining blockdev_direct_IO users
Message-ID: <20260713095857.GB10501@lst.de>
References: <20260710050744.GA6720@lst.de> <fea4c4f25afb7711d1e8fbe6ca5ab654ec522186.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fea4c4f25afb7711d1e8fbe6ca5ab654ec522186.camel@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:slava@dubeyko.com,m:hch@lst.de,m:dsterba@suse.com,m:hirofumi@mail.parknet.co.jp,m:glaubitz@physik.fu-berlin.de,m:frank.li@vivo.com,m:shaggy@kernel.org,m:jack@suse.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-nilfs@vger.kernel.org,m:ocfs2-devel@lists.linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,linux-nilfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1656-lists,linux-nilfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nilfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06752749979

On Fri, Jul 10, 2026 at 09:51:09AM -0700, Viacheslav Dubeyko wrote:
> On Fri, 2026-07-10 at 07:07 +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > we have 7 users of blockdev_direct_IO and one of the lower-level
> > __blockdev_direct_IO left, and I'd really like to get rid of them.
> > 
> > The filesystems are affs, fat, hfs, hfsplus, jfs, nilfs2, udf and
> > ocfs2,
> > and you are the relevant maintainers.  In 7.2 exfat converted
> > entirely
> > to iomap, which would be a really good example for a "simple" file
> > system.  Another options especially for the file systems supporting
> > foreign formats would be to just drop direct I/O support and reduce
> > the support burden.
> 
> I like the idea. I think we can try to switch HFS/HFS+ and NILFS2 on
> iomap approach. Do you have some initial patches for this? Which
> particular commit(s) converted the exfat to iomap? It will be good to
> take a deeper look into this conversion to estimate the complexity of
> HFS/HFS+, NILFS2 modifications.

Almost all commits in fs/exfat/ in 7.2-rc1, starting with
623f0aa1eca5c2a94ca1e4e5de719d062eac3b6c


