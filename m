Return-Path: <linux-nilfs+bounces-30-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367387FA2A8
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6844A1C20AA0
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADF28ED;
	Mon, 27 Nov 2023 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYpJqI8E"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4258D5F;
	Mon, 27 Nov 2023 06:30:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf80a7be0aso35291535ad.1;
        Mon, 27 Nov 2023 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095443; x=1701700243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSxSrCRiJkeqU23CuDt7v+73UNnBJ7TRHcGgifUa9Yk=;
        b=bYpJqI8EnryZ+yo2VOVu99RmRipT4pzrIgwkmm5LJySXc5SIuCNGcNdyWWQH612oDY
         3ZnkW+dv7IU0Kj6/GXHCHuZg6tPPt7f7BNsxOiVSPYbn6Q3CqTShhVEVHTjDWoULG+9b
         k9qdk54ToGM+7J4yQfBhv4+vMu2lcyKyFZ9w0pfHTzWuRHywtv/GNCdhncw8L+JMcBS9
         wsnnMsiMUb++FoviSnvB3MMROkFb45JZ9PyU8+Cc7dtS+Ntx6illuA0jfd8tORzdhYHc
         TBxPpePuwpTF6eE7OGTCXgYY7hLk2eb4FCqYYGlkZ+5w18hWrFdN6fcJ6j5H5NreMIEW
         oY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095443; x=1701700243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSxSrCRiJkeqU23CuDt7v+73UNnBJ7TRHcGgifUa9Yk=;
        b=m83maYOBV1W9dvydFEHSG8IKwL9jP3JfZmqhM8ha1wvfSJGC7oowrH/pndCXUaDGHQ
         4DNMglYThCMRjO/1n5T3ut70M/2SN/2hIIqF3eNKALbIkpVO9OJq8p0rnRdG5zzawyEa
         UgrYwCD+yO6lhZ5hSBD0W8x6Ivn7yBCurHSRHLaMS+zxHWiHpbfqtN5xf1PncBRBubJA
         8YLoNs8Q6GJfmUeBGmiOWFsdjeqCHIUKFlch3LEehA2LWPuA+EzfmSJ1pv/xB50BCLtV
         5a5D7tcecTSUkIJrv5p3HcebVDk2nxDQy35bG31ZZTJCjwfNi9rhqXgrVDT/SEHPQNTk
         JsOg==
X-Gm-Message-State: AOJu0YyS5AXEGzdTxJEfATcrcy4M5lKaTZCtiCYvCwxm79Pcz765sp+Z
	QsiCrQnJvw/IsU4pMrSyf8A=
X-Google-Smtp-Source: AGHT+IGxNIHZTgLY6e1iQkdBk2++jXsrV4IwaatIPGDfc4XjTiGbKHVcdwpbf0qvBG2HryVf+QdJaQ==
X-Received: by 2002:a17:902:8488:b0:1cc:5e1b:98b5 with SMTP id c8-20020a170902848800b001cc5e1b98b5mr12600757plo.66.1701095442903;
        Mon, 27 Nov 2023 06:30:42 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:30:42 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] nilfs2: Folio conversions for directory paths
Date: Mon, 27 Nov 2023 23:30:19 +0900
Message-Id: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

please add this series to your queue for the next merge window.

This series applies page->folio conversions to nilfs2 directory
operations.  This reduces hidden compound_head() calls and also
converts deprecated kmap calls to kmap_local in the directory code.

Although nilfs2 does not yet support large folios, Matthew has done
his best here to include support for large folios, which will be
needed for devices with large block sizes.

This series corresponds to the second half of the original post [1],
but with two complementary patches inserted at the beginning and some
adjustments, to prevent a kmap_local constraint violation found during
testing with highmem mapping.

[1] https://lkml.kernel.org/r/20231106173903.1734114-1-willy@infradead.org

I have reviewed all changes and tested this for regular and small
block sizes, both on machines with and without highmem mapping.  No
issues found.


Thanks,
Ryusuke Konishi


Matthew Wilcox (Oracle) (15):
  nilfs2: Remove page_address() from nilfs_set_link
  nilfs2: Remove page_address() from nilfs_add_link
  nilfs2: Remove page_address() from nilfs_delete_entry
  nilfs2: Return the mapped address from nilfs_get_page()
  nilfs2: Pass the mapped address to nilfs_check_page()
  nilfs2: Switch to kmap_local for directory handling
  nilfs2: Add nilfs_get_folio()
  nilfs2: Convert nilfs_readdir to use a folio
  nilfs2: Convert nilfs_find_entry to use a folio
  nilfs2: Convert nilfs_rename() to use folios
  nilfs2: Convert nilfs_add_link() to use a folio
  nilfs2: Convert nilfs_empty_dir() to use a folio
  nilfs2: Convert nilfs_make_empty() to use a folio
  nilfs2: Convert nilfs_prepare_chunk() and nilfs_commit_chunk() to
    folios
  nilfs2: Convert nilfs_page_bug() to nilfs_folio_bug()

Ryusuke Konishi (2):
  nilfs2: move page release outside of nilfs_delete_entry and
    nilfs_set_link
  nilfs2: eliminate staggered calls to kunmap in nilfs_rename

 fs/nilfs2/btnode.c |   4 +-
 fs/nilfs2/dir.c    | 244 +++++++++++++++++++++------------------------
 fs/nilfs2/namei.c  |  38 +++----
 fs/nilfs2/nilfs.h  |  20 ++--
 fs/nilfs2/page.c   |  25 ++---
 fs/nilfs2/page.h   |   6 +-
 6 files changed, 159 insertions(+), 178 deletions(-)

-- 
2.34.1


