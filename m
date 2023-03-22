Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE506C5A87
	for <lists+linux-nilfs@lfdr.de>; Thu, 23 Mar 2023 00:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCVXhF (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 22 Mar 2023 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCVXhD (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 22 Mar 2023 19:37:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FA234D9
        for <linux-nilfs@vger.kernel.org>; Wed, 22 Mar 2023 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528221; x=1711064221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rNEfSER4swwikeY50PtiH1QfqYxcG1VPN0FLVwTfQCk=;
  b=O2QWck6PMH//1X9cYC5cgmc1aoeVOBfYNRgA74V+NoxKsRrlZngWGKNb
   OCM2fmMLIbuBO2yZMUqpPQaHjDgGqqBia/nsJa2n7VASVS3Vl4vddOImh
   wYMsS6KwTGAVYGlFHPF9fs/gJ1/YHUKslJueVHpXOHIQX5RQT/drS3IQm
   Eh+djZ+ht2s+17IakjgWpKU58cZJ1S64B+liN4wqS2blgj+8d/If5l7AD
   gWv3KJ0/OnPZ6YsVQDkRMK9LXBf+66tiRXOBPwPI1ztj5glwsY1ka29I8
   BTCOtwg19KwSgKlubv2b/QYYHKGdmJ0OFVsPOkfH8Ge5zAzfN2Ze7VzRr
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="224559535"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:37:01 +0800
IronPort-SDR: 8OjzKoMPrXWmK6t70gw/tuhzpPN0xWdGzU1/QtnN2ds+s+v0Pfhwwb52rrldX/xwpqT3gFcn8E
 Di3MUxhrd83JU6D13Ekk18l0Fbhx+GapUmP1WhE/qH9fvk+6ire6wDvcqicJDBT/P33Rr8Dw0M
 551S/cQErZvUMCCPGtiTO6CblAdbHVO4zSR3KhedOHnhbpNlikSLihyGb89dO+ltvUeJhluC1p
 3YBDm3BuakgPdlmG6IwHicNEz6bezIpiLLJ1oDNbEvm+ydsdHCNGEqOKFG8wYFS3HDuLZoeZ/A
 7eY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:47:38 -0700
IronPort-SDR: N3CZlFZ7VaqE97MBxCn4B42zGWyDa9SYXYbQbwPYgnX0gPFyqfzwWIKaxh44PvuOLf+LTi7qt1
 vIs18fHp9Rh4JIWk4cJxUumBxsFYsNDk+sjCVHFDzH8/H4bzV71IvcovPCoTEM0mNXBgYy4BY4
 /JJ0MgnQWBxjj72PnOaPudXgWl2ca2eMnT+WD4H3ZPSBNHZHtOVZFarfUoZ3hoc2DqxjYFT3nu
 rSZEDtLjN5xlBHWR6CKSaUnWRsjZrfMI+eF22C/nEKN4sHPCFENTXW1fRsV398PX/TT6IrPX9k
 VAY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:37:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlHd4QCXz1RtVt
        for <linux-nilfs@vger.kernel.org>; Wed, 22 Mar 2023 16:37:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528221; x=1682120222; bh=rNEfSER4swwikeY50PtiH1QfqYxcG1VPN0F
        LVwTfQCk=; b=gT5N7kqZT/kA++fyjWYaTTcnwsHIU+GxJKWEfPwzBiAuQVTWE/1
        /XSwnAsGDMRI/Y1Jhnkq1HUe07ZviACdSHwYBy3cPkogTD3aZzjZw6ZN5tHgpe9r
        rYmSGTTnjYGKPrZ9a/0zI/nDYVo83VcWkNqYbvWtD9gDfcaB5H7WHjvAP1w/VrrN
        nfP1vozO/wPTRIJQCGTxpM7ajlvBYy7MdKoeUoPGXS/c9SkgKFCicMwWBmhUsxmR
        1deI/MYdU9LPZjEUCSrqU5VLR4JGUe0MfWWt4ECMEUqLtwlqgFCm34sEU4T+mopP
        NIq5omYoOjp17FeDSPQj4xsIsoP7veSa97g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GKQnI5MrYhJX for <linux-nilfs@vger.kernel.org>;
        Wed, 22 Mar 2023 16:37:01 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlHc1plZz1RtVm;
        Wed, 22 Mar 2023 16:37:00 -0700 (PDT)
Message-ID: <b81bd0d2-bf95-a3da-2fdf-a7d95600f370@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:36:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 10/10] nilfs2: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-9-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-9-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 3/23/23 01:59, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

