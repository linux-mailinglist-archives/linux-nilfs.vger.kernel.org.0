Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509A35F1CC4
	for <lists+linux-nilfs@lfdr.de>; Sat,  1 Oct 2022 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJAO2y (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 1 Oct 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJAO2n (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sat, 1 Oct 2022 10:28:43 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46F4621A
        for <linux-nilfs@vger.kernel.org>; Sat,  1 Oct 2022 07:28:40 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id q26so7481164vsr.7
        for <linux-nilfs@vger.kernel.org>; Sat, 01 Oct 2022 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5SOqjTYxrPX3UKSRLL1nV1n1rZEuBHFtZb+M/+rfmWU=;
        b=AGd+clWmm36L7dQlU00uRrlhU9GjQwXmYL1f6rVF6JlwTpf3m+JIZ694Ulv7hM4Qea
         Tscs6ZLGdjWiEokTuInG1qfyGe59YNuKLDRyyYZLC+tji6tm01Le+PLolXs1nAobvyQ/
         IfvDSXZYkJJHCx/iiTjBPTbXz7/tXhdjxaNDufuBfCily18Zx0i2rmLmT/v5zfWK/57Q
         w//+PgoByAiDfJ6F+oxKznhm/8qp1lj1NhETBGH5RgHR1t0pCUyyh60QTkqHNABCRDuq
         puJeB/+KG2hfJpVhio7nsA+M4kBE8eYuXuvrwbmAVpS3l+iHFYNJ1BNj0EDQCs7g6gVr
         oL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5SOqjTYxrPX3UKSRLL1nV1n1rZEuBHFtZb+M/+rfmWU=;
        b=7yrpc1Y81NH/loA/fDppm55kuel68eLK59LEjczSzUU8o23tzAldJxCoO+ZvB5MBR2
         mSZ+QC5KZm5JBGRaCOvB2DqPoWvD64cSdGffU0HPw+pJ+X33PtWXlse3SneKsG9+RLgG
         uVQuchO+VePOJMLHw5uIEOHsp4j4dFKKqXO1ulE4J2G7XEMlQfM16DlGMid4VcJtPLPe
         sKpu3a8A6OBJxHKB2eiqeqM+X4a5zzUUFDbxvHoySaI9BUeVz+DPVl9AlRR//QFJqfnE
         JMaWa5zwFxAHX/WtL9PRVsjDSgUbKtmDmKm1Z+6eD72aWf2/Xj/4rsRtFOn6eBsvPaQQ
         YGoA==
X-Gm-Message-State: ACrzQf1J4PHuEiNzNlTPi86lfdrpsqrWvyJTzSIdWDMLBVzb6xZC6Vot
        WV4iepcSQrduiCcVV64pwjdcVCeoczoo+Ru/XbE=
X-Google-Smtp-Source: AMsMyM6rPTL458XEEstNSXVPA9VmeIIbf75f8bWUsAL8tyiPULU8FJeaC4DHq78CzPm/bLafkC4pXF9BkGNJrq8KOiM=
X-Received: by 2002:a05:6102:5709:b0:390:e360:88e8 with SMTP id
 dg9-20020a056102570900b00390e36088e8mr5956685vsb.22.1664634519580; Sat, 01
 Oct 2022 07:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eb0ba805e9d6e30e@google.com> <f1438f46-a52d-707b-4ef9-ab29525f1c98@I-love.SAKURA.ne.jp>
 <4ac809f9-a414-e936-0da1-f943e0551ef2@I-love.SAKURA.ne.jp>
In-Reply-To: <4ac809f9-a414-e936-0da1-f943e0551ef2@I-love.SAKURA.ne.jp>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 1 Oct 2022 23:28:22 +0900
Message-ID: <CAKFNMom4G5jzSZ_i-kKnykzkhDags+XKYbRZD-cu_FeTVrFMwg@mail.gmail.com>
Subject: Re: [PATCH] nilfs: check filetype/uid/gid at nilfs_read_inode_common()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Sat, Oct 1, 2022 at 9:41 PM Tetsuo Handa wrote:
>
> On 2022/10/01 20:24, Tetsuo Handa wrote:
> > syzbot is reporting lockdep warning followed by NULL pointer dereference
> > at nilfs_bmap_lookup_at_level() [1], for a crafted filesystem which
> > contains raw_inode->i_mode == 0 is poisoning checkpoint inode at
> > nilfs_read_inode_common() from nilfs_ifile_read() from
> > nilfs_attach_checkpoint() from nilfs_fill_super() from nilfs_mount().
> > Check that filetype/uid/gid are valid as well as i_nlink is valid.
> >
> > Link: https://syzkaller.appspot.com/bug?extid=2b32eb36c1a825b7a74c [1]
> > Reported-by: syzot <syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> > This patch solves crash but I don't know whether this patch is correct.
>
> Hmm, since bmap->b_sem and bmap->b_ops are initialized by nilfs_bmap_read(),
> and nilfs_bmap_read() is called from nilfs_read_inode_common() only if
> S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)
> is true, I guess that the caller needs to verify that the returned inode is
> a regular file? But where to add that check?

Exactly, this looks like the root cause of the issue.

For metadata files, which are internal persistent files of nilfs2 and
used to store metadata
on disk, must have a file type and must call nilfs_bmap_read(), but
that sanity check
is missing.

As you pointed out, we need to add a sanity check for i_mode of metadata files.

The simple way is to insert a conditional sanity check in
nilfs_read_inode_common()
using nilfs_is_metadata_file_inode() and S_ISREG(), for instance:

    if (nilfs_is_metadata_file_inode(inode) && !S_ISREG(inode->i_mode))
             return -EIO;   /* On-disk inode of the metadata file is
corrupted. */
    if (inode->i_nlink == 0)
             return -ESTALE;   /* ... */

Or, we can add the i_mode sanity checks separately in
nilfs_dat_read(), nilfs_ifile_read(), nilfs_sufile_read(), and
nilfs_cpfile_read() before they call nilfs_read_inode_common().

I think the former is fine because we don't have the idea to add
metadata file inodes other
than file type.   If you make a revised patch, I will approve or
handle it.   Or if you are busy,
I will take over the fix.

Thank you,
Ryusuke Konishi
