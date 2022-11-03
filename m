Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1493617F45
	for <lists+linux-nilfs@lfdr.de>; Thu,  3 Nov 2022 15:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiKCOTk (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 3 Nov 2022 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiKCOT0 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Thu, 3 Nov 2022 10:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F82101FA
        for <linux-nilfs@vger.kernel.org>; Thu,  3 Nov 2022 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667485089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7sFhbFjsyed+EphiRBlueeREBkJAs1QiqobCz6ZZTfY=;
        b=K+WxXayITKcz2e4xpEGpZZr1+QLKsNauZ4S7CS+kiOfMxUimslN9BX8wZ/PfRG/rU2kbk2
        QeBwQ0fCY0TxqT7banXultIFaFovdEsEC1Fey0kaRaA7ztxlFXkUhALoQpoKJ3EGCPAzdJ
        R+TH1gIjGBrqND75cK9FoS9HvIGcesg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-CNkE3meeO0iO0VMoBM36Sg-1; Thu, 03 Nov 2022 10:18:08 -0400
X-MC-Unique: CNkE3meeO0iO0VMoBM36Sg-1
Received: by mail-pf1-f200.google.com with SMTP id f189-20020a6238c6000000b0056e3400fdc0so802004pfa.10
        for <linux-nilfs@vger.kernel.org>; Thu, 03 Nov 2022 07:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sFhbFjsyed+EphiRBlueeREBkJAs1QiqobCz6ZZTfY=;
        b=TmCwQ8Dew708044YEqzk5vNcCNEtQ8POnCJJDMaswV+7CNSlu0te0MakHvulzu8K56
         POpGuvonVLrrDzr8EkwoA6lOFagHtD5AlOk7JN6PzzS/qxmDp10/fP1I5FvXW3YfBIFJ
         5z7sb4bdlXtYv12/8JfOCP0tLonbP1zPdgXEJfKtneYrb4hCrmsLlGnMFQyfvAFwc898
         PqRlrNv0A8t3RYejl93ob0S2Iaapa46kzz0gZcJmgMp4JGGglIT3hiKsPE3n1SLwmCjY
         rzdJzhPRoH8Yz4Q678OpLXjfyNO6llyblHXMjQvhvva78CNhUuNOWi/KbDEjWPNO+5Dj
         m9ug==
X-Gm-Message-State: ACrzQf2+A/YuRbe5zeGkIDfkBhdZcg5uN9rvpKdLwPOBf584eQqWCDXp
        jCTzw39itaxqvG8Ji90wMo5j/lj1BaYgCzkEO/wtZvKqpRjaLaX3YhSKk5xwTjMrIzLJhpJLyjO
        iFf9Enr1Z0KD6/KkwvM5nd7A=
X-Received: by 2002:a17:903:2411:b0:184:7159:dce6 with SMTP id e17-20020a170903241100b001847159dce6mr30858919plo.101.1667485086965;
        Thu, 03 Nov 2022 07:18:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6I/WFalNfYH/3sFbEjanTaxkxJ1wJL/15Zu/ebEfrCM+l4I16qNoEzd1/CBQMRz0CoooQADw==
X-Received: by 2002:a17:903:2411:b0:184:7159:dce6 with SMTP id e17-20020a170903241100b001847159dce6mr30858903plo.101.1667485086707;
        Thu, 03 Nov 2022 07:18:06 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:fc9c:8ee9:e32c:2d9])
        by smtp.gmail.com with ESMTPSA id gf7-20020a17090ac7c700b00214247989dfsm39222pjb.13.2022.11.03.07.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:18:06 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com
Subject: [PATCH] nilfs: Avoid use-after-free caused by nilfs->ns_writer
Date:   Thu,  3 Nov 2022 23:17:59 +0900
Message-Id: <20221103141759.1836312-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

syzbot reported use-after-free in nilfs_segctor_sync() [1].

The use-after-free occurs with nilfs->ns_writer.  The scenario for the
issue is as follows:

Task1                                   Task2
----------------------------------------------------------------------
nilfs_construct_segment
  nilfs_segctor_sync
    init_wait
    init_waitqueue_entry
    add_wait_queue
    schedule
                                        nilfs_detach_log_writer
                                          nilfs_segctor_destroy
                                            kfree
    finish_wait
      _raw_spin_lock_irqsave
        __raw_spin_lock_irqsave
          do_raw_spin_lock
            debug_spin_lock_before  <-- use-after-free

While Task1 is sleeping, nilfs->ns_writer is freed by Task2.  After
Task1 waked up, Task1 accesses nilfs->ns_writer which is already
freed.

This patch fixes the issue by taking nilfs->ns_segctor_sem in
nilfs_construct_segment() so that nilfs->ns_segctor_sem cannot be
freed while nilfs_segctor_sync() is sleeping.

Link: https://syzkaller.appspot.com/bug?id=79a4c002e960419ca173d55e863bd09e8112df8b [1]
Reported-by: syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/nilfs2/segment.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index b4cebad21b48..d4f10d82664d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2239,16 +2239,24 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
 int nilfs_construct_segment(struct super_block *sb)
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
-	struct nilfs_sc_info *sci = nilfs->ns_writer;
+	struct nilfs_sc_info *sci;
 	struct nilfs_transaction_info *ti;
+	int ret;
 
-	if (!sci)
+	down_write(&nilfs->ns_segctor_sem);
+	sci = nilfs->ns_writer;
+	if (!sci) {
+		up_write(&nilfs->ns_segctor_sem);
 		return -EROFS;
+	}
 
 	/* A call inside transactions causes a deadlock. */
 	BUG_ON((ti = current->journal_info) && ti->ti_magic == NILFS_TI_MAGIC);
 
-	return nilfs_segctor_sync(sci);
+	ret = nilfs_segctor_sync(sci);
+	up_write(&nilfs->ns_segctor_sem);
+
+	return ret;
 }
 
 /**
-- 
2.37.3

