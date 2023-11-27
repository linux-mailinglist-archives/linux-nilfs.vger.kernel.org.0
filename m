Return-Path: <linux-nilfs+bounces-37-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23457FA2AF
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 15:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8BDB21127
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6B31747;
	Mon, 27 Nov 2023 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw9jDzfc"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F56BD4E;
	Mon, 27 Nov 2023 06:31:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfb3ee8bc7so16410645ad.1;
        Mon, 27 Nov 2023 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095462; x=1701700262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d7tcqdMYU+NIu4RxF41sEaUndQSw2DoYo4hopYEA8w=;
        b=Lw9jDzfcO5WwCkgN8ONaCbNWVhsbAvekvVKZcIjQoUiE9FfYcOONuKZY056OKpW3v7
         IENEfEnMsccKUatjG3AVzMoLcf4DuLB+dGl5jmehqCEdksCsaxdC86yqCUuJtVrqxxU0
         XpyPbkEDI9/ouSGWUoVd1IRIMONx8ym1OAOfErcPddirgQLUKXinbxiTyHDHpByCJ4MD
         V949yjyvlAoy4rflSebQSjPAep3aOq6MyE03ayPQpvxFFTLNu2aldc8Vfs76velUn5X8
         ll77DRrNuaOROQkK70zeKV7l+6gcSBhvzy2b/BHDg5rnAFd54+ZYHt7lsmAgzReMHlX+
         +Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095462; x=1701700262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d7tcqdMYU+NIu4RxF41sEaUndQSw2DoYo4hopYEA8w=;
        b=N6//HMVubi3AMG7UxR1mnew+a0glSA+9biatiE6HHlWfEf/yRV7N0sOHmMaK9w8wx4
         VHApIwVcMl+LbWtmcctWOp5U7razjWh38uwj7180upve70D6VOzfovBHlmkKSoETsSZv
         PkMWFsAT992bRkIA1LigDEKwr6JLcTMtABQspdtvs1boKZLkOYnKeJKEdwocwpNG7Cps
         U9eo0LrdKIQsD4Y47rqHA/1dqHvNl8iivEyM9r/4tzfCen7E1hQbLo0X3Ik8T0xfyaiX
         nSZFG8J0MzmjN39Pdh5LDyzcV8oG7DQ2oX9SOUgPxBqWlq2/Ece2rYE+NSr7Gn6+7H7W
         AKKg==
X-Gm-Message-State: AOJu0Yzvd2iG2yFgDesm7pvsaV+im4GL66xddB20e0PvPElEyd8RYX6/
	MKobZD7Yf6rYYLmv4v+C9z8=
X-Google-Smtp-Source: AGHT+IFR9IdkflmhovRvGJ8Y/cHbW9Gy8VWxRdd3Uuf+6+6Epad+/hFOJoL1wuvJ8+WH5OSI/7gvDQ==
X-Received: by 2002:a17:902:b282:b0:1cf:b190:ea09 with SMTP id u2-20020a170902b28200b001cfb190ea09mr9899906plr.42.1701095461923;
        Mon, 27 Nov 2023 06:31:01 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:01 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] nilfs2: Pass the mapped address to nilfs_check_page()
Date: Mon, 27 Nov 2023 23:30:26 +0900
Message-Id: <20231127143036.2425-8-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove another use of page_address() as part of preparing for
the kmap to kmap_local transition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 45f75d4c4522..01900e84bddf 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -107,12 +107,11 @@ static void nilfs_commit_chunk(struct page *page,
 	unlock_page(page);
 }
 
-static bool nilfs_check_page(struct page *page)
+static bool nilfs_check_page(struct page *page, char *kaddr)
 {
 	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
 	unsigned int chunk_size = nilfs_chunk_size(dir);
-	char *kaddr = page_address(page);
 	unsigned int offs, rec_len;
 	unsigned int limit = PAGE_SIZE;
 	struct nilfs_dir_entry *p;
@@ -192,7 +191,7 @@ static void *nilfs_get_page(struct inode *dir, unsigned long n,
 
 	kaddr = kmap(page);
 	if (unlikely(!PageChecked(page))) {
-		if (!nilfs_check_page(page))
+		if (!nilfs_check_page(page, kaddr))
 			goto fail;
 	}
 
-- 
2.34.1


