Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7591E4EE7
	for <lists+linux-nilfs@lfdr.de>; Wed, 27 May 2020 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbgE0UKP (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 27 May 2020 16:10:15 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38370 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387632AbgE0UKN (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 27 May 2020 16:10:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49XMPw2zbpz9vZ2s
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 20:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r2YvCRwB4UNY for <linux-nilfs@vger.kernel.org>;
        Wed, 27 May 2020 15:10:12 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49XMPw1JcWz9vZ29
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 15:10:12 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49XMPw1JcWz9vZ29
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49XMPw1JcWz9vZ29
Received: by mail-il1-f197.google.com with SMTP id p81so21488606ill.5
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hPSY+Zh0t1rGNkSqJtjBbGWhpyEB+X/pF0E6TThgwhg=;
        b=cO0BH8ko43bkOPatdOWMTW1FAm4WGWEPap0aloF2Ov8I0nG59A/3qh6AZfb6yAbZZO
         WAhNKKNK7gSl5i+QdplLfll1L86UVGr2JjcN3cCuvjtM4R1WxDbhalnYCwNgAdRyz5pR
         gYgtyRBZD+g5y6bZ/jB0XJ+eePjHUzxTXtJ8zt8lnJwfL9WqejH+dysiC2m3vWxz0qIU
         5nQrWV7T5cxzaojhGzAJaNCP3VPFY8xJInVRdfzCR+MaWpnpTT3X+w0EwAsjWp/q6kjl
         XGbnFX8oRUWA22jCtYpUo772KJpqFPyEjNrgn1OTYXUggTnMtWI0arlJAKaeejZwEVHO
         OJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hPSY+Zh0t1rGNkSqJtjBbGWhpyEB+X/pF0E6TThgwhg=;
        b=GnoX1MikI6cblumvV37YkttQDUQZZPAF4tEwld+g95Ad/u8pgipCKqAAH6TA6/lBOa
         hEN5ycSw6BIMDt/rCNeZhD+q81cOl1YfcGwFy7wMewLppYo0wVoxdeHgZoFrlSx3TKBf
         FVTRUI45Q/CaTFfzNsW48Dl4dIh8DQgwthoah3sA//873jQQlO/kHZqCf8cfVNi71bL/
         ilWXsRpsg+jVdeJrwNLnYnYF2eyoxI8UxjQEVLOLrI/dh6gnxWa21rbl54/htf5bNHDB
         Slsv6KN7Z8f/4zFdLOA2ByUkJZdVi87jp9nW3Tqv8UAOlVPIB2t44Xv70m61WGjjdHYc
         b0Lg==
X-Gm-Message-State: AOAM533xoj0KCjedVUMN4a59gCMhZRTLVEtAQ5xbPinDBvJ8TYgIqmU+
        +LmURHdh8UonebOKr2ti0mL7/1+ByXIT7k5ttvLn6mS/DWXhNloSRISDCwrdBOtgs2zf5uq84N6
        r0rnI1JFSqaaq84OZiC811zuiNPQ=
X-Received: by 2002:a6b:7b4a:: with SMTP id m10mr8477807iop.55.1590610211695;
        Wed, 27 May 2020 13:10:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuhrc7NDsfRK/mm7gpFg9DSuH5ZtlqPdBbXWHpT2UnfIHxGwqhPUuTPCAJzX65HWUIdG9W/A==
X-Received: by 2002:a6b:7b4a:: with SMTP id m10mr8477782iop.55.1590610211353;
        Wed, 27 May 2020 13:10:11 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id y11sm2020565ily.22.2020.05.27.13.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 13:10:10 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: Fix reference count leak in nilfs_sysfs_create_device_group
Date:   Wed, 27 May 2020 15:09:33 -0500
Message-Id: <20200527200933.31135-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
In nilfs_sysfs_create_device_group(), the memory allocated by
kobject_init_and_add() is not freed when kobject_init_and_add()
fails. Thus replace the jump target "free_dev_subgroups" by
"cleanup_dev_kobject".

Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 fs/nilfs2/sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index e60be7bb55b0..4a74756d52fe 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1000,7 +1000,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
 				    "%s", sb->s_id);
 	if (err)
-		goto free_dev_subgroups;
+		goto cleanup_dev_kobject;
 
 	err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
 	if (err)
@@ -1038,8 +1038,6 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 
 cleanup_dev_kobject:
 	kobject_del(&nilfs->ns_dev_kobj);
-
-free_dev_subgroups:
 	kfree(nilfs->ns_dev_subgroups);
 
 failed_create_device_group:
-- 
2.17.1

