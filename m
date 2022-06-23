Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE13557205
	for <lists+linux-nilfs@lfdr.de>; Thu, 23 Jun 2022 06:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiFWEp2 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 23 Jun 2022 00:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243026AbiFWDrJ (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 22 Jun 2022 23:47:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52C38BEA
        for <linux-nilfs@vger.kernel.org>; Wed, 22 Jun 2022 20:47:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q9so3722090ljp.4
        for <linux-nilfs@vger.kernel.org>; Wed, 22 Jun 2022 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHWe+AqQbXL1+Nmqri62sq/R0WS4/yHfHIvfHlvtoQA=;
        b=g0IEjL5wDRtNuTH559JoYvQy1yzpIX2+0e6zYC1NdtRVGcstYUB0GfBAgJfBZ1FAf8
         QkFZRgLk+RSHendi6Su8/HJT9gUZsivfWpjNLy8YlQUFUxNpmbUxuD4DMFgMS44uqC1C
         l264BPpp+7RON0ygyIoZqxVo5yTK3DeHOXVjTLs+a96I30ANb3fislxZNfzzVhwNnYh7
         z6hh/9I4uzdluj1KLbj3YjYsdT5nw7ERMocGWdiB240+wYfXrbEvLgY+euloMbNTb2Ea
         s4/igW3PP2ory4JIcJinzjsDFgBeprfWdUKkysCOjAIeY7bdFXxKscYefU7hQerqs0FY
         KDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHWe+AqQbXL1+Nmqri62sq/R0WS4/yHfHIvfHlvtoQA=;
        b=ELthdqLRdXChXy6GyW7pnpcJ1ahdiNS81tJDojZCZR1X7VW9zJKGu3lYeqd8In6Jw8
         bg7/9UAcX3WElaKD+/GpVLiz7QVqISxM1i26JN2bAKeIeB0RxMnsj6NBtE5oQ3Poc9Qs
         XSdlhgzE6AXN3Qq6MiKoVrk8yxL6g56rs1WrTsUgNCcvmSCX4HrhaaIE7PCCMPt70i1s
         0Cc7sBRdk9VJCm1FJI8tGZ1qIHcdJCw5CmXkqgTkpYM9iJJX2BnTTXyf+nt6nbP+3qZQ
         DiaZm2DDVN9LV8OiTSRf6W3icWQKClRq07nBxlxb+iZiLb0vigk13AXBocpVY5OGfUkk
         0j2Q==
X-Gm-Message-State: AJIora85Si1cjvMhgnvAX/RNjeaxuFMavPSInG9P/hADmEvbA55zH+ZQ
        o+EPAAIiy00ckVlmx7wDQzOq1CcNUcf5ohNqdHDTKYu/bwg=
X-Google-Smtp-Source: AGRyM1vfzHcqq2DmSt4gsK8GE1u9lWLpp1qdK4Lf87wE2Yg/prkhw0/pE5j08DftAN094wW6wedkthLvUq+Z0B8A264=
X-Received: by 2002:a2e:b8d1:0:b0:25a:642d:d65c with SMTP id
 s17-20020a2eb8d1000000b0025a642dd65cmr3520748ljp.108.1655956025490; Wed, 22
 Jun 2022 20:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Tk8fzpXneoDAyvdoJFdFjX7Cx-cJ7GO0uNXjGrYDk23FyekA@mail.gmail.com>
 <YrMHJYobUpjv+KRj@kelsos> <CA+Tk8fywv3sL1wLcZioWACCBfMPpDCqrKEXnvuzH0q6GP9FCWA@mail.gmail.com>
In-Reply-To: <CA+Tk8fywv3sL1wLcZioWACCBfMPpDCqrKEXnvuzH0q6GP9FCWA@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 23 Jun 2022 12:46:48 +0900
Message-ID: <CAKFNMokCAegqoej8o2EK4QFVFeXoob1b1Zug+Lx+2jM8PeCe5Q@mail.gmail.com>
Subject: Re: Is NILFS2 suitable for long term archival storage?
To:     Ciprian Craciun <ciprian.craciun@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        Tommy Pettersson <ptp@lysator.liu.se>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Wed, Jun 22, 2022 at 11:39 PM Ciprian Craciun wrote:
> On 6/22/22 15:12, Tommy Pettersson wrote:
> > Yet another curiosity I have had to deal with is symlink
> > properties. The standard says that rwx properties of
> > symlinks may be set to anything but should be ignored. All
> > filesystems I have used sets them to 777, except for nilfs2,
> > which honors the current umask value. Now, rsync, which is
> > probably to blame here, tries to update the properties on
> > symlinks, and if it reads from nilfs2, and gets something
> > other than 777, it can not set this other value if the
> > target is not also nilfs2, and will think it has failed. The
> > only workaround I have come up with is to find all symlinks
> > on nilfs2 and update their permission to 777.
>
>
> I've seen this weird behaviour and doesn't bother me.

Ugh, this looks like a bug (or regression).
I will look into what's happening.

Ryusuke Konishi
