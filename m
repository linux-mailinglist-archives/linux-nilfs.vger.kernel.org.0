Return-Path: <linux-nilfs+bounces-223-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E888678A
	for <lists+linux-nilfs@lfdr.de>; Fri, 22 Mar 2024 08:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3931F2178F
	for <lists+linux-nilfs@lfdr.de>; Fri, 22 Mar 2024 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68A13AC4;
	Fri, 22 Mar 2024 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vuW4jdSh"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581012E73;
	Fri, 22 Mar 2024 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092770; cv=none; b=n9lyPeGfH7a3mFNo7T36BhIJS62vFH9mptYuXAeDDpPRZDAPatn0z2uHLQAVEZbUYgYxgp0wRwowsfw3eotydlrz0cEXK3PA4wo9vZaqT75nhgSt3Nb8PvNtF516qW86hKVtNPYL07saWwcLTOJ/znQkIOKuAOj67NWXKd7tL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092770; c=relaxed/simple;
	bh=b5yh5Ro13phNND/80F3AVm8xzwC5dFx95GcRhGsDev8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sSyO0KcBp+EP/fxJ1mEK8xwLPsxHGSKUUraGxNy/XYtE/0Mb6Z21S/X7YlFY/jDQSR7P9IfFesvRgIXAYi+l92FXRouAYioShXi/QLZSKJshuy06rhdPVRYF3+07/Ev8btRX6GgwvEFdPxqwYFm5moDpLIUnJSh0ubTeiBbwgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vuW4jdSh; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711092766; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UgPpTlkFL1H9yfrCsS8ILprwfmX7hK7UbK0sXPD5zGk=;
	b=vuW4jdSh97bi4w+spWKjNeFDgTR1MIRl6wdnWl5HT9n1F/dGWXvaDrWf6JTHBorv0jzLQ1xhWl1a5UGHefvPHmPq/WoEp7Jz7iPSdDZHU0tYJGTIQ5D+ZtiOw9DAoqwxLz9cfEjBMgE2qEtDbmBcKvwsoGSFO1CxJaihf1d1kr4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W31DHWD_1711092764;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W31DHWD_1711092764)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 15:32:45 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: konishi.ryusuke@gmail.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 3/3] fs: Add kernel-doc comments to nilfs_remove_all_gcinodes()
Date: Fri, 22 Mar 2024 15:32:40 +0800
Message-Id: <20240322073240.91639-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240322073240.91639-1-yang.lee@linux.alibaba.com>
References: <20240322073240.91639-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function nilfs_remove_all_gcinodes.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/nilfs2/gcinode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index bf9a11d58817..1c9ae36a03ab 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -175,6 +175,7 @@ int nilfs_init_gcinode(struct inode *inode)
 
 /**
  * nilfs_remove_all_gcinodes() - remove all unprocessed gc inodes
+ * @nilfs: NILFS filesystem instance
  */
 void nilfs_remove_all_gcinodes(struct the_nilfs *nilfs)
 {
-- 
2.20.1.7.g153144c


