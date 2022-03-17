Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1024DCCE6
	for <lists+linux-nilfs@lfdr.de>; Thu, 17 Mar 2022 18:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiCQRwN (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 17 Mar 2022 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiCQRwM (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91290166E20
        for <linux-nilfs@vger.kernel.org>; Thu, 17 Mar 2022 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647539454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CWUmn/QvK/L7nVX8kGPV5onMGWPPEQZ85b495jUko/o=;
        b=VDDw96qB66Qd/IGq+j3AGfY7++eYnxf9FMkO2vxm+Oaz/A9HyWTM+AbiKFcUC9cNPoGCRN
        chb1FuRsASSY5UiTE78US0rrG7VMberxwqCC7e0sfPvpzMK5FX6hgUAKlCV3VdKEgxQGcq
        HuhlJX2dC8lT/5w60qBQntRDjLDtGs4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-GAnFPMdLM36od7JEJFx32A-1; Thu, 17 Mar 2022 13:50:53 -0400
X-MC-Unique: GAnFPMdLM36od7JEJFx32A-1
Received: by mail-oi1-f200.google.com with SMTP id i13-20020a056808030d00b002da1b96f89dso3449043oie.23
        for <linux-nilfs@vger.kernel.org>; Thu, 17 Mar 2022 10:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWUmn/QvK/L7nVX8kGPV5onMGWPPEQZ85b495jUko/o=;
        b=Gtj1yjJEocVowO/8wrSMVsZK14vUnbo/MYQ7umAd99Z9rOYX5ILCLJOHxwAD6WQ4JC
         9Wdx2yaLAwaXELtdhPTp9MHfb6KojxZGERik5i9kq96xkGtl1HZIHcdLEr1YJlLNzdcj
         Ek8sbkCnMgCAQ5e0CEzewfPRNzoQq0tHKPMFMsFgCDpOJimLWFJFZ19L6sMaD5JDXiXY
         Q6oHfy6VPk6mJp3PfiYZkX+Hgf6IXmy3D9VIv6/z4mrsvdMc71WuezNA9ydTobS4gpel
         5qIvtWsYk4sHQAUppcwHQ45jUOY+H2T8DEHRRIX7eKo8eAGOju6O0uTAYFyl15N9MHT8
         sWHA==
X-Gm-Message-State: AOAM533+uPqXn22KLP1ZlT6gCxMG65qgxnctVNayK0C0P8hTR3p82j4c
        Ejj1MqC4i+2aQIB3Lc48rhCLw8kd/20PTIMNeKavd1/LayzM9c7RVbZqlCj+LJNv/B0NoprMm55
        pPsAqwM8aE/nl5ysn37g/m5U=
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id j13-20020a056808118d00b002d4be7e6748mr2506864oil.123.1647539452734;
        Thu, 17 Mar 2022 10:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztjwuwCNgzs0OEH5TeCj4r7xDj/r/kSgu0Xko2rMEd3ZIk4tDT4v84Ij+AlVx37u4LbZxI4g==
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id j13-20020a056808118d00b002d4be7e6748mr2506857oil.123.1647539452543;
        Thu, 17 Mar 2022 10:50:52 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e9-20020aca3709000000b002ed1930b253sm2770239oia.30.2022.03.17.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:50:52 -0700 (PDT)
From:   trix@redhat.com
To:     konishi.ryusuke@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] nilfs2: move initialization of nr_dirty to decl
Date:   Thu, 17 Mar 2022 10:50:43 -0700
Message-Id: <20220317175043.1972081-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

On clang build there is this error
inode.c:227:13: error: variable 'nr_dirty' is
  used uninitialized whenever 'if' condition is false
        } else if (ret) {
                   ^~~

In nilfs_dirty_folio(), if the call to
filemap_dirty_folio() fails and there
are no buffers, nr_dirty will be uninitialized.
Move the initialization out of the buffer
block and to the decl.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nilfs2/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index c1219c0678a57..01e58b65c9384 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -204,7 +204,7 @@ static bool nilfs_dirty_folio(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct buffer_head *head;
-	unsigned int nr_dirty;
+	unsigned int nr_dirty = 0;
 	bool ret = filemap_dirty_folio(mapping, folio);
 
 	/*
@@ -214,8 +214,6 @@ static bool nilfs_dirty_folio(struct address_space *mapping,
 	head = folio_buffers(folio);
 	if (head) {
 		struct buffer_head *bh = head;
-
-		nr_dirty = 0;
 		do {
 			/* Do not mark hole blocks dirty */
 			if (buffer_dirty(bh) || !buffer_mapped(bh))
-- 
2.26.3

