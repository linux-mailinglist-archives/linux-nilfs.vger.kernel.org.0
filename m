Return-Path: <linux-nilfs+bounces-1272-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CdPxOd5qommY2wQAu9opvQ
	(envelope-from <linux-nilfs+bounces-1272-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Sat, 28 Feb 2026 05:11:10 +0100
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC91C03EF
	for <lists+linux-nilfs@lfdr.de>; Sat, 28 Feb 2026 05:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E65E303DAA5
	for <lists+linux-nilfs@lfdr.de>; Sat, 28 Feb 2026 04:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887D33ADB3;
	Sat, 28 Feb 2026 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kvxRBJTV"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3E930274D
	for <linux-nilfs@vger.kernel.org>; Sat, 28 Feb 2026 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772251867; cv=none; b=jQtSA4nkhuWzbXRJXkiDjcPL0bfhQRdQAvezvnlwgEeCU6g6VmXZseJOuBsYrEm/xm6XxJjkcHpgTIPYO0ZDc6ptnIT3bEoviD7/QO5s2PLdv3BfkLxuIiQM7iTk47boFZKVC7LCBcfjxrR1ugrGKeXB/S6Vnd0wSdzoPsyYDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772251867; c=relaxed/simple;
	bh=plyVn+BKfoyL9u0QhzlEuFxYs62Qofix5INAmvZbgaY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bLxrxbtOnB7Ul0JYyeNP1EzmwE+gB9WPxS3zgS79QXioRBAt5AYjZXeIq1KCVf1hf+DELKKOcDcaN3SS45soypJQxxaj6kHJtZW5TnACnesgMEgY500VY+a+48Af36LxJ5fjsdOsLFggPZke6BeXpM4LHsAlSykHZVwZ2lcpGp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kvxRBJTV; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SGDrRcmOhvI7U5Idyqp+usjzvWo8orTDNcE7eLcziwE=;
	b=kvxRBJTVpuiDyhuduxdlQaYjEIOFA3r6t3cNUL0MLYvnC/VNMw7L0VN2WK1Oq/Std+C9aIgqq
	IBYEB6+Mj57q9DcK5ICpD+mP4CdryzqDEixmajHU0qq0x0gXcIbW0YQwr/odqTxOnNAb5W+ye5F
	XWOz6aEQ4txWBEE7aOlLen0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fNBSv2Z0dzRhTB
	for <linux-nilfs@vger.kernel.org>; Sat, 28 Feb 2026 12:06:07 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 25B4140569
	for <linux-nilfs@vger.kernel.org>; Sat, 28 Feb 2026 12:10:55 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Feb 2026 12:10:54 +0800
Message-ID: <a7212afb-29e0-45ba-b349-b5ab86d5af63@huawei.com>
Date: Sat, 28 Feb 2026 12:10:54 +0800
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <linux-nilfs@vger.kernel.org>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
Subject: subscribe
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200016.china.huawei.com (7.202.181.9)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1272-lists,linux-nilfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangjianjian3@huawei.com,linux-nilfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nilfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06BC91C03EF
X-Rspamd-Action: no action


-- 
Regards

