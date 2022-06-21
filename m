Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44EC552EF4
	for <lists+linux-nilfs@lfdr.de>; Tue, 21 Jun 2022 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349157AbiFUJlf (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 21 Jun 2022 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349386AbiFUJlN (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 21 Jun 2022 05:41:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098EB275E8
        for <linux-nilfs@vger.kernel.org>; Tue, 21 Jun 2022 02:41:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k22so11644141wrd.6
        for <linux-nilfs@vger.kernel.org>; Tue, 21 Jun 2022 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0/Z6/I6MXGt005euOEO8lskeXxe8CmInEjWcMvwjoVw=;
        b=Ow/90e63LjwtOUgoFS7unWWIJj7F8D54Tjn7+Mq2TRx9LXYUJIknV6uKYfPIZjjOis
         Dgv83CpC4kIVW05FAxL5qxvd+PKXff2sJjLEoNgTJS1lnnv40rd27aiaFKh6T+BqXm3v
         +S1YQZij8rNBKpFm2QBp/4yMBIuZCYWUtpnr/BSdSw7OO2uK+8XEsxk2w9SV0xx7eHfM
         TqxrrfBfOKNzrk/fAQwEHB7PAau/6oOETu1O43HxOUjIW8hYQQWyfUHpzhZ91FwkRLLh
         WyGb8Mjaa43YEA4DcBfV7mJ+zSBIswps5vmuZetx3VFkjUkR5YhRVZ5JmE3oJ0F95/i1
         KXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0/Z6/I6MXGt005euOEO8lskeXxe8CmInEjWcMvwjoVw=;
        b=sM2jGd23jmU+Gen7tvn4HMZxH5uBEHLzbtzEvLXf53CEhbuWsgo4XnA3Wnx4zohf9Y
         V2hp4tx+MLP6v6mL3qTUnF+MKEZDAAy/sEmIaRRrot4sc95C7h3arFUDzg4oaVpR7aAn
         rol3lPhp4zME8cQTgtGiZifDc+MvBSWYjZy1m+iPhO9tvuSsHDJohCoqQq6+dfPeF34H
         /PoUOSGQ2EehLnjYjUzc3L1Vyrc443X06DhzMCY/gfxbHWl9tMbfuSpa4TwJXw2y3gyM
         m+PAkRBZ6hmLxLZ95plKL7UQb4hgufpyBCRTH5JnGY+oNoWQZ/aQQldkrfYz0lfy0bOg
         fFYw==
X-Gm-Message-State: AJIora9TVzmpua2bKKOXbfdyme4GYdG7CXshkwSGQ7xu1rATD6GC3opl
        oNy+tCn2SKWSBoycO8r+tfTbf15Ec6hbqLiIMnQbuiKx
X-Google-Smtp-Source: AGRyM1upAGoWZGbag2wL50IPoWTp7KEa+bFcHS8HoPLlOzfcdZuvo1pYW+/N3FTP9j6eNrrscC3OoM9snG04+/iVMsU=
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id
 a4-20020adffb84000000b0021a10f21661mr29018765wrr.2.1655804464587; Tue, 21 Jun
 2022 02:41:04 -0700 (PDT)
MIME-Version: 1.0
From:   Ciprian Craciun <ciprian.craciun@gmail.com>
Date:   Tue, 21 Jun 2022 12:40:28 +0300
Message-ID: <CA+Tk8fzpXneoDAyvdoJFdFjX7Cx-cJ7GO0uNXjGrYDk23FyekA@mail.gmail.com>
Subject: Is NILFS2 suitable for long term archival storage?
To:     linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

[I'm not subscribed to the mailing list, thus please keep me in CC.]


I was looking at NILFS2 as a potential solution for a file-system for
long-term archival (as in backups or append-only store).  In this
use-case I would use large CMR or SMR rotational disks (say 4+ TB, WD
or Seagate) without any RAID or disk-encryption, connected via USB
(thus sudden disconnects are to be expected), used with `restic`, or
`rdiff-backup` and `rsync`-like if `restic` doesn't work.  As such,
the IO pattern during backup would be mostly creating new files, a
couple MiB each in case of `restic`, and random reads during `restic`
checks.  In both cases there is quite some concurrency (proportional
to the number of cores).

So I was wondering the following:
* is NILFS2 suitable for such a use-case?  (my assumption is yes, at
least based on the features and promises;)
* how reliable is the current version (as upstreamed in the kernel) of
NILFS2?  data-loss of previously written (and `fsync`-ed) files is of
paramount importance (especially for files that have been written say
days ago);
* are there instances of NILFS2 used in production (for any use-case)?


I've tried searching on the internet and the email archives, but I
couldn't find anything "current" enough.  Moreover at least OpenSUSE
(and SUSE) have dropped the NILFS2 kernel module from the standard
packages (granted JFS was also dropped).

Also I'm concerned due to the fact that there isn't any `fsck` for NILFS2 yet.


Related to this, could the community recommend an alternative
file-system that would fit the bill?  (Ext4 and JFS are the only
file-systems I have heavily used and relied upon.)

Thanks,
Ciprian.
