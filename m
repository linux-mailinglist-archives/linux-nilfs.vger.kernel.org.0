Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52A4F5E9D
	for <lists+linux-nilfs@lfdr.de>; Wed,  6 Apr 2022 15:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiDFMtU (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 6 Apr 2022 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiDFMs1 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Wed, 6 Apr 2022 08:48:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125B267598
        for <linux-nilfs@vger.kernel.org>; Wed,  6 Apr 2022 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649235166; x=1680771166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LFM3dJ4XtmmQmpjm/ADKwYliPf/iPacGMSt9/3x5IFU=;
  b=hmhLN3V5Z6I/dn0yqIgflvVCJzkcT0OG42JXTzhuKlithAaWuoMFy5k1
   PxqIU97/5aoxQWEl03MvKvQ4y+HieZ1mhtNVYm2PxiUQIkj6ADANNPgYI
   qRyTmcV+yOYApZ80cHLmOsitoiv0ASq2aHeADxtS7fy83UXvYBnuqPY5L
   G9RwisIuGeyJ0qLPczRLOdGGjgdXFykgZQmvwXANVyhf7tVFMRN2no8Df
   jYMWFWOiVsejgWa7Duz/lSs35ckMQC4Y+rlUJze+dM9kEeH0ebWUvDr0S
   nqjfSW7RZbg0jski/seH1sHngdreweombUZRq9k03qX9kaeuchnAVBnpo
   A==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643644800"; 
   d="scan'208";a="196092191"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 16:52:44 +0800
IronPort-SDR: 5NcCpotOKDvpxUheC4mo1ZJ8hRfMrrpTg0hzoRe79w0mCZx4P4IveTFw7+72b3fZHnYnF2MFwd
 USx8N8eR7/K841ge0sCtGiOqYXQNZt1FWdH6HM7aJq15JtaO+nZ7tuxmp6MbArjbGiFnYpDV39
 +nG/gp2ie8cD+vmBgESlCmNoA4FD9lEj/WAiiKnTe4f/OyPCc6+B22thrSbUPdnhupOB9U9bGq
 lP0weg2Kb0aCBFBxkFBZyBIWqkMQ0KyRJON/tXvFlxOiFj43b9FmWwFFRyD2Fj7QAr7Scz72hf
 nUxld1tZjyiF0RAO1b5LV69f
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 01:24:15 -0700
IronPort-SDR: CLFr7jvzkujvGjBYDU3TVsnCqkPO7Prv431odOFu4GhCpIol3SaWy8f+eCyDfJwSGqtd6DSaeK
 1CtzSOr3RRv1A1e4o4iXcdekO8nbL36IH1Gjmqj5r9VrPcfQCdgLsVQAD/C7oZLo0zXWSEKuT8
 qZbScIOOOvG8gzGYCD4d/wzOqo5Lln4s9qbU+axQNw7UB6J8dbvJx5yJrpgOS6dbZt58GtV0jh
 u33GGT3ykMJ3gRNvYF58kjHu1ufOphfBcGrF7QIrIgieBqHDSZLU6r53v3KJ+3oMns0az2TZaK
 swc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 01:52:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYJDn5pz9z1SHwl
        for <linux-nilfs@vger.kernel.org>; Wed,  6 Apr 2022 01:52:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649235160; x=1651827161; bh=LFM3dJ4XtmmQmpjm/ADKwYliPf/iPacGMSt
        9/3x5IFU=; b=FzUociJ5h7WAQTsg6/of1WcVO/OsM8WZr8TGwq4XsiCjPsWYnIG
        8/w+gKZQabfM5/6lPmJQreKk5Ou6wFCFKuKzU34LNEBfiEEQgQdKgaFRiQjCbS+v
        bXmYOK12GNp/Ja0XBlu9I1309M6iplipC0iSH4zUASq/4DY1Z1ntJWZZ2gnz7v04
        gr+tHwiyI12IKqfvshI8zep4+bgj/F03PH6lDam0sCy+54uxyIAUOpes7fa1mbqW
        oKbTS+GZl8C4hDtpg8QtlcOVicbeOAAs2w8xnnXnZGy/42U80yMH8z7K4uMfNY4W
        C4OWYxx5B6+JAZVIxV0TMfw3Lljnnr2SA9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZHa5LE9_h-gQ for <linux-nilfs@vger.kernel.org>;
        Wed,  6 Apr 2022 01:52:40 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYJDg4WyPz1Rvlx;
        Wed,  6 Apr 2022 01:52:35 -0700 (PDT)
Message-ID: <ea3d14cb-00ea-8d7b-4615-9347fdd7aa27@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 17:52:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 14/27] block: add a bdev_max_zone_append_sectors helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-15-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220406060516.409838-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On 4/6/22 15:05, Christoph Hellwig wrote:
> Add a helper to check the max supported sectors for zone append based on
> the block_device instead of having to poke into the block layer internal
> request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/zns.c | 3 +--
>   fs/zonefs/super.c         | 3 +--
>   include/linux/blkdev.h    | 6 ++++++
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index e34718b095504..82b61acf7a72b 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -34,8 +34,7 @@ static int validate_conv_zones_cb(struct blk_zone *z,
>   
>   bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>   {
> -	struct request_queue *q = ns->bdev->bd_disk->queue;
> -	u8 zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
> +	u8 zasl = nvmet_zasl(bdev_max_zone_append_sectors(ns->bdev));
>   	struct gendisk *bd_disk = ns->bdev->bd_disk;
>   	int ret;
>   
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 3614c7834007d..7a63807b736c4 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -678,13 +678,12 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>   	struct block_device *bdev = inode->i_sb->s_bdev;
> -	unsigned int max;
> +	unsigned int max = bdev_max_zone_append_sectors(bdev);
>   	struct bio *bio;
>   	ssize_t size;
>   	int nr_pages;
>   	ssize_t ret;
>   
> -	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
>   	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
>   	iov_iter_truncate(from, max);
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a433798c3343e..f8c50b77543eb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1188,6 +1188,12 @@ static inline unsigned int queue_max_zone_append_sectors(const struct request_qu
>   	return min(l->max_zone_append_sectors, l->max_sectors);
>   }
>   
> +static inline unsigned int
> +bdev_max_zone_append_sectors(struct block_device *bdev)
> +{
> +	return queue_max_zone_append_sectors(bdev_get_queue(bdev));
> +}
> +
>   static inline unsigned queue_logical_block_size(const struct request_queue *q)
>   {
>   	int retval = 512;

Looks good.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
