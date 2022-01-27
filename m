Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0849E870
	for <lists+linux-nilfs@lfdr.de>; Thu, 27 Jan 2022 18:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiA0RJm (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 27 Jan 2022 12:09:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244287AbiA0RJm (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 27 Jan 2022 12:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dhUoO5mtU5C6v7W8MZ+6HMQJZitoVQcF/qB+IF1Jr0=;
        b=iqZwwK30l7CDia1+L6TyOX78TJGh777QRB7HIqQCgyBv2L68CLt4FXEBkuy9Eu2uBf8uV5
        QT1RNH9hptiXMInzgIqbnfWB9aj+Mu9pqkX9ntG7/TWIM+/Ffqvyweq73ETk4A5QybIiGB
        CiGgb7wr5SfeI0CpBNG+8U/3Oce9ZOc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-HqgbdrbwPWqZfDOdbzYjwg-1; Thu, 27 Jan 2022 12:09:40 -0500
X-MC-Unique: HqgbdrbwPWqZfDOdbzYjwg-1
Received: by mail-qt1-f197.google.com with SMTP id d25-20020ac84e39000000b002d1cf849207so2662014qtw.19
        for <linux-nilfs@vger.kernel.org>; Thu, 27 Jan 2022 09:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+dhUoO5mtU5C6v7W8MZ+6HMQJZitoVQcF/qB+IF1Jr0=;
        b=XKakel8SVjNSEpwAl/BSV0uc07VrfTOUkUykdj0HzqocHm/pflFnzV0KfgXtJe+IMp
         xnP+9HvEKfJ2TlRnZqlhUvTlsZOW8CsAHkg1bQAUJiyR2eniPfOGQ7op58amGdwAsqFD
         +2Y06v1ZJylqRzHT8baZQbNL8VltWtX++dKNcjp1pmP5ld+92yd2L2Wc8Q2oadiu/w02
         03lPIAcd8jq+xy3aDT46COV6Vo3bLBZBLuf2coY2zoQh8j9Kw1On/GrAPzHP/v2CWq1a
         xtfUcK3A+0kUnH6KLSWW8K1YlHQiqFrp85eBUdjkVLOOQgu3HFXD4ZWn6MyhiMcNeLiA
         Upnw==
X-Gm-Message-State: AOAM533NyHP/iv8ZDBSBI1GlmAKZfU1PktY2r1CodRIDMegqYz6/KPaq
        wZ6eWgCtpC1EbK+5cS1VALndqS7SuIgTLJFZxNM3apGKjGMtzGyE0MdkNOf/sCOykX5Ox8jHyzX
        PY35UBFWUT1OEZ2LIhFZzYg==
X-Received: by 2002:a05:620a:1671:: with SMTP id d17mr3422878qko.683.1643303379784;
        Thu, 27 Jan 2022 09:09:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyie4bqi26jfgNY8Cjw+Pn5xYBOKV6NvnkIoBYF0/ZaizWWrCUD9ZTrfOlIA4zvFGF0i2/RFw==
X-Received: by 2002:a05:620a:1671:: with SMTP id d17mr3422658qko.683.1643303377286;
        Thu, 27 Jan 2022 09:09:37 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i8sm1628636qti.52.2022.01.27.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:09:36 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:09:36 -0500
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
Subject: Re: [PATCH 06/19] dm-crypt: remove clone_init
Message-ID: <YfLR0DPcDOYO65Hp@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Just open code it next to the bio allocations, which saves a few lines
> of code, prepares for future changes and allows to remove the duplicate
> bi_opf assignment for the bio_clone_fast case in kcryptd_io_read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

