Return-Path: <linux-nilfs+bounces-1601-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDNeNc6FFGpLOAcAu9opvQ
	(envelope-from <linux-nilfs+bounces-1601-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 19:24:30 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F95CD5B8
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 19:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABA30305BF9E
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69B63FB040;
	Mon, 25 May 2026 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pN9krxar"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBA3F86FA;
	Mon, 25 May 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729590; cv=none; b=RypP/41qHfmTNzI5PwfaPXmwTwweEt1vwwEYxeTdWSI7+MffKN0UDmI+AEJaglMnQtIAHatDMK83XKkxQOwxXKObbilEkhAJDXVTiQjZCp1fdyksEibZqHNs6iTqMhuW7J1tFIyt95Mht/UW9CjnfsXgAeWO9BmqnyK8NZrv8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729590; c=relaxed/simple;
	bh=EVXXu4sV6MscmBwHhFyKnodMspkRKKuBcdxXJSjEyQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsaPA944JydWvk/c8yzgMTzphxvKGEpHip7qHqzAfAP/geuaaowSQfIaEZxtydHOTPSwnnC6nC9gp1s3m+BmRCL9mv6RjwwrHbUYkQOWV4kfZjJrKW5GthKStFQeR0KkYt53csdUG08Yf8jjqAFrawTC3XxB2rw6dxla5yOIPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pN9krxar; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jnT5uD2/V05L39bVnpVotauKBAAXgYz3YR7yRnawO+0=; b=pN9krxarib6WIBpUXXPFPx8I0N
	G2NoOXSmzy+e/oAZRaz8+cctyLZ0i7mW0itkLE71HxB6T50BlTuh2/uyABas62MBgw6GJY5tvBmFy
	25MtWV0U3WY+AtQJaKhszFJ7D2r7kOkobFkWD+XVauXQqz0PKAa85FT/AyKDoiYv5tLvgBPQbRK1K
	husnRiLd9Agf+2RR3QnD8K3qW2yCgG8Voh/FRqFl/yOZdY5YH5anTiyce7UjzPIjypwC00Eo0iOqd
	b63PiVCDNf39NWgd4ynWOCiVMnXUCiYI3cSDO7GzMRT338yOUNPjz3TbXSVbdk6tFdMEntKdnINfW
	1IRan/jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxt-0000000HODB-20gY;
	Mon, 25 May 2026 17:19:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 29/34] nilfs2: Convert nilfs_mdt_submit_block to bh_submit()
Date: Mon, 25 May 2026 18:19:22 +0100
Message-ID: <20260525171931.4144395-30-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525171931.4144395-1-willy@infradead.org>
References: <20260525171931.4144395-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1601-lists,linux-nilfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-nilfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 6B4F95CD5B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid an extra indirect function call by using bh_submit() instead of
submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-nilfs@vger.kernel.org
---
 fs/nilfs2/mdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 09adb40c65e5..26043db677cd 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -148,9 +148,8 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff, blk_opf_t opf,
 	}
 	map_bh(bh, inode->i_sb, (sector_t)blknum);
 
-	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
-	submit_bh(opf, bh);
+	bh_submit(bh, opf, bh_end_read);
 	ret = 0;
 
 	trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
-- 
2.47.3


