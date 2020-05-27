Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E941E4EC6
	for <lists+linux-nilfs@lfdr.de>; Wed, 27 May 2020 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgE0UFS (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 27 May 2020 16:05:18 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:46906 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0UFS (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 27 May 2020 16:05:18 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2020 16:05:17 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49XM5F6qc7z9vFJM
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 19:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zQBQpMMZ5gVM for <linux-nilfs@vger.kernel.org>;
        Wed, 27 May 2020 14:55:45 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49XM5F58jsz9v8yw
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 14:55:45 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49XM5F58jsz9v8yw
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49XM5F58jsz9v8yw
Received: by mail-il1-f198.google.com with SMTP id j71so17813ilg.9
        for <linux-nilfs@vger.kernel.org>; Wed, 27 May 2020 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q3TLvJ9CIfB/1wbg5oIw6CZmCCpeVyOuikrOuGzN8wA=;
        b=iSjjF+W7C++RnXuhE6xA97IPJEc37+fmpoEckipRxMbfZd7b7rJ9U99XRoYCjMOUoE
         9bpsnGsBCPwrMuKtiyBQSdQXD06vFEj5R+v6qA7VyuLOexIruIZMnGDZx2UBWVzz2FHq
         OdxtczifndOGVGRZBd5gQowMpBEvPV/IPyPhEnn1a9ytoddnkZkuKjGQqXFV6aSbgIm7
         N/bfr9r0Pb/AekpiJKA5DvtWn2bFbBdTuzJPKEtTbqp23V/ASN47pwvt1grw3GxnWonL
         vfciYVl69sKcy7ew1k8B3dKcmHjMePfW9LqGwIfVcjgzyFQwGdjEZHUfCgT4q0pBLTfU
         YLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q3TLvJ9CIfB/1wbg5oIw6CZmCCpeVyOuikrOuGzN8wA=;
        b=inTXEmHzRz9D3K52qVPnk9K4I3eU3igHYXMWZdXKxjsfYSeD+6QxzIfckq5NreE68Q
         MZvCI4Bl1I2pk8N+lNw7qaaMJ8x59i2k+HBQOB+VFi2ibC2SOTg1+KIP1DGxMrIUthya
         a5h0j4wYRndLOKNCJs4tSQl01QAF9E/kjk2N0bbIdYdDJjJPRrv2USeq2tXtd7LK+5EF
         EhFhoKOl922qMDZaUqG9Mg2ArkIFExmY3gDggXyziNnV9EdP5wIJHde9hFjwWFTmUoPM
         5nlNA5B2i3wGda8JebB5wC96LmhqLETaad2Csnp4QOpZRyHRyHZorQL07gGeqf5tKMAw
         M5og==
X-Gm-Message-State: AOAM530XQjTsn5gphMJnd5EDmrM6yzvjJlnuE2CW0ogsn6hNaDDw8wKn
        SSU+7f1aha8oxuNQt3sZ6i1T+iFEnE7YykaSW0lHgeF0Ezg/LbXs1ZopLjwZoaUPyI1Rm9r1jie
        RuWqGINehmJr5w4UZALajPefgkZQ=
X-Received: by 2002:a92:850c:: with SMTP id f12mr5148866ilh.86.1590609345275;
        Wed, 27 May 2020 12:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9CP+QzV9HstUrQjfwizvsa+8CrWyaTwz5Sh4uFEJsn3bJC2Whv3hZELa9M3ae1hc9u9LgnQ==
X-Received: by 2002:a92:850c:: with SMTP id f12mr5148837ilh.86.1590609344875;
        Wed, 27 May 2020 12:55:44 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id u1sm1596638iol.42.2020.05.27.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:55:43 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: Fix reference count leak in nilfs_sysfs_create_snapshot_group.
Date:   Wed, 27 May 2020 14:55:32 -0500
Message-Id: <20200527195532.28077-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: a5a7332a291b ("nilfs2: add /sys/fs/nilfs2/<device>/mounted_snapshots/<snapshot>group")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 fs/nilfs2/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index e60be7bb55b0..b2517c5e773a 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -209,8 +209,10 @@ int nilfs_sysfs_create_snapshot_group(struct nilfs_root *root)
 					    "%llu", root->cno);
 	}
 
-	if (err)
+	if (err) {
+		kobject_put(&root->snapshot_kobj);
 		return err;
+	}
 
 	return 0;
 }
-- 
2.17.1

