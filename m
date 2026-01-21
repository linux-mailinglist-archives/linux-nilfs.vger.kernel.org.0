Return-Path: <linux-nilfs+bounces-1117-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEUqO5Y3cWnKfQAAu9opvQ
	(envelope-from <linux-nilfs+bounces-1117-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Wed, 21 Jan 2026 21:31:18 +0100
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE435D443
	for <lists+linux-nilfs@lfdr.de>; Wed, 21 Jan 2026 21:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93E0EB0B5B1
	for <lists+linux-nilfs@lfdr.de>; Wed, 21 Jan 2026 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22D3AA1B2;
	Wed, 21 Jan 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke3b0iRs"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFF3A35BE
	for <linux-nilfs@vger.kernel.org>; Wed, 21 Jan 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022013; cv=pass; b=SEqv5WJ8kyAV2jIMzIiKDwd2lTenfvbO8zamnB+AOlzaMGADfowaEPNx82kvSXIWNv0RC/qFAGK0WTI4FhNFTvKyu+SoMINN8i8gPtInaodr5u06VN1FADEz/KkvYDGmCEJDCHw8661cwyT9xfn4xih0AvwN7CenN6oC+okZ1eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022013; c=relaxed/simple;
	bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyzON5uLaYJ4YHtAKDdKhZeymxwrCU/kQyhiIewdg0Yrk/ZH/6VGYxX7DCxlaluQj0M04WgxsACJj5UDrcUULM7mXiYe/7tvFszbHbKUvSD51ouXHRpVcmVbqNGdWqBwMj9XpnKb4MwpGVhiNk3oUWpFlXC91aGODE7P4ogCMHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke3b0iRs; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b86f3e88d4dso22130766b.0
        for <linux-nilfs@vger.kernel.org>; Wed, 21 Jan 2026 11:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769022008; cv=none;
        d=google.com; s=arc-20240605;
        b=iTne88UyXV5QxLrXSIOkwH1H8RPtr0uY6rHbAFftSUB5237pPIEPIQpQnYS8jww7bp
         EhGuDUAIkTWXrmkitP618S8b3O+clyFi95f3nxeggqae/Jtbk0iqsphUj3VL8DEf2XLo
         6FPPHlijx8tXcliT8MMlBDNQdex/HKbSAGwaxcmcy+Dq/pDNDYtm9K/UOrV9Q2uibbH6
         LVY3L34rUW6eeVDCjOUbnILv097kk/RuAENwlkQHxhLR7+xyVcI9Usfnp3n6vshCkqwJ
         NKYQDw58UlyIz/4lkFYanVy1Q7UkkiEm1KTZJuTyEejHBL1yjAWvCpokqLbPZ71qnDRL
         YUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        fh=dgve2vRMMAZWHv+ZapKxTLqU6PmHStSy+TDk0eRsjB4=;
        b=SHR3OMdbXN6eGsqM403rphjnDJljfGSOgj+T5BiKMrxEXN/wEyWFKruBwaEfrpYBjd
         xboVxuzAxS/Pwf8TjxFqa66uiW11cdQHA5hdOIL9F/OoFWnKY5NRGvcoKv92k4wmrCXR
         HS96z05lnGM2wffLE4uAVbWa7QQE8K6wwbqM+g/lGa0eF/Jobsrd8BQJjDxrIEBES9YR
         SEu79d9hDLaLB3/F986Wg62ziUC/WkjZLB8xKw3D9KfZ4Nd/QGic8UOEjiBjS7EMWijB
         413kavXlPJj5ocY8GkfnbRrUvyo/BRCS7PYmyRffD1+siaAWNnY9tkdGCLBTVvIFrHtg
         sG4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769022008; x=1769626808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=ke3b0iRsOPGdb9oGItiqf3p2ocGTfsItthso0F5B2fak03CUA0liWLn/Ve+kCx5qdQ
         JombE0ayrWVRZQXIZl23qp9IKs0OR39m8RilvLRQvVGHRFm30KkpG++OotWZ92AwuCGc
         mfAvUOj8NIFwo25zttpr2t9oiEAh7Td8L4n9JqF49lbt65BYqwZMpd8IuL+pjuR3w7Cx
         uwF7vQXLdVLV63Ny5cgNkQ66Jb7r0JOenkZbCMRNua5Ow/a8OGWNheD6DVKMa3a6U1VX
         hddDJM9Nq2Z5pHCrVaA1w4AG9WOs41axr0x1rUqjUrhki3bUl8DCRQXOnsnH+8mR9kKE
         KgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769022008; x=1769626808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=f982p02gSB+GHQVh+TBBqgHPxLl3p1QIqjzQLzfRS4pGzS1rE6jgDefaZiH9j2nQLh
         0vVHvUV8z6Wa4cPLJo95+aMN9XTKsGtq/HesnI+xZcXsWny/+kUyuu5HfSdsv9jPyFz8
         nT5VhHSDXxrnPjLo0NBMYCfkO0mz5WIMQ/37ER94RJqXfh677550/zxf5QAcukNQaGyR
         DZkNBH7r77GTRNA3exdO/usLXSuXdriNdDD7iZ/QpnZge3UNhWCAmjndY/5XAZDXs3zb
         wPtLDc6obJw7PjyihKRjhNKjwnMtB5BecOcnMMKFSgKbyAI9SkAPk++w6hTGydnvAf7p
         4mCw==
X-Forwarded-Encrypted: i=1; AJvYcCUYJhQMBU1sYPoHoV4OJ2gSPjVMwdl9Q8AKGcvM/kXkxaxHv2kOywBBlYARq7TkZUcmYLzPYhKcXrl2wg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuz6E43EkKQD3abHdPdCU+jKAOj14M0micVzuNBN0TTNMvkXHn
	iiCQsLVwfacSiAmWswtUPD/1LrkARBrK06jGrf0vuL1wqo0nSL727az+VqzitPvpPy61PAe+QnS
	uq2y24SRnzuNJyEk12NZYTBWkvTOyn44=
X-Gm-Gg: AZuq6aKrwLUHRmtsvwF59QX79DMH8k1+f1nVfcIq0tmauDMiRiJRVvWQdUGgg2/2dl8
	z82RSJzpD6Exsu8Vyi3NVtMZVFx9XWtTVP7n7ZfWM9I28cUjiX9SH9LCULVnyweD9a83K7V1UFv
	Phtwluorc+MzK2Gk4YbN27NTbCaISS/lXKZp25jw6r/RwIpnT5scr3ent+fdLqSLEhvV5SomP8g
	rsp783Ac+iODplYkbwG4qA+CiPr3upw8ti9qmfQ840Xz/IJt3dDdPWGa57E40XekfdBzsnjICN0
	YD1koN3/bTRuQ9lAVbxKM3wulrg=
X-Received: by 2002:a17:906:6a13:b0:b87:206a:a23b with SMTP id
 a640c23a62f3a-b8792f79852mr1477117366b.34.1769022007470; Wed, 21 Jan 2026
 11:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org> <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner> <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner> <176890211061.16766.16354247063052030403@noble.neil.brown.name>
 <20260120-hacken-revision-88209121ac2c@brauner> <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
 <176896790525.16766.11792073987699294594@noble.neil.brown.name> <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
In-Reply-To: <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 19:59:56 +0100
X-Gm-Features: AZwV_Qh050IhjThhArfxNo-53HjJR0uLCcITEQOtntS-75Lw875opD6ONQssxps
Message-ID: <CAOQ4uxg+dC1o+6V7Nvxf8UW3H=0OvsGjEe76LNY6q8ZcpGDDJw@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,infradead.org,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,gmail.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-1117-lists,linux-nilfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nilfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	TAGGED_RCPT(0.00)[linux-nilfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6DE435D443
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 12:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
...
> > But if you really really want to set this new flag on almost every
> > export_operations, can I ask that you please set it on EVERY export
> > operations, then allow maintainers to remove it as they see fit.
> > I think that approach would be much easier to review.
> >
>
> We could probably do that, but I think the main ones that excludes it
> are kernfs, pidfs and nsfs. ovl and fuse also have export ops in
> certain modes that exclude NFS access, so the flag was left off of
> those as well.
>

For the record, my comments regarding fuse_export_fid_operations
and ovl_export_fid_operations variants were purely semantic -
it did not make sense to mark them as _STABLE_HANDLE, but
it does not matter if you set a flag on those ops, because they do
not implement ->fh_to_dentry(), on purpose, they are not
exportfs_can_decode_fh() by design.

Thanks,
Amir.

