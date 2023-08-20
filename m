Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE2781F4A
	for <lists+linux-nilfs@lfdr.de>; Sun, 20 Aug 2023 20:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjHTSl4 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 20 Aug 2023 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHTSlx (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 20 Aug 2023 14:41:53 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4D31BF4
        for <linux-nilfs@vger.kernel.org>; Sun, 20 Aug 2023 11:41:24 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-563ab574cb5so2765797a12.1
        for <linux-nilfs@vger.kernel.org>; Sun, 20 Aug 2023 11:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692556884; x=1693161684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/n5kjMvYzdRUXwH8feZ+4YEm3skk2x5QaWimKw+DCM=;
        b=lmQzfXpZAapHGrp/EaWyD+Sp246t9t1eanc7dr2CHDH56qFEBAmpu40uAffO42mJyD
         SNS4yjDW2x/G99Cw+X/hV/SP0LV3pDHwnxV92hK5qqm9eyAuydswTOaIbODuklPXSOYp
         wBZVOUtFDkqrujJ7CQNH0DbLLMSjP1iCyTYWVWQvMSWltFW3QGaKVlvd/pAfibEGutN1
         cM7P3UqOLvO1nGLwSqi+jHwjG5s2zvLYyuGfaZolTyHyjjVz+cNXi4fVy+aaukUkbJWG
         HhgzvAny53NTgPTJIFdb4Od8eYQkxDN/rAunjFz4eodjbJ7hNspAs4UUBi/VrydyYfaV
         okUA==
X-Gm-Message-State: AOJu0Yzvce0vcbHgbI7n5H8of5Q+HAR1O/txBolvB48xamfnWl4778ll
        o0XZ+VpsA2DCpelVtyhvKgxSzWNbFbGf6GIrAextD/1flsxy
X-Google-Smtp-Source: AGHT+IG3eaeUAH2EW45k/+HZjIXX99Q9piV7GARJu71AM1i236ME0RtbJCZz+N43b2fgb4vOTwTGQxFuzEj7n5oY0lhEjCqFkOik
MIME-Version: 1.0
X-Received: by 2002:a17:902:c449:b0:1bb:b74c:88fa with SMTP id
 m9-20020a170902c44900b001bbb74c88famr1918271plm.6.1692556883825; Sun, 20 Aug
 2023 11:41:23 -0700 (PDT)
Date:   Sun, 20 Aug 2023 11:41:23 -0700
In-Reply-To: <000000000000dc83d605f0c70a11@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d299b406035f1bbd@google.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in folio_end_writeback
From:   syzbot <syzbot+7e5cf1d80677ec185e63@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org,
        konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 92c5d1b860e9581d64baca76779576c0ab0d943d
Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri May 26 02:13:32 2023 +0000

    nilfs2: reject devices with insufficient block count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170c6337a80000
start commit:   929ed21dfdb6 Merge tag '6.4-rc4-smb3-client-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3da6c5d3e0a6c932
dashboard link: https://syzkaller.appspot.com/bug?extid=7e5cf1d80677ec185e63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb3b69280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f34201280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: nilfs2: reject devices with insufficient block count

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
