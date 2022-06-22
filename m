Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25C5549EC
	for <lists+linux-nilfs@lfdr.de>; Wed, 22 Jun 2022 14:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiFVMVq (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 22 Jun 2022 08:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiFVMVp (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 22 Jun 2022 08:21:45 -0400
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 05:21:43 PDT
Received: from mail.lysator.liu.se (mail.lysator.liu.se [IPv6:2001:6b0:17:f0a0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8535A83
        for <linux-nilfs@vger.kernel.org>; Wed, 22 Jun 2022 05:21:43 -0700 (PDT)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 864BE16068
        for <linux-nilfs@vger.kernel.org>; Wed, 22 Jun 2022 14:12:22 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
        id 852BC15E5D; Wed, 22 Jun 2022 14:12:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Score: -1.0
Received: from fmooo.mooo.com (unknown [37.247.17.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id 1942715E5C;
        Wed, 22 Jun 2022 14:12:21 +0200 (CEST)
Received: (nullmailer pid 20687 invoked by uid 1000);
        Wed, 22 Jun 2022 12:12:21 -0000
Date:   Wed, 22 Jun 2022 14:12:21 +0200
From:   Tommy Pettersson <ptp@lysator.liu.se>
To:     linux-nilfs@vger.kernel.org
Cc:     Ciprian Craciun <ciprian.craciun@gmail.com>
Subject: Re: Is NILFS2 suitable for long term archival storage?
Message-ID: <YrMHJYobUpjv+KRj@kelsos>
References: <CA+Tk8fzpXneoDAyvdoJFdFjX7Cx-cJ7GO0uNXjGrYDk23FyekA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Tk8fzpXneoDAyvdoJFdFjX7Cx-cJ7GO0uNXjGrYDk23FyekA@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi Ciprian,

I am using nilfs2 daily at work since 5 years. During this
time I have had a handful of "bad btree node" corruptions.
They don't destroy the current data, but causes weird
problems with snapshots, and I have re-created the
filesystem on these occasions. This is of course not
supposed to happen, and may eventually be fixed if someone
future version.

But the main reason I would not recommend nilfs2 for
long-term backup is, like Ryusuke has mentioned, that nilfs2
does not have checksums and a corresponding scrub mechanism
to validate that no bits on the disk have accidentally
flipped or become unreadable. For safe long-term storage you
will need checksums and scrubbing to detect corrupted data,
and redundancy (raid, mirror) to correct the corruption and
get a notice to replace the failing disk.

Even if safety is not a priority, there is little benefit
from using nilfs2 for backups, since you will probably make
a manual snapshots after a backup anyway, and not have any
use for all the automatic checkpoints that will be created
during the backup.

Another thing that could be an issue is that nilfs2 does not
support xattr, if that is needed for the backup.

Yet another curiosity I have had to deal with is symlink
properties. The standard says that rwx properties of
symlinks may be set to anything but should be ignored. All
filesystems I have used sets them to 777, except for nilfs2,
which honors the current umask value. Now, rsync, which is
probably to blame here, tries to update the properties on
symlinks, and if it reads from nilfs2, and gets something
other than 777, it can not set this other value if the
target is not also nilfs2, and will think it has failed. The
only workaround I have come up with is to find all symlinks
on nilfs2 and update their permission to 777.

That said, I could go on and on about how much I love nilfs2
for its user error protection. I use it as a "working area"
where I can experiment fearlessly, because I can backtrack
to any point in time.
