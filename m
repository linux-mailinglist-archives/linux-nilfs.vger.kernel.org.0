Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A36C0B50
	for <lists+linux-nilfs@lfdr.de>; Mon, 20 Mar 2023 08:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCTH0O (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 20 Mar 2023 03:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCTH0M (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 20 Mar 2023 03:26:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DCF1CBC5
        for <linux-nilfs@vger.kernel.org>; Mon, 20 Mar 2023 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679297171; x=1710833171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PznhUX2rDF8uhJla7kd2cwVnZx5w5yiNB4r5BQcdnfM=;
  b=UbyG2Crc+FySricv/rQwxs995CKLi40+3IHN1lXEo6X3iLWrtW9k7Rtf
   NnS6+mKimwbLWCg6wjYUJ8D6Cy5M9Cs6UZHE6Al6y8IdSNCdSWYjqy+yu
   mqsOB8U3K9wQ9WNcG4UC5dA61MJjhDPaM7VPHzA2yBLie6QeLm+oeWenH
   OOrgNbPxo+ihuHi9lVUCuEkxjZmYdMoGaCJL4AXvhVygT9WtWynnEc2Ug
   KJ4CdM3F2ES++T/AZ56yGtdxDAMYkB/W3qWS4r8k33ToKpnf346HaEvWC
   Hh9u3CPNjPHHXEU7Ym49uKVpgiQnH1jHu8IDnzzlpGylLZrzxI4bAMEPr
   A==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="330429283"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 15:26:10 +0800
IronPort-SDR: nxCJUddQTrXrkq+6ASpQFkHy0xMOogmCBQTrdKZve2Dxs8SYCMkfC2keU+LZIt/54z1wUqQCVh
 1K+Tx86NhcWzSV859HUW7ZgZDxgt3+7OGCVYexLxJIbjyocbsDkT+ulvF3BPbUk2NqXn2XGDA5
 U4iqdclQzxU31Qc6K0QeN17vlRyRrSqa/Sl2nnSza2Q+Pu8ll5qYjJLRQLP5fJsjadUQfg7Y5u
 J2wBS+YnmBxEmCrsa9JG1t9Mbt2mDOfFH60/xOAw18+3TMwtZs5R4DTd1rO6ehPyy3P3BIfHW3
 P8c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2023 23:42:31 -0700
IronPort-SDR: YCl0Ug5pLlkCSKwXBXuWDLRvVQwElbe3HJoC9lIacUi2t+HIxwLkw0mnjjb+3aZO7GDHsL09ZV
 zyUGDpam6SiCu5u2izIhYHQm9LuJ31WtO7FVPq8poCbWvcl+02W+JUC1wIGeMiq8kaVP9dQl6Q
 +8Umai2ueenXNB1JShQFQa9dDsdHebTu/nE2sscXZ72KHEh7XpxWDvumIRbcV+z6nzCRYLO/vF
 f0wQpI+DOZ0X9uof7MfPIen0XBt8ZYF6JqFA15cWPYTKoX2BncOkCaysRRuUbcm72HB+rVkEYb
 B7E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2023 00:26:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg5rL2L8Fz1RtVn
        for <linux-nilfs@vger.kernel.org>; Mon, 20 Mar 2023 00:26:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679297169; x=1681889170; bh=PznhUX2rDF8uhJla7kd2cwVnZx5w5yiNB4r
        5BQcdnfM=; b=Ac3sR0XYJ+rryJ+0bDOPKxCm+dcSwHcMLzkGxuGt8+HwZ87G7ax
        pAFVEfaZLRQ1T7YBu9pTJb2iOB0dq+m2M50+2ySCb+VWMEj6z8KBJcfvkX/VTy5y
        HdsZwpvEu2xSrqc4DcASona2/D8FSQf2eX7sdS1/ZdFCrT/cmr56n/dcPEizamwB
        YvpCPWbz6qWy+PWRiDVh/KqVyD37i1IhQ4/yFHZk59+5WH/VWBjihD6KvLqKMHsL
        iYmgtRtkq5BDuKsPoQJio8UBdylvkAVkIe2vLW8QNxxsm80THSUesX6KayIzGn6+
        /6kD3KtQY7keflXYjvtNZUIrzhBwhIGlsKA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TQmI-UPwUMyZ for <linux-nilfs@vger.kernel.org>;
        Mon, 20 Mar 2023 00:26:09 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg5rB164vz1RtVm;
        Mon, 20 Mar 2023 00:26:01 -0700 (PDT)
Message-ID: <982b6aa9-4adb-acef-d9d7-9a1764a66213@opensource.wdc.com>
Date:   Mon, 20 Mar 2023 16:26:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2, RESEND 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <e4b8012d-32df-e054-4a2a-772fda228a6a@opensource.wdc.com>
 <20230320071140.44748-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230320071140.44748-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 3/20/23 16:11, Yangtao Li wrote:
> Hi filesystem maintainers,
> 
>> Hard to comment on patches with this. It is only 10 patches. So send everything please.
> 
> If you are interested in the entire patchset besides Damien,
> please let me know. I'll resend the email later to cc more people.

Yes, I said I am interested, twice already. It is IMPOSSIBLE to review a patch
without the context of other patches before/after said patch. So if you want a
review/ack for zonefs, then send the entire series.

> 
> Thx,
> Yangtao

-- 
Damien Le Moal
Western Digital Research

