Return-Path: <linux-nilfs+bounces-799-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB4B470ED
	for <lists+linux-nilfs@lfdr.de>; Sat,  6 Sep 2025 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D611B168215
	for <lists+linux-nilfs@lfdr.de>; Sat,  6 Sep 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034181C4A2D;
	Sat,  6 Sep 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTeAKkTE"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203C10E0;
	Sat,  6 Sep 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169859; cv=none; b=RbGpscwh7J9QP3mogRhXJUu49xAhyebc0yrd4Yb/XMhNpdb/zYMwYF0c1IGFsIGIv4IPw2qFgId1yPawEXkpdLLoWCbgYtbIRbGcJ0bbsGX1P9RAjse8EgqpnzOP5jUJd7UCMLQPHDWI7Syi6CKbNElGe2QrvfezrwJkKjv7fP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169859; c=relaxed/simple;
	bh=F1hJovWmCfz9s+nQZMDZmXzPfEOEYG4ethHA7VhwAxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJmWDBESK8j/uRQVcQKIGnT6+3MzPEfeI9CNMQXdER2v5s6nqLlTLbr2nuY+hHukmda4DbT0TpVo6wb9zV9zP9kV8YZcMaEgi9efh8tebXg0safFUdTp29kwKVsvxxd8wFd9lb7aUKuHTp5fGGXaKdV/FYUGhr+FlA18atUmkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTeAKkTE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c7848519bso29705545ad.1;
        Sat, 06 Sep 2025 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757169858; x=1757774658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBL3cu6DBLTJJUpb15kTPRt3v3Uat1QdI04xL2+8P7s=;
        b=iTeAKkTEMNZ75QkKkUynZyoqZWSJjNRs0hmG4cqx5tTW6GR2l3ydmL+etAiVl7fCZW
         xuW3ZvREatj20C2r6+wzcwUvzqDC0xMOsL2uyX9qZfJwjbQNc2H1ozFULTOZCW+Dfo4a
         KGUgRaek1KGsOBa1p7y3QalaLkx5WrvFNEDp0oGbihOgZbQ2+6V7LyJLRRNW5sUDXdag
         RkS/JfdYLe3Zsbd1mbfcDA6g55dMHMuvT6X51CJCpzolXXzW+QCosayhRiGW4ytsysaf
         jPBy8MKVNH/4t7YuuU70lAs8MJfnKR9h3xXA5lgX3m8ywP5pbfOFEB+hg8xhCawI7ebL
         3hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757169858; x=1757774658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBL3cu6DBLTJJUpb15kTPRt3v3Uat1QdI04xL2+8P7s=;
        b=UjLzdnkX4TgIxwJ+tHwmu0lYAtQw18D3qZCk0Dyv/Nwow+amv3jJe8+QyMUh4nxN4f
         eJTOBvQgCKl1hw0vQIRuQbuZApm4UqEuzK+2IhPfDyI2jnpEeETKS3+SXpVtGTTX0pKf
         QA2EwrPseEF8MSSUwjG10kJ/zRU/kCzatszvuOpdFUVWywR216h0vU6qRaS+Kbli3L6E
         /Haaa21/rPhE4gZjsJLiU+X2fVKGW7MOCQh4sLFlgJjjxh3Qr3fY5sObouMRJ9nbbEY9
         zajHS994jQj+VD+Wjz3Cun5+ud6arewkWe98IhP9r2L75Wmvdip3UnHIkery/OCsBJvB
         gvpg==
X-Forwarded-Encrypted: i=1; AJvYcCU55eHnQ0gOVfDPT/Ddz4tr0HaC+XP+mD3mFZZiePTcG7p+OE/KeJqtJSZvh1rE44ROBj8HbdutsiCnVKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgd3JvxmBVmxYEKQkyeiH6tkTkImgQbDVU5JB150tJlZopIJM
	rUdamUl65MkoHh/MUeB9ua0wlsjQnPt3W+NEXq4yUaMfriA5x9CpkHLO
X-Gm-Gg: ASbGncuaH+LzqWSQf8GCq6+sPD6arzjsN6odmS3oVyH4SmlygZ30j51zg3oePu5JNJa
	K/7jjIsT/e/otxWybaqD8Vf07VenHbhpqm2RJHGHRl1RyWNkesha9dxOGNq1C7klEUCYvNMB6mf
	PCxGO7iriMwjexv/uX3oEVGVYxr6g237eohFuSt0a8KAdTx+LK6aRJ8HJLDzUHGVHZ0od4ZQt0J
	mVIeELcw2QN+v1N/Yp1Bl2+Jqr51kW2T4u97ZCG5CtgwaGDTDdt+10ez+JUjwwyjQScbZfTugqk
	cP6wessvlmbKfhfA0lpiyqZASB7yQEJt4JM4bgQgfXH+0UNA3Uwh9wHNXe+imsfcaxN6eaAz7Bq
	9dJqH/DUCNSRH/xvJvARgvV1E5PBHMBGmkWkPsbxuLTuS8kVqyYQtmy0gevJrW+fMKr+NoA==
