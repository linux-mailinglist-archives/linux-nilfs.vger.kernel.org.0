Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259E72B41C
	for <lists+linux-nilfs@lfdr.de>; Sun, 11 Jun 2023 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjFKVSc (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 11 Jun 2023 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFKVSc (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 11 Jun 2023 17:18:32 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479691AB
        for <linux-nilfs@vger.kernel.org>; Sun, 11 Jun 2023 14:18:30 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77accdaa0e0so367808539f.0
        for <linux-nilfs@vger.kernel.org>; Sun, 11 Jun 2023 14:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686518309; x=1689110309;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++zemBX/2RrOYOFOLtSc1QjMmPmCs+Z/n8b0jPh3c7o=;
        b=fKYa3Zj/+H1wOa5wBS+1pFN5YBDQBU1q2i6zB4wNhaapCneROaAwEtc/Y+pTY920hW
         dbnhC0WULSov562NX+DZxIRtG+0TE828LmvKfqRrNWdI+h5nYaUzlC0dvfhXe/XgMaEN
         30rIYRQruN4ZmEiWiF7fCOcWiSd+FOZRMLw27SCjBhrhni9V8EgTMw3MoZRUSuuF03jY
         ADjR62mPoAM1NTPj3HpWQELDGQh3pTShuETd+akm5qEhRTQDuuTygN7LjpCOe80qR34+
         DZfpCrEyZ+ZdX4SnBq4WssbEBVrRrvWNxzDxVPl+9ETEI58mAL3c14gXQRP9UIS4klmv
         E8Fg==
X-Gm-Message-State: AC+VfDxL31HPH/fm1jQejLam4aVvYugSq3sqn8srj8dpyRMHY4U+FyXl
        XuTVSNVuKKMx+k2WSMJpx1h7Wi2eBQMZrHqA+wPUObmpOBtd
X-Google-Smtp-Source: ACHHUZ5uexlpBPtPJccaNdHhmErmovEuc0aJEQv+DulBACxbzELH3wDT/Ehuljo6vWiQkQ7yLj0tlIJ2iLEPDZLXWLeSG1iJZatu
MIME-Version: 1.0
X-Received: by 2002:a6b:fd15:0:b0:777:afc6:8da0 with SMTP id
 c21-20020a6bfd15000000b00777afc68da0mr2935869ioi.1.1686518309621; Sun, 11 Jun
 2023 14:18:29 -0700 (PDT)
Date:   Sun, 11 Jun 2023 14:18:29 -0700
In-Reply-To: <000000000000da4f6b05eb9bf593@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0951105fde12435@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in nilfs_clear_dirty_page
From:   syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dsterba@suse.com, hch@lst.de,
        konishi.ryusuke@gmail.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

syzbot has bisected this issue to:

commit 4a445b7b6178d88956192c0202463063f52e8667
Author: Qu Wenruo <wqu@suse.com>
Date:   Sat Aug 13 08:06:53 2022 +0000

    btrfs: don't merge pages into bio if their page offset is not contiguous

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17778475280000
start commit:   022ce8862dff Merge tag 'i2c-for-6.4-rc6' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f78475280000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f78475280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=53369d11851d8f26735c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e9d48b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d7fa63280000

Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com
Fixes: 4a445b7b6178 ("btrfs: don't merge pages into bio if their page offset is not contiguous")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
