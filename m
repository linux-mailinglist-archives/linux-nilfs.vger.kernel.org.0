Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DE49E882
	for <lists+linux-nilfs@lfdr.de>; Thu, 27 Jan 2022 18:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiA0RLK (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 27 Jan 2022 12:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244326AbiA0RLJ (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 27 Jan 2022 12:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hISkPgWXBvxaPJR1A6cjvL239jVaZB/M99kE10NpdT4=;
        b=T+O7ZF/7JwGOGUIvTZg6eaQYi/o72n7QCPHbJSfgPmX6HDEXWnmZUPSVEdm8lDarNlmoJQ
        GhtzkmbItddRzZOso6KBieqZ7OBdv9/4kj0uaa5kTqtOwbux3JqkjCuyDbpdZkqKk5FAVM
        VrNTQbAElD3bR/3I/u1QNS555vRbMQw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-E0vOzT6nOTGE8l43osFb4w-1; Thu, 27 Jan 2022 12:11:07 -0500
X-MC-Unique: E0vOzT6nOTGE8l43osFb4w-1
Received: by mail-qv1-f70.google.com with SMTP id iw14-20020a0562140f2e00b004204be8b6baso3789921qvb.3
        for <linux-nilfs@vger.kernel.org>; Thu, 27 Jan 2022 09:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hISkPgWXBvxaPJR1A6cjvL239jVaZB/M99kE10NpdT4=;
        b=iwjRSUOa5psTLvXbiuM3BhyU371EwCHA+AwZbbZb5cp1qh/XI6L9H8iMnqBW9kHTjH
         hOylfRRVV51XlSmzIVU9yViBi7NwLzIPeZvAkH1ellamUFiPSh7r8QVtmRja8bP1kVJ6
         kd4Ro4TRd9ZjxHYqRRlrRq/nlgwqtFGeqoIDL5ymJn/QnPw20XF36OWFAq2D+CKBi61I
         WaGn2yzUpxgpoEPyPUVf7ddVOX6eAa/R2gYbr6AeTCh0RmNaq7GjI7yECY5irdcSuizm
         b5CGmMmAVhmgDNB/sQ9AcwAGDC4OVZRPmPaCOZcwd5lwupNgMi9KOJoVB+Bf3YUtwpRg
         DM+Q==
X-Gm-Message-State: AOAM530iZ9eS531F+4ssi1htQKRwxnrXXPd81ThhpphUZ685w/9y0fNO
        sIahSfxxmvG2XeOoZhuJ1naSvq2bmNTur0vWYPWFZCo5WMoPBFb0RfTP/RsAoH/pjOkB0ErbyID
        WkZ+kB+Coicg2eb7n5dVJAA==
X-Received: by 2002:a05:6214:c2a:: with SMTP id a10mr4419655qvd.42.1643303467584;
        Thu, 27 Jan 2022 09:11:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQanMj7Y00ur/yzuLmY8gwfKPDXJeoixdwOU4KzNAVApl7lAtazZ8/rD9LIFjZrTulwd1nlg==
X-Received: by 2002:a05:6214:c2a:: with SMTP id a10mr4419637qvd.42.1643303467335;
        Thu, 27 Jan 2022 09:11:07 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h6sm1661870qtx.43.2022.01.27.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:11:06 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:11:06 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 07/19] dm-snap: use blkdev_issue_flush instead of open
 coding it
Message-ID: <YfLSKlF89y3Cbf+S@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Use blkdev_issue_flush, which uses an on-stack bio instead of an
> opencoded version with a bio embedded into struct dm_snapshot.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

