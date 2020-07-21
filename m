Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8039227B5B
	for <lists+linux-nilfs@lfdr.de>; Tue, 21 Jul 2020 11:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGUJG1 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 21 Jul 2020 05:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJG1 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 21 Jul 2020 05:06:27 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C09C061794
        for <linux-nilfs@vger.kernel.org>; Tue, 21 Jul 2020 02:06:27 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a30so9695685ybj.5
        for <linux-nilfs@vger.kernel.org>; Tue, 21 Jul 2020 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nHNUw5fKJrBs4Yw/4gDozM7ufiIL1f9OJbiyNszRX0w=;
        b=gzWewCkqzF6t0I1uHFY3JNre+Yd9o1QRxPOgeyRzDBxODC5/k0OeoTzJzQevQrTe53
         el7ZR08o/puEO48+NELLWBOkT152iHDFD7Gv9CUgH9uYymLTq2wvuSU7ictqMs8h6GtS
         Pq5aJhoQXnzwgCY3QGbQbROosEUpKFJGTF9F785Lcr281zAZCf/DVWvGBTsflU1zgrz2
         ciRXWipT/rK98btXUyjHQZEyBcWerjjd4J0kjKrdpYeDdjdBe7a1uIjc0qz/Vw65HQkk
         B/x9DQPfd77ImRgOzrT9TaMcaMsUFMePQT/NtFhV+RSVC7czRrH/bIbq3vDhjuv6XCCl
         2MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=nHNUw5fKJrBs4Yw/4gDozM7ufiIL1f9OJbiyNszRX0w=;
        b=FVYvU0F+jGYx2dQJK7sN9jPnaEADhhxbLkU2Jf/sr7WVlLF0kbMt692InTq6CqgT2I
         3UlKo5e2eOrgJJD2f2drY6tqLpu1b9y19ySa6AA4VFamGZ7DtqLBR6pM701BQJegccE/
         r+CNSxlyxD4dO+4oZoqzEOLqX3/7rBZMy6ZdCzVl/PvPvifcP/o28KUb64sQp3foJXJJ
         Pz1DJ26O/Fa4YC9uPAOE8PQJ23b7bglVsnll5LgypgFeaBdagZ/KxXOLnBESpkw0BGTA
         aHSbhZGwkyHppQwSqzYpt/oFA4DcD0kaM7cljrOCeRGk4YQVmRh8M31Ef9DNIdrmmn2U
         mE+g==
X-Gm-Message-State: AOAM531IY1tgrXA5rFSE6/O3qfyPArrNzX7lCnXg8OKQQ+VT3xSCptA8
        SYWTE42amPGCZXxWNxSn+h5PxbFYmichBEOSfx8=
X-Google-Smtp-Source: ABdhPJz96mHD3nkDeB0t1UeeJiU/0QGvjBoChqSU1RrK3QF3daSD+AQSI9+3OaR/AniWH40afKFrhtZDW3umnrIcZJs=
X-Received: by 2002:a25:8008:: with SMTP id m8mr38623233ybk.104.1595322386425;
 Tue, 21 Jul 2020 02:06:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:698b:0:0:0:0:0 with HTTP; Tue, 21 Jul 2020 02:06:25
 -0700 (PDT)
Reply-To: jinghualiuyang@gmail.com
From:   Frau JINGHUA Liu Yang <alvinteddy830@gmail.com>
Date:   Tue, 21 Jul 2020 11:06:25 +0200
Message-ID: <CAM5-t4Lm9iw7ww90NJdQL_ht+GE_Vi8AAK8P4A8RO3cPG6Wmnw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

--=20
Guten Morgen,

     Ich bin Frau JINGHUA Liu Yang f=C3=BCr die Mitarbeiter der CITIBANK
KOREA hier in der Republik Korea. Kann ich $9.356.669 USD =C3=BCberweisen?
Vertrauen?

Mit freundlichen Gr=C3=BC=C3=9Fen
