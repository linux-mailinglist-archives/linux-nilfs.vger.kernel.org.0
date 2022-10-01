Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEA5F1BFB
	for <lists+linux-nilfs@lfdr.de>; Sat,  1 Oct 2022 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJALYv (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 1 Oct 2022 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJALYt (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sat, 1 Oct 2022 07:24:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673971D0D1
        for <linux-nilfs@vger.kernel.org>; Sat,  1 Oct 2022 04:24:46 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 291BOcFq055702;
        Sat, 1 Oct 2022 20:24:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 01 Oct 2022 20:24:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 291BObDx055698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Oct 2022 20:24:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f1438f46-a52d-707b-4ef9-ab29525f1c98@I-love.SAKURA.ne.jp>
Date:   Sat, 1 Oct 2022 20:24:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: [PATCH] nilfs: check filetype/uid/gid at nilfs_read_inode_common()
Content-Language: en-US
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org
References: <000000000000eb0ba805e9d6e30e@google.com>
Cc:     syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000eb0ba805e9d6e30e@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

syzbot is reporting lockdep warning followed by NULL pointer dereference
at nilfs_bmap_lookup_at_level() [1], for a crafted filesystem which
contains raw_inode->i_mode == 0 is poisoning checkpoint inode at
nilfs_read_inode_common() from nilfs_ifile_read() from
nilfs_attach_checkpoint() from nilfs_fill_super() from nilfs_mount().
Check that filetype/uid/gid are valid as well as i_nlink is valid.

Link: https://syzkaller.appspot.com/bug?extid=2b32eb36c1a825b7a74c [1]
Reported-by: syzot <syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This patch solves crash but I don't know whether this patch is correct.

Commit 05fe58fdc10df9eb ("nilfs2: inode operations") did

+       if (inode->i_nlink == 0 && (inode->i_mode == 0 || ii->i_dtime))

and commit 612392307cb09e49 ("nilfs2: support nanosecond timestamp") did

-       if (inode->i_nlink == 0 && (inode->i_mode == 0 || ii->i_dtime))
+       if (inode->i_nlink == 0 && inode->i_mode == 0)

and commit 705304a863cc4158 ("nilfs2: fix the nilfs_iget() vs. nilfs_new_inode() races") did


-       if (inode->i_nlink == 0 && inode->i_mode == 0)
+       if (inode->i_nlink == 0)

but I don't know which commit was wrong. Is inode->i_mode == 0 valid in nilfs?

 fs/nilfs2/inode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 67f63cfeade5..798efd879642 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -442,6 +442,20 @@ int nilfs_read_inode_common(struct inode *inode,
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
 	if (inode->i_nlink == 0)
 		return -ESTALE; /* this inode is deleted */
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFLNK:
+	case S_IFREG:
+	case S_IFDIR:
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		break;
+	default:
+		return -EINVAL; /* Filetype is invalid */
+	}
+	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+		return -EINVAL; /* UID/GID is invalid */
 
 	inode->i_blocks = le64_to_cpu(raw_inode->i_blocks);
 	ii->i_flags = le32_to_cpu(raw_inode->i_flags);
-- 
2.34.1

