Return-Path: <linux-nilfs+bounces-766-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C5ADCF32
	for <lists+linux-nilfs@lfdr.de>; Tue, 17 Jun 2025 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6001887AF5
	for <lists+linux-nilfs@lfdr.de>; Tue, 17 Jun 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDAC2E54DE;
	Tue, 17 Jun 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e57dSNG8"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749E2E54B7
	for <linux-nilfs@vger.kernel.org>; Tue, 17 Jun 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169222; cv=none; b=a1wy9fIGJ1kyyrg1Dx9fbJ75KCojgbP8hQ9kOJ9K1SHM2G/I+D0dogalrOULW47mWyD+6sERDKmeh7L3cKXjtzyFCgw3Y9jO+5OqX5GhIOiM4p4/5cXnJ1LcKXbDVZdbAifknrWZ1UmA4zaMfTC+lnpmmNLLnarecFfhVxM85Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169222; c=relaxed/simple;
	bh=lh4Wu179zCLjOtNueJK/Sz96qfLF/PqNel8O0RNTt9E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QwywhgmHQ+E5xV8snN5ie29+8NDaMxB71bkPyHf9yiyOp0dRfH6uCNj8SnfXdwjfqKJFjVXU81Jcv+VutlCf/3oxQCdeZirD1hogygufuA8gLbUJAqXIVcGmUXHBbsxV115JlOLPw+w2sbYtyhRxk54M6bLvWafkXEg1tALBHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e57dSNG8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750169219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lh4Wu179zCLjOtNueJK/Sz96qfLF/PqNel8O0RNTt9E=;
	b=e57dSNG8JyLwMAkdJSqCUMubAYMpvJ/Hfo0qLskuAM5JtEWPPB+bMdIosDWqy6KdKN2lY/
	BnmFnzlXG3JQ+rheYLUv7vKAPWK26Yk+bmcZDVjhzi59NJY64LcIVKLI63uIMhtZ7pVqlZ
	HkF0ZNqhM5gwd4UBapbtqGgxaD7mz54=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-2LLz78djNkqBLGkfhctWoA-1; Tue,
 17 Jun 2025 10:06:57 -0400
X-MC-Unique: 2LLz78djNkqBLGkfhctWoA-1
X-Mimecast-MFC-AGG-ID: 2LLz78djNkqBLGkfhctWoA_1750169214
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9696F19560A5;
	Tue, 17 Jun 2025 14:06:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C81A19560B0;
	Tue, 17 Jun 2025 14:06:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    "Liam R . Howlett" <Liam.Howlett@oracle.com>,
    Jens Axboe <axboe@kernel.dk>,
    Jani Nikula <jani.nikula@linux.intel.com>,
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
    Rodrigo Vivi <rodrigo.vivi@intel.com>,
    Tvrtko Ursulin <tursulin@ursulin.net>,
    David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
    Benjamin LaHaise <bcrl@kvack.org>,
    Miklos Szeredi <miklos@szeredi.hu>,
    Amir Goldstein <amir73il@gmail.com>,
    Kent Overstreet <kent.overstreet@linux.dev>,
    "Tigran A
 . Aivazian" <aivazian.tigran@gmail.com>,
    Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
    Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
    Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
    coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
    Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
    Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
    Sandeep Dhavale <dhavale@google.com>,
    Hongbo Li <lihongbo22@huawei.com>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Sungjong Seo <sj1557.seo@samsung.com>,
    Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
    Andreas Dilger <adilger.kernel@dilger.ca>,
    Jaegeuk Kim <jaegeuk@kernel.org>,
    OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
    Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
    Anton Ivanov <anton.ivanov@cambridgegreys.com>,
    Johannes Berg <johannes@sipsolutions.net>,
    Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
    David Woodhouse <dwmw2@infradead.org>,
    Dave Kleikamp <shaggy@kernel.org>,
    Trond Myklebust <trondmy@kernel.org>,
    Anna Schumaker <anna@kernel.org>,
    Ryusuke Konishi <konishi.ryusuke@gmail.com>,
    Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
    Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
    Joseph Qi <joseph.qi@linux.alibaba.com>,
    Bob Copeland <me@bobcopeland.com>,
    Mike Marshall <hubcap@omnibond.com>,
    Martin Brandenburg <martin@omnibond.com>,
    Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
    Ronnie Sahlberg <ronniesahlberg@gmail.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Bharath SM <bharathsm@microsoft.com>,
    Zhihao Cheng <chengzhihao1@huawei.com>,
    Hans de Goede <hdegoede@redhat.com>,
    Carlos Maiolino <cem@kernel.org>,
    Damien Le Moal <dlemoal@kernel.org>,
    Naohiro Aota <naohiro.aota@wdc.com>,
    Johannes Thumshirn <jth@kernel.org>,
    Dan Williams <dan.j.williams@intel.com>,
    Matthew Wilcox <willy@infradead.org>,
    Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
    Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
    dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
    linux-bcachefs@vger.kernel.org, linux-mm@kvack.org,
    linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
    linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org,
    linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
    linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
    ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
    linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
    linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
    linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 00/10] convert the majority of file systems to mmap_prepare
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <644215.1750169159.1@warthog.procyon.org.uk>
Date: Tue, 17 Jun 2025 15:05:59 +0100
Message-ID: <644216.1750169159@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> This is preferred to the existing f_op->mmap() hook as it does require a
> VMA to be established yet,

Did you mean ".. doesn't require a VMA to be established yet, ..."

David


