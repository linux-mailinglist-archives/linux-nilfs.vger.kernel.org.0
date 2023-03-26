Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699F6C92D1
	for <lists+linux-nilfs@lfdr.de>; Sun, 26 Mar 2023 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCZGcZ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 26 Mar 2023 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZGcY (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 26 Mar 2023 02:32:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D88A54
        for <linux-nilfs@vger.kernel.org>; Sat, 25 Mar 2023 23:32:22 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32Q6W8Em030738;
        Sun, 26 Mar 2023 15:32:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 26 Mar 2023 15:32:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32Q6W8Oa030735
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 26 Mar 2023 15:32:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6c1d39bc-b19b-becf-821e-8cc9db8b4167@I-love.SAKURA.ne.jp>
Date:   Sun, 26 Mar 2023 15:32:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: [PATCH] nilfs2: fix incomplete initialization in
 nilfs_direct_assign_p()
Content-Language: en-US
To:     syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>,
        konishi.ryusuke@gmail.com, syzkaller-bugs@googlegroups.com
References: <0000000000000d710705f63f014c@google.com>
Cc:     glider@google.com, linux-nilfs@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000000d710705f63f014c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

syzbot is reporting uninit value at nilfs_add_checksums_on_logs() [1], for
nilfs_direct_assign_p() from nilfs_direct_assign() from nilfs_bmap_assign()
does not initialize "struct nilfs_binfo_dat"->bi_pad field.

We need to initialize sizeof("union nilfs_binfo"->bi_dat) bytes if
nilfs_write_dat_node_binfo() from nilfs_segctor_assign() copies it
and nilfs_add_checksums_on_logs() passes it to CRC function.

Reported-by: syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=048585f3f4227bb2b49b [1]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
I'm not sure whether this can fix the bug, for a reproducer is not yet
available...

 fs/nilfs2/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index a35f2795b242..4358b4581ec4 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -313,7 +313,8 @@ static int nilfs_direct_assign_p(struct nilfs_bmap *direct,
 	nilfs_direct_set_ptr(direct, key, blocknr);
 
 	binfo->bi_dat.bi_blkoff = cpu_to_le64(key);
-	binfo->bi_dat.bi_level = 0;
+	/* initialize bi_pad field together while assigning bi_level field */
+	*(u64 *) &binfo->bi_dat.bi_level = (u64) 0;
 
 	return 0;
 }
-- 
2.34.1

