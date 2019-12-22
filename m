Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA5128C99
	for <lists+linux-nilfs@lfdr.de>; Sun, 22 Dec 2019 06:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfLVFMD (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 22 Dec 2019 00:12:03 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38234 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfLVFMD (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 22 Dec 2019 00:12:03 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so5211929qvs.5
        for <linux-nilfs@vger.kernel.org>; Sat, 21 Dec 2019 21:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EcuYR/cmyuV4MkHtcnRAElLeh08ralhwl0TXIbFHQwY=;
        b=eHNvI+h3K/+CU95ficRWCKeQngbw4ref5bo3oWHdi0VsuTvbdnbh+e8+PrWLG9MxrQ
         fel89zZnM9odNMzjo/GG5fy3clWvrJKoELKsxaTVG/XCHeLX46wQ4CnAqgtXCWW+9xPf
         BPgPmJmCoh97WZU/UfVZVUM0WhGv3nfHIHJ147nyVrHRh+ji0bDsD1T0/MWrMX6BdsQA
         DZOwkpEjHQcl8+E8ADOFqFCctZ1Dwkm9aWlTfzCroxHX5SDkCqcXLlYQJJWjsIh7qNG6
         kpbDqOFSlw1Mn4XlSCA9pMcgLj0z0PjysaBXZmNEUJPT1gzK8aeXFd3EwiXJ8wAAVOCo
         pEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EcuYR/cmyuV4MkHtcnRAElLeh08ralhwl0TXIbFHQwY=;
        b=VUUASlh9USP8CTm7vxQ2e6b60IjYsdBqzHdTeHeedF5Z4rojcl6cXOJpxo6Ji3MhgB
         Qx7g2s4JfSpaPB75MEhTrIXTV8h4oUQQVIu8BbM8cLhMmB6mvoPBfSjcz6nvMJKAbtjc
         iqpdH2zeLnBpgx6f4BEpyH5Hk6IMyvkHnAW8QEisosCfjFM5QncUTljhIEmwjufyHl5R
         c8KYrnFvoInvQ2i9dLzQHxZulODErlYM0rcsbT+RSulSNaIO1UsSJlbv1kcJ5wN3LWuI
         +UcnsNcCCfG2+I5avGZIyKZL0KgzTLF5XhBTIzCibbGn/RDiQNWWY5ZSeN10yDnz4zjp
         MkMQ==
X-Gm-Message-State: APjAAAWGd8SN2MWmYAgxw4rV5TiqXO9p+sHaUuxTwgM4nvwXVyyIZXQi
        HFReuq6UZEt9g5J4ceTPxZjzoJhGIIrPx9OAihuWXXYxtew=
X-Google-Smtp-Source: APXvYqxOPt0yNutkYlW5ipJoBcKoRaUS07DKk3NdxJwXjjrbzBNnYVwP3uTYmsL6r60bMvBvLfmfKdb/SjljICHF/WA=
X-Received: by 2002:ad4:4dc3:: with SMTP id cw3mr18859172qvb.130.1576991521891;
 Sat, 21 Dec 2019 21:12:01 -0800 (PST)
MIME-Version: 1.0
From:   "Daniel Bonner (OsPark)" <osborne.park@gmail.com>
Date:   Sun, 22 Dec 2019 16:11:51 +1100
Message-ID: <CAM7pBgMxOcKM_tH7HCajfBLX2kw80zs02pbhhnY+91srTqQuEg@mail.gmail.com>
Subject: kernel 5.4.3 Ubuntu mainline crashes when trying to write to nilfs2
To:     linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi nilfs developers,
I have no problems using nilfs2 with Ubuntu official kernel
5.3.0.24.26 on Ubuntu 18.04.  However if I install mainline kernel
5.4.3 the system freezes when I try to write to an nilfs2 partition.
Regards,
Daniel
