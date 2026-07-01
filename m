Return-Path: <linux-nilfs+bounces-1646-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id twlhBEpzRGr0uwoAu9opvQ
	(envelope-from <linux-nilfs+bounces-1646-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Wed, 01 Jul 2026 03:54:18 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD96E91DA
	for <lists+linux-nilfs@lfdr.de>; Wed, 01 Jul 2026 03:54:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=Y7Gh2Rj2;
	spf=pass (mail.lfdr.de: domain of "linux-nilfs+bounces-1646-lists+linux-nilfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nilfs+bounces-1646-lists+linux-nilfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B6D304A8D8
	for <lists+linux-nilfs@lfdr.de>; Wed,  1 Jul 2026 01:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3E3612F4;
	Wed,  1 Jul 2026 01:54:14 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBE40D574;
	Wed,  1 Jul 2026 01:54:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870854; cv=none; b=cVJVctQ5jyAPHnAgYfxkVdEWT5NEe9rXzICS12U6FiEYDbx3ePV7UuwTiY/4QzxoWEwAL1jKmWkNJ7lH6V4UbakPGvDSSwkYFKWUwCaKc00oztolyYaQR7vG6g95ksD6qFs2H2+AZJjH38TYLDhd43YeIayoVRHpt3i5X5cOJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870854; c=relaxed/simple;
	bh=BIOqsPGQCvayLCeKlSTWaFtZw7q1oLWki08D5HMCWeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPyETa1FYXW0NpQfZ0BPhNCwbqL3emMD/mHtMQirIeDn3EH7j4QZlyP/6gL93YL+u3Vupg7URWjfWWQhf1TDdmAY5iBZRIgAEJMLL6dJE0UN9yJvyiKItAeMiEMxKnratqpv7hhHQelqQ3inUfqrmaoJzbqsce+NpqGhaJv3L2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Y7Gh2Rj2; arc=none smtp.client-ip=54.204.34.129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782870804;
	bh=sw2k2+7CqopSkda2wguNtx1pNBLBcyT7y6YRFs9aCYc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Y7Gh2Rj2cQJK9IkJifdHVxmEl/nsekt1WsV7T7YNyF4iuWZBJcDYSz+s5DsH9GfyK
	 3lO2FpgQUln2ynCS9kTDMkt3paFwFquf89LL5wfertHC1IpKFGFZhrZvwrZuT2AEGV
	 Npxndgc0mnAZSsElNkBUcD1aK/mGL6x9JX1AEAWw=
X-QQ-mid: esmtpsz20t1782870787t405d38e2
X-QQ-Originating-IP: Zwhbe/SmZQw4Ewur99zckmBV0s8i4kmQW7pFouGcBrs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 09:53:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1077355903454823753
EX-QQ-RecipientCnt: 7
From: wuyankun <wuyankun@uniontech.com>
To: konishi.ryusuke@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	slava@dubeyko.com,
	syzbot+c37bed40868932d790e9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wuyankun@uniontech.com
Subject: Re: [PATCH] nilfs2: prevent double insertion of b_assoc_buffers in dirty buffer lookup
Date: Wed,  1 Jul 2026 09:53:05 +0800
Message-Id: <20260701015305.970002-1-wuyankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAKFNMonk0BDe3PcNdu7ZvSitO1U1TFEvj9mLXAdBK96fCnBScQ@mail.gmail.com>
References: <CAKFNMonk0BDe3PcNdu7ZvSitO1U1TFEvj9mLXAdBK96fCnBScQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MD5XEDocxEOL9wP0kXehm5V4n/dr6CyOsC/JSnGrWnPqXd73aJaGgrLs
	wD72XRjV8xrRhFqRq/oufYWPTsGihvIfbQ7mv63x0d/4EyGRiSMqTqidRBwJDHoodZEMErp
	cBTtI0rmDRbfSqgiUZpjnJ6fYLt71e2Wdr7KT5jBj1M4eajFFUBKYDAM+th4TiIEB3V3oV6
	WhUTWgKQm73DzR3RXBwE6shA4xgdQDNMi8Cd6X/wdoO0HuGpM/RAbpkDeuOqhvi7jLrz/SK
	Zw4ajkQA3stNRDTbdae0dVOXdDabks6GZzAgbPOVeZ9PDi4I8yJQLYUuntxHsTxcYwPX+wY
	RdUNdKBemc7nt09brrwHzAVwaX/9VzAZ0qonkeKCoELBpdq8zf6snG4ssRGGb7pOlY9YLo/
	RiKCLpjZ4eAlUU7JJTkHo1k4m3Kk4VGgqUeloJL6XMp+cvTuVukKQ1j60c7nAwfzRO2keHu
	hBoalrT1OzbpT32Nh83ton3Qza5pf0xxb7cFF6BlJlY5PY+tBbpZg6QUKpsJYp7/9AaBWdq
	hL712iqUEJU6oln3p4Ai3Vl5T8RZr53y93llmOQWloeKjoTrE6ZPoJ0zWhtXY0+zL0R5PzZ
	9bSILs2RNuclZEZ8B7cPby5jHw06O8K8sgr9apA2S5yT3CHAmZCBLpnJuPFaJN5SLLiuo1v
	hC8s75gFXX8leUhoAm483yIm4uksGr33qFyFLtaToNSsyfg03rYxHhTeIQTXXmSeHsF7E/2
	bJfAxmU9c68lGKSabNeCfj2x3svoaoJfP1BL2GCRmL6SHXmsgVESVG2TcP7rJ/pW9toX5+m
	lpnFjEwlJ1DSZqwU9HFkL3yo7XDSk+o956yHvJcIO5EG+Rtm/g29+VFV290qhQn+0ALSr88
	tYIHpbQYA7I2LqWJPU8ymLEcHzkJlNCiAI7mCH4B5fjxsxMkdh5WwF5Me8YwK+ucEUJ9nJ9
	PFOBJ7rrJ7QJSLrhsConRchM1Nk1Nxf7r1hu1/72D9ZOUC5SYkysNnXO7wtFPZ0f9Q7UEx2
	yPkcaIBD63JrAPH7iK
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1646-lists,linux-nilfs=lfdr.de];
	FORGED_SENDER(0.00)[wuyankun@uniontech.com,linux-nilfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:konishi.ryusuke@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-nilfs@vger.kernel.org,m:slava@dubeyko.com,m:syzbot+c37bed40868932d790e9@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wuyankun@uniontech.com,m:konishiryusuke@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wuyankun@uniontech.com,linux-nilfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs,c37bed40868932d790e9];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6DD96E91DA

Thanks a lot for the detailed investigation and for clarifying the actual root cause. 
That explanation makes sense, and I agree that the proper fix should be a bounds check 
in nilfs_ioctl_move_inode_block() rather than masking it in nilfs_lookup_dirty_data_buffers().

Please go ahead and handle the fix patch on your side. 
I appreciate the help and the clear breakdown of the issue.

