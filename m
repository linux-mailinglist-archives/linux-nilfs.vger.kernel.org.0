Return-Path: <linux-nilfs+bounces-40-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33107FA2B3
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7001CB21136
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E6111B4;
	Mon, 27 Nov 2023 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddpL/kve"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E461010F6;
	Mon, 27 Nov 2023 06:31:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc9b626a96so30352245ad.2;
        Mon, 27 Nov 2023 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095471; x=1701700271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZIiUDywASZ5qLtxZqnaVnT8sxb13W9YOdsItG5ysDI=;
        b=ddpL/kveJht9XsO36Dpv4ydrFVF2gHZn0max1hT/qbuwk/6k/w9296jrSQLS4TzBLo
         jYR5Q+pcFZ4zegz5l9N5uIuc2DphizKoQ+5JrSrUHltDhW0I22PYgcGEDaicqvZXSatC
         WowotQRskAF7ezxA6U2X+WRqlx+k4oEWC539tvo9UHS34vHb/A7WlaJbB7hReeL9EKzR
         wex/gETBXGFhmQDeFWsk0RuVJipNqbCP8wkR6iWfAoxSI4PVCJJvP0ijQHTHrrgB9fAJ
         CgFklZL+wjFK+XWv9DDQpDz5QARud0hGZp4Adim8/UHIiZ1LcPc0qEZ9hsuL0ua7CBUZ
         tJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095471; x=1701700271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZIiUDywASZ5qLtxZqnaVnT8sxb13W9YOdsItG5ysDI=;
        b=FL5FzhSpbBkojd6cigJ6jvnhqUQCk4fFUBUUlJvEaDDf+5rd5hf4F48zkU93XDWJMj
         033GLDAPdthkFw2plP8PE50ZvzqHEZflq9fmTGJR5zEeQarkKmA8J2H24vUARj9rhDGP
         FCPTCqs1VH4TQ5r/u14Mu3583VGiITbaLgBMwU260qFwFCEy0G5OdaLGW7PPYRDUC2rk
         dU1IDkpTeQ/EzGb3koMh3FiPamuw8Sw9jVy2iPgN2HRmZ2Jo6eME38bmccKywmE3yPW9
         rdJojqyfCG/ywtcTSkiack0leKVKydZRglyluY/uASZSEsuZd2xvq82idyN4CmoAwXx2
         SE+A==
X-Gm-Message-State: AOJu0YxHzBkR7BADpvdaiMsB+S7LbSpBY3GEd5Rcry1zTN/5oQz9Es7t
	s3xRqqsQpnvIrWDulr7xGBlzs/wQsP8=
X-Google-Smtp-Source: AGHT+IFC6kljr/OxSGZeYSj1/XgvOHN9fwAW1Ops/Yklp4y0OXGn1HDHydCquS+o6vgWef+Lkm+O6Q==
X-Received: by 2002:a17:902:c411:b0:1cf:a0b1:ec06 with SMTP id k17-20020a170902c41100b001cfa0b1ec06mr13415865plk.55.1701095471403;
        Mon, 27 Nov 2023 06:31:11 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:10 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] nilfs2: Convert nilfs_readdir to use a folio
Date: Mon, 27 Nov 2023 23:30:29 +0900
Message-Id: <20231127143036.2425-11-konishi.ryusuke@gmail.com>
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

Use the new folio APIs to remove calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 5c9ca3f0d7f4..c7b046589877 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -284,9 +284,9 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct nilfs_dir_entry *de;
-		struct page *page;
+		struct folio *folio;
 
-		kaddr = nilfs_get_page(inode, n, &page);
+		kaddr = nilfs_get_folio(inode, n, &folio);
 		if (IS_ERR(kaddr)) {
 			nilfs_error(sb, "bad page in #%lu", inode->i_ino);
 			ctx->pos += PAGE_SIZE - offset;
@@ -298,7 +298,7 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 		for ( ; (char *)de <= limit; de = nilfs_next_entry(de)) {
 			if (de->rec_len == 0) {
 				nilfs_error(sb, "zero-length directory entry");
-				unmap_and_put_page(page, kaddr);
+				folio_release_kmap(folio, kaddr);
 				return -EIO;
 			}
 			if (de->inode) {
@@ -311,13 +311,13 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 
 				if (!dir_emit(ctx, de->name, de->name_len,
 						le64_to_cpu(de->inode), t)) {
-					unmap_and_put_page(page, kaddr);
+					folio_release_kmap(folio, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += nilfs_rec_len_from_disk(de->rec_len);
 		}
-		unmap_and_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 0;
 }
-- 
2.34.1


