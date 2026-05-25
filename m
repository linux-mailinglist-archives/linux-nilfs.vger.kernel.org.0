Return-Path: <linux-nilfs+bounces-1602-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FtMOzGFFGo2OAcAu9opvQ
	(envelope-from <linux-nilfs+bounces-1602-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 19:21:53 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B595CD51D
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 19:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 603603017278
	for <lists+linux-nilfs@lfdr.de>; Mon, 25 May 2026 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E7D314B9A;
	Mon, 25 May 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFLYqe1t"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512F202C48
	for <linux-nilfs@vger.kernel.org>; Mon, 25 May 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729700; cv=none; b=HYdr7EhMHL+l9Cbmb1IVlLwlM2OSjhBFUya93rGFqJ8+hyMdhZFzp/8TDQ5MCjBA7ptvT+GGE4Kf81WOIdLrp+ZSiveoXRyj5bXSHDZZJgjcbADBoR3/8w/JZSDEFz5QE7nj/aysjCQ92mxeLaSUHkJA54jCluiTXBdCd/ZYhi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729700; c=relaxed/simple;
	bh=VCEFYOA8bvBB0He6GPuue1J5cPggJ9r83oKY1RULIeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onfb0ufWmwAoGjuvKzMtv6KsRGQDbIx+GB1bJukrystVn2aq73YeegagZXOTRHdyuwWiFAuBFcRX81Y7msQuafdba0FRXb05TLnF91Oolk42hh7/xW6BIJ3VEA0ICTN+zlsE5uM5W/7JvGCp89TtcBc7ecEDI6FP716KvfRwI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFLYqe1t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so45498485e9.1
        for <linux-nilfs@vger.kernel.org>; Mon, 25 May 2026 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779729696; x=1780334496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNWXusXZo+ITDqzjd8lv9UPW26DbKQzVTY3kSMXJqIc=;
        b=nFLYqe1tk7qwCxZBvuRvWqGDl/PP1t56e6sHt9JBmmmYmlbOXU8xnMDPX+8rPndMNa
         2zgBc7yUrnJOp9pyEBh4d/26MNx5cn3UNMTWA5ijw8O2EKGD44exJ9D+89Ul/Qc1Pt+R
         /EOZDji4aBNJqur9ul7T5t00BS5di3PrdKi2XezOB//+KK/86ne/3D2AmRBY6ANpdjCb
         ThvzY2xpYZ+2BNNBxmDNt1N/CaZP22TNh0pp4Q7X428uuzBIbbBges+roGw8JwlrYKUn
         xPu/34xris6plMkYf5LQoMtInpdT2hWsLdOTyXxGzT9tEeMg/Y98J2QfxTtUdj6zOITs
         b2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729696; x=1780334496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNWXusXZo+ITDqzjd8lv9UPW26DbKQzVTY3kSMXJqIc=;
        b=kgntUsVLB7JFAXoo8GGl1OyuzWto3CjFFMkLO+kS6JsIir0uYPY6HyONSkviKQ5XSC
         e8gkseVAimYTW1Cx14zHsstUzmzYNiZhEd/B5vKnawtXwPPF8aRMrsElIqS0t4oafVyA
         oU8z0bqkrm3doPsGsWLtCeV4vfcJCvoz5IkQTE3qn3swL4FvNdjoZWAnMh8Tj0WUtJoY
         HpteMUh2EUcBkIOHL4INoycdzY8Gw2x5RQeuA17PTKlGOEAlPxSL1sEQllkSBFfKruyn
         oUWupZesWbtubElZM3fozFCwJiX+His+3CAZMsFzMu/xZM+9mJuCAt9MMQraDnVMlXNp
         jDzw==
X-Forwarded-Encrypted: i=1; AFNElJ8vrKV5jUydksoglV35dzfnKxJu7gbx+0n83G1ttm/70ekhvL20z1ca5O4zE5DSh00hpT0s6EILQTOf+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZN0a1n3Uj7M2Jg2WptAy534x/150+kaUYr0UxEv9TBAdbsbJS
	cIq9uzfOC3Vxlm3YU9U7MAtcj/zzAkklkehtZZdOhLlAGvW7qadkZJJz
X-Gm-Gg: Acq92OEdYJ67+ohI5zp9bxvf0Q5SSctQNtODo/6XKBSoa7JKj0BiRIrw12x/6Bf3aKv
	M8a9UIg9UDOveGOOBITSkbKMQ7rroDHXBaqRk9Lian2IaVmZnlGS7jFlOigDrBoPESrW0n4EtIV
	KQJs9bBMQ9jNjz4VJ9VlewzJSZiP6yMdK7KA+7M95SYpVdn5n0A38RHIcYN/z8/obhS9BMe1HpI
	ymWWzjW1T05W4lUPZd0meTgdLOpuZqYaqNOkvnRgpZA6heiUGLtgfkMMLW4/61cVrcWDJFUtIWE
	ejD5KwQXB11J/cMlz4bRhQPbMoGmSFrBBN1gwJ11IFMONBLL3vSMuFNO0L7vT02b09XOWM5KqxN
	WEpRd5SMTnUG4U/CHO7xcxKupzATfHEuYzvlya1H/nKqCx3xib4V91UDslBpXf1JrnwF4MshSID
	xXJMn8wilHSIyu/jzTwhEmZ9diE/r220LM6a0glwItv5TAUXccdgHwWrdggBwoZVHF
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id 5b1f17b1804b1-4905872e758mr158057335e9.18.1779729696288;
        Mon, 25 May 2026 10:21:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d63f8sm88577605e9.18.2026.05.25.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:21:35 -0700 (PDT)
Date: Mon, 25 May 2026 18:21:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jan Kara <jack@suse.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Dave
 Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi
 <miklos@szeredi.hu>, Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao
 <leitao@debian.org>, Kees Cook <kees@kernel.org>, "Tigran A. Aivazian"
 <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <20260525182134.04045610@pumpkin>
In-Reply-To: <2omm5gmnv2khshoxkrag5rusd3qzrsqyjgsef2syxgryrtg6vq@ao7oabqwebgo>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
	<20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
	<2omm5gmnv2khshoxkrag5rusd3qzrsqyjgsef2syxgryrtg6vq@ao7oabqwebgo>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1602-lists,linux-nilfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,mit.edu,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-nilfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:email]
