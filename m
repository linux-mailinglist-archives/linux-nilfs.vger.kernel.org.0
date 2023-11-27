Return-Path: <linux-nilfs+bounces-50-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B317FA789
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391FC1C20A46
	for <lists+linux-nilfs@lfdr.de>; Mon, 27 Nov 2023 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5CD36AE7;
	Mon, 27 Nov 2023 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bh1p6YKU"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131661B5;
	Mon, 27 Nov 2023 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P99EmKb4CapbHLKU/m7jH61AXQCv185cerJCelU8Tkc=; b=bh1p6YKUVaMZU1UXxX75PJ5pJd
	Kpt4PCHwleFCJKWQvMAJnka35xkf8igrqA7udG64iX5akAd7ewYwNVf8DIa46ttmKkubyREJEEqsa
	APaHcb1jLHmtSoBgNafcfPrA5tKj0xujCw7C5k8lYJvkLnnqxRacT0rHL1LWEpWhKyeacOpxjCjlv
	Gbri0WJTkS92HNMGbEview6G8gs+nbJILS3r3BqxSbOskP57tCdPTJY0wi7KO2Sc1NUCRcPuw9sQn
	Ht+PqBy2Xo/mXg7vwW+TwWYAz1EDrYlhCugbdQVAn+AcE/KRcKlgR5ZfxSl4ZZCXPlH6R5EXOQ+Wb
	5JWsZefA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r7f6Q-00Ba0a-QH; Mon, 27 Nov 2023 17:08:58 +0000
Date: Mon, 27 Nov 2023 17:08:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] nilfs2: eliminate staggered calls to kunmap in
 nilfs_rename
Message-ID: <ZWTNKhFukc+ZxRJA@casper.infradead.org>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
 <20231127143036.2425-3-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127143036.2425-3-konishi.ryusuke@gmail.com>

On Mon, Nov 27, 2023 at 11:30:21PM +0900, Ryusuke Konishi wrote:
> In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
> with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
> path.
> 
> When replacing the kernel memory mapping method from kmap to
> kmap_local_{page,folio}, this violates the constraint on the calling
> order of kunmap_local().
> 
> Swap the order of nilfs_put_page calls where the kmap sections of
> multiple pages overlap so that they are nested, allowing direct
> replacement of nilfs_put_page() -> unmap_and_put_page().
> 
> Without this reordering, that replacement will cause a kernel WARNING
> in kunmap_local_indexed() on architectures with high memory mapping.
> 
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for catching this!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

