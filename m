Return-Path: <linux-nilfs+bounces-1652-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QIXhCRyyTGozoQEAu9opvQ
	(envelope-from <linux-nilfs+bounces-1652-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Tue, 07 Jul 2026 10:00:28 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6EE718CDA
	for <lists+linux-nilfs@lfdr.de>; Tue, 07 Jul 2026 10:00:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C4y1fx7e;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nilfs+bounces-1652-lists+linux-nilfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nilfs+bounces-1652-lists+linux-nilfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28284300DEC2
	for <lists+linux-nilfs@lfdr.de>; Tue,  7 Jul 2026 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEC127A907;
	Tue,  7 Jul 2026 08:00:24 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C0DDC5
	for <linux-nilfs@vger.kernel.org>; Tue,  7 Jul 2026 08:00:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411224; cv=none; b=EY+kV7URF+HFYivJH/kGW8X4h2+RqdPOEgA8vIVGO63H9+xAe5oJPhcWFiyK4/dvi6NaXiu5MiOhbUvrbpzU2AufDvwgDh6O3YgDaEdwlKeUxeTxWCjUBxIuV8yXZlLZgp7t4F3dQfrfVARm8Fmkae0sTNevlDgo+7huUEcLmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411224; c=relaxed/simple;
	bh=ryDOfNlRaRGYN/Wt1BnJsasdKDRXWgRly1+2in/xZ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaP8CTwqX5+Hs6A5I/GsJlP72U/65MPlCI+jijul2gbyzehcfhsKrfGZe5aZ7kKoLdzTPbCBpoHjHiAjQO5FglDDAJdMhRuCC6hiun39dBA15p3MGKF0JXAvVezYpKrxbTPFrrScJB5ddYfc9AvlLZxExrJVo+zXmcrvx1gkfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4y1fx7e; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso3071716a91.0
        for <linux-nilfs@vger.kernel.org>; Tue, 07 Jul 2026 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783411223; x=1784016023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ensxtyL2InlA/bA/hJQoV9ROy5P1Zvl3hy+zcR+oqY=;
        b=C4y1fx7eoBJwOCi1XdKRzV5rJSsFXg7kP/Ey7tDnGX+05f2B587XcOfvjyi+6qMaI1
         gPVmkpYB7jxhDrtIokDaGGNMDmjg6uA71DMjB39aEEnDBFK6Eeu4bZpIt75m5gKpeGAq
         iOTrhL386sKt7YDAp6AdOGAMo6loHSOOnsN/RfP7Vv75uaS/USGTueTzhUpdkd03EESL
         0yIssmy+LkiRbPied+fCitmnHLoHf/aqFHF+sgjarbqCv0kxN49Bc2ni+PrTo+++fkxv
         Vwet/I13a/XpiTKVPQNHiABnIq0XO0+0t1R4Sz9bp5weXfFJKLrnqPhYqcaz5Maeuvbs
         2i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783411223; x=1784016023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ensxtyL2InlA/bA/hJQoV9ROy5P1Zvl3hy+zcR+oqY=;
        b=gPPR6SSd5azV4vP5/R16NJtpZ6tzVeqEUmU2p9qPIZ3iSXL/VI+HsliKWrVcKrLC+i
         isDFMSK0yHyCr7lDrH1E/eYPoS7ertWjeQdrrhcvD286tA/bm0kRQa+OQ6qp1E+Rcw3f
         7To0umepsfN3AD0iHGSTG+IE1iOAwiZ/TfGkOEmIcv8rxFf48o+2g8wLz6L0dgRpKbcP
         J6QNRkMe6X2aDpIja2z0jHbCyvec1rZJIsMOM0XNBzrZubJgC4pUe/23zipIcwEGSfw4
         qMYnyeBA7cqpIESnAOwXHMhjBTAiP6Jv65LM2mBXTY7zUK+FvslSFvq6TJXcZd/5qR7I
         5hPg==
X-Gm-Message-State: AOJu0YxeadisYjjSSEGd1QoNvGhTrHCVXvS4LkUJ6YC3KPufxPZXXswC
	XKyUMya7pqNgtCC61N2HcN6XRd6S+1ia6z5+81LjWIA/I/UTcaV+dqHA
X-Gm-Gg: AfdE7cmTNNKc46hHrZEx98d9iCBvYBf4B7eDkquBoT63K5fMlW890Uu7sAFKu/HAOjq
	lN0jEUnL5/aHjZSx3YgnSw1s+DvblUfwx9c0nhTgizLEXlSArYHFlKwWGzK9/vKpdars4QDIZBh
	EuChhJnwZwHmBtzIFwr2xhVhujLUwWSnflWyHje43wMYt5rx+TDZOT/PBYChzjWAK0az/KFKthF
	qvGKLxGFH0C+4iFcuwOV8NLv/TzOFJIKIhPny5bkE05zc5kPoScb8TNcOKa/PR1U3NuFCjrqXBP
	WHdr/rXzrY+jqlvTJO8VsphELOrzoLKCxSXH4R/zDJ9gyQxJ1fyYAmBatG1Onr+KJu2GvFvDnCE
	2EzEyFZQMcQbJLFRboJrFpbCVCSSiEnAXs5I6NZwJchVaqjB+w9GGwdJqSYxKzl+fcIJL2FK0/b
	rWKI3Q2TuPfDLSdoUAZ7J4KBWe9yrR6o4Dd4or0wXggMZgq230NqZBefgG
X-Received: by 2002:a17:90b:5292:b0:381:23d5:693f with SMTP id 98e67ed59e1d1-3875806236fmr4349519a91.28.1783411222720;
        Tue, 07 Jul 2026 01:00:22 -0700 (PDT)
Received: from carrot.taila25129.ts.net (madb688455.ap.nuro.jp. [219.104.132.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d36676desm643964a91.10.2026.07.07.01.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 01:00:22 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	syzbot+79b815da3aec0a6a4d02@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH] nilfs2: handle corrupted checkpoint count gracefully during deletion
Date: Tue,  7 Jul 2026 16:59:41 +0900
Message-ID: <20260707080019.21550-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1652-lists,linux-nilfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:slava@dubeyko.com,m:linux-nilfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+79b815da3aec0a6a4d02@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:igorpetindev@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[konishiryusuke@gmail.com,linux-nilfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,googlegroups.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konishiryusuke@gmail.com,linux-nilfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs,79b815da3aec0a6a4d02];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE6EE718CDA

From: Igor Putko <igorpetindev@gmail.com>

Syzkaller reported a kernel warning in nilfs_cpfile_delete_checkpoints()
due to a corrupted checkpoint count on the storage medium where
le32_to_cpu(cp->cp_checkpoints_count) is less than the number of
checkpoints being deleted.
Triggering a WARN_ON() for disk image corruption is suboptimal. Fix
this by returning -EIO and reporting a filesystem error via
nilfs_error() instead of interrupting execution with a kernel warning.

Reported-by: syzbot+79b815da3aec0a6a4d02@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=79b815da3aec0a6a4d02
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
Fixes: 1f5abe7e7dbc ("nilfs2: replace BUG_ON and BUG calls triggerable from ioctl")
Cc: <stable+noautosel@kernel.org> # Warning suppression primarily; will request backport individually if needed
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Viacheslav,

Please apply this for the next cycle.

This fixes a kernel warning and a missed inconsistency check that could
occur with file system images containing corrupted checkpoint metadata.

Thanks,
Ryusuke Konishi

 fs/nilfs2/cpfile.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 4bbdc832d7f2..d3349fa58abe 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -81,18 +81,26 @@ nilfs_cpfile_block_add_valid_checkpoints(const struct inode *cpfile,
 	return count;
 }
 
-static unsigned int
+static int
 nilfs_cpfile_block_sub_valid_checkpoints(const struct inode *cpfile,
 					 struct buffer_head *bh,
 					 unsigned int n)
 {
 	struct nilfs_checkpoint *cp;
-	unsigned int count;
+	unsigned int checkpoints_count;
+	int count;
 
 	cp = kmap_local_folio(bh->b_folio,
 			      offset_in_folio(bh->b_folio, bh->b_data));
-	WARN_ON(le32_to_cpu(cp->cp_checkpoints_count) < n);
-	count = le32_to_cpu(cp->cp_checkpoints_count) - n;
+	checkpoints_count = le32_to_cpu(cp->cp_checkpoints_count);
+	if (unlikely(checkpoints_count < n)) {
+		nilfs_error(cpfile->i_sb,
+			    "deleted checkpoints count %u exceeds block count %u",
+			    n, checkpoints_count);
+		kunmap_local(cp);
+		return -EIO;
+	}
+	count = checkpoints_count - n;
 	cp->cp_checkpoints_count = cpu_to_le32(count);
 	kunmap_local(cp);
 	return count;
@@ -522,6 +530,10 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 		count = nilfs_cpfile_block_sub_valid_checkpoints(cpfile, cp_bh,
 								 nicps);
 		brelse(cp_bh);
+		if (unlikely(count < 0)) {
+			ret = count;
+			break;
+		}
 		if (count)
 			continue;
 
-- 
2.43.0


