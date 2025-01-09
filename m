Return-Path: <linux-nilfs+bounces-633-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810FFA0701B
	for <lists+linux-nilfs@lfdr.de>; Thu,  9 Jan 2025 09:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2113A53AB
	for <lists+linux-nilfs@lfdr.de>; Thu,  9 Jan 2025 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A27768FD;
	Thu,  9 Jan 2025 08:32:32 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B4155345;
	Thu,  9 Jan 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411552; cv=none; b=VRc762JhIwHnB2+9wOnzt3phphVemuPq0XpIzstSM9/wrY/koQ7e6tJa3Y+s3AhzZUUmv34snOnejzATctvB81T5kDgixPsV7bVNnvJe0a0kpfODetOJfTXCkQpY7068seCxpftcegSWJZLLUZnRtf2YS408ehrjscWDn7bSB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411552; c=relaxed/simple;
	bh=poarNGRIRlrFhCZq/SYxzI+AosnCkqKYGO1MLVWHu9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCWssD5PPY/gPo3c6XjHDZLM3BikdSVOz5fx7CbLr3oe6N1THM1ndnsVY6k6NiROGGUOpjhNfUtOW+dd730OnZEdYWZ+B8XR++KoXykB7IZA/zO6V6PcUtnIT96w1si2dw5ZhdeFAoademPCOBUItG7q2e9WAAjDr5fulGsk0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E79B68AFE; Thu,  9 Jan 2025 09:32:26 +0100 (CET)
Date: Thu, 9 Jan 2025 09:32:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-man@vger.kernel.org
Subject: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
Message-ID: <20250109083226.GA22264@lst.de>
References: <20250109083109.1441561-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109083109.1441561-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Document the new STATX_DIO_READ_ALIGN flag and the new
stx_dio_read_offset_align field guarded by it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 man/man2/statx.2 | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index c5b5a28ec2f1..7ad9c219a51d 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -76,6 +76,9 @@ struct statx {
     __u32 stx_atomic_write_unit_min;
     __u32 stx_atomic_write_unit_max;
     __u32 stx_atomic_write_segments_max;
+
+    /* File offset alignment for direct I/O reads */
+    __u32   stx_dio_read_offset_align;
 };
 .EE
 .in
@@ -261,7 +264,7 @@ STATX_BTIME	Want stx_btime
 STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 	It is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
-STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
+STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align.
 	(since Linux 6.1; support varies by filesystem)
 STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
 STATX_SUBVOL	Want stx_subvol
@@ -270,6 +273,8 @@ STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
 	stx_atomic_write_unit_max,
 	and stx_atomic_write_segments_max.
 	(since Linux 6.11; support varies by filesystem)
+STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
+	(since Linux 6.14; support varies by filesystem)
 .TE
 .in
 .P
@@ -467,6 +472,25 @@ This will only be nonzero if
 .I stx_dio_mem_align
 is nonzero, and vice versa.
 .TP
+.I stx_dio_read_offset_align
+The alignment (in bytes) required for file offsets and I/O segment lengths for
+direct I/O reads
+.RB ( O_DIRECT )
+on this file.
+If zero, the limit in
+.I stx_dio_offset_align
+applies for reads as well.
+If non-zero, this value must be smaller than or equal to
+.I stx_dio_offset_align
+which must be provided by the file system if requested by the application.
+The memory alignment in
+.I stx_dio_mem_align
+is not affected by this value.
+.IP
+.B STATX_DIO_READ_ALIGN
+.RI ( stx_dio_offset_align )
+is supported by xfs on regular files since Linux 6.14.
+.TP
 .I stx_subvol
 Subvolume number of the current file.
 .IP
-- 
2.45.2


