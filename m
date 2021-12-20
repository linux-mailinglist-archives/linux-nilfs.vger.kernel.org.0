Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D027A47B285
	for <lists+linux-nilfs@lfdr.de>; Mon, 20 Dec 2021 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhLTSDx (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 20 Dec 2021 13:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbhLTSDw (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 20 Dec 2021 13:03:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EDFC061747
        for <linux-nilfs@vger.kernel.org>; Mon, 20 Dec 2021 10:03:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso469773wme.1
        for <linux-nilfs@vger.kernel.org>; Mon, 20 Dec 2021 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=JEStVySRLr2GINyxh3VkR+D/zIXkJGB5FmVtEynirFjv9heyeO9+wCUnTk1Ykaxx/t
         EMo/Yp+1bfNDVDTpdjOXRhh5tDn0BQoiR6U/VmTFzYwKUHWRAEZ/ydtKIgUKoU25eNWF
         F1QWvFtporkaURhF1h+MOK82iPEjQ6E49k4jA8JmWJD5wCJW5zaa77SoqsK9cE2qagqo
         tXpOl90cbImvjbkO70RWpNqjz6qu+itSYZ5gKdqub+kKOGX4YeDI6b3m5gqMOmN5cqqL
         qrakXPAsyvl8Amk+YKAH2MU1yRnf4qmkAfcIcPsvZXJfjnDFJ6pXywp3WrX6hR3cyEjY
         wbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=wlhq27bQxb/ErTv6KNa+/XrWjYuJhN/6nAcEVdFdXlwICgWhcGzvfQa99DLR0C8Iw1
         WMuTI65CLDrVjN/ThjKSbB5mSuXfYUtEcNPcWZfonXKlqZyiV8swNEeztBx6lS2tSugI
         UJ6JfKOZ/XVs/kvHgKJOCXcxhU6DWUBcz9jXQjZJNtJba21DLUWcTb9TLRbF/iWi7Xo7
         hALsV/GvUaGMCgjArVXMTTKSz07wC8ckayEZa1eHdXm5/44cFgKp01hFfI0q1VFLL5Fi
         ckL9UA6yhJIQ3oMWxXOYAN+LAHVMUcIwb0QLq4WyJOzeHyE74iW3+Zp5daZftmgb8AeA
         p1jw==
X-Gm-Message-State: AOAM533muRllxLgq7CLTP4YamAkFG70DGasMnY4Ah9SboU+Y+C/XgUm4
        HX4DOTowlC0DkxkG3uEwZJU=
X-Google-Smtp-Source: ABdhPJzNTYC2MEc9Vgv5PjqY4/qVjH44P0K6tufj5zrfbofHRvE8N+Kk4lqQ5Owb5q/e/v6PbsaWJw==
X-Received: by 2002:a1c:2:: with SMTP id 2mr95796wma.41.1640023427155;
        Mon, 20 Dec 2021 10:03:47 -0800 (PST)
Received: from [192.168.9.102] ([129.205.112.56])
        by smtp.gmail.com with ESMTPSA id o64sm46568wme.28.2021.12.20.10.03.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Dec 2021 10:03:46 -0800 (PST)
Message-ID: <61c0c582.1c69fb81.1ea54.0554@mx.google.com>
From:   Margaret Leung KO May-y <kshirsha16@gmail.com>
X-Google-Original-From: Margaret Leung KO May-y
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Mon, 20 Dec 2021 19:03:40 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
