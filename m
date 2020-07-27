Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9422F0F1
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Jul 2020 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbgG0O2i (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 27 Jul 2020 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgG0O2g (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 27 Jul 2020 10:28:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B6C061794;
        Mon, 27 Jul 2020 07:28:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t6so8083118plo.3;
        Mon, 27 Jul 2020 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HabJRMADlao94yEJSHvnaFVFEzocZspVEhiAVrZ3aoQ=;
        b=EiK/d5uDMNQE9vA1GyKcPJPFxOOm+RbyqY0iYHtKHqhk2ffuujz6UNYW1/cqPpvYfZ
         gU3F5MFFPtqU45FZKE/tg/H+j0MXV8L2UjDlzTaP3cpzOjc3r7cGwTO56lSda8fexDMO
         9mLL/KhNY7Kb+TgTsMa9JWKbCS6fu7VZs5kX+QjdvZw9VVIl15AlmcQ4p6ogFq97gSV5
         BvDtJZ8s99qTPau/B1aB/B52LMH5VkipFeRkIutLMCh5v6fb1UnhXy8RfFBjnveTEnNH
         moDN1EA2OOV4ZKxnOjV30eZi57X0aQD5TvGToA97VmyjJzFHZH/Ca/jvsAVMeLu/6W6j
         WvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HabJRMADlao94yEJSHvnaFVFEzocZspVEhiAVrZ3aoQ=;
        b=NF0NKuRW9ouVD2xuiAs3PJb+Unp92ioDhixWcKIIwRyniZRcPad5bfzEW++EVsaJGq
         k8H8KUKB1DxEzuqTU50fZiry2IdI0/bOjKWmlYWdkxTsg9GtaYP3qBzV6i7ZzRjuULrw
         70U+MttP98xGtdMnmX1gKIHVV8Nvx51J+E7Vmr/G8J5Lo/k5ndBRXU1Qq0XjUn82CRLE
         x1mQQv2xnr7zeZQUzQgccZ0S+MWSzklSrksGZTDq/rd/sk8gdW79vibdrr67xH1Er8d7
         eAenTgv93puXWBxiHISefol4qRAz/WMe4ISj5XQs8Yh828SLrG2G0iNPPa0yRGYAWha8
         1tlQ==
X-Gm-Message-State: AOAM5315ERqGocH9WmsvDcpIt0hUvQ0HUiefnROBXFucJHRvd+6F72Ph
        STnF/MOKxBUdPZAqb7IwqOCutGzMNAI=
X-Google-Smtp-Source: ABdhPJyailnQLU/5YatsDIUFYY/yJT3Gd0bUIDV0NdAPqycJFBx3uWZid22W6rHh6A0J8KDT/HJT3Q==
X-Received: by 2002:a17:90b:3555:: with SMTP id lt21mr20186735pjb.234.1595860116064;
        Mon, 27 Jul 2020 07:28:36 -0700 (PDT)
Received: from carrot.localdomain (i60-35-88-138.s42.a014.ap.plala.or.jp. [60.35.88.138])
        by smtp.gmail.com with ESMTPSA id g18sm15430460pfk.40.2020.07.27.07.28.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:28:35 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] nilfs2 updates
Date:   Mon, 27 Jul 2020 23:28:28 +0900
Message-Id: <1595860111-3920-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi Andrew,

Please queue the following changes for the next merge window:

Eric Biggers (1):
  nilfs2: only call unlock_new_inode() if I_NEW

Joe Perches (2):
  nilfs2: Convert __nilfs_msg to integrate the level and format
  nilfs2: Use a more common logging style

In this series,

>  nilfs2: only call unlock_new_inode() if I_NEW

fixes wrong unlock_new_inode() call and related WARNING which can be
triggered from error paths of nilfs_new_inode().

>  nilfs2: Convert __nilfs_msg to integrate the level and format
>  nilfs2: Use a more common logging style

reduce object size and use more common kernel logging styles.

Thanks,
Ryusuke Konishi
--
 fs/nilfs2/alloc.c     | 38 +++++++++++------------
 fs/nilfs2/btree.c     | 42 ++++++++++++-------------
 fs/nilfs2/cpfile.c    | 10 +++---
 fs/nilfs2/dat.c       | 14 ++++-----
 fs/nilfs2/direct.c    | 14 +++++----
 fs/nilfs2/gcinode.c   |  2 +-
 fs/nilfs2/ifile.c     |  4 +--
 fs/nilfs2/inode.c     | 32 +++++++++----------
 fs/nilfs2/ioctl.c     | 37 +++++++++++-----------
 fs/nilfs2/mdt.c       |  2 +-
 fs/nilfs2/namei.c     |  6 ++--
 fs/nilfs2/nilfs.h     | 18 ++++++++---
 fs/nilfs2/page.c      | 11 +++----
 fs/nilfs2/recovery.c  | 32 +++++++++----------
 fs/nilfs2/segbuf.c    |  2 +-
 fs/nilfs2/segment.c   | 38 +++++++++++------------
 fs/nilfs2/sufile.c    | 29 ++++++++----------
 fs/nilfs2/super.c     | 73 ++++++++++++++++++++++---------------------
 fs/nilfs2/sysfs.c     | 29 ++++++++----------
 fs/nilfs2/the_nilfs.c | 85 ++++++++++++++++++++++++---------------------------
 20 files changed, 256 insertions(+), 262 deletions(-)

-- 
1.8.3.1

