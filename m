Return-Path: <linux-nilfs+bounces-1600-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE4UCo+FFGo2OAcAu9opvQ
	(envelope-from <linux-nilfs+bounces-1600-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 19:23:27 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7C85CD58B
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 19:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F74304EBA5
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C133D3F7A9B;
	Mon, 25 May 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kcclb7pb"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEC315785;
	Mon, 25 May 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729589; cv=none; b=hKZNGbGgjNbe7X2aY8j++Ror0rUQPTjT1pHwzKWFD8U8kofDjgzPNFMQKGC6bhDK0fy3iOV2qePELgf4yhGt8PsAzz6FU/0FJl5OJOmoJCoAilWsg5+uop3L60SgF0MCtWrxK9KI+Z5EMmIiPOugusjwSvzxNXfa+8K4Eaj4HmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729589; c=relaxed/simple;
	bh=VGVQ8aMGm4My3/ruBM3u+ImXWhMSuMDyZI/V3lJXGCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEzAqLyPLBP0dpCFkfyro/uh2COf3Iks8g21/+3B2JehqkoQHUT0sJn/Z4pa9q6cTtrxxIJNllfKSsqGhm1oGT5DTl8hMCf97DGAb9CfA++NQm+BlURYHPkXsa36ATb8iezt/ixncwgImD9XkZ+uF8IpliH0SnriKuZnxLNF1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kcclb7pb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=K9Mysa+E/p5ZR0zqdtDsekWyNgA5sQt9DHw4UugSOO8=; b=kcclb7pb1MPW8pZnR34u3UX1Cd
	OHQOvB3s6Fpu4tORpbms+bUFK/3kn48d+RWGqzxwolPkevIUUfA8Ab+9mO7s/RAxLj46Z+ZNVUmGF
	pG3vixFFl59UZZnS4HLdIvOIPx/oQ9HrWGGTFq9k2wlGO7MwTjoj19b3FugUPjMocCq1YUVobZmpt
	iYAzcDNkZCzqcJ1xruh6oS2S+6PF4vJMtn36Zx1SqyBcUnrGhVMu0S5URs2onQIQyovwvo6qy9gCS
	tbcufv/BuukTGyOHfxP0talJYgdC5wGmCMncLtMNfNP6sN7ltVYL5DwhuaPOu1uo00wX4+s1XjFjE
	GveT64pQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxt-0000000HOD3-10OR;
	Mon, 25 May 2026 17:19:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 28/34] nilfs2: Convert nilfs_gccache_submit_read_data to bh_submit()
Date: Mon, 25 May 2026 18:19:21 +0100
Message-ID: <20260525171931.4144395-29-willy@infradead.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1600-lists,linux-nilfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 7F7C85CD58B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid an extra indirect function call by using bh_submit() instead of
submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-nilfs@vger.kernel.org
---
 fs/nilfs2/gcinode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 62d4c1b787e9..f979dc9d04b8 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -83,9 +83,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 	if (!buffer_mapped(bh))
 		set_buffer_mapped(bh);
 	bh->b_blocknr = pbn;
-	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
-	submit_bh(REQ_OP_READ, bh);
+	bh_submit(bh, REQ_OP_READ, bh_end_read);
 	if (vbn)
 		bh->b_blocknr = vbn;
  out:
-- 
2.47.3


