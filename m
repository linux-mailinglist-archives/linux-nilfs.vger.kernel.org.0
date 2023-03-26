Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3906C93B7
	for <lists+linux-nilfs@lfdr.de>; Sun, 26 Mar 2023 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCZKNz (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 26 Mar 2023 06:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjCZKNx (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 26 Mar 2023 06:13:53 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E37469A
        for <linux-nilfs@vger.kernel.org>; Sun, 26 Mar 2023 03:13:52 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32QADboD084425;
        Sun, 26 Mar 2023 19:13:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sun, 26 Mar 2023 19:13:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32QADb49084422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 26 Mar 2023 19:13:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1103c7b0-0e46-4a92-74ee-920bf9599a80@I-love.SAKURA.ne.jp>
Date:   Sun, 26 Mar 2023 19:13:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: [PATCH v2] nilfs2: fix incomplete initialization in
 nilfs_direct_assign_p()
Content-Language: en-US
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, glider@google.com,
        linux-nilfs@vger.kernel.org
References: <0000000000000d710705f63f014c@google.com>
 <6c1d39bc-b19b-becf-821e-8cc9db8b4167@I-love.SAKURA.ne.jp>
 <CAKFNMokJ0_n6y3Wrc87WfhKA02ay4dqP7R_4XnonqDCj_Tuqcg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAKFNMokJ0_n6y3Wrc87WfhKA02ay4dqP7R_4XnonqDCj_Tuqcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

nilfs_direct_assign_p() from nilfs_direct_assign() from nilfs_bmap_assign()
is not initializing "struct nilfs_binfo_dat"->bi_pad field.

We need to initialize sizeof("union nilfs_binfo"->bi_dat) bytes if
nilfs_write_dat_node_binfo() from nilfs_segctor_assign() copies it
and nilfs_add_checksums_on_logs() passes it to CRC function.

Link: https://syzkaller.appspot.com/bug?extid=048585f3f4227bb2b49b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Use memset() for initialization, suggested by Ryusuke Konishi.

 fs/nilfs2/direct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index a35f2795b242..4c85914f2abc 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -314,6 +314,7 @@ static int nilfs_direct_assign_p(struct nilfs_bmap *direct,
 
 	binfo->bi_dat.bi_blkoff = cpu_to_le64(key);
 	binfo->bi_dat.bi_level = 0;
+	memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));
 
 	return 0;
 }
-- 
2.34.1

