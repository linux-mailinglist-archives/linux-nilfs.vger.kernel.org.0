Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C649F03F
	for <lists+linux-nilfs@lfdr.de>; Fri, 28 Jan 2022 01:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiA1A7A (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 27 Jan 2022 19:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbiA1A67 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 27 Jan 2022 19:58:59 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C1C06174A
        for <linux-nilfs@vger.kernel.org>; Thu, 27 Jan 2022 16:58:59 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w7so5890099ioj.5
        for <linux-nilfs@vger.kernel.org>; Thu, 27 Jan 2022 16:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnqrK1B7nE7jhPSJbx7uJGsFsnzMH0p8PmdMrmsnx7c=;
        b=eiqFDzffYRJHxrlhdAhplyWNbDu7+9XCywnSXd70CEjIhMS+QILhU1gn2PxLfmnCZT
         bNJ9Uu6Wc0dwdvneqYk7j+Gx1rRovjfECn7zCQ0xWiL4H6hvX9A8b5oKYyqce02E7DCW
         NTzQ49F7FCqba9EG78FvWG2FJ0q8GVrQIyWy2fIDxxDCLv3njcQzyLih4s1aXLOz0i+/
         5sSTGgzeA0gu4w3dPuF1jSpGKYFT3eqFqlPbp/g33aBBagrayGA8ak+IubpG+AiehtbE
         3dsYzg7w2/MbCg9ctg4WDF1ndwIhh6gr6Vd+Zl57wcQBRUaLrzVSaK25RiFiy+diDvja
         JVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnqrK1B7nE7jhPSJbx7uJGsFsnzMH0p8PmdMrmsnx7c=;
        b=nVx+ttDW7NeuhAmjRpcuy9+reFqvQYhrHZgdBzpFr51/xA42dN4HkdldkrgR+VT5c/
         93N2XwpIGhs3VGlAchFPaiZ4Jku40Tz3Lhznc4wjhiauUtxD4EA/FIzQ0D0kYvpErT4E
         sju3usAtubIFf+soDCX+i+RfzifrsztRnAdhA8cU+RtSy/cveo5e9XopDI4oY2LNwka+
         B42jgXaXWJr87bRlULNPgSj3GqZyCPM/+GNsY4PHztOD3nuE7DTYOGtNEdH+rGo+TEmx
         r6cZfU9ujQIgXjzAC0BhgS5c+xGy05LiPW1s0Nyf9Vad4fF2RJ0wojBac5o71qW/JebM
         zZzg==
X-Gm-Message-State: AOAM5336jTKjYwcwrKvSG6Akd6HbI9CAzX0gYCYfWBonrvXBNSCGV/Z4
        en+N6cLS/vL77Il8ydULiVsHsg==
X-Google-Smtp-Source: ABdhPJwV/AEHiSXVQGFEZXPZwOlZ61Jpa3Td0l0CjC3IrFA3/SuJ9toHc9iJFAxn2WQdRiu2+bdIdQ==
X-Received: by 2002:a02:84ef:: with SMTP id f102mr3301483jai.25.1643331538286;
        Thu, 27 Jan 2022 16:58:58 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m4sm12789023iln.48.2022.01.27.16.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 16:58:57 -0800 (PST)
Subject: Re: [PATCH 0/9] Remove remaining parts of congestions tracking code.
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e721a70-bc57-0894-9d76-34a9d58c0cb7@kernel.dk>
Date:   Thu, 27 Jan 2022 17:58:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 1/26/22 7:46 PM, NeilBrown wrote:
> Congestion hasn't been reliably tracked for quite some time.
> Most MM uses of it for guiding writeback decisions were removed in 5.16.
> Some other uses were removed in 17-rc1.
> 
> This series removes the remaining places that test for congestion, and
> the few places which still set it.
> 
> The second patch touches a few filesystems.  I didn't think there was
> much value in splitting this out by filesystems, but if maintainers
> would rather I did that, I will.
> 
> The f2fs, cephfs, fuse, NFS, and block patches can go through the
> respective trees proving the final patch doesn't land until after they
> all do - so maybe it should be held for 5.18-rc2 if all the rest lands
> by 5.18-rc1.

For the series:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

