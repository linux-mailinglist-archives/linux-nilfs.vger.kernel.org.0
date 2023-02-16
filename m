Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9C698AE8
	for <lists+linux-nilfs@lfdr.de>; Thu, 16 Feb 2023 04:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBPDEs (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 15 Feb 2023 22:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPDEs (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 15 Feb 2023 22:04:48 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EFE2684
        for <linux-nilfs@vger.kernel.org>; Wed, 15 Feb 2023 19:04:47 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-16dcb07b805so1216822fac.0
        for <linux-nilfs@vger.kernel.org>; Wed, 15 Feb 2023 19:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f3Wjhm4RPWvkAIoti+3MMiCzf2Q2MiltcHtrp7wN3Vs=;
        b=AKsDdulgWNEtYmivZQ/g+yujbksF29oXeK2dGqGOsT70eZb4W3R9APR0q2W//Sqrob
         m2k21hF4D3TlapTU3y9xzLSfZZXCF6pu5XqoFSbtLEFCWR/inDn0jhB6+rbvI5SQlaa0
         JfZ8LN3kZtCiWhIlLqKgpP5b4FvCLYiEBGD1qoAup+8NTcvNABk20dvANhfDUfrsZwNZ
         JgOIa66WkQJAkosh2JvLWsEPRtP2SH64WNVPnVxLtfGtvypr8KGZj02y644AOfYa8kp/
         FGnHLgkzodYdcXqZsfv4GLoLyndLpJyINrHrg4lAUGgKF3pI4/0uJqplbB96Z9U1X3FM
         GVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3Wjhm4RPWvkAIoti+3MMiCzf2Q2MiltcHtrp7wN3Vs=;
        b=EmTTDeUuLmqQSxOuhwMoIyd1Pr/4ZdktXoHGKLR2rtUuP6m0IWh7jBD8O55ZUpfO7+
         2k44zf3+/YKWlhFLjAn+1PFdkazAZLHPqviI+1xoQHhB9Y6p9pT+IOPP2UqvId/7myqI
         D+w5clnCYPaxo1qTrg6Kkti5ZW4LMaYn5P4xUbtz+9GFJc+Npfn8B/sl0A9LoF5j49zE
         NWwmFwR2Zc+xHio/abjJ+A1HMb8FCrSwCbbpW9bxFjmkC2PE91/+2HVkiL0ppvAUmXw9
         HO37p4C04gAw9y63iyLo3VyQRuAPrtV2/NemgmO5/fUyiyMElL1OKh5oIy0Q44toUUEG
         9lrw==
X-Gm-Message-State: AO0yUKVDiIss+NaPhF4ObB3GtYqlm9cfW0SJ1o0Hp0lDBF0EuDrRwVsF
        tWxZ6x0kPGApNDjwIs0Z8fIK7OvixjSEy09Q+tsuUDrwvuI=
X-Google-Smtp-Source: AK7set+d/XWESSK1dik4dzNb4s62L1yQ3Tjp7LFRD3/ll7+VJFTbMZQuF9IBOYq97SWYL+D8srFsA4Sh3KVEix+XhIs=
X-Received: by 2002:a05:6870:218a:b0:163:83b6:d9e2 with SMTP id
 l10-20020a056870218a00b0016383b6d9e2mr84712oae.90.1676516686172; Wed, 15 Feb
 2023 19:04:46 -0800 (PST)
MIME-Version: 1.0
References: <CANX2M5bVbzRi6zH3PTcNE_31TzerstOXUa9Bay4E6y6dX23_pg@mail.gmail.com>
In-Reply-To: <CANX2M5bVbzRi6zH3PTcNE_31TzerstOXUa9Bay4E6y6dX23_pg@mail.gmail.com>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Wed, 15 Feb 2023 19:04:35 -0800
Message-ID: <CANX2M5bQ5EOfC+oYXS5Ni8CrSW65zUfLaz_yfAPiLezvVmR1FA@mail.gmail.com>
Subject: KMSAN: uninit-value in nilfs_add_checksums_on_logs
To:     linux-nilfs@vger.kernel.org
Cc:     Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
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

Reporting this bug without the reproducer attached as it hits the
character limit and the report bounces. The reproducer is available on
request.

On Wed, Feb 15, 2023 at 6:43 PM Dipanjan Das
<mail.dipanjan.das@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
>
> ======================================================
> description: KMSAN: uninit-value in nilfs_add_checksums_on_logs
> affected file: fs/nilfs2/segbuf.c
> kernel version: 6.2.0-rc5
> kernel commit: 41c66f47061608dc1fd493eebce198f0e74cc2d7
> git tree: kmsan
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=a9a22da1efde3af6
> crash reproducer: attached
> ======================================================
> Crash log:
> ======================================================
> NILFS (loop4): segctord starting. Construction interval = 5 seconds,
> CP frequency < 30 seconds
> =====================================================
> BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:112 [inline]
> BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
> BUG: KMSAN: uninit-value in crc32_le_base+0x3b7/0xc30 lib/crc32.c:197
>  crc32_body lib/crc32.c:112 [inline]
>  crc32_le_generic lib/crc32.c:179 [inline]
>  crc32_le_base+0x3b7/0xc30 lib/crc32.c:197
>  nilfs_segbuf_fill_in_data_crc fs/nilfs2/segbuf.c:208 [inline]
>  nilfs_add_checksums_on_logs+0x6ec/0xea0 fs/nilfs2/segbuf.c:321
>  nilfs_segctor_do_construct+0xa636/0xe870 fs/nilfs2/segment.c:2076
>  nilfs_segctor_construct+0x222/0xe10 fs/nilfs2/segment.c:2379
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
>  nilfs_segctor_thread+0xc19/0x11c0 fs/nilfs2/segment.c:2570
>  kthread+0x30b/0x420 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> Uninit was created at:
>  __alloc_pages+0x767/0xee0 mm/page_alloc.c:5572
>  alloc_pages+0xa9a/0xd90 mm/mempolicy.c:2286
>  folio_alloc+0x41/0x100 mm/mempolicy.c:2296
>  filemap_alloc_folio+0xa5/0x450 mm/filemap.c:972
>  __filemap_get_folio+0xe7c/0x1960 mm/filemap.c:1966
>  pagecache_get_page+0x46/0x270 mm/folio-compat.c:98
>  find_or_create_page include/linux/pagemap.h:612 [inline]
>  grow_dev_page fs/buffer.c:946 [inline]
>  grow_buffers fs/buffer.c:1011 [inline]
>  __getblk_slow fs/buffer.c:1038 [inline]
>  __getblk_gfp+0x365/0x1750 fs/buffer.c:1333
>  sb_getblk include/linux/buffer_head.h:356 [inline]
>  nilfs_segbuf_extend_segsum fs/nilfs2/segbuf.c:99 [inline]
>  nilfs_segbuf_reset+0xfd/0x520 fs/nilfs2/segbuf.c:129
>  nilfs_segctor_reset_segment_buffer fs/nilfs2/segment.c:421 [inline]
>  nilfs_segctor_collect fs/nilfs2/segment.c:1499 [inline]
>  nilfs_segctor_do_construct+0x20c6/0xe870 fs/nilfs2/segment.c:2045
>  nilfs_segctor_construct+0x222/0xe10 fs/nilfs2/segment.c:2379
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
>  nilfs_segctor_thread+0xc19/0x11c0 fs/nilfs2/segment.c:2570
>  kthread+0x30b/0x420 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> CPU: 1 PID: 11600 Comm: segctord Not tainted 6.2.0-rc5-00010-g41c66f470616 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> =====================================================
>
> --
> Thanks and Regards,
>
> Dipanjan



-- 
Thanks and Regards,

Dipanjan