X-Rspamd-Queue-Id: 67B595CD51D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 18:17:04 +0200
Jan Kara <jack@suse.cz> wrote:

> On Sat 23-05-26 20:54:22, Mike Rapoport (Microsoft) wrote:
> > jbd2_alloc() falls back from kmem_cache_alloc() to __get_free_pages() for
> > allocations larger than PAGE_SIZE.
> > But kmalloc() can handle such cases with essentially the same fallback.
> > 
> > Replace use of __get_free_pages() with kmalloc() and simplify
> > jbd2_free() as both kmem_cache_alloc() and kmalloc() allocations can be
> > freed with kfree().
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>  
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I'll just note that we allocate here fs block size large buffer so the same
> kind of allocator as we use for folios would be even better. But that's a
> different cleanup I guess.

Would kvalloc() be more appropriate here?
Does __get_free_pages() return physically contiguous memory?

-- David

> 
> 								Honza
> 
> > ---
> >  fs/jbd2/journal.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 4f397fcdb13c..1137b471e490 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -2784,7 +2784,7 @@ void *jbd2_alloc(size_t size, gfp_t flags)
> >  	if (size < PAGE_SIZE)
> >  		ptr = kmem_cache_alloc(get_slab(size), flags);
> >  	else
> > -		ptr = (void *)__get_free_pages(flags, get_order(size));
> > +		ptr = kmalloc(size, flags);
> >  
> >  	/* Check alignment; SLUB has gotten this wrong in the past,
> >  	 * and this can lead to user data corruption! */
> > @@ -2795,10 +2795,7 @@ void *jbd2_alloc(size_t size, gfp_t flags)
> >  
> >  void jbd2_free(void *ptr, size_t size)
> >  {
> > -	if (size < PAGE_SIZE)
> > -		kmem_cache_free(get_slab(size), ptr);
> > -	else
> > -		free_pages((unsigned long)ptr, get_order(size));
> > +	kfree(ptr);
> >  };
> >  
> >  /*
> > 
> > -- 
> > 2.53.0
> >   


