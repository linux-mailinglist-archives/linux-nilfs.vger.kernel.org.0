Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30D242F961
	for <lists+linux-nilfs@lfdr.de>; Fri, 15 Oct 2021 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhJORAQ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 15 Oct 2021 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbhJORAP (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 15 Oct 2021 13:00:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F1C06176C
        for <linux-nilfs@vger.kernel.org>; Fri, 15 Oct 2021 09:58:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c29so8890778pfp.2
        for <linux-nilfs@vger.kernel.org>; Fri, 15 Oct 2021 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D4ik1Lt2fUu7rVQyF8CllyYkKQv1Uz9xzDA6N8pwEt0=;
        b=Wa0EACpWQ8IomuSobKiAJDXNIo9H/HSTHk3bhesUYAYHCsUAKK+Bjrkw13ye1TxZcf
         TuQa8RCxeCC8IVmjTZdx5iQYLmOHoIRbNEFY9PFnqm6LcjTjI/8URYdBHdOJCis8Hcgz
         7OkB4Z6yrhdMDXf4pPYVZP18IZMykjhm0o16E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D4ik1Lt2fUu7rVQyF8CllyYkKQv1Uz9xzDA6N8pwEt0=;
        b=mKvwQIhogjuY6qDdNiMVcFn7vvcTRY5/Yh3er7gBTj1L76/6S6QiMMc+9MvvnrNO2w
         u3HSeQFSGNr/sgeEEXf5AONuIHpsC1pZHGTIoqhG5exVETbvhOp1S4o7yqJzFzWs+62Z
         2U30je3Z4g4fLxte+xTNIiZ9RZrBpHdjwp1gwP++wv3gTXd9q9t1//Nh7ty0RyunQPGt
         HXhkbujpwYkeXM1QvEx6E15LUk5zg5HyoFGxEZUZTMZpChdrSIvgqseJWKIErW4es4vX
         Q4U63/afRNPeB+pDr3P5ZcXtR+kYHvW9R/+6yHHhA4F01HoIjfo7WotV1wxnN7kPKapP
         eeRQ==
X-Gm-Message-State: AOAM533YcHIsv9AQtoRf4G0LpZM25Axv/gN6cMHqvSwmduDFqUhI/fzy
        74WFAnON9K6Nr3DAq8x/Mdf8FQ==
X-Google-Smtp-Source: ABdhPJwjs+d5iHomMRfB84u/9uN/BXfrv3rJikQOTGFeQP4iBMjOf7nvTwY+G4DJFOV8bNrfnz+CuA==
X-Received: by 2002:a63:4766:: with SMTP id w38mr10056849pgk.104.1634317087874;
        Fri, 15 Oct 2021 09:58:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm5367341pgi.43.2021.10.15.09.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:58:07 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:58:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 25/30] block: add a sb_bdev_nr_blocks helper
Message-ID: <202110150957.44EE74B5@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-26-hch@lst.de>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:38PM +0200, Christoph Hellwig wrote:
> Add a helper to return the size of sb->s_bdev in sb->s_blocksize_bits
> based unites.  Note that SECTOR_SHIFT has to be open coded due to
> include dependency issues for now, but I have a plan to sort that out
> eventually.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

You can adjust this changelog to remove the note about SECTOR_SHIFT
now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
