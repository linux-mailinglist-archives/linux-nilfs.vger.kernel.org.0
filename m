Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B58482403
	for <lists+linux-nilfs@lfdr.de>; Fri, 31 Dec 2021 13:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhLaMum (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 31 Dec 2021 07:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhLaMum (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 31 Dec 2021 07:50:42 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B0FC061574
        for <linux-nilfs@vger.kernel.org>; Fri, 31 Dec 2021 04:50:41 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id x4so27402872ljc.6
        for <linux-nilfs@vger.kernel.org>; Fri, 31 Dec 2021 04:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oixpD7mA6MIIr2h59s8ew94+nhlOIPKVy9b6uYHJmfU=;
        b=dotjDRQ9ZTHWKOtY7Gd7aELWgx9fPrFKb15+3y8jOu0J06byJP0u5enC8OdXFVa8u6
         BzN9F7YRSUFIV0Kzee1Swtq3SVbodFuDxxqPqKWwd1hfz2pi+tF/fyO+aq1MmpX/RG/6
         eEu42sU5EagX87qeQwaWJv1+iy9RkCrLrYVnDJgNJUcXP1daT/UeBB2/xOdOML1msiNw
         9yIlnPrmuXW/mA2FPIEMZGkGvyUWmZ/MxvNQYKDhorG6QHjgtEb18gr0sDPc+FH6u7QL
         jeP1dHJZ+77gd0CzaYTRf24wO0qGC1NimEsUmtjN3pURzEC5nhxk3TPTyxen43PZ2Yen
         GeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oixpD7mA6MIIr2h59s8ew94+nhlOIPKVy9b6uYHJmfU=;
        b=GgrpLEZC7stewElpYeiABq7jwRaGH1yUpKZbJUsc6S0aGY25O/6RI4eI7RN1R57aw+
         qUTnX9iMnat8tbj0pu3eShnk4Qjfl7/Bgrfz5RLG9LqeLcmSxmyyZYmDNUAmJNAIPkyL
         v7qie3L19w/rMoxcQVtzBVm7t7DT6WURpiKsbYh16CBs9aBxGKO4hegqeqesX29QPVJX
         rqOGc6OFYTrtKTPU8XirZWnEVZgILk7eNcjrESF2WAM+qMhij2pN0YAIuJmiAAKjiBwY
         GuKGQFpfDHtHvYpUdSQNLuKqDVAKv4wHEsxsLMw7G4dp0MLBsT55wDXN/hMRQDGg1mGn
         6BNg==
X-Gm-Message-State: AOAM533Gn/n0CTA36j4msHGVAdT9kZkO4kvBgF45/1LbJvyKTNQfAMlz
        vIHobvoJAoQ6AHYknbhAXSDBt7B4p4bALfWJmEPsSmATiVM=
X-Google-Smtp-Source: ABdhPJwQcxofpnOghZuF9rz7DtKaT+Yf7mLSitXLEi/opofTpym4X2VhV5qhstjBKMcYMDQiWfiXOX1gN3R+2Cc8YuY=
X-Received: by 2002:a2e:240e:: with SMTP id k14mr18894203ljk.108.1640955039648;
 Fri, 31 Dec 2021 04:50:39 -0800 (PST)
MIME-Version: 1.0
References: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
In-Reply-To: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 31 Dec 2021 21:50:27 +0900
Message-ID: <CAKFNMo=gkj_9wzw+qjmfHr53-4WZeMjSgwHnrDakfTdZkSGdNw@mail.gmail.com>
Subject: Re: couldn't mount because of unsupported optional features (477e7ad1e859f753)
To:     Hendrik Levsen <hendrik@levsen.org>,
        Peter Grandi <pg@nilfs.list.sabi.co.uk>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

On Fri, Dec 31, 2021 at 7:16 PM Hendrik Levsen <hendrik@levsen.org> wrote:
>
> Hi,
>
> Trying to mount a NILFS partition fails with "couldn't mount because of
> unsupported optional features (477e7ad1e859f753)". Neither the OS nor
> the partition have been touched/modified since the last successful install
> mount. Might the underlying block device be corrupt? Is
> "477e7ad1e859f753" a valid set of feature flag?

This value is not valid as the feature flags.
Only 0x00000001 is used for them at present.

The strange thing is that the test of feature flags is done after
validity checks of super blocks (with CRC and a magic number).
So, this type of corruption usually doesn't happen.

NILFS maintains two super blocks, at the beginning and end of the
partition.  If one of them is destroyed, it will be automatically detected
and repaired with a spare.
It seems that something unexpected has happened -  for example,
some external tool or underlying device driver directly overwrote
the super block, and oneline NILFS driver signed CRC against the
broken super block and then wrote it back to the block device unfortunately.

If you inspect further, nilfs-tune command may give some information.
It displays a summary of one of the valid super blocks as follows:

$ sudo nilfs-tune -l /dev/xxxx
nilfs-tune 2.2.5
Filesystem volume name:   (none)
Filesystem UUID:   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
Filesystem magic number:  0x3434
Filesystem revision #:   2.0
Filesystem features:      (none)
Filesystem state:   valid
Filesystem OS type:   Linux
Block size:   4096
Filesystem created:   Tue Mar  2 20:10:57 2021
Last mount time:   Fri Dec 31 20:52:02 2021
Last write time:   Fri Dec 31 20:52:22 2021
Mount count:   28
Maximum mount count:   50
Reserve blocks uid:   0 (user root)
Reserve blocks gid:   0 (group root)
First inode:   11
Inode size:   128
DAT entry size:   32
Checkpoint size:   192
Segment usage size:   16
Number of segments:   59617
Device size:   500107862016
First data block:   1
# of blocks per segment:  2048
Reserved segments %:   5
Last checkpoint #:   529322
Last block address:   50448632
Last sequence #:   24605
Free blocks count:   110473216
Commit interval:   0
# of blks to create seg:  0
CRC seed:   0xxxxxxxxx
CRC check sum:   0xxxxxxxxx
CRC check data size:   0x00000118


As for recovery, if a spare superblock survives with
valid data, you may be able to repair the file system by manually
erasing the broken one, in theory.   However, this operation
must be done very carefully and is not an intended repair method.
Therefore, I don't recommend it, and I think we should not make it
an usual option.

OTOH, it deserves consideration if there is room for improvement
on the logic or implementation of the tandem method of NILFS
super blocks.

Thanks,
Ryusuke Konishi


>
> Thank you
>
> Hendrik
>
