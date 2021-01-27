Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B730614F
	for <lists+linux-nilfs@lfdr.de>; Wed, 27 Jan 2021 17:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhA0Qw5 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 27 Jan 2021 11:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhA0Qwz (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:52:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B75DC061756
        for <linux-nilfs@vger.kernel.org>; Wed, 27 Jan 2021 08:52:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id a20so1591620pjs.1
        for <linux-nilfs@vger.kernel.org>; Wed, 27 Jan 2021 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lQKD9AgPexRDubj64bboSIKnHej4WVBTeYTVGyeOaHk=;
        b=0n7IOfJztdBvyCO+NwquWZO/9oDoBxQCCGXsafUQ/GvUYsfJ9GMPAPuFm/2AHz2s7h
         uCjspaY6eWonaZrU5TNO1bFTgmPIbBbshQEov2cSyySKuYe6JHBj4YtmSsCgqqeJQ0sz
         TEp+kDX55Ttsnc0J6mELqLNa4WTTuqIBpHFd3WA2ygVL+9LP+Y/h3dPZ0HRlZG6rjvCq
         o8+mzv9CEKGMlgIZqlWOyLBHKwUPEfZAqrHsgb5eQJ8jwi6mY18MiLv0LfN195kWsU1I
         9aIP573InHU/7bIMgKM0aes7wOoE1YqdbZK7PAc68mg/7wVOpXqK0JLzoUJL/hUqxtsf
         yCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQKD9AgPexRDubj64bboSIKnHej4WVBTeYTVGyeOaHk=;
        b=iXCqFZMbuhcosA6IOTf3G7WPWcu4l9Q0BHGqSljvsxduOh6gmk6mjXmeBHiq5+DNpt
         LJsvzRez0bGRXbE9aSwG3RbucpIKQmH3tsr5sU/U1v74+yPrJYfupoWmFfoq2HwSJho3
         FzbdXfpvkQTq0kG390AR8e5I9eqPH9iAxOUy1fE8W5C1DXwx2Mov0SQbAMWyo3D7GvbX
         nFxOg7Bzn7Fo/7Fke6OwEJcC5Xi1M0EHDw9eRq/D19kEO/ZWCkVFGjpe1ucEm8tWKI2c
         ZRQwYCUxyrp/iOElBt3AGxew953YPM7vPetKNHnxJM9SM8jbes4Q9Kzs5/VRdnIqZdWu
         gq5w==
X-Gm-Message-State: AOAM532uzNtznxb2t53lMwysyY+inYlJyNSj4PistnmGN5hGjC/igZxT
        E5OS47Rm/J/Bfd5cf7udbv6Hyw==
X-Google-Smtp-Source: ABdhPJznkZAkmGjzE0K3XJ7r+1OuPOB/uSu+0QVk0qZGt1uSi7gcicfz36VtRv3b8tVtY1Mr6zsRVA==
X-Received: by 2002:a17:90a:b782:: with SMTP id m2mr6555276pjr.220.1611766334716;
        Wed, 27 Jan 2021 08:52:14 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id z13sm2914261pgf.89.2021.01.27.08.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:52:14 -0800 (PST)
Subject: Re: misc bio allocation cleanups
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20210126145247.1964410-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53e9b2e0-7169-f2fe-3c33-5f8a28cbd01b@kernel.dk>
Date:   Wed, 27 Jan 2021 09:52:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 1/26/21 7:52 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains various cleanups for how bios are allocated or
> initialized plus related fallout.

Applied, thanks.

-- 
Jens Axboe

