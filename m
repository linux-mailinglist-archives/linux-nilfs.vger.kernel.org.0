Return-Path: <linux-nilfs+bounces-44-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 674557FA2B8
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 15:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3931B21224
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51502111B4;
	Mon, 27 Nov 2023 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvFBsreH"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711C1AD;
	Mon, 27 Nov 2023 06:31:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf89df1eecso27319505ad.3;
        Mon, 27 Nov 2023 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095485; x=1701700285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ0hTMNOO2rQEY/dpZit98zV3CambmsVJR+t1rZ7hqw=;
        b=lvFBsreHk2zBB4k3PxfvUiSWpHMqxYMoxPpfUbGsWPzafdGKfV9jpTYqrtJtgbMJr0
         YLQ5fZl+e6CMCbDY+1aGMrqmtXUGHrwj0F8bQJJF5RY/XHhdxxQ7j99AZWHcfRntw+FT
         3dtMoaiUrQ3vSNhMf3CRCDNIKozNsXaE+7lLATjUgzIu3+9afC+r3PNfq9yG26mrEuj2
         KBtmM2wJp38mRb1irXA3GEyo3CxwrurWtr2o2CiloHIiKVP/jbzg7Q0zPdsBZWba2arb
         XtpXPHGl8/OQMNnGqRuED2NqSeqTfr6w++2yuqLkT/SQUrcuZ3wT5sZa1slrV7MN1nc6
         zpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095485; x=1701700285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ0hTMNOO2rQEY/dpZit98zV3CambmsVJR+t1rZ7hqw=;
        b=oE72ZTJXknOkhAjo3J3fxy49gThjWmVuykMy8N94IEOPx6zQ61MukmGAHxCSyZNTBf
         ks0GJYEJOTgg9iDzzmPVSj/+U0I9HZ1Wi0/KH7MC4sV4x7REkBYraYcupaIau8zFvX3f
         yzm3uny6w4gDXVOyN1O+URquzUEzx/UpkRaUtVB5CVIax9k3FYPldLMVOkpcaR3xvpPV
         1o6fCJ8FCOPvWzfSJ1fsFu6Voq0/XRCHXCZSv8Ibf0PPNaaFKpnQJDkoyfCz69cZi6GW
         Cs3/NSH9Lwje7HJUwcBEA+Ui0rumqDU4TX+YnLG9PIzM18h5VMLjuFl0WISgwQH+bDsX
         1efQ==
X-Gm-Message-State: AOJu0YxjHT9idnkKOUUp8H3D2koxfUuEF1wYakmvTIB3XmvB41Ru4njk
	DKFSFCUmltCSxWNU8iZTRsA=
X-Google-Smtp-Source: AGHT+IGy/CYDGZVItVW7R8O6dqj5gmUXwm0OW1c2CXsygrOfqAP0Is/gJQa5ZYWaF7N2qjYgEcMYuw==
X-Received: by 2002:a17:902:e843:b0:1cf:d24c:7b6c with SMTP id t3-20020a170902e84300b001cfd24c7b6cmr2485252plg.59.1701095484950;
        Mon, 27 Nov 2023 06:31:24 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:24 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] nilfs2: Convert nilfs_empty_dir() to use a folio
Date: Mon, 27 Nov 2023 23:30:33 +0900
Message-Id: <20231127143036.2425-15-konishi.ryusuke@gmail.com>
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

Remove three calls to compound_head() by using the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 8d8c42e34148..919936d9ec27 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -203,17 +203,6 @@ static void *nilfs_get_folio(struct inode *dir, unsigned long n,
 	return ERR_PTR(-EIO);
 }
 
-static void *nilfs_get_page(struct inode *dir, unsigned long n,
-		struct page **pagep)
-{
-	struct folio *folio;
-	void *kaddr = nilfs_get_folio(dir, n, &folio);
-
-	if (!IS_ERR(kaddr))
-		*pagep = &folio->page;
-	return kaddr;
-}
-
 /*
  * NOTE! unlike strncmp, nilfs_match returns 1 for success, 0 for failure.
  *
@@ -611,14 +600,14 @@ int nilfs_make_empty(struct inode *inode, struct inode *parent)
  */
 int nilfs_empty_dir(struct inode *inode)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	char *kaddr;
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
 		struct nilfs_dir_entry *de;
 
-		kaddr = nilfs_get_page(inode, i, &page);
+		kaddr = nilfs_get_folio(inode, i, &folio);
 		if (IS_ERR(kaddr))
 			continue;
 
@@ -647,12 +636,12 @@ int nilfs_empty_dir(struct inode *inode)
 			}
 			de = nilfs_next_entry(de);
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 1;
 
 not_empty:
-	unmap_and_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return 0;
 }
 
-- 
2.34.1


