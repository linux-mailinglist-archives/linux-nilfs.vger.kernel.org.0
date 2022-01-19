Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661BD493B10
	for <lists+linux-nilfs@lfdr.de>; Wed, 19 Jan 2022 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354781AbiASN1H (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 19 Jan 2022 08:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354763AbiASN1H (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 19 Jan 2022 08:27:07 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9177FC06173F
        for <linux-nilfs@vger.kernel.org>; Wed, 19 Jan 2022 05:27:06 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id v17so2159613ilg.4
        for <linux-nilfs@vger.kernel.org>; Wed, 19 Jan 2022 05:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bOtjTSupMPdLeWMiVKrD7jaORGYKT+sk6BwRJT6YH5k=;
        b=7BEfqJqRzXAE088B+2bHOpvIL0UUVYOZUvHjaUycgtIQCZS6qJSTGhtIwa1Xa6EPfk
         oV2YXPGcxgiVF5LaQHluLKvgATLLAeZKgM3nn6DNYQRh6ifI6cdJPU7ZNOAzZ5g1fFkO
         MWYcErn30fkxjWY45t9Yboy2jcExTsCrzys7xQCWMUAHOZ2PvIOKEUon3RlzTMdRHOFW
         W8Ams8MdRsSgkRcx2W8R30267oa8zRJAWTCRB6MNRYIPNawBrTjM+yr6IoXc6oDoeZjs
         ao5paPXCdk//Rx9HxN4miEoGhchTg9VDu7RK7HyILmak+tgC3BqPCX5DU7MxKWRj66d8
         cjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bOtjTSupMPdLeWMiVKrD7jaORGYKT+sk6BwRJT6YH5k=;
        b=T9b5M+AFYFn/pxGOCvMcthvxunXo+rCkhG0XfzmtnaEuXfBc0nYCnzesxPai1oBcY3
         T1ljFNcaXrw/ynriNlVKpVCo0+QQNFABSJjxa/prWIxSBD3wmSzZPazK7dwsyXVGwsGP
         G1Ldhuqlw59aWgYMjGYIWKhDhCszefMCqCRKJ7nESoa6ZPpp3nDIMp331MYl6wZfmq+m
         yXbRjnmtG2ovZFUKETko95CKXTmecl0nIerZilpdAWW7+zJre3/upLu792HtIxpvzC1m
         62S2wed3WtS4rtaC0aw2l36g6PncxTeur0NsDuKqdb22RpuG/Y+ul2j2XDgWHNPtZt0Y
         brXg==
X-Gm-Message-State: AOAM533zBmNdErC4nF1vwIMR0t7EPmNMNw103ukxOcqq9kVmuUq4Kq18
        d10O2Hz9SnZWgYXI6fX/Uxmmvw==
X-Google-Smtp-Source: ABdhPJy/gK+ACUkzeActiCIlSLAxm2cSY3hrzhU1AqADv9+8T7xomkwrCDZtFgg9hB/5uCyhH7Qi5A==
X-Received: by 2002:a05:6e02:144a:: with SMTP id p10mr9326688ilo.152.1642598825847;
        Wed, 19 Jan 2022 05:27:05 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c7sm4569815ioi.18.2022.01.19.05.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 05:27:05 -0800 (PST)
Subject: Re: improve the bio allocation interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
References: <20220118071952.1243143-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b9aedb6-4531-91fe-3493-133470ebee80@kernel.dk>
Date:   Wed, 19 Jan 2022 06:27:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 1/18/22 12:19 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series is posted early because it has wide-ranging changes and
> could use some early ACKs before -rc1.
> 
> It changes the interface to the bio allocators to always pass a
> block_device and the operation, which is information needed for every
> bio submitted through bio_submit.  This means the fields can be
> directly initialized in bio_init instead of first being zeroed and
> thus should help to micro-optimize even better than the __bio_set_dev
> that Pavel proposed while also cleaning up code.

Looks pretty straight forward from the block core point of view. Didn't
look too closely at the fs/driver changes yet.

-- 
Jens Axboe

