Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3D46F044A
	for <lists+linux-nilfs@lfdr.de>; Thu, 27 Apr 2023 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbjD0Kjl (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 27 Apr 2023 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0Kjk (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 27 Apr 2023 06:39:40 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65550FF
        for <linux-nilfs@vger.kernel.org>; Thu, 27 Apr 2023 03:39:39 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32f23e2018fso26164365ab.0
        for <linux-nilfs@vger.kernel.org>; Thu, 27 Apr 2023 03:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682591978; x=1685183978;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tW3lXjwwvfoDVqxWAf7Y3WOKVF4KqvvCL69ImettA3o=;
        b=MLDi2fwVVGdbgilM31A2I7ful9pJ5bGT/wBlwEEIojJofOvbkZoLeQ0eQ85Bsn1H1m
         EVkxrqYviulq9LMcKPzAOo/M78Nm37GYrWk7gI2cbSxeP3e3JCgoEcOfQFtKlhqTeuNh
         LzVu2uY+Dt9DC8yW9l15VPdyquanbvIu5QxBnGnnSwm78yShMmuj58BIJLjo+Qk/UCy+
         PzfLSIPr9vbnrFpsMNJNeGjf8Q87wekI10T1S4fykPEb4MxLYB1zgiQ6n631XQDhrBns
         3S70Nu4ZE8YOa037GBPX61aMEMmyLtmmjUXnQLtmeyVp2Rzr4zPKSHUvYFEvSV1F2SMB
         p0MQ==
X-Gm-Message-State: AC+VfDyF4WLwoW9Qpym4hLzdukSIdIj6+ZVGLZesq3b653QWCgnPDx5r
        Eur1pe3ot25l03yiQxHkZW3V10rPksAK0iVJwLa8b/tUPotd
X-Google-Smtp-Source: ACHHUZ7UuotYn7/Qzw/4dXAbuxUIl2RCcVpdBNfl5F7f81acWzI1cipma/pIr/+4zaRJCADT1SoJG+S2vLZkF8iW0eH2CUHi5OEA
MIME-Version: 1.0
X-Received: by 2002:a92:c90e:0:b0:32f:ea0:785e with SMTP id
 t14-20020a92c90e000000b0032f0ea0785emr1077533ilp.2.1682591978799; Thu, 27 Apr
 2023 03:39:38 -0700 (PDT)
Date:   Thu, 27 Apr 2023 03:39:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032c8c505fa4ef9cc@google.com>
Subject: [syzbot] Monthly nilfs report (Apr 2023)
From:   syzbot <syzbot+listf919ad9f1f609cd7cf5d@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 3 were fixed.
In total, 17 issues are still open and 24 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1238    Yes   INFO: task hung in lock_mount
                   https://syzkaller.appspot.com/bug?extid=221d75710bde87fa0e97
<2>  605     Yes   WARNING in nilfs_btree_assign
                   https://syzkaller.appspot.com/bug?extid=31837fe952932efc8fb9
<3>  321     Yes   WARNING in nilfs_sufile_set_segment_usage
                   https://syzkaller.appspot.com/bug?extid=14e9f834f6ddecece094
<4>  241     Yes   INFO: task hung in sync_inodes_sb (4)
                   https://syzkaller.appspot.com/bug?extid=7d50f1e54a12ba3aeae2
<5>  195     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<6>  55      Yes   INFO: task hung in nilfs_detach_log_writer
                   https://syzkaller.appspot.com/bug?extid=e3973c409251e136fdd0
<7>  28      Yes   kernel BUG in folio_end_writeback
                   https://syzkaller.appspot.com/bug?extid=7e5cf1d80677ec185e63
<8>  21      No    KASAN: slab-out-of-bounds Read in nilfs_iget_test
                   https://syzkaller.appspot.com/bug?extid=cac676135771fc8f1eb2
<9>  6       No    BUG: unable to handle kernel NULL pointer dereference in nilfs_segctor_do_construct
                   https://syzkaller.appspot.com/bug?extid=5afc832d6dbb2fd17538
<10> 3       No    WARNING in nilfs_btree_propagate
                   https://syzkaller.appspot.com/bug?extid=527641d191abe35993c1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
