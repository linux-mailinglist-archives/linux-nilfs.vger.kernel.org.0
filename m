Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AAD6AE4A3
	for <lists+linux-nilfs@lfdr.de>; Tue,  7 Mar 2023 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjCGP1x (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 7 Mar 2023 10:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCGP12 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Tue, 7 Mar 2023 10:27:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E924A210B
        for <linux-nilfs@vger.kernel.org>; Tue,  7 Mar 2023 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=CwtM2I8MyP77x6N/6ACd6UHL5fqc6hmbDNIHsCliH86BXkGJofgH8Qq5K83YLnyGHct5xO
        5DIE7vFgWBQgRLQzLOOmVFB4UE8PfY4lBLJm0hnG5z0AM+oUTlq4HRNpxxrl7rWxb6Dw3A
        eXVUmEriEHAA2PF9EeHwYEAlVIcUlOI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-bKzaXkpDP2eJ5Xbg4fDwQA-1; Tue, 07 Mar 2023 10:24:17 -0500
X-MC-Unique: bKzaXkpDP2eJ5Xbg4fDwQA-1
Received: by mail-pf1-f200.google.com with SMTP id a25-20020a056a001d1900b005e82b3dc9f4so7329089pfx.1
        for <linux-nilfs@vger.kernel.org>; Tue, 07 Mar 2023 07:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49sjefw2FKulo5Vz5tQGPSxZQZKzbcJ05HQTQwuGmNA=;
        b=jA/D29qwRhB0QV57y36c+gFuzq2OkGs2ShsfTthYBQPOHLmeN9nS5g789kfZWiHtl5
         gjYY5THAh7C8ILXC3akQZiuLT1Z6V2WcTetRpgzTtTASO8+Ydq3Bbzz3MveGE3zCXCVs
         akHsIsnPNF0V7CvhKbdskxaKjHTtEjAtXYY/tsaWGX+24OF36DWn46Mvht829sEnz6hs
         5IKTH4SJYY6eveO12p8yW1SIoPxzZZGutA7deUmPkASsHy19Fd4OHVL1l68OYD88IN5+
         pMFondf6wo9eq9NZylY3okNlRcgsdETExLTd9SZMQiRzgRJ4QlQI858X442KtAVKlye1
         5i1w==
X-Gm-Message-State: AO0yUKUu3vmk6lvMe84gSwQpkhD/QQs0q2wLRkEiAFKm67bMcYZZqEet
        l2snF4sNjGFCfhnA5EXXuK7H4sNHWZ72ocuYxhI0YgQobLWEo7q17Upzb9sj2x8l2fSGIrJ05Gi
        7abx3k6uE83xFL2ZSu/g76gSBw8zXpmuiS81GJkY=
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id ix18-20020a170902f81200b0019af153b73emr5668631plb.4.1678202642957;
        Tue, 07 Mar 2023 07:24:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9SWy5O05m3x1Ey9TSLMznr1jfUxFnvxAX39KEBXqqmaUx44UhyFFrhNGEtwClSqvzd8jjgUVc0X6h/fPAWheE=
X-Received: by 2002:a17:902:f812:b0:19a:f153:b73e with SMTP id
 ix18-20020a170902f81200b0019af153b73emr5668618plb.4.1678202642668; Tue, 07
 Mar 2023 07:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20230307143410.28031-1-hch@lst.de>
In-Reply-To: <20230307143410.28031-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 7 Mar 2023 16:23:50 +0100
Message-ID: <CAHc6FU4G5S+5S+1OdatY3apQvmDcvzOQSPPPQdQZTwMNjSq5tw@mail.gmail.com>
Subject: Re: [Cluster-devel] return an ERR_PTR from __filemap_get_folio v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Tue, Mar 7, 2023 at 4:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
> __filemap_get_folio and its wrappers can return NULL for three different
> conditions, which in some cases requires the caller to reverse engineer
> the decision making.  This is fixed by returning an ERR_PTR instead of
> NULL and thus transporting the reason for the failure.  But to make
> that work we first need to ensure that no xa_value special case is
> returned and thus return the FGP_ENTRY flag.  It turns out that flag
> is barely used and can usually be deal with in a better way.

Thanks for working on this cleanup; looking good at a first glance.

Andreas

