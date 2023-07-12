Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FBF75109D
	for <lists+linux-nilfs@lfdr.de>; Wed, 12 Jul 2023 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGLShh (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 12 Jul 2023 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGLShg (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 12 Jul 2023 14:37:36 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 11:37:34 PDT
Received: from ns2.prnet.org (ns2.prnet.org [188.165.43.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABEC61BF3
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Jul 2023 11:37:34 -0700 (PDT)
Received: from secure.prnet.org (mail.intern.prnet.org [192.168.1.206])
        by ns2.prnet.org (Postfix) with ESMTP id A010C23F4D8
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Jul 2023 20:32:57 +0200 (CEST)
Received: from [IPV6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a] (unknown [IPv6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a])
        by secure.prnet.org (Postfix) with ESMTPSA id BF284328D9D
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Jul 2023 20:32:13 +0200 (CEST)
Message-ID: <174f995c-e794-74c4-24d6-52451f3f3f28@prnet.org>
Date:   Wed, 12 Jul 2023 20:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     linux-nilfs@vger.kernel.org
From:   David Arendt <admin@prnet.org>
Subject: read checksum verification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

I recently had a bad experience with NILFS (not the fault of NILFS).

I used NILFS over ISCSI. I had random block corruption during one week, 
silently destroying data until NILFS finally crashed. First of all, I 
thought about a NILFS bug, so I created a BTRFS volume and restored the 
backup from one week earlier to it. After minutes, the BTRFS volume gave 
checksum errors, so the culrprit was found, the ISCSI server. For now I 
will use BTRFS on my ISCSI volumes to not have the same situation again 
even if I would prefer using NILFS due to continuous checkpointing. If I 
can remember well, NILFS creates checksums on block writes. It would 
really be a good addition to verify these checksums on read, so 
corruption of this type would be noticed within minutes instead of days 
or possible never if rare enough. I think it has been mentioned earlier 
that NILFS checksum are not suitable for file verification but only for 
block verification. I think the most important is to know that something 
nasty is going on, even if the details aren't known, so I think it would 
be a good addition the have some sort of data checksum verification on 
read in NILFS.

Bye,

David Arendt

