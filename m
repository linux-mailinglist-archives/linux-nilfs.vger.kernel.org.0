Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA47EABEE
	for <lists+linux-nilfs@lfdr.de>; Tue, 14 Nov 2023 09:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjKNIqe (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 14 Nov 2023 03:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjKNIqF (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 14 Nov 2023 03:46:05 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A6173F;
        Tue, 14 Nov 2023 00:45:57 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso3798198b3a.2;
        Tue, 14 Nov 2023 00:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951557; x=1700556357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xisVeqpy2L7XrdO22Kj0Z2SYhUle5QFc64kz4XqShlg=;
        b=PpXiegtXxKV3CBiT6z6b7ityetE/cQBX81WCX2Pu0zTIrkYLrazHOsyuYxxsbCIcDh
         Kbg3uDWKK1aQamQa14hz/lSB8eEF90JsjSxwL/VBp6T1LmARfyfKZ2JE4+0WCtTAjUDO
         ZzMyiRR2us/EdmNfI/Ruve6Den/HZRLYUqxA7XsX9IaiDv1YKGf724+ZCuPcS0ZFyf+v
         8TjHmlqsfHT5Wfc1jEqwahS0hwLQHL9S0HOlnwuvCC9yZjSNA2Bn+mc9mv3hvkUA6slr
         D+GGysVa8TdvUGzNvwtajLAjooAN1Qttdrq/e6EFbAs1eFvL1FEqyIRdJ6SinizHuMqZ
         jH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951557; x=1700556357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xisVeqpy2L7XrdO22Kj0Z2SYhUle5QFc64kz4XqShlg=;
        b=w9+Vk55qCUpTo1CvqW5XYxucKsjujXuOij1UCqcDTFF7TIp+Q9JuNEDh6frw7X9lHS
         3QfjD5Bfe7LjXsn+pWI18QeBx02qwPl2OtygGu8uBblTqTNJ4a8mMPTw/pUwWgFwGzv7
         nQ1hxbcOL88uqjnw8WlUTH74Ga4ctw1ygUXoVLieL7fOf8ZeBEQM/ZBTGbLz/9JFVIt7
         yxHqoJGa8kZ3nRnaqubOfW750zWg1wYfegsAnDil7fqKgQpYXcztmFdU1SlpdL0cvq+m
         Iq2aZXGNRt8YN2/We74objCwyoD9eR73JJNMBZ5SEqNzxcp7TSEMFBI1wd7zu2jKkQ/+
         itRg==
X-Gm-Message-State: AOJu0Yw3+7wkXvqLPFJgN52ZY5fw4bA/1HuT69KnoX3WDuO578tJ29Du
        0umi43xT0MZ3vcarXUloAYEBkgQrWNY=
X-Google-Smtp-Source: AGHT+IEXGX1kjcfI5Y6JVcmLn2dKdb2xMoZv5eLI5dPWiNAzGiOPQsOpjk4FfL8GEZThpsJwf8IwYQ==
X-Received: by 2002:a05:6a20:12c3:b0:16b:c20d:f979 with SMTP id v3-20020a056a2012c300b0016bc20df979mr11331159pzg.13.1699951556883;
        Tue, 14 Nov 2023 00:45:56 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:56 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] nilfs2: Convert nilfs_mdt_submit_block to use a folio
Date:   Tue, 14 Nov 2023 17:44:29 +0900
Message-Id: <20231114084436.2755-14-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
References: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Saves two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/mdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 7e4dcff2c94b..e45c01a559c0 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -158,8 +158,8 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff, blk_opf_t opf,
 	*out_bh = bh;
 
  failed_bh:
-	unlock_page(bh->b_page);
-	put_page(bh->b_page);
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
 	brelse(bh);
  failed:
 	return ret;
-- 
2.34.1

