Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A21E5192
	for <lists+linux-nilfs@lfdr.de>; Thu, 28 May 2020 01:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgE0XEv (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 27 May 2020 19:04:51 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:43866 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XEv (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 27 May 2020 19:04:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49XRHQ1YmWz9vYjP
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 23:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n3Sajjwf43Zt for <linux-nilfs@vger.kernel.org>;
        Wed, 27 May 2020 18:04:50 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49XRHP6wKgz9vYjG
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 18:04:49 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49XRHP6wKgz9vYjG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49XRHP6wKgz9vYjG
Received: by mail-il1-f197.google.com with SMTP id g65so3666944ile.21
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YHV5y6pIipCjzQp8LJwYmqlUFnQseQ80Ln/ckTdkCZw=;
        b=cTHdopN1hULb06TaGd+P4W4iF4wc7U/uaQW2V250xUb74vT/pfcAPR/g7vHCexSE9Y
         2W4eeIUZWE0ubJXJebuMkJuDiQDogzRy969KUhph1Z8Fpyxp7S2HZ98bY6d0mWzii+ol
         JP1eqF6PGJdyzbh5D74xjdDym8bsW0Yd3N3ZLKoWZYAiwW0FAHmg3AzvKgh/Ip/VmI8J
         J95FoovDFBV1D2IOtBvw8iabv3ImXcgts0MdLraATS6I5cLk6NCJTGSPmnKuf/p7xdsb
         S218PRxjeZqROisKi/g/v3FZpOnnkqlTG9Z+Tv6PsXxvGLt6vUmKFf+gQMR2dNTH8MwG
         QpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YHV5y6pIipCjzQp8LJwYmqlUFnQseQ80Ln/ckTdkCZw=;
        b=uFWHYyN7kwo2K2EZZCcO/Qa2W8UOdHKLBzhJrrd4oIHuCovYJYXSON0mBrhrP7wXB8
         bePxgfnYyv3a5OLU4nzTk7lgZqL12m6AKjOmxkx09xGuA2nuMlwFMEMXTuPRnpk8en8/
         as09GiZJNAlowtKFXBKJjxwiUyXZCLuswDt4d5Q1oNrH1M5gzFyfNDO8KdN7IP5AhYwk
         uUpcE4GvoRwZcmAEVJ4EmJyjgOVNGDpRNy6q07wyDZO1rsDSA5rGbCIzPfyhAP3BXKWP
         Ho235OT7BHTjs+9ieoZZIIV1Dit4TjUQiZh5wHZe2/vwCn7yQbpS2Orl0fXusl6av6mV
         RWIQ==
X-Gm-Message-State: AOAM533AyLQGpziWChDbbwu1olueEh/6zC89r6FPTEMoFPki2J7f3JPu
        yti3mIaB2hfRCzo08hS1aBB3rkwTzkwJ1SGeExQ8EkjhGsEAVzDB+hfhIaQknmdznfe8TkAiRSg
        N7FBCc8Db63ChqamD5pnVBGSqV/Y=
X-Received: by 2002:a92:b111:: with SMTP id t17mr546474ilh.241.1590620689540;
        Wed, 27 May 2020 16:04:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlTRkpMzSpcZA8QETYVU9t9ay5AnrCwVzFMdxU6g6ePsCHRybtbfLtQNmcfzP1tRPi4oa3rg==
X-Received: by 2002:a92:b111:: with SMTP id t17mr546454ilh.241.1590620689242;
        Wed, 27 May 2020 16:04:49 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id s2sm2215847ilj.29.2020.05.27.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 16:04:48 -0700 (PDT)
From:   wu000273@umn.edu
To:     konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH V2] nilfs2: Fix reference count leak in nilfs_sysfs_create_device_group
Date:   Wed, 27 May 2020 18:04:42 -0500
Message-Id: <20200527230442.24228-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
In nilfs_sysfs_create_device_group(), the memory allocated by
kobject_init_and_add() is not freed when kobject_init_and_add()
fails. Fix this issue by calling kobject_put() to clean up the
kobject.

Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 V2: using kobject_put() to handle kobject_init_and_add() instead of
 kobject_del().

 fs/nilfs2/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index e60be7bb55b0..8416f915d118 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -999,8 +999,10 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	init_completion(&nilfs->ns_dev_kobj_unregister);
 	err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
 				    "%s", sb->s_id);
-	if (err)
+	if (err) {
+		kobject_put(&nilfs->ns_dev_kobj);
 		goto free_dev_subgroups;
+	}
 
 	err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
 	if (err)
-- 
2.17.1

