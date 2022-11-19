Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BA630C1A
	for <lists+linux-nilfs@lfdr.de>; Sat, 19 Nov 2022 06:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKSFYg (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 19 Nov 2022 00:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSFYg (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 19 Nov 2022 00:24:36 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B09FB08EC;
        Fri, 18 Nov 2022 21:24:34 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NDhp91JshzFqM6;
        Sat, 19 Nov 2022 13:21:21 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 13:24:32 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 13:24:32 +0800
Message-ID: <0e693d41-0bb5-b4a9-19b7-1c71e90e06bf@huawei.com>
Date:   Sat, 19 Nov 2022 13:24:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] nilfs2: Fix nilfs_sufile_mark_dirty() not set segment
 usage as dirty
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konishi.ryusuke@gmail.com>
References: <20221118063304.140187-1-chenzhongjin@huawei.com>
 <20221118141138.c091445bdda36b78f6277c1f@linux-foundation.org>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20221118141138.c091445bdda36b78f6277c1f@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 2022/11/19 6:11, Andrew Morton wrote:
> On Fri, 18 Nov 2022 14:33:04 +0800 Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
>> In nilfs_sufile_mark_dirty(), the buffer and inode are set dirty, but
>> nilfs_segment_usage is not set dirty, which makes it can be found by
>> nilfs_sufile_alloc() because it checks nilfs_segment_usage_clean(su).
>>
>> This will cause the problem reported by syzkaller:
>> https://syzkaller.appspot.com/bug?id=c7c4748e11ffcc367cef04f76e02e931833cbd24
>>
>> It's because the case starts with segbuf1.segnum = 3, nextnum = 4, and
>> nilfs_sufile_alloc() not called to allocate a new segment.
>>
>> The first time nilfs_segctor_extend_segments() allocated segment
>> segbuf2.segnum = segbuf1.nextnum = 4, then nilfs_sufile_alloc() found
>> nextnextnum = 4 segment because its su is not set dirty.
>> So segbuf2.nextnum = 4, which causes next segbuf3.segnum = 4.
>>
>> sb_getblk() will get same bh for segbuf2 and segbuf3, and this bh is
>> added to both buffer lists of two segbuf.
>> It makes the list head of second list linked to the first one. When
>> iterating the first one, it will access and deref the head of second,
>> which causes NULL pointer dereference.
>>
>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> Merged in 2009!

Yes, seems it is introduced at the beginning of this file and the 
function called nilfs_touch_segusage().

Wired that this problem is not discovered utill now. So I'm wondering 
that whether this is a real-world
problem or just a use case constructed maliciously by syzkaller. But 
according to the result of syzkaller bisection,
this problem should have a history.
>> --- a/fs/nilfs2/sufile.c
>> +++ b/fs/nilfs2/sufile.c
>> @@ -495,12 +495,18 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
>>   int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
>>   {
>>   	struct buffer_head *bh;
>> +	void *kaddr;
>> +	struct nilfs_segment_usage *su;
>>   	int ret;
>>   
>>   	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
>>   	if (!ret) {
>>   		mark_buffer_dirty(bh);
>>   		nilfs_mdt_mark_dirty(sufile);
>> +		kaddr = kmap_atomic(bh->b_page);
>> +		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
>> +		nilfs_segment_usage_set_dirty(su);
>> +		kunmap_atomic(kaddr);
>>   		brelse(bh);
>>   	}
>>   	return ret;
> Do we feel that this fix should be backported into -stable kernels?
Sorry that I'm not familiar with the specific use scenarios of nilfs2. 
So I can't offer a better advice. I think if it
is a problem that not happen easily in normal situations there's no 
necessary to backport it to stable.
