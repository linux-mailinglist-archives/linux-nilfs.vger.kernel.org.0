Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375EC602969
	for <lists+linux-nilfs@lfdr.de>; Tue, 18 Oct 2022 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJRKge (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 18 Oct 2022 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJRKgd (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 18 Oct 2022 06:36:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D432B632
        for <linux-nilfs@vger.kernel.org>; Tue, 18 Oct 2022 03:36:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n73so11326635iod.13
        for <linux-nilfs@vger.kernel.org>; Tue, 18 Oct 2022 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bghXZht/FJ5ch8pbZ5Ej2OdFU1AcwTtiCLzsPZREjY=;
        b=Gn0oeG5qQW7Rm6+kr0ewLnKPPFkrRwHac+bcS44GHF8mDyjloX30TRHS09GVUamrCC
         pvQ9nxDHuXC/A8zM4gBoMsB+lnflTO1f3KjqPn/GQfLBFNo1fv1SBKfDNIFBBOYJP7ur
         8erHkaWH565nbQ4560AwZ9+li5N4+pKFI379lTe+Ok8uk6WD68PdAGGG7Cfti/p/XarS
         UjW6iMLX6FSUxLR66h7DG5SKwP23/XIPW7HQjUwis5DJjdjXzLYJXyvqpOVtRiwVUK9b
         GwA7fID/4s5dZdrGBVMiIqiojqBLqqcFBUZaPxFK5a4ddBeWhvAOWubHFwBO+0Zy8Hsh
         knSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bghXZht/FJ5ch8pbZ5Ej2OdFU1AcwTtiCLzsPZREjY=;
        b=uzHYbSblV9WSf1nUVhcJn9paAB2bMoIrrytuFP/WW6T6gjDRgLk9Nm2ankT9l38mKE
         0WtbhOkJqdRdA0u5jNAuSu40WToYzmO6FbS+KOubAykPxqtDo458wQmP0ai2VcBKoLQu
         3FPfAU9ZCaXvP/F4Apnaipc2ZY3BMWS4d3gaHaSUW6AcUv5ev50mjsTlNHg06F/eKhE0
         mNaLIE00Y4mupgUUiDQfOXAAYObCrmnJXdLVkVHOYtU6MUZ0TcitUckYeRfdBgn4Zw7C
         RGkg6TPYjPqh9OX6KHGjD42NfQXFHHjYTzHz3V3f60IrgLJrupDOlnlFYrpr/smUWNGD
         NezQ==
X-Gm-Message-State: ACrzQf37KlbuOpEd8HsAzWHf4alpOHAfBuSb9lFyJArgen39figSgF7z
        1KXqW/IYxFdmFJvmyL39cXKMHNvdzxj8yWN7Pq8mFl6q
X-Google-Smtp-Source: AMsMyM7vKlbSEpziWAdgxfBbcSBbuWRU7Nuux1k2WnwnD+Cf36Q4ZVL2dlq71d8jZvugZJU/ZbcEuhnGAMnEyJdawFU=
X-Received: by 2002:a5d:9ac1:0:b0:6a3:1938:e6b0 with SMTP id
 x1-20020a5d9ac1000000b006a31938e6b0mr1329828ion.186.1666089390152; Tue, 18
 Oct 2022 03:36:30 -0700 (PDT)
Received: from 927538837578 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Oct 2022 03:36:29 -0700
MIME-Version: 1.0
From:   "Linux NILFS <linuxnilfs@gmail.com>" <linuxnilfs@gmail.com>
Reply-To: Linux NILFS <linux-nilfs@vger.kernel.org>
Date:   Tue, 18 Oct 2022 03:36:29 -0700
Message-ID: <CAE7Udf9z-LbpQoNCXj+FAdZQhTfgg9SqhDD4qK8h_Nbya=W+3A@mail.gmail.com>
Subject: Published nilfs2-kmod9.
To:     linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Published nilfs2-kmod9, a standalone kernel module for RHEL 9 clones.
Available for AlmaLinux 9, Rocky Linux 9 and CentOS Stream 9.

For details, please see the repository,

ChangeLog file, or commit logs.

from https://nilfs.sourceforge.io/en/index.html#n135
