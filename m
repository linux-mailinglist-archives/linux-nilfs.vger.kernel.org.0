Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82A5FE7C0
	for <lists+linux-nilfs@lfdr.de>; Fri, 14 Oct 2022 05:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJNDvd (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 13 Oct 2022 23:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNDvV (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 13 Oct 2022 23:51:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E819C042
        for <linux-nilfs@vger.kernel.org>; Thu, 13 Oct 2022 20:51:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so6786348pjs.0
        for <linux-nilfs@vger.kernel.org>; Thu, 13 Oct 2022 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xj6EA9Cf8G1V5kTfX084ZFL0HswwaRXsbxfz8fvUzdM=;
        b=EmENXU//I1HHcNUunkI3Nuy/Lst7i/3szR10j2QqD9QUaz/zaxjc6gMJPzkEvRVSXz
         RvEx64dqOngIB0pCZGpVsYdGLkNngiqc/dU6a+AuL5mseSoG8zQad2HS7ZLB3TJ5+v6K
         2pSOaNfvKHEI/b02Yiaj++xzqAJ3C/teg8I2g76lxRiTVjupi42/SBVYnPHlW80gtDIS
         yK4jKf7x9bY5aLFABs8AeC1mOqhcHA9qWCB3nF4irs+2HRsAGQmWQYu882I9IN6swonx
         qxhdWDU8P+9WlnGEBWMHWMNQEKLsNlJRT18Nl/QiYe9vnZ7tnvXiXVtr3pnhtshA3+Jx
         o5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj6EA9Cf8G1V5kTfX084ZFL0HswwaRXsbxfz8fvUzdM=;
        b=Api4Ao/daa/aQL1OMpMCZEB+Oyfyn8V5hrc4ctoc7aRCJmttlXabTSzxYs6BbdBtDl
         DDEkvHohWmrCYcpPTLcXTYINH2ON4TemnaxLtTIzpcwtMAYWxju8QULB5VbDcd8+7K2x
         hgFysD+QdRq6an1MOv+hSJPLwbGp2MGn8r04UgBaoTP6QivyEMb0rJbrWHz3YlTeZsW4
         zDXVIRJTSgjeVg/IGcmsdUqDvRnz2AfwL5f4QiYLB6BChzWidJKaeaIJRv6Up/X60wN6
         ka6F7VmyEOPMx/9Txd6XhBwn5YFR68MccLySk5Rl29pp/v1xUSsehDzn3l8yrToM11rJ
         dskw==
X-Gm-Message-State: ACrzQf1HATYya86g7y4b6hOw0YOgj0bSxLqnXWf8SX8e/t2zVOP3JXtE
        /MrXJBWHXMfhs9l6bKHe8KQiJJ5ykHWORZNU
X-Google-Smtp-Source: AMsMyM7s1sOslKip/dGdE56XK5d5Er1ShADXOLTKQTQv/dZlQDAoBr9sXyrrJYNVJzE2BSCrTkdTSQ==
X-Received: by 2002:a17:90a:86c6:b0:20b:dba4:758a with SMTP id y6-20020a17090a86c600b0020bdba4758amr3424553pjv.71.1665719478458;
        Thu, 13 Oct 2022 20:51:18 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e24-20020a656798000000b00454f8a8cc24sm464642pgr.12.2022.10.13.20.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:51:17 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:51:17 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 20:07:05 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: git://github -> https://github.com for konis
In-Reply-To: <CAKFNMonU3aVqwRdxyFefBJMg0-XC9j8bE-qYZ-9xx-4--NdkGg@mail.gmail.com>
CC:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     konishi.ryusuke@gmail.com
Message-ID: <mhng-1ec448c6-70ad-4964-9dd0-032892bfb2ef@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Thu, 13 Oct 2022 16:06:43 PDT (-0700), konishi.ryusuke@gmail.com wrote:
> On Fri, Oct 14, 2022 at 6:49 AM Palmer Dabbelt wrote:
>>
>> Github deprecated the git:// links about a year ago, so let's move to
>> the https:// URLs instead.
>>
>> Reported-by: Conor Dooley <conor.dooley@microchip.com>
>> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> I've split these up by github username so folks can take them
>> independently, as some of these repos have been renamed at github and
>> thus need more than just a sed to fix them.
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d118acdce8b8..c9c396e2d8a0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14363,7 +14363,7 @@ L:      linux-nilfs@vger.kernel.org
>>  S:     Supported
>>  W:     https://nilfs.sourceforge.io/
>>  W:     https://nilfs.osdn.jp/
>> -T:     git git://github.com/konis/nilfs2.git
>> +T:     git https://github.com/konis/nilfs2.git
>>  F:     Documentation/filesystems/nilfs2.rst
>>  F:     fs/nilfs2/
>>  F:     include/trace/events/nilfs2.h
>> --
>> 2.38.0
>>
>
> Ah, that's right, it needs to be fixed.
>
> I'll pick this up unless it's decided to apply similar fixes all at once.
> Thank you.

It's easier on my end if you just pick it up.  Just note the 
"git://github -> https://github.com" typo.  I can send a v2 if you want, 
but IMO it's trival enough to just fix up.

Thanks!

>
> Ryusuke Konishi
