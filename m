Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0076361A185
	for <lists+linux-nilfs@lfdr.de>; Fri,  4 Nov 2022 20:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKDTvR (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 4 Nov 2022 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKDTvO (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Fri, 4 Nov 2022 15:51:14 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC48E303D1
        for <linux-nilfs@vger.kernel.org>; Fri,  4 Nov 2022 12:51:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z6so3673582qtv.5
        for <linux-nilfs@vger.kernel.org>; Fri, 04 Nov 2022 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x16jINQR4q6R4H/0ehn+NSarZW0ZiXtTfCfHHiaRLp4=;
        b=bIdKEWgR5UZIy0TJaruQujMahMwynr4PVMnDcU4kBitHBNo7q073JbrYzG65FbHP7Y
         mbM9hFjlLlwQAouSAl9oSuR5cXI0K/JQyyZwmKs1co0JGtwjHN72PIS9n6MKeTRWxT7Z
         cCPuFkDzNQGR2KqOHNVW0/FBQA0CMharaPptg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x16jINQR4q6R4H/0ehn+NSarZW0ZiXtTfCfHHiaRLp4=;
        b=ongEhqvJ793+dFi0pK9/7q5qipVokX2hCI2HYfwk3VHFtb/pCIWjf7rqhQ9DLLZQXj
         MmF4bdDiitPwJEtecUAs7YJVeHGEq+MLFPkw0p/oIYU30C8VylXIaGoM24qOR3nI5L/U
         PuSKU/taXLaMH8qhz7+JikzPImb0Einb7W2hc8uBjqf73NcUYqjGggIE1EMfwzKJusJH
         iqjOyopamIHodlnskbhAqCxJIOxcwPAwOxmhyNn9KAmw+D2NaGXHpTVs8jUBf/qaIhK8
         XD1iZmndol1qg06PUZtj2ICj3wxG3fvtY+YZ8R+071gIDlLLouv8+PMbC1OwwsLYLyNr
         QwjQ==
X-Gm-Message-State: ACrzQf1k8F5pZT19DRux17Fc3+vHci+IxTCDoyPRJs4mnHQtIH1IBxFN
        cj526hzkckMG2a9H2NR4iuHc/9xy40ARpw==
X-Google-Smtp-Source: AMsMyM6MnOVziVyKBdvifgvqlZL+nMt8qp1TCM8MT52KKVIriMptnaIsQ92U9XHO6eOyNJLWg+cC6A==
X-Received: by 2002:a05:622a:13c8:b0:3a5:4cee:4ecc with SMTP id p8-20020a05622a13c800b003a54cee4eccmr10562215qtk.351.1667591472670;
        Fri, 04 Nov 2022 12:51:12 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id bm32-20020a05620a19a000b006fa84082b6dsm16107qkb.128.2022.11.04.12.51.10
        for <linux-nilfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 12:51:11 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-369426664f9so52702927b3.12
        for <linux-nilfs@vger.kernel.org>; Fri, 04 Nov 2022 12:51:10 -0700 (PDT)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr16823922ywe.401.1667591459021; Fri, 04
 Nov 2022 12:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org> <20221104192232.GA2520396@roeck-us.net>
 <20221104154209.21b26782@rorschach.local.home>
In-Reply-To: <20221104154209.21b26782@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 12:50:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wge9uWV2i9PR6x7va4ZbPdX5+rg7Ep1UNH_nYdd9rD-uw@mail.gmail.com>
Message-ID: <CAHk-=wge9uWV2i9PR6x7va4ZbPdX5+rg7Ep1UNH_nYdd9rD-uw@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 00/33] timers: Use timer_shutdown*() before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-edac@vger.kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bluetooth@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-leds@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Fri, Nov 4, 2022 at 12:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Linus, should I also add any patches that has already been acked by the
> respective maintainer?

No, I'd prefer to keep only the ones that are 100% unambiguously not
changing any semantics.

              Linus
