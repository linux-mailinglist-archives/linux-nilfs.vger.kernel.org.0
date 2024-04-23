Return-Path: <linux-nilfs+bounces-288-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84F8AF5D5
	for <lists+linux-nilfs@lfdr.de>; Tue, 23 Apr 2024 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858FE1F22FE1
	for <lists+linux-nilfs@lfdr.de>; Tue, 23 Apr 2024 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1313E027;
	Tue, 23 Apr 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W5px8edf"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973013DDD0;
	Tue, 23 Apr 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894686; cv=none; b=ZxEAXAHbygt4wHx5ZXGooMIzh0sRfjows+jHUj9VTFdIvBDoCgWm0LbPPzjzKLmoD9cfmKxZWp6wMGKKU6c9i8t/BGJ8t2RSN6dPyUu5QFHIMFN7G7qGwuVv/lHpvVD3zlVsCYYgiD+ilZbxy7K1GLl1xNtqwACYeKMOZKOE/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894686; c=relaxed/simple;
	bh=hC9rxUeSadKSU2aEXlDrNwf14LNDHBTSKVPnedHJIFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr2xsTWAcsee+CtAWSNvZOaWxtVPwVHaIqIZWMrp4X7NsrQ4kfmVCgNGZNVfDglvmrbyFj1ehllAzJLoqs5CCqLY12Zt22zU6wXTijMcrV+3hMT3A6muvpE/QLxDfz9Q0lpvysCVRhosZTf8wBs3wO1REz4fHSDV77aDTep2RzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W5px8edf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=klyNdKV+mbLyM76gHuHyyUzl+cYj6c4vtjiHIU/fzN8=; b=W5px8edfZMaMlw/2N3A9zcRb3r
	GTiaRp+u75rrMWquTmYC+LVA83brfQrIO9DrLByEnxVK2bEGQLzL9XwjAdkUfIOV9RQKBb2ir6bfx
	TDNvwhzVwEr0tMVevPxVW2s1JVLUirK99x3AUtdNhtnXsgZ14ZuVBeMXCFMccwCAG7lh0bCX0v2Kw
	Hgbm9M4TuNrWp968CWL0TTC0MlvUFqk3rCzX36bYiVhXRejJ33275FRacqFVBTgLWrb3S0SAHQmIi
	EmSff33FPlG71JJmcRXbPuL+kJb/vTX/qipR1gbPjf+wp1QTC6MF7yiyb3g0zJIyidbWOiMYw2cxw
	VYPiMmbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKIY-0000000Gnth-26Ci;
	Tue, 23 Apr 2024 17:51:18 +0000
Date: Tue, 23 Apr 2024 18:51:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 16/30] nilfs2: Remove calls to folio_set_error() and
 folio_clear_error()
Message-ID: <Zif1FpA6oLBxavIV@casper.infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-17-willy@infradead.org>
 <CAKFNMonpNymFnG=YkmsStHdJXdrQOaEgPdkr8231DunXDiOyvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMonpNymFnG=YkmsStHdJXdrQOaEgPdkr8231DunXDiOyvQ@mail.gmail.com>

On Wed, Apr 24, 2024 at 01:36:52AM +0900, Ryusuke Konishi wrote:
> On Sat, Apr 20, 2024 at 11:50 AM Matthew Wilcox (Oracle) wrote:
> >
> > Nobody checks this flag on nilfs2 folios, stop setting and clearing it.
> > That lets us simplify nilfs_end_folio_io() slightly.
> >
> > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Cc: linux-nilfs@vger.kernel.org
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Looks good to me.  Feel free to send this for merging along with other
> PG_error removal patches:
> 
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> 
> Or if you would like me to pick it up independently (e.g. to gradually
> reduce the changes required for removal), I will do so.

Please take it through your tree; I'll prepare a pull request for the
remainder, but having more patches go through fs maintainers means
better testing.

