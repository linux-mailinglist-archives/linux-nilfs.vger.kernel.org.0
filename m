Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC8754330
	for <lists+linux-nilfs@lfdr.de>; Fri, 14 Jul 2023 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjGNTWk (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 14 Jul 2023 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjGNTWk (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 14 Jul 2023 15:22:40 -0400
Received: from ns2.prnet.org (ns2.prnet.org [188.165.43.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 967FA3A88
        for <linux-nilfs@vger.kernel.org>; Fri, 14 Jul 2023 12:22:37 -0700 (PDT)
Received: from secure.prnet.org (mail.intern.prnet.org [192.168.1.206])
        by ns2.prnet.org (Postfix) with ESMTP id 96B6923FC2F
        for <linux-nilfs@vger.kernel.org>; Fri, 14 Jul 2023 21:23:21 +0200 (CEST)
Received: from [IPV6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a] (unknown [IPv6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a])
        by secure.prnet.org (Postfix) with ESMTPSA id 18ED232AB1B
        for <linux-nilfs@vger.kernel.org>; Fri, 14 Jul 2023 21:22:36 +0200 (CEST)
Message-ID: <eb47952c-93eb-a776-7cfb-c50219513e78@prnet.org>
Date:   Fri, 14 Jul 2023 21:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: {WHAT?} read checksum verification
Content-Language: en-US
To:     list Linux fs NILFS <linux-nilfs@vger.kernel.org>
References: <174f995c-e794-74c4-24d6-52451f3f3f28@prnet.org>
 <25775.10549.41499.886957@petal.ty.sabi.co.uk>
From:   David Arendt <admin@prnet.org>
In-Reply-To: <25775.10549.41499.886957@petal.ty.sabi.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

Quoting was not possible as I deleted the original mail to fast, sorry 
for this. This reply is concering Ryusuke Konishis mail.

First of all, you are 100% right, the underlying block layer should 
never return corrupted data, but bad things are unfortunately happing. 
In this case a bug in the iscsi server itself was the culprit and is now 
fixed.

I did several tests by untaring the content a an elastalert container in 
order to compare real world performance if someone is interested:

nilfs2 directly on iscsi: tar -xpf /tmp/elastalert.tar  0.91s user 5.19s 
system 6% cpu 1:25.71 total

nilfs2 with underlying dm-integrity in journal mode: tar -xpf 
/tmp/elastalert.tar  1.04s user 5.23s system 3% cpu 3:18.90 total

nilfs2 with underlying dm-integrity in bitmap mode: tar -xpf 
/tmp/elastalert.tar  1.00s user 5.17s system 4% cpu 2:15.04 total

nilfs2 with underlying dm-integrity in direct mode: tar -xpf 
/tmp/elastalert.tar  1.10s user 5.33s system 7% cpu 1:26.27 total

read performance in all for tests after an unmount/remount: tar -cf 
/dev/null .  1.11s user 1.80s system 5% cpu 51.300 total

Another test was writing 1024 bytes random garbage on the dm-integrity 
underlying device and doing again a tar -cf /dev/null .

Result:

[ 6005.098464] device-mapper: integrity: dm-0: Checksum failed at sector 
0x2200f
[ 6005.098484] NILFS error (device dm-0): nilfs_readdir: bad page in #4031
[ 6005.170770] Remounting filesystem read-only

So dm-integrity seems effectively a good choice.

I don't now Ryusuke if you still remember me, I was the contributor of 
the "allow cleanerd to suspend GC based on the number of free segments 
patches" long time ago :-)

Bye,

David Arendt

