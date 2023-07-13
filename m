Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97E751792
	for <lists+linux-nilfs@lfdr.de>; Thu, 13 Jul 2023 06:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjGMEhm (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 13 Jul 2023 00:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMEhl (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 13 Jul 2023 00:37:41 -0400
Received: from ns2.prnet.org (ns2.prnet.org [188.165.43.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DA8E69
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Jul 2023 21:37:38 -0700 (PDT)
Received: from secure.prnet.org (mail.intern.prnet.org [192.168.1.206])
        by ns2.prnet.org (Postfix) with ESMTP id 4F40D23F50D;
        Thu, 13 Jul 2023 06:24:07 +0200 (CEST)
Received: from [IPV6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a] (unknown [IPv6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a])
        by secure.prnet.org (Postfix) with ESMTPSA id C1874329221;
        Thu, 13 Jul 2023 06:23:21 +0200 (CEST)
Message-ID: <b99d2029-9b96-a016-875e-09b208c0ab9c@prnet.org>
Date:   Thu, 13 Jul 2023 06:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: {WHAT?} read checksum verification
To:     Peter Grandi <pg@nilfs.list.sabi.co.UK>,
        list Linux fs NILFS <linux-nilfs@vger.kernel.org>
References: <174f995c-e794-74c4-24d6-52451f3f3f28@prnet.org>
 <25775.10549.41499.886957@petal.ty.sabi.co.uk>
Content-Language: en-US
From:   David Arendt <admin@prnet.org>
In-Reply-To: <25775.10549.41499.886957@petal.ty.sabi.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 7/13/23 00:29, Peter Grandi wrote:
>> I used NILFS over ISCSI. I had random block corruption during
>> one week, silently destroying data until NILFS finally
>> crashed. First of all, I thought about a NILFS bug, so I
>> created a BTRFS volume
> I use both for main filesystem and backup for "diversity", and I
> value NILFS2 because it is very robust (I don't really use
> either filesystems snapshotting features).
So do I, therefor I said it was not NILFS fault.
>> and restored the backup from one week earlier to it. After
>> minutes, the BTRFS volume gave checksum errors, so the
>> culrprit was found, the ISCSI server.
> There used to be a good argument that checksumming (or
> compressing) data should be end-to-end and checksumming (or
> compressing) in the filesystem is a bit too much, but when LOGFS
> and NILFS/nILFS2 were designed I guess CPUs were too slow to
> checksum everything. Even excellent recent filesystems like F2FS
> don't do data integrity checking for various reasons though.
>
> In theory your iSCSI or its host-adapter should have told you
> about errors... Many can enable after-write verification (even
> if its quite expensive). Alternatively some people run regularly
> silent-corruption detecting daemons if their hardware does not
> report corruption or it escapes the relevant checks for various
> reasons:

The host adapter can return errors if underlying the disk itself returns 
them. If bits randomly flip on disk after being written, the host 
adapter can't know (at least not in non raid scenarios).

> https://indico.desy.de/event/257/contributions/58082/attachments/37574/46878/kelemen-2007-HEPiX-Silent_Corruptions.pdf
> https://storagemojo.com/2007/09/19/cerns-data-corruption-research/
>
>> [...] NILFS creates checksums on block writes. It would really
>> be a good addition to verify these checksums on read [...]
> It would be interesting to have data integrity checking or
> compression in NILFS2, and log-structured filesystem makes that
> easier (Btrfs code is rather complex instead), but modifying
> mature and stable filesystems is a risky thing...
>
> My understanding is that these checksums are not quite suitable
> for data integrity checks but are designed for log-sequence
> recovery, a bit like journal checksums for journal-based
> filesystems.
>
> https://www.spinics.net/lists/linux-nilfs/msg01063.html
> "nilfs2 store checksums for all data. However, at least the
> current implementation does not verify it when reading.
> Actually, the main purpose of the checksums is recovery after
> unexpected reboot; it does not suit for per-file data
> verification because the checksums are given per ``log''."

It think exactly this would be interesting, if checksum per log already 
exist, it would be good to verify these on read. As already said, I am 
not expecting to know on which file corruption occurred, but it would be 
nice to know that something nasty is going on.

