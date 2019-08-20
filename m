Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11FC966FC
	for <lists+linux-nilfs@lfdr.de>; Tue, 20 Aug 2019 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfHTQ6r (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 20 Aug 2019 12:58:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42173 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfHTQ6q (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so5079283qkm.9
        for <linux-nilfs@vger.kernel.org>; Tue, 20 Aug 2019 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:reply-to:date:message-id:subject:to;
        bh=Bc3+trJVxu3aAYC67i/cNPRp5gvRjUQQvN3492Msyyk=;
        b=tC9kmrq1fVlnaLp4SWTARYVsmkGNjoLEEH0/4i0/4p9DN2MkIukM1jEwJjzcqMa0F+
         Wx+IU+yWRvTs9Yol0j+DwW7YCSWbzBO4ofIDCZ/aJZXLJ/lHJnW/oy6xoh9RQq+3PL8S
         /RgRMiqSj0bZRldKCSMFTxGxlpRhRXFIpV4I/F27h1G8YQ04u+BrZacXyCCiMBW3cNUT
         8Nuh/dpEmxIwYQHy0Rhn/65XNzSMh+VNhNhq9sZ/cQW6Lg86slqBYasUCnrqOTZehNYW
         +cjrmg7hsR1ctbhvj57vGEmhUqGiG4By7xmfFUwEc4oVC5obFnPz5CPanzdrzrvTeI3W
         10uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:date:message-id
         :subject:to;
        bh=Bc3+trJVxu3aAYC67i/cNPRp5gvRjUQQvN3492Msyyk=;
        b=rjA712MqSHVQmdwSgIfRAraVZKbB/GHZ3PI4n8Jkhh8Hq0wogvxbM2ITtytxf0n4G7
         Stu8TO4eGffo0tk6odzo/nRYmmNgbLPjy4K3Xq97IP7E/SCDuk08WBFUZ87/9Ro1wTts
         ozAPopdMucRpibEu/IQmgCKV1GbWS3reRK8FvDuY6NRqiQn+Is3mwP3tSeVQ19FNOMCj
         5AN2WARzc0CbTMpLbGVxBC9ukf9OTGJ9xp4DpGyPuDMIG6KGNPXlgVS9c1nHAstfEvnQ
         nbfaMe40TJfoOQtI0aV+R/fJL0kkYpLxX/v7e6AVkj/SpMKB02ezpDnO735MCOtlCT0T
         CZxg==
X-Gm-Message-State: APjAAAVCCl71d+qECCDYy+38Uu6c9yZZRMycp/LaT5OHE/1oPoqfq8yx
        UCiYeMyNW/rCTzWnaSrLlTHY8Gks5HYpQdNXvb7IUQ==
X-Google-Smtp-Source: APXvYqzngLXb6GUnDLnY4Ik2pvCtKwBlgJ4aPjHnvoje1FuLspIb/Ylg6qNjzr5njWtgeUp0YYA9cWcGeT+W4pXixm0=
X-Received: by 2002:a05:620a:710:: with SMTP id 16mr25862238qkc.382.1566320326117;
 Tue, 20 Aug 2019 09:58:46 -0700 (PDT)
Received: from 927538837578 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2019 12:58:45 -0400
MIME-Version: 1.0
From:   linuxnilfs@gmail.com
Reply-To: Linux NILFS <linux-nilfs@vger.kernel.org>
Date:   Tue, 20 Aug 2019 12:58:45 -0400
Message-ID: <CAE7Udf_=1CVQUqVZUHV9HCez3Kg24CcmhLj7Wjyfb=EFNcA-9A@mail.gmail.com>
Subject: NILFS utils 2.2.8 was released
To:     linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

A maintenance release with some fixes

from https://nilfs.sourceforge.io/en/download.html#2.2.8-u
