Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBDB42B6D1
	for <lists+linux-nilfs@lfdr.de>; Wed, 13 Oct 2021 08:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhJMGSs (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 13 Oct 2021 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbhJMGSr (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 13 Oct 2021 02:18:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D15C061749
        for <linux-nilfs@vger.kernel.org>; Tue, 12 Oct 2021 23:16:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f189so449969pfg.12
        for <linux-nilfs@vger.kernel.org>; Tue, 12 Oct 2021 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WC8qlO5hS71mDqsT8bl0w3ijZFYGEZDCAo8tBaqenJs=;
        b=aGzx5g9EmfagK2VYJKbeonxVbvTyFyy8ubTg44u1Ahx/MTDIDSZon1W91/+YJyEM+w
         qj/Bi7I6qMRTurFfMFJfRoGMnC8vVMBa/lQEQP7VCzyqkR4kCDSqk5gFGwAkYxrRmLwC
         vKA47OmSM4jrpJqdnIRH8x1Z1vvipau07Niuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WC8qlO5hS71mDqsT8bl0w3ijZFYGEZDCAo8tBaqenJs=;
        b=0JN9LA0gs1gQ9fhf8A0/7Ufw57R51m5EFtGDmjioPeFQeTfqXnYgBSJihUS+zdRTQ8
         vrQw7W2gwf3TnXhoCWHN2MSTnKPp/498EtHcvg6dOJu/EI/e44PlSm+qsVWFC8YVvW7Q
         n3h8JY6iYYkxOSG2Bit9KwtHFve/Kkj3sDWNYGCLh3LEikKGDJ/kWnWrQbu5L6Zspuop
         /15vvzirfg7YBmGSJVDIbtxAFqu/oNTkV/k5dlhRbapA0Zc+CsCfZG5k1KkBv+HBhNK5
         jI7fxQxpW+jGzRP52tPDf2Q1E2gTawAxdK2KfHigk3lrp7mvxycmBd2FybSDFQ2EzLGQ
         VTsw==
X-Gm-Message-State: AOAM532UAGp3tWve4vVBJtHZOe7i2l7Tf3OcFuZbsxhMo4tJkFuYxt8L
        xwlpxHveWOKGEn8wKYfBBYBmSg==
X-Google-Smtp-Source: ABdhPJywBNvyfgfyQbknPTYchwSJjS8lkA7Ed3FT30CWk3r+y/Lrw7XBaVRa792lS0jCj03fnTC0tQ==
X-Received: by 2002:a62:1b8e:0:b0:44c:9318:f6e1 with SMTP id b136-20020a621b8e000000b0044c9318f6e1mr36636622pfb.84.1634105804176;
        Tue, 12 Oct 2021 23:16:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z4sm13596761pfz.99.2021.10.12.23.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:16:43 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:16:43 -0700
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
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 14/29] hfs: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122316.C8D15CD2@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-15-hch@lst.de>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:27AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
