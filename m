Return-Path: <linux-nilfs+bounces-462-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D2963787
	for <lists+linux-nilfs@lfdr.de>; Thu, 29 Aug 2024 03:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA88285A4F
	for <lists+linux-nilfs@lfdr.de>; Thu, 29 Aug 2024 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDED17740;
	Thu, 29 Aug 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="byNY5B7h"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED5156CF
	for <linux-nilfs@vger.kernel.org>; Thu, 29 Aug 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894024; cv=none; b=fStr9A+Nn2hD2I0cl3E4mmqXZDL2inOquOrN4KsUW0qeyXwYt7/23V9CxdBnwBssRPIkmhH9a8MFVJxiu9VcbgcpDO3M9L3xbk4BD1xTQffiN4ITmQ1FoEzHhSAPramDdxCIxfDixJjwS0bF9i3RdVywXyqHBi8EHdHJxZV6AeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894024; c=relaxed/simple;
	bh=QZSHxYnZffpIKDJQfF894fDZ88O276Su0mp7bvsMYsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VotY58UBZaU39pP5ac/G+YQbJQKx9iJhTdWtD7wooOl2hpv7xzsk6MA+9rxOh5Pp+hianRQfgq+c7nGelbjJIdMXF0SoHuzkbz0HG5AXmoaoZymwR9WExcQ8Jr8YkMz8ldHeHyiy346UHZkF0fe6jdNeYCgxg7DHzllSGJBLkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=byNY5B7h; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5dc93fa5639so73341eaf.1
        for <linux-nilfs@vger.kernel.org>; Wed, 28 Aug 2024 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724894021; x=1725498821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOK43HzfUC4fUs2jMhP685J0KLgFQyklTJipLfR3ILk=;
        b=byNY5B7hJISZLw4gehJz6cCfR0ftEzhTtMuAecj+XCqBKcBi6isPuNPlKf8x+TiCLF
         2g2WH0RXnqEaltL/NQ+Zc2EVfeHTKjaSddTeYk2K14352juZ/hD9Fxl90WJxwsXobT4A
         ryT971r5Jq6vColL/nsV6Pmy9xIEWF+g8wdO2iYSTYYqhtvxGgMUqrH9ilV+n7qUVdrN
         5wMfw3DWJCry0GKH1KSSfG993zLVQquMJ9b6RpvgV4XU/hBB5tvN5O5Cc5uaOzP5Vxm5
         DYX5COFfDaqK/DKO2KyGM9pm9U3YhEdmgL6iN0IEgtUqBiqtXWNas5fOp3LpYX0jNUSQ
         ahdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894021; x=1725498821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOK43HzfUC4fUs2jMhP685J0KLgFQyklTJipLfR3ILk=;
        b=k4EPWYnYn9xZyls5HEqEudZjNG4c55cygN2iZSek7W/92Xl8kKTrw9W8lSLmKbDMUL
         NEVgNC42bpf/8MtOC8V5yp4Akr29vReWH772ibB9haTKh4gnXCBMZszRS/r7CMfuaGo1
         NCjdEORw/27DCHXGfNQppaYGCQIBSPUB0nPSuWN/4U3qpuClQqxZh7cRMcbll+4jQzwV
         82RswYrdF/9OUyxXfBjc2EGrvZ4KTkQOtPFTBL1mD+hCZPkKmdJDa8RWpkvDXWuFXG4S
         yiHb2i+2c7yydFIJK4romivye1vN8btrzE0qhAt2IgRMvviRPZkrXQ3qzAKUTTp86d4c
         VGig==
X-Forwarded-Encrypted: i=1; AJvYcCUocKG11oOTMxj5BWNI7V7AzcWootwP3F9cr2nePtQY7ELf1DHVk8PBa5O8g7FJKMd/sx8nhs+Y/kL6Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1MLG144IS2wk96PzgzQRlLh62+66XnPGdAYcw7yZXjnSPuxO
	scDT72tgOoeudquZ9ERVAlLBZXOd+eq8Eu0H/LONlXsjfaqSyXefnDBX0JFqirw=
X-Google-Smtp-Source: AGHT+IEv5uy91MMd9xldjAJRw1ukkVavpZu0JesCgQjc1mSwIVm9H9vj6ortMWGxWwgKyEsf+kbmxQ==
X-Received: by 2002:a05:6359:5fa2:b0:1b1:a899:95fe with SMTP id e5c5f4694b2df-1b603c2db72mr189869955d.8.1724894021276;
        Wed, 28 Aug 2024 18:13:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569e73asm89488b3a.119.2024.08.28.18.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:13:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjTjF-00GMRW-2c;
	Thu, 29 Aug 2024 11:13:37 +1000
Date: Thu, 29 Aug 2024 11:13:37 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: report the correct read/write dio alignment for
 reflinked inodes
Message-ID: <Zs/LQftjQ7EC/lGu@dread.disaster.area>
References: <20240828051149.1897291-1-hch@lst.de>
 <20240828051149.1897291-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828051149.1897291-4-hch@lst.de>

On Wed, Aug 28, 2024 at 08:11:03AM +0300, Christoph Hellwig wrote:
> For I/O to reflinked blocks we always need to write an entire new
> file system block, and the code enforces the file system block alignment
> for the entire file if it has any reflinked blocks.
> 
> Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
> vs write alignments for reflinked files.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iops.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 1cdc8034f54d93..de2fc12688dc23 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -570,6 +570,33 @@ xfs_stat_blksize(
>  	return PAGE_SIZE;
>  }
>  
> +static void
> +xfs_report_dioalign(
> +	struct xfs_inode	*ip,
> +	struct kstat		*stat)
> +{
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct block_device	*bdev = target->bt_bdev;
> +
> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
> +	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> +	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
> +
> +	/*
> +	 * On COW inodes we are forced to always rewrite an entire file system
> +	 * block.
> +	 *
> +	 * Because applications assume they can do sector sized direct writes
> +	 * on XFS we provide an emulation by doing a read-modify-write cycle
> +	 * through the cache, but that is highly inefficient.  Thus report the
> +	 * natively supported size here.
> +	 */
> +	if (xfs_is_cow_inode(ip))
> +		stat->dio_offset_align = ip->i_mount->m_sb.sb_blocksize;
> +	else
> +		stat->dio_offset_align = stat->dio_read_offset_align;

It might be worth making it explicitly clear that logical block size
aligned IO for COW operations will still work. I think that's what
you are trying to say, but it took me a while to work out. Perhaps
something like:

	/*
	 * COW operations are inefficient on sub-fsblock aligned
	 * ranges.  They need to copy the entire block, so the
	 * minimum IO size we will ever do in this case is a single
	 * filesystem block.
	 *
	 * Even though we support sector sized IO on COW inodes, we
	 * want to help applications avoid the costly RMW cycle it
	 * requires for COW inodes. Hence report the native
	 * filesystem allocation unit size here to indicate the
	 * smallest alignment that will avoid RMW cycles in the DIO
	 * write path.
	 */

-Dave.
-- 
Dave Chinner
david@fromorbit.com

