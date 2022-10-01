Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71465F1CE4
	for <lists+linux-nilfs@lfdr.de>; Sat,  1 Oct 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAOjq (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 1 Oct 2022 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJAOjq (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Sat, 1 Oct 2022 10:39:46 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C57CE27
        for <linux-nilfs@vger.kernel.org>; Sat,  1 Oct 2022 07:39:43 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id bi53so3592792vkb.12
        for <linux-nilfs@vger.kernel.org>; Sat, 01 Oct 2022 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4KqazxCTvLkfxkm5AfsUxNfKP7jqF68GM9nSLaqwIGc=;
        b=Al8vbn8gcQbfbcbrnFJuMYvif2f+Ah/bqueBaP0kMQEX2XlXSwG1rwYcAsGfZNY6oj
         mmhe9xlZ33L1Y3ABBaszZ+Uef8WMYBmvbQdAYn1Tdn2cQH35svz0yAENvtXXb6cvaxN4
         7LnrgGVEEYaXScpFpfstZKRkArFJUSr3Em3FHDRYXT6wNZ7C6rXTlBdSGX87WPq5VQsF
         5efGOF7bwHYm0qmQ6c6WcllKFRFckfjSruEp/gnTwkAdImwOJnNXzk29hkVewAPu9ReE
         y2TL+2H0aNEY/2ngWEnn2WcTRuDJ+OzvVV6tqRRzJ49rvuG4Sh3Lk6r26bF3amFTWzYJ
         XBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4KqazxCTvLkfxkm5AfsUxNfKP7jqF68GM9nSLaqwIGc=;
        b=HKp+sexfWjjQR6jRbx+zw2XcdPgeLcWQo2BXA0ybjK5koS8e/Yi1gYGGQtY2gdmvJF
         l8ulXO9sx9Wzqk3YmrUIRyhDXpSgs8Ke7pFTq/VQvMkxNNxovrvkZ8O0hV+VFlbJ4Q3K
         3idogfY2m8C8qJ0OqtrVIMeM4oX98gVk2doOxwKeBulDziJ+4II8QgASU+q74q+0Ha1m
         hngKsSTIhRP6bGsjDAyh2iZxsqYQsG1BAO5nul1o+LXQ/aRBFdL0GufP859clW7YC/56
         95JHD+hsobtK60XOkhqb282lbOGkb1Ezp4972fGaXNJhttgl0H2ZpEb+q8S/c4Jx8fn1
         Thvg==
X-Gm-Message-State: ACrzQf3d24MJj5iFz/JfVLlNJ49uTvAhg0Nt62XIUaRMaOM8CA3l5fKx
        DNWqEb3jNLCidWFAHc8CUhi96NMP63mrfIakMSaD8tLf
X-Google-Smtp-Source: AMsMyM6jd4GFOIFiBwC6cLZfQJ/nYL0uviSIORCHXlv6sIWqETNnTypmRAP+/EGczmKZKuf4BJazN3j2RC2qGBHgw7A=
X-Received: by 2002:a1f:a7ca:0:b0:3a2:cb7e:65a1 with SMTP id
 q193-20020a1fa7ca000000b003a2cb7e65a1mr6628139vke.4.1664635182502; Sat, 01
 Oct 2022 07:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eb0ba805e9d6e30e@google.com> <f1438f46-a52d-707b-4ef9-ab29525f1c98@I-love.SAKURA.ne.jp>
 <4ac809f9-a414-e936-0da1-f943e0551ef2@I-love.SAKURA.ne.jp>
 <CAKFNMom4G5jzSZ_i-kKnykzkhDags+XKYbRZD-cu_FeTVrFMwg@mail.gmail.com> <7d6a80dc-940c-8a64-020d-4a524913512a@I-love.SAKURA.ne.jp>
In-Reply-To: <7d6a80dc-940c-8a64-020d-4a524913512a@I-love.SAKURA.ne.jp>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 1 Oct 2022 23:39:25 +0900
Message-ID: <CAKFNMomOwpW6feTDa-PsEVHBySuwt=5hZRtWxqaeaUZkdX2ECw@mail.gmail.com>
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

On Sat, Oct 1, 2022 at 11:35 PM Tetsuo Handa wrote:
>
> On 2022/10/01 23:28, Ryusuke Konishi wrote:
> > I think the former is fine because we don't have the idea to add
> > metadata file inodes other
> > than file type.   If you make a revised patch, I will approve or
> > handle it.   Or if you are busy,
> > I will take over the fix.
>
> Please take over the fix. Thank you.

All right,  thank you for your help so far!

Thanks,
Ryusuke Konishi
