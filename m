Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4567240E
	for <lists+linux-nilfs@lfdr.de>; Wed, 18 Jan 2023 17:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjARQuQ (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 18 Jan 2023 11:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjARQuP (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 18 Jan 2023 11:50:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024F37576
        for <linux-nilfs@vger.kernel.org>; Wed, 18 Jan 2023 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674060567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgwAP3iZLubX4jJpj4ZhHlVnjkE2V1abu7VwSCjHn5c=;
        b=FpPtyau+an4M+Xmird4Xa55nXKWQRW/HNcmcQSdNAXfbf6uBNlSZv3LT2A3ZKvHicboUzb
        5ELS9ts1FsvaSwHadjEFvZqjjYegwwWO8LSgtzewRICSYz2nb+oU85GmlxeCh6ixDlgHGz
        THvX5plULwo/UDZKgbfGkNtQcVQ4LXM=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-128-rITeNedaOKuzFAfDVbae9g-1; Wed, 18 Jan 2023 11:49:25 -0500
X-MC-Unique: rITeNedaOKuzFAfDVbae9g-1
Received: by mail-ua1-f69.google.com with SMTP id p25-20020ab05859000000b006001ac8d2efso3491549uac.11
        for <linux-nilfs@vger.kernel.org>; Wed, 18 Jan 2023 08:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgwAP3iZLubX4jJpj4ZhHlVnjkE2V1abu7VwSCjHn5c=;
        b=sjZWoGgV4a8FNsG4su/pnKW6U6Wbe10Ut8KGjEebYYG1C0B/DILZEit9kdCsNzvVlN
         6GtwaNT8jkNKI0LFbA7OApNj1dGmTiBLWZmw56FrQe9faf+ymijgaC2GGtQvC7FhFkJ7
         vrSrPUD9RuVhx/DwwroVhAy9WRyKGE/0SNHRyl8jaHtyk7ujjZPWKCb6cYYHA/3SGLIQ
         U8/B2imQfCTUfAbUtQ2R+qclQO46XG3COHwuNkpYx6zVVhFl7H7ELUEDNukA2WVaRcrO
         u3NmKlpDudqHlo0D39/+B/a2j7beOFbDDKsf9zm12EpgqEfqFZg6zpWXey/OoACzGjl0
         9S9g==
X-Gm-Message-State: AFqh2kpQv6rD4heOJi8F9ni7SAFmFF9FvvSolurnPIbSeYWDJ7wBiIIF
        aLGJ7izbpOeUONF0MslSioYW9pDpLQZPQfg3evSIFrVPLP2P+BVba6VpDdOGcyl28YPiaLqsBQn
        c3zakWxmX6nXdNCp1DNfEVg0=
X-Received: by 2002:a05:6122:c54:b0:3d5:5366:dc6c with SMTP id i20-20020a0561220c5400b003d55366dc6cmr4414368vkr.4.1674060565085;
        Wed, 18 Jan 2023 08:49:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvRoSYdOHAFhWX6SkAWaiD3PJ9bgCoG4JU7ThLaby5WFm6CrHkvSID8k/76bqXjrAWdFrKBiQ==
X-Received: by 2002:a05:6122:c54:b0:3d5:5366:dc6c with SMTP id i20-20020a0561220c5400b003d55366dc6cmr4414340vkr.4.1674060564852;
        Wed, 18 Jan 2023 08:49:24 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b00705c8cce5dcsm11812650qkb.111.2023.01.18.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:49:24 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:50:26 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 4/9] shmem: remove shmem_get_partial_folio
Message-ID: <Y8gjUhcRYkRuxLDq@bfoster>
References: <20230118094329.9553-1-hch@lst.de>
 <20230118094329.9553-5-hch@lst.de>
 <Y8f6sShghKuFim5E@bfoster>
 <20230118164358.GD7584@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118164358.GD7584@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Wed, Jan 18, 2023 at 05:43:58PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 18, 2023 at 08:57:05AM -0500, Brian Foster wrote:
> > This all seems reasonable to me at a glance, FWIW, but I am a little
> > curious why this wouldn't split up into two changes. I.e., switch this
> > over to filemap_get_entry() to minimally remove the FGP_ENTRY dependency
> > without a behavior change, then (perhaps after the next patch) introduce
> > SGP_FIND in a separate patch. That makes it easier to review and
> > potentially undo if it happens to pose a problem in the future. Hm?
> 
> The minimal change to filemap_get_entry would require to add the
> lock, check mapping and retry loop and thus add a fair amount of
> code.  So I looked for ways to avoid that and came up with this
> version.  But if there is a strong preference to first open code
> the logic and then later consolidate it I could do that.
> 

Ok. Not a strong preference from me. I don't think it's worth
complicating that much just to split up.

Brian

