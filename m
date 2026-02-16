Return-Path: <linux-nilfs+bounces-1132-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIVnDIbikmmrzgEAu9opvQ
	(envelope-from <linux-nilfs+bounces-1132-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Mon, 16 Feb 2026 10:25:26 +0100
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E3141F1E
	for <lists+linux-nilfs@lfdr.de>; Mon, 16 Feb 2026 10:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D2B300B057
	for <lists+linux-nilfs@lfdr.de>; Mon, 16 Feb 2026 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD5285C9D;
	Mon, 16 Feb 2026 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sLAZlM6U"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666828B4FA;
	Mon, 16 Feb 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771233921; cv=none; b=Avw55ZCgmJxnWeCPNPuXs041ykqGD4p5fuok1P6k4BIR3zp/dNpLgQqQPYw0H/ZI3r1mCXQzn3oaLfSHlbbxQEld/SMA2JQIYMB1ZcBiaDpTNCrwy4W+9i1fP0v1wi0o4KQLSJ0cXxvoRQfDDinsW6ApODJAqEPSuykJOPg78bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771233921; c=relaxed/simple;
	bh=teVpk2XZW67wfkZQ1XKSJ+AuDGNe6REwyeDEOoqWHE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GpjPjIKJ538jBaEi7KlQNT6VGrH6Z3uUAlMbmNyvS9F1Ip2TZKeQDVpnm5aYfxC5DVVs4wWOd41p5d1UGiLynUyzb7r80j5SOs6gcw1U+fV2s2u0x0pkHrNLYLDYreNGn/NPw8xLIHiATk6HC18d40qFXTR+r0YqMJbSLpQ6Ub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sLAZlM6U; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771233920; x=1802769920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QBXQKckpKtA9xxZeWDZVrxYkoL0OJsfPg2X+lblSyqM=;
  b=sLAZlM6UMZTF4C8SF6iautbmV/iPHRTIzPdtmH6cu4s2XYFphxo0Qnm4
   22DCETnoJkfvpzobXA+V/VGa8ZfTDAYBR1adMpoh0zoKlymZJG6JeiV5P
   fmGKNWisTCsJtaxtqe4hkPEmZm1GsUEZi4Hq/fM/TS/6PuyibCrvGLjYi
   T35bDdxaQCW7hAKPxsNs8QYbYabQc2EgiwBdSk0BD0nKB/m95hD5L87pK
   0OG+JiE0NkLFAgYBXF6WVCMXPWk5zgyzJMq7OBXebV7dqctnWV1JvQRi0
   ekxxngVY+3ypyBMtpY0f2q1ad8vGxKQSjRhqhjTPgy6WR62L1nltZr2EV
   g==;
X-CSE-ConnectionGUID: +17Sc2rbRA6/UJ/TV4E+qw==
X-CSE-MsgGUID: SxbjeGP2QvOm9ED6TlD+Lw==
X-IronPort-AV: E=Sophos;i="6.21,293,1763424000"; 
   d="scan'208";a="13142021"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 09:25:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:29428]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.39:2525] with esmtp (Farcaster)
 id 628fd057-29ea-4936-8409-59d678637773; Mon, 16 Feb 2026 09:25:16 +0000 (UTC)
X-Farcaster-Flow-ID: 628fd057-29ea-4936-8409-59d678637773
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 09:25:15 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 09:25:14 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko
	<slava@dubeyko.com>
CC: <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yuto Ohnuki
	<ytohnuki@amazon.com>
Subject: [PATCH RESEND] nilfs2: fix i_xattr comment to note it is unused
Date: Mon, 16 Feb 2026 09:24:47 +0000
Message-ID: <20260216092446.5596-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1132-lists,linux-nilfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,linux-nilfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nilfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 607E3141F1E
X-Rspamd-Action: no action

NILFS2 does not currently support extended attributes. Update the
comment for @i_xattr in struct nilfs_inode_info to clarify that it is
reserved but unused.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/nilfs2/nilfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index b7e3d91b6243..41b8b42be21d 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -27,7 +27,7 @@
  * @i_state: dynamic state flags
  * @i_bmap: pointer on i_bmap_data
  * @i_bmap_data: raw block mapping
- * @i_xattr: <TODO>
+ * @i_xattr: reserved for xattr object (unused)
  * @i_dir_start_lookup: page index of last successful search
  * @i_cno: checkpoint number for GC inode
  * @i_assoc_inode: associated inode (B-tree node cache holder or back pointer)
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




