Return-Path: <linux-nilfs+bounces-1617-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIdvEqN8GGrbkQgAu9opvQ
	(envelope-from <linux-nilfs+bounces-1617-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Thu, 28 May 2026 19:34:27 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA295F5AD7
	for <lists+linux-nilfs@lfdr.de>; Thu, 28 May 2026 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A33003028271
	for <lists+linux-nilfs@lfdr.de>; Thu, 28 May 2026 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2D0401A33;
	Thu, 28 May 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bMyT9hlX"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A43FD96F;
	Thu, 28 May 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989522; cv=none; b=jF/V5/HLPU5w35gYSqi2DaVxI1TGm3wRCV+FJk7EbjXIy/l5RzFEQKCqH2FqCOcKjhhOQrzPrP9Tib9rg9TSdnubal4I+a8fyfrYu3nyC41owRO0Yr95CG/zyBfj+eYpUbbWpox7KtesU4m8QA9CNQpWXhHhY2kVIug161VYk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989522; c=relaxed/simple;
	bh=KPAr8K4CKrrGmK+A4WvnoSRSFyks73tRLEV+b/q6+vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEE+3gaoXbCncl0fLXJD8dXEGvd5M2MnXYDd4+tkOgP2T6E2kp7xRObc1HGWQ+HUQXekLMbE7kK+R/rficHiQqx7G6VqYCowp2JLaSHJMDiSEVPFAZEen7EHEXbAOZhXk0QnNhhu7Ra8amlhGmmM8P6svf4GOlwZMqiXAA1B/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bMyT9hlX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=liX/fYf+smhQAD7rxwtQGc+NUg2STk/wQND3GuZuy0k=; b=bMyT9hlXapfyb4HweSBGc8r8MP
	YLsgxmV/d+oP9kyz3WZFYa8rtHMPcUyOTnGXayByPohhAOHCdsSBSsC0k4eZaMzRKjRRJ6PF8RveB
	CPDMBiQzIHlhfN23rHRB45mNUhzKQkiE44WmGUDb16uZdlVBs5HDEjrgxfgODL4Pu8iq4D/7sasij
	E9DEhhc3nWkQ5XWbsrW7vGGuf7lQfYKadNj9uTIN9Fo9lxgz0L6kGOxSkNocI3sem8Sz+2/Zi8J2j
	RjzDAvd1jcI+xdpOlsWXmGRVEiu54/c4IeboupzThsvROOXw4nOcc+wVaXmQ3es6xvnxTRaO7wWSc
	m8T+rubw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaL-00000004abF-47Xn;
	Thu, 28 May 2026 17:31:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH v2 29/34] nilfs2: Convert nilfs_mdt_submit_block to bh_submit()
Date: Thu, 28 May 2026 18:31:42 +0100
Message-ID: <20260528173150.1093780-30-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528173150.1093780-1-willy@infradead.org>
References: <20260528173150.1093780-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,vger.kernel.org,dubeyko.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1617-lists,linux-nilfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-nilfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nilfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:mid,infradead.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5FA295F5AD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid an extra indirect function call and changing the buffer refcount
by using bh_submit() instead of submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
---
 fs/nilfs2/mdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 09adb40c65e5..2a435349fd21 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -148,9 +148,7 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff, blk_opf_t opf,
 	}
 	map_bh(bh, inode->i_sb, (sector_t)blknum);
 
-	bh->b_end_io = end_buffer_read_sync;
-	get_bh(bh);
-	submit_bh(opf, bh);
+	bh_submit(bh, opf, bh_end_read);
 	ret = 0;
 
 	trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
-- 
2.47.3


