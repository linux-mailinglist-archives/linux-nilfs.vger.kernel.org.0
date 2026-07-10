Return-Path: <linux-nilfs+bounces-1654-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fMe1KL9+UGpE0AIAu9opvQ
	(envelope-from <linux-nilfs+bounces-1654-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Fri, 10 Jul 2026 07:10:23 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2106E737416
	for <lists+linux-nilfs@lfdr.de>; Fri, 10 Jul 2026 07:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nilfs+bounces-1654-lists+linux-nilfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nilfs+bounces-1654-lists+linux-nilfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BC8C305B284
	for <lists+linux-nilfs@lfdr.de>; Fri, 10 Jul 2026 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A93793CC;
	Fri, 10 Jul 2026 05:07:51 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30826378D9A;
	Fri, 10 Jul 2026 05:07:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660071; cv=none; b=eFQhuIGWGhruP85LPYnFRZmb3hexdNZhMDWg3voMMWjxKabam4k/SObIhbC4YehHZf91WysfhyhO0+6zA0o5bcSbQDhNVMH2rEjPWzID4uKzn1p1A5n0ntW0FdbS2dxLIIsBjPtEKl9h83OErdVqjE8+acs3rCKmyOTQNcAR810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660071; c=relaxed/simple;
	bh=T37xMCgsiHRoI8IL7Mhq+k8JTqo3npGSGG4RHC0ZMNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cGn1usTbmWpnku3rY9UU1XFu8jmtVJbrU5WLRjVcXbUgXmP2fOn2ZeyIoI5zlYvmFX8KM/0Kmphuf71cTXopuWF/E/AVo4h+1AHV4qtBPNLkGW/f86XTZa84he9BNLsxqTL+J6RbT9v9AjCltoSvOZK0Iwq07JKAPa3YTildhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id A755C68BEB; Fri, 10 Jul 2026 07:07:44 +0200 (CEST)
Date: Fri, 10 Jul 2026 07:07:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Dave Kleikamp <shaggy@kernel.org>,
	Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev
Subject: removing the remaining blockdev_direct_IO users
Message-ID: <20260710050744.GA6720@lst.de>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsterba@suse.com,m:hirofumi@mail.parknet.co.jp,m:slava@dubeyko.com,m:glaubitz@physik.fu-berlin.de,m:frank.li@vivo.com,m:shaggy@kernel.org,m:jack@suse.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-nilfs@vger.kernel.org,m:ocfs2-devel@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-nilfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1654-lists,linux-nilfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2106E737416

Hi all,

we have 7 users of blockdev_direct_IO and one of the lower-level
__blockdev_direct_IO left, and I'd really like to get rid of them.

The filesystems are affs, fat, hfs, hfsplus, jfs, nilfs2, udf and ocfs2,
and you are the relevant maintainers.  In 7.2 exfat converted entirely
to iomap, which would be a really good example for a "simple" file
system.  Another options especially for the file systems supporting
foreign formats would be to just drop direct I/O support and reduce
the support burden.

