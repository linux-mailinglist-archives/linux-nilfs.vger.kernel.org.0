Return-Path: <linux-nilfs+bounces-1529-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HOIAvp2wmlNdQQAu9opvQ
	(envelope-from <linux-nilfs+bounces-1529-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Tue, 24 Mar 2026 12:35:22 +0100
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 964A73075F2
	for <lists+linux-nilfs@lfdr.de>; Tue, 24 Mar 2026 12:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95AE93040013
	for <lists+linux-nilfs@lfdr.de>; Tue, 24 Mar 2026 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B2275AFD;
	Tue, 24 Mar 2026 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sPDCT2WD"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FC3B27EF
	for <linux-nilfs@vger.kernel.org>; Tue, 24 Mar 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351633; cv=none; b=AJcO21Rdc7lFD18PbLC0jZVtxQo5GP/vjmg+vtB7XVFonVH3wY0pVeoWM/v2O4Y6aiEjYrN1kFiJ8bu8OFIonRLMhQSsDEAmJs19cqLNcgxumQhw6ld6q7XCuWzRbxct17N7xzkEr0nErkl6jhbxwgAuGKTWtpav1O5DOj61CfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351633; c=relaxed/simple;
	bh=mwfnq+p/VIA/hxKMEUOtoonFgYbt/9YqPrOyodGMcM8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMV+mhziZ/DYCy+/zNeUIz5qT7zDrpw40ImBDHTbBXT9H8cdiUttBCn1RFI07K4yhoh/swDj+DsE6jsQFz3xpskJGLYvKVgHfWtLVeWpK0NIpaoKU6TktuN2Uwkcg6Gus5EEx2LAIJypAlrQOlsv9CWJmQdj7N8RuQWTY+/uB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sPDCT2WD; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Mar 2026 19:26:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774351620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwfnq+p/VIA/hxKMEUOtoonFgYbt/9YqPrOyodGMcM8=;
	b=sPDCT2WDPd/UgCRu5UsMbWEbgQ76oyNGcz4Hxyrc1ixepDFHl80J1eDa+YwGfOkCrZOpgc
	0m83qNef+RUNEFD/80KAMaQeh92zt12gI4OBK4heEZ6+s83s0kWJLWhx6x4twkXC1rPJ0R
	XWHDkzTFJ+VXIqukwUR84f0tQnsOHSY=
Message-ID: <f75eb907cfe0944a5cc3bd02d137fce8.junjie.cao@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Junjie Cao <junjie.cao@linux.dev>
To: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_ioctl_prepare_clean_segments
In-Reply-To: <65f731a33b7f0f5e26bf288505694c9a.junjie.cao@linux.dev>
References: <69b8c9a9.a00a0220.3b25d1.002a.GAE@google.com> <69c08e14.050a0220.3bf4de.008f.GAE@google.com> <65f731a33b7f0f5e26bf288505694c9a.junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1529-lists,linux-nilfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com,dubeyko.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@linux.dev,linux-nilfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nilfs,466a45fcfb0562f5b9a0];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 964A73075F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please test this branch.

#syz test: https://github.com/Lukaaa525/linux-kernel.git nilfs2-mark-blocks-dirty-fix-syztest

