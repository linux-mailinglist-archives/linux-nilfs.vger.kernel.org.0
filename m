Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7E42B670
	for <lists+linux-nilfs@lfdr.de>; Wed, 13 Oct 2021 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhJMGLr (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 13 Oct 2021 02:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbhJMGLo (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 13 Oct 2021 02:11:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABEBC061766
        for <linux-nilfs@vger.kernel.org>; Tue, 12 Oct 2021 23:09:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso3587626pjb.4
        for <linux-nilfs@vger.kernel.org>; Tue, 12 Oct 2021 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z0+/l2JzZcIMvRxuVnPDxpTt0N87/VTetFSC9UipIbo=;
        b=dDm5KKH54Cm+jQj+Mhb1k8rvRxfJNbsL/HRxrPpWdrzH1k+JCSsBgY9A1wItnAnyuP
         9ultcLUzRn7czy1OW9j2NX2hgXb5hjl16HGUd04L8fCWxy7FcQb0Xj95F86MpdxVurhd
         +Yoq3Vcva7UyTZ4UkXIHSgLR2MTnO/N9XCsr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0+/l2JzZcIMvRxuVnPDxpTt0N87/VTetFSC9UipIbo=;
        b=esyMuv0XKJ8WSMAHHW+I/9cXLz8bibkBq5eCWb9G8CYRDZhYyu+SmUNRoXWF2eSsqt
         TvjPh1GO43dJFfvggko1OBsVzDikixJhk/T2Zkh5mYTvn3N29jbq8qCAVMeyDMidCPd/
         JFoAOMbbcfebCFCXYrq34WTsVFifx6pK9Xl5uODDX/OPij8OddIi5DX482FyUSuHmdDR
         tXcRYYwMwAase8SBuZS4g4DnDaI4amQ5NPeDgckUxroRhryyB5t57FCkPz9JRqsHJlI2
         0FTdBIDz937iK4j4NjbVsW4reH5Ignl5uA0Sb4yhs5uA4IVu5662F6ZE9T96WJ7z1j0C
         f50g==
X-Gm-Message-State: AOAM531p6QqNXdYjKgiSQD9gz8Ha0Cl+1EmHWM2Z8cFVjIZHym9mYstc
        J2SVzX2xkrk8vN7a3cR/jMcqjQ==
X-Google-Smtp-Source: ABdhPJx1Mq3qptD5w3g2Y6okZL9tWnjLnFrTXEu5gKzk6Wq6AX2hVHSkDjnl1IkjZGDzNZT+Poo5bw==
X-Received: by 2002:a17:902:b593:b0:12d:7aa5:de2d with SMTP id a19-20020a170902b59300b0012d7aa5de2dmr34892215pls.31.1634105379132;
        Tue, 12 Oct 2021 23:09:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nn14sm5323477pjb.27.2021.10.12.23.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:09:38 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:09:38 -0700
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
Subject: Re: [PATCH 02/29] drbd: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122309.FB5CB2DE3@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:15AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
