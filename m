Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D48A37F4D4
	for <lists+linux-nilfs@lfdr.de>; Thu, 13 May 2021 11:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhEMJcr (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 13 May 2021 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhEMJco (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 13 May 2021 05:32:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340AC061760
        for <linux-nilfs@vger.kernel.org>; Thu, 13 May 2021 02:31:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so26249847wrw.8
        for <linux-nilfs@vger.kernel.org>; Thu, 13 May 2021 02:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K2KX3N3qEtXhLRhml3Iacue6w4dhQzMo6cc0mTtnvQM=;
        b=r0pHg9wLk+EkYR5JCrgzCwvxfLOJCEKZ7rlImrKtZJl/RFxusIlb/dHrHqumPtHekw
         TuV6M6W+5C+88MZcMWoYC03FLTQRmP+HZMlOaDrQZ05FPxs039l9uS8pmlV0dKcHMLz5
         CUqwLbiwuftKZoH8oiGOepbGAFDSG4Xu5+/lPafGcdhEnhzFZdCxQq3GbaAARfd4JsuT
         kHeqskEgSV555dWibYEfk/fmA7mMm6ZrQ1QRkSy9E8MD6r3u6nR2yInb8/OXA+SqhpjS
         pZLrEoh296DZ+mareJMyQNItfC2RAfn4QvCt91FAO4gpzmeg8UIwAnQk+eaJMz+vsqlG
         BA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K2KX3N3qEtXhLRhml3Iacue6w4dhQzMo6cc0mTtnvQM=;
        b=G+QJhMIWoCoruiUy//gedxUZ1tETiUPUFma9E3ZF5BOWLqAfqFJexFfcrVAuv51uEV
         rCN1qO0RzgGL9a0cBmM3RnF9pxryJpDQqD0LiyOXXOvztQ8MHFRbwbKI3FTO62KpDKM8
         c3zNv6tVNvD+96BUKPpUeiCKk31fbpiL8hE9y2jvczN841r2JO2vIEGYOAYOAPuBavZO
         NvYkpup+A8traySWKTtboKz6uMXjfDcnOgEEE16Lf4ypQtR5z8uAFnf1jT6ziNV7hS+G
         np80e/JnzXPnOp5qz5jABb22nv1cwZAdhdhh8liFEEAZ5y1gcQA2qYJIsiXFKpZhi0Db
         43zw==
X-Gm-Message-State: AOAM530kNigUGTB1j8UaG4Kf4dph0hcbppWKBzHKWKWwMJHv0YSOoZV/
        /FTowZxbekvpqE87qo2ITTc4eQ==
X-Google-Smtp-Source: ABdhPJwmID9w2Hp1ruXNrBudSly/39AHF+tVW4EuRSQip8bKri1BbA6tswXSbk2m1ujO+jkvowzwUw==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr15604521wry.243.1620898293114;
        Thu, 13 May 2021 02:31:33 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f3sm2252580wrp.7.2021.05.13.02.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 02:31:32 -0700 (PDT)
Date:   Thu, 13 May 2021 10:31:30 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, JC Kuo <jckuo@nvidia.com>,
        Joe Perches <joe@perches.com>,
        Sumit Garg <sumit.garg@linaro.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-nilfs@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/4] kdb: Switch to use %ptTs
Message-ID: <20210513093130.qzbh6tm7lbclgayh@maple.lan>
References: <20210511153958.34527-1-andriy.shevchenko@linux.intel.com>
 <20210511153958.34527-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511153958.34527-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Tue, May 11, 2021 at 06:39:56PM +0300, Andy Shevchenko wrote:
> Use %ptTs instead of open-coded variant to print contents
> of time64_t type in human readable form.
> 
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Any clue what route this will take into the kernel? I'm certainly happy
for someone else to take the kdb bits alongside the vsprintf stuff
(so here's an acked-by too in case they are fussy about that sort of
thing ;-) ):
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
> v2: collected tags
>  kernel/debug/kdb/kdb_main.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 1baa96a2ecb8..622410c45da1 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2488,7 +2488,6 @@ static void kdb_sysinfo(struct sysinfo *val)
>  static int kdb_summary(int argc, const char **argv)
>  {
>  	time64_t now;
> -	struct tm tm;
>  	struct sysinfo val;
>  
>  	if (argc)
> @@ -2502,13 +2501,7 @@ static int kdb_summary(int argc, const char **argv)
>  	kdb_printf("domainname %s\n", init_uts_ns.name.domainname);
>  
>  	now = __ktime_get_real_seconds();
> -	time64_to_tm(now, 0, &tm);
> -	kdb_printf("date       %04ld-%02d-%02d %02d:%02d:%02d "
> -		   "tz_minuteswest %d\n",
> -		1900+tm.tm_year, tm.tm_mon+1, tm.tm_mday,
> -		tm.tm_hour, tm.tm_min, tm.tm_sec,
> -		sys_tz.tz_minuteswest);
> -
> +	kdb_printf("date       %ptTs tz_minuteswest %d\n", &now, sys_tz.tz_minuteswest);
>  	kdb_sysinfo(&val);
>  	kdb_printf("uptime     ");
>  	if (val.uptime > (24*60*60)) {
> -- 
> 2.30.2
> 
