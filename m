Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464F740AB11
	for <lists+linux-nilfs@lfdr.de>; Tue, 14 Sep 2021 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhINJoZ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 14 Sep 2021 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhINJoX (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:44:23 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2FC061574
        for <linux-nilfs@vger.kernel.org>; Tue, 14 Sep 2021 02:43:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s16so26939605ybe.0
        for <linux-nilfs@vger.kernel.org>; Tue, 14 Sep 2021 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=glzbzmrCPWLsOheQe4o1My9WgmGNFkD73CJ7Z8e0T5E=;
        b=oUjKPSIw1KxBDayBD8+lj9oZQIVnH3igcTRawWvFwtpzcp2mMwwfbg9lvYlRyS3Ldf
         P1nbGltTZ8RjPqIZo1ZiZYWXTqP4KAEl3EXe+BAb+UdHrI8ZLC06Z4Q0CjIU/pbF5i2X
         g9ewSJSL/qkrFP+2w4uTkOqxFAc05Zs+QxfCmU4epNxAxv6jYcYq1M6y2w0rHB1aT6Dr
         98RbIqHMQIT7wbIccCIM9F+CC6MV8PSa815vRcJRGTAB/+v6NcWCXSR8l2T8hdPnE26I
         gCimbas2Suv4MG7u4u0wwX4m7Kq//moW9DgKBl8/RxvJ0qOzV2rb9N4vUmRVGYFMF0Kp
         Ljsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=glzbzmrCPWLsOheQe4o1My9WgmGNFkD73CJ7Z8e0T5E=;
        b=IWbn9LcThH4wCP1ipM4/1xSMqtmKi0KamHFWrf/oowcvebQzoqzmzQIMyNg4AA/T8G
         s1Fyk7kMv2Vc/oMjcx5d+GXGkV8QNb8himeCW7m8ezRUtmCn7ivtQeG3j+Nk10PIpncb
         MXY6RnWLin/8i0uk0w7BUyL8u6aW/VNCegXyoOIMm1YA1qH2ez8tlo7wMzfB2tkIJ/uj
         UfiFCYPbTwwhV5WoZepkrUIxf/hrPLfY8+GYU+n3/dhKKBVfbKT+LWqCC/kybbaw2gwO
         jIJ8x/EcqY5JutzGV9d2TlSETVDWVmcDf6UiYjYC95rl8JFzwoaKkWbfe+1zj1DpSVCV
         ageA==
X-Gm-Message-State: AOAM5329F4gQ1oKiml/F5Meu1OEd9zB6wzFlAk7DeIoJLhVd+VSLJ8Gt
        5p3C+o/ydonMC/QIFXemZh8vuWs4x4hmPBHXZQNi2V96WY4=
X-Google-Smtp-Source: ABdhPJyNPCmgH2Rv6fFcWdflnumndeE8vDbMsmYNLoWVaffuBkIOaX2zFlcscijN3STaGHnZp4hskuN+0xh0hKzqVRM=
X-Received: by 2002:a25:2302:: with SMTP id j2mr21034053ybj.507.1631612585815;
 Tue, 14 Sep 2021 02:43:05 -0700 (PDT)
MIME-Version: 1.0
From:   dexen deVries <dexen.devries@gmail.com>
Date:   Tue, 14 Sep 2021 11:42:54 +0200
Message-ID: <CAJUT6o672tBVfPRSBqz2RRwLhWqfhD2EHuNY-s6GyASYdFwD4g@mail.gmail.com>
Subject: Filesystem crash and unexpected recovery
To:     linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Writhing this in case somebody finds it helpful.

tl;dr: filesystem crashed due to overfilling, refused to mount with
errno -5, was recovered automatically by nilfs-resize

Due do my mix-up I have over-filled my root filesystem (220GB) with
large file (~150GB), as root. The filesystem locked up (kernel
5.14.0-rc6), after forced restart refused to mount, returning errno
-5. The nilfs-tune tool indicated seemingly correct content. other
tools could not access the filesystem.

Under pressure of time I have given up on it and decided to re-install
system; using nilfs-resize (through gparted) unexpectedly recovered
the filesystem. The tool correctly detected filesystem and was able to
work with it, but for completion required a number of extra blocks to
perform the operation. The filesystem worked since. Again, due to time
pressure I wasn't able to preserve filesystem snapshot or anything -
only this written summary is available.

Best regards,
--
dexen
