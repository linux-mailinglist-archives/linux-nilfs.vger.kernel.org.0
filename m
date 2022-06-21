Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07D553776
	for <lists+linux-nilfs@lfdr.de>; Tue, 21 Jun 2022 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353553AbiFUQKU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nilfs@lfdr.de>); Tue, 21 Jun 2022 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353491AbiFUQKT (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 21 Jun 2022 12:10:19 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 09:10:07 PDT
Received: from mail.daotechnologies.com (173-12-0-166-panjde.hfc.comcastbusiness.net [173.12.0.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B732CDEF
        for <linux-nilfs@vger.kernel.org>; Tue, 21 Jun 2022 09:10:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.daotechnologies.com (Postfix) with ESMTP id 273E24060ECB0;
        Tue, 21 Jun 2022 12:03:35 -0400 (EDT)
Received: from mail.daotechnologies.com ([127.0.0.1])
        by localhost (mail.daotechnologies.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a3tqbaxXh8u8; Tue, 21 Jun 2022 12:03:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.daotechnologies.com (Postfix) with ESMTP id 0C37E4060ECB1;
        Tue, 21 Jun 2022 12:03:34 -0400 (EDT)
X-Virus-Scanned: amavisd-new at daotechnologies.com
Received: from mail.daotechnologies.com ([127.0.0.1])
        by localhost (mail.daotechnologies.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t04EkLwcKQ8d; Tue, 21 Jun 2022 12:03:33 -0400 (EDT)
Received: from [192.168.27.42] (173-12-0-163-panjde.hfc.comcastbusiness.net [173.12.0.163])
        by mail.daotechnologies.com (Postfix) with ESMTPSA id DFB424060ECB0;
        Tue, 21 Jun 2022 12:03:33 -0400 (EDT)
Message-ID: <bbaf111e-34c8-02d8-da52-a95d474b7210@daotechnologies.com>
Date:   Tue, 21 Jun 2022 12:03:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Is NILFS2 suitable for long term archival storage?
Content-Language: en-US
To:     Ciprian Craciun <ciprian.craciun@gmail.com>,
        linux-nilfs@vger.kernel.org
References: <CA+Tk8fzpXneoDAyvdoJFdFjX7Cx-cJ7GO0uNXjGrYDk23FyekA@mail.gmail.com>
From:   Keith <kperry@daotechnologies.com>
In-Reply-To: <CA+Tk8fzpXneoDAyvdoJFdFjX7Cx-cJ7GO0uNXjGrYDk23FyekA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RDNS_DYNAMIC,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 6/21/22 05:40, Ciprian Craciun wrote:
> [I'm not subscribed to the mailing list, thus please keep me in CC.]
>
>
> I was looking at NILFS2 as a potential solution for a file-system for
> long-term archival (as in backups or append-only store).  In this
> use-case I would use large CMR or SMR rotational disks (say 4+ TB, WD
> or Seagate) without any RAID or disk-encryption, connected via USB
> (thus sudden disconnects are to be expected), used with `restic`, or
> `rdiff-backup` and `rsync`-like if `restic` doesn't work.  As such,
> the IO pattern during backup would be mostly creating new files, a
> couple MiB each in case of `restic`, and random reads during `restic`
> checks.  In both cases there is quite some concurrency (proportional
> to the number of cores).
>
> So I was wondering the following:
> * is NILFS2 suitable for such a use-case?  (my assumption is yes, at
> least based on the features and promises;)
> * how reliable is the current version (as upstreamed in the kernel) of
> NILFS2?  data-loss of previously written (and `fsync`-ed) files is of
> paramount importance (especially for files that have been written say
> days ago);
> * are there instances of NILFS2 used in production (for any use-case)?
I use nilfs2 in similar ways and have been for well over 10 years now.  
I use it in a mostly as part of a data replication solution (single or 
multi-stage).  I would mostly recommend it for windowed backup and 
archival solutions (i.e. we're going to keep X amount of data for Y 
amount of time and purge every Z interval).
> I've tried searching on the internet and the email archives, but I
> couldn't find anything "current" enough.  Moreover at least OpenSUSE
> (and SUSE) have dropped the NILFS2 kernel module from the standard
> packages (granted JFS was also dropped).
>
> Also I'm concerned due to the fact that there isn't any `fsck` for NILFS2 yet.
>
This is why I don't 100% recommend it.  I have had no more than 4 major 
issues in 10 years where I could not purge old data. Specifically what 
that means is I had a snapshot that changed back to a checkpoint so that 
it could be purged the next time garbage collection ran.  As a result, I 
eventually had to reformat which meant giving up the current data (which 
could span several years). I sometimes use an nilfs2 fs in a loop 
mounted system on top of a large parallel / distributed filesystem and 
that combination could be the issue but it makes no sense to me why 
there is no way to get around a problem like that.  The lack of tools to 
analyze and fix that condition or to be able to efficiently copy or 
migrate data to another system continues to be an issue.  That said, I 
have NEVER lost data in snapshot and have been able to access data from 
years prior even when I can't purge.  The benefits of nilfs2 continue to 
outweigh this issue for me and if I really want all the data in a 
filesystem that can't be purged I could rebuild it manually somewhere 
else on the data lake.  That would be a p.i.t.a. but at least it is an 
option.
> Related to this, could the community recommend an alternative
> file-system that would fit the bill?  (Ext4 and JFS are the only
> file-systems I have heavily used and relied upon.)
>
Nothing else comes to mind for me as an all-in-one-solution.  I think 
you're going to have to continue to build a solution from the best 
offerings you find.

-- 
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
Keith C. Perry, MS E.E.
Managing Member, DAO Technologies LLC
(O) +1.215.525.4165 x2033
(M) +1.215.432.5167
www.daotechnologies.com