X-Google-Smtp-Source: AGHT+IFJQN+PhhPghauvY8hWWyyjIff15L2XDX+Ft/C/N1kxPZuhhPA5+sICetkWv73SpWiUHHhpJg==
X-Received: by 2002:a17:903:2ad0:b0:250:aeb0:1049 with SMTP id d9443c01a7336-25168b89eb4mr32157895ad.0.1757169857510;
        Sat, 06 Sep 2025 07:44:17 -0700 (PDT)
Received: from carrot.. (i114-180-53-102.s42.a014.ap.plala.or.jp. [114.180.53.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cac2f24fdsm85833885ad.46.2025.09.06.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:44:16 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] nilfs2: fix CFI failure when accessing /sys/fs/nilfs2/features/*
Date: Sat,  6 Sep 2025 23:43:34 +0900
Message-ID: <20250906144410.22511-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

When accessing one of the files under /sys/fs/nilfs2/features when
CONFIG_CFI_CLANG is enabled, there is a CFI violation:

  CFI failure at kobj_attr_show+0x59/0x80 (target: nilfs_feature_revision_show+0x0/0x30; expected type: 0xfc392c4d)
  ...
  Call Trace:
   <TASK>
   sysfs_kf_seq_show+0x2a6/0x390
   ? __cfi_kobj_attr_show+0x10/0x10
   kernfs_seq_show+0x104/0x15b
   seq_read_iter+0x580/0xe2b
  ...

When the kobject of the kset for /sys/fs/nilfs2 is initialized, its
ktype is set to kset_ktype, which has a ->sysfs_ops of kobj_sysfs_ops.
When nilfs_feature_attr_group is added to that kobject via
sysfs_create_group(), the kernfs_ops of each files is
sysfs_file_kfops_rw, which will call sysfs_kf_seq_show() when
->seq_show() is called. sysfs_kf_seq_show() in turn calls
kobj_attr_show() through ->sysfs_ops->show(). kobj_attr_show() casts the
provided attribute out to a 'struct kobj_attribute' via container_of()
and calls ->show(), resulting in the CFI violation since neither
nilfs_feature_revision_show() nor nilfs_feature_README_show() match the
prototype of ->show() in 'struct kobj_attribute'.

Resolve the CFI violation by adjusting the second parameter in
nilfs_feature_{revision,README}_show() from 'struct attribute' to
'struct kobj_attribute' to match the expected prototype.

Cc: stable@vger.kernel.org
Fixes: aebe17f68444 ("nilfs2: add /sys/fs/nilfs2/features group")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202509021646.bc78d9ef-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Hi Andrew,

Please apply this bug fix.
This fixes a control-flow integrity test failure in nilfs2's sysfs
recently discovered by the kernel test robot and identified by Nathan.

Thanks,
Ryusuke Konishi

 fs/nilfs2/sysfs.c | 4 ++--
 fs/nilfs2/sysfs.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 14868a3dd592..bc52afbfc5c7 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1075,7 +1075,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
  ************************************************************************/
 
 static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
-					    struct attribute *attr, char *buf)
+					    struct kobj_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%d.%d\n",
 			NILFS_CURRENT_REV, NILFS_MINOR_REV);
@@ -1087,7 +1087,7 @@ static const char features_readme_str[] =
 	"(1) revision\n\tshow current revision of NILFS file system driver.\n";
 
 static ssize_t nilfs_feature_README_show(struct kobject *kobj,
-					 struct attribute *attr,
+					 struct kobj_attribute *attr,
 					 char *buf)
 {
 	return sysfs_emit(buf, features_readme_str);
diff --git a/fs/nilfs2/sysfs.h b/fs/nilfs2/sysfs.h
index 78a87a016928..d370cd5cce3f 100644
--- a/fs/nilfs2/sysfs.h
+++ b/fs/nilfs2/sysfs.h
@@ -50,16 +50,16 @@ struct nilfs_sysfs_dev_subgroups {
 	struct completion sg_segments_kobj_unregister;
 };
 
-#define NILFS_COMMON_ATTR_STRUCT(name) \
+#define NILFS_KOBJ_ATTR_STRUCT(name) \
 struct nilfs_##name##_attr { \
 	struct attribute attr; \
-	ssize_t (*show)(struct kobject *, struct attribute *, \
+	ssize_t (*show)(struct kobject *, struct kobj_attribute *, \
 			char *); \
-	ssize_t (*store)(struct kobject *, struct attribute *, \
+	ssize_t (*store)(struct kobject *, struct kobj_attribute *, \
 			 const char *, size_t); \
 }
 
-NILFS_COMMON_ATTR_STRUCT(feature);
+NILFS_KOBJ_ATTR_STRUCT(feature);
 
 #define NILFS_DEV_ATTR_STRUCT(name) \
 struct nilfs_##name##_attr { \
-- 
2.43.0


