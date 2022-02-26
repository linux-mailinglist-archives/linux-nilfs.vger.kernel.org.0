Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B74C5675
	for <lists+linux-nilfs@lfdr.de>; Sat, 26 Feb 2022 15:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiBZOTc (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 26 Feb 2022 09:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBZOTb (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 26 Feb 2022 09:19:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD29C28B636
        for <linux-nilfs@vger.kernel.org>; Sat, 26 Feb 2022 06:18:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so10871934pjb.5
        for <linux-nilfs@vger.kernel.org>; Sat, 26 Feb 2022 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=YLa//Mj+DxSVB6ps7DGXFT54Z3VfJ89NQIGANWGG0d8=;
        b=4ZL0rPQtivoPekslBbHbwd4MefOSslZozUIbdtrwySGfwrmJgBc+4NYFds5wDTHm4t
         2becxLEhcY0AudOFZ4Leuds9nQWinUKLxN6SxVY8v/DeIiB7zFc+sge2xTZt7HZ22E4c
         wI8SYLYmz84xi4a9xzyzJHo9eCJMOD1cjl7Bb1Nv4I02Ks91P50Txh6GFwxAX+nN/N2O
         4a3u/5VfFZioKhCo+T586yBD3Fo6GXnd1mbYw8bBPJ4/YmkfAFihTXT5w4NyzBoo6HyQ
         98T2uukeyBcSTCwQEyXQsaWbpdGz1EsLyNLehoM9MUUXu2vWcjMBduc3+jxZEqlAQhXS
         njbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=YLa//Mj+DxSVB6ps7DGXFT54Z3VfJ89NQIGANWGG0d8=;
        b=rLHNZiHPYO2foJ8V04OI9e0b/RCQtEeFZq7TELA1U5oGJiEpRTZceIw67eZV9kvRPR
         CBCrq2x81DUUoxjiBtscxzXwzBtuDmbXyxm27in2LAndosFW8ETEfp/2/+1bLyHrhPY3
         Qy4kJZD6RfC6E1Cj+0kcpB2m5BR/wCqxFrb7pm124HDHsRVwmKP5+As828MWdiucZOyt
         pLpiVUnwyZZiQTek+Hqqr4Zj9REKYivP6Ak+qOacwMG9tksZ2Pwe52mkKBHXoe8hRdMJ
         CojsrWMYKVdsh2h3MV7O7Jc8x0ajE4wQEwq+jvN7qXfdsvybUVvm14SR9CCnsk7w7PE3
         QqUA==
X-Gm-Message-State: AOAM53335PlUIfFR7RZvO0VUI4U0ID4RILPSXx1VmrQgs6Dy8IBfPQdt
        qNdK/ONarxJadDVfsaismiTeZw==
X-Google-Smtp-Source: ABdhPJyJKVuE7IehtiPL55TmKVwMJ1sfKAPOT8bfarpBPlYkibZZVH3H7ViDApTvLOtrG+Q1QJrxKA==
X-Received: by 2002:a17:902:b60b:b0:150:c60:28d0 with SMTP id b11-20020a170902b60b00b001500c6028d0mr12147643pls.116.1645885136312;
        Sat, 26 Feb 2022 06:18:56 -0800 (PST)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x23-20020a63fe57000000b0036490068f12sm5767222pgj.90.2022.02.26.06.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 06:18:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220222154634.597067-1-hch@lst.de>
References: <20220222154634.597067-1-hch@lst.de>
Subject: Re: simple file system cleanups for the new bio_alloc calling conventions
Message-Id: <164588513511.8353.16195805858154505642.b4-ty@kernel.dk>
Date:   Sat, 26 Feb 2022 07:18:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Tue, 22 Feb 2022 16:46:31 +0100, Christoph Hellwig wrote:
> this fixes up the remaining fairly trivial file system bio alloctions to
> directly pass the bdev to bio_alloc.  f2fs and btrfs will need more work and
> will be handled separately.
> 
> This is against Jens' for-5.18/block branch.  It would probably make sense to
> also merge it through that.
> 
> [...]

Applied, thanks!

[1/3] mpage: pass the operation to bio_alloc
      commit: 8020990b8e1be0b4e325371ccb45a427acbabf9e
[2/3] ext4: pass the operation to bio_alloc
      commit: 6a9856721a18208a50c826ed84b3665c4851dfe8
[3/3] nilfs2: pass the operation to bio_alloc
      commit: 91f6bd2d4d0aa91abf11b5780221d776f30cbac1

Best regards,
-- 
Jens Axboe


