Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16B47E0879
	for <lists+linux-nilfs@lfdr.de>; Fri,  3 Nov 2023 19:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjKCSuM (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 3 Nov 2023 14:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKCSuL (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Fri, 3 Nov 2023 14:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F632D52
        for <linux-nilfs@vger.kernel.org>; Fri,  3 Nov 2023 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699037362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RpbYT9SzTc/xmcrawP8dennNWLPo+v9u/X8zga55vvs=;
        b=CSyApGAPZOReeFC1deLqn0wybNy7BQ7xHyFSTXMMGyJtq4Ugw7zfF4eZSzh8U4fss7cPtU
        ilQw5ZEyVfVA1V2Z+epREjoXpHFRMN7nbbCmLN5BKWqlus5ndL4CfM3UfEWHCgT3EuYJFw
        3IMrOyiB3TSR6vWC8mUj2ognN53Nnb0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-LSBF0bC1N5GBX9ZC9yM17Q-1; Fri, 03 Nov 2023 14:49:19 -0400
X-MC-Unique: LSBF0bC1N5GBX9ZC9yM17Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9dd4e40349bso14860066b.0
        for <linux-nilfs@vger.kernel.org>; Fri, 03 Nov 2023 11:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699037358; x=1699642158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpbYT9SzTc/xmcrawP8dennNWLPo+v9u/X8zga55vvs=;
        b=spjipIAgVjZlPwvF7Up5Y/y4CZeZ/vBHVqAgKeeID8lF412XmPF8zgx1fMcAbVRoMQ
         vPuUpj7FaRAz/5r8uWKnl5/hc6WLVhg/QW6Agxl/iy1dEhR3R70QE8Zayklt8/O+dYGM
         udEmeqXVFB47T9/0rih0OWJsIZ7AJ5k2tYuCvcEGT+Zosup2v5M+WaQ1iPsY54wxT1mb
         pqFkyaKJwANaAiHNgFriJIT1rMtzMwIedBLCvjSZkS9Z0SWSGEeBYvRSQBsbOMvCNvCf
         9kTkGA7lYsJGStkw7m/rQG8giCPWOv1u++T1o9ZV3hUp67UhXjQnL1hia5T1BdDxqFTt
         WQoA==
X-Gm-Message-State: AOJu0YwcWOnp8QL5BMfwVEfdlMk3wlVWVjRSUk/drOdvtX+vEfAP/sSi
        xELfpJ6Vf6l30YARmNV/gNOYbuo199CXsArDoZtcWZCHYgmIex8/gdAvbpCrubto4gapVDPq+Wc
        H1okve+gcZq6BfrP6yI8ZgOqotI/HVSwjRg==
X-Received: by 2002:a17:907:7e92:b0:9b2:bf2d:6b65 with SMTP id qb18-20020a1709077e9200b009b2bf2d6b65mr17287372ejc.4.1699037357976;
        Fri, 03 Nov 2023 11:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr56jYMAaIdUBHapGDiUsxpOD0wl3SxAYzOKNd70AAZbwIT8wq1IAkOYVVvUoqEPOzb+kzSQ==
X-Received: by 2002:a17:907:7e92:b0:9b2:bf2d:6b65 with SMTP id qb18-20020a1709077e9200b009b2bf2d6b65mr17287358ejc.4.1699037357636;
        Fri, 03 Nov 2023 11:49:17 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32d1:5200:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090608c500b009b29553b648sm1163679eje.206.2023.11.03.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:49:17 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] fs/nilfs2: use standard array-copy-function
Date:   Fri,  3 Nov 2023 19:48:32 +0100
Message-ID: <20231103184831.99406-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

ioctl.c utilizes memdup_user() to copy a userspace array. An overflow
check is performed manually before the function's invocation.

The new function memdup_array_user() standardizes copying userspace
arrays, thus, improving readability by making it more clear that an
array is being copied. Additionally, it also performs an overflow check.

Remove the (now redundant) manual overflow-check and replace
memdup_user() with memdup_array_user().

In addition, improve the grammar of the comment above
memdup_array_user().

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Rename + rephrase commit so that it's clear that this is a
  cleanup-patch.
- Mention the grammar improvement of the comment in the commit message.
- Remove the preceding manual overflow-check, since that is now
  redundant.
---
 fs/nilfs2/ioctl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 40ffade49f38..cfb6aca5ec38 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -872,16 +872,14 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 	nsegs = argv[4].v_nmembs;
 	if (argv[4].v_size != argsz[4])
 		goto out;
-	if (nsegs > UINT_MAX / sizeof(__u64))
-		goto out;
 
 	/*
 	 * argv[4] points to segment numbers this ioctl cleans.  We
-	 * use kmalloc() for its buffer because memory used for the
-	 * segment numbers is enough small.
+	 * use kmalloc() for its buffer because the memory used for the
+	 * segment numbers is small enough.
 	 */
-	kbufs[4] = memdup_user((void __user *)(unsigned long)argv[4].v_base,
-			       nsegs * sizeof(__u64));
+	kbufs[4] = memdup_array_user((void __user *)(unsigned long)argv[4].v_base,
+				     nsegs, sizeof(__u64));
 	if (IS_ERR(kbufs[4])) {
 		ret = PTR_ERR(kbufs[4]);
 		goto out;
-- 
2.41.0

