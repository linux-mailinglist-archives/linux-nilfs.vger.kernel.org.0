Return-Path: <linux-nilfs+bounces-1525-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FPfJWuGvWnQ+gIAu9opvQ
	(envelope-from <linux-nilfs+bounces-1525-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Fri, 20 Mar 2026 18:39:55 +0100
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95B2DECC6
	for <lists+linux-nilfs@lfdr.de>; Fri, 20 Mar 2026 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70AFB31A2B5C
	for <lists+linux-nilfs@lfdr.de>; Fri, 20 Mar 2026 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48783CE4B6;
	Fri, 20 Mar 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqmmvlGq"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985113D16EE
	for <linux-nilfs@vger.kernel.org>; Fri, 20 Mar 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027946; cv=pass; b=fvBkfMD00FB/dDXk/nQZL7w3tmxlU3x8dKt2zTONe+1avqFAZPUsORDGpUMsIitNN9niIUI4OHWWa71naI5sICjyimg5h6P/X66feLObWi0ex1JzP4eBx4te4GdHfo9MVgJ4sb206w16lWXfacDig0zmgAdkM8/WJHNVOZzinnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027946; c=relaxed/simple;
	bh=0Ei1Apo4HJBJ7TiDkC3EzoI2/5iGdEvrZR7flXNAYzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kyn+Q4dIo3Y/OHa/O6D6/tCm6CWzXLR8O3iM1buQtjKtFxl3SWoc9L/QTwx93SG3oqkyydwLh/0xaGcSjs2MEeWkpcbRc2R5VzOBMSQ+dJz82boISeDzKo0nwit3Ivyl6OhBA+pfKrOllhyQIqljLgVSfwjQ/zfGHJwgm1cbI84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqmmvlGq; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so887137e87.1
        for <linux-nilfs@vger.kernel.org>; Fri, 20 Mar 2026 10:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027943; cv=none;
        d=google.com; s=arc-20240605;
        b=L6RbkW7Ex7sHFmaVRWOAoEC7zyfed9sDL8GqNrndUFAMO6Xtl/AyUxGLb+dfEEMtKQ
         /OSs8+73ylfX4CGBhehxjOskLlTZkuY8yJlr/fwSmUImIkji+nXSzYORn9nDCqJqm9RJ
         NkHL+arDQrAqpAXcGvwFykI+r6/0ZA9qJrQqgdkYDgTStAvQD5nQzLgNdbgy93wPtjce
         Lk+u+6olDsxZFTK/c4V7c2v8m72owgzp6XQN6FifaF+RJzstEihV7EIWrPq/5sT8d4g0
         ArCP4jKqavQAY7GmYKyXmOESEGSXd1YtuHl11Rw+ihktjIlimQ06OrMAx3Efk+gpecLQ
         xbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s498isnvbkjVq5qRHxEqvBaM65UxpttgA2LePsrEXuc=;
        fh=MbavPlyBM30hvSWCvItToig456aJUtVFG9T99EKBID8=;
        b=JBaKVDPLtC5wl+UAyLaw+kImIbkMFSRlPpDQB1JUwI29Xnj3lmmNQfPZDvUob9kivB
         I/jcwM8D0l1fSQCT4gehAuJmQBCPcqPiRUSdrx8aV4ISrfVBLomMl2mjraEt9kY9BT0/
         vZErAoADm4SVYECLvT9ntwe+S3icwz3wCPIc6/rS09hH/FscKcPXJOD2Vu7ezXaBMgFr
         0dqPX52OF4Ya+WAq7c20O/zLpdOOsZvrCxrxu9ulI7B9tS1Gy5raABPTN7Ri2hTdRmVY
         O1syO2MawpZ2SREKbImV5546GFTqqsZeITzQtMqgYAm7XbctCTzniEtOz1ZzopqhuBgr
         i/RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027943; x=1774632743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s498isnvbkjVq5qRHxEqvBaM65UxpttgA2LePsrEXuc=;
        b=lqmmvlGqXQcg74vtu1ZbaLsrUeLtJA2AsQPlAvBTX89tQHEFpe3cpid4CRZWNAw6Ts
         fggCLm+6mqF24MetAZDb029a/vFl7RFQ/94a3CZGWjlEIwVgV7JV+S9ET/gieXpfjH/9
         YgmkpaPErP+RN3ga/ieqajlHzC3MYr4WiWLBzvAb+OFBG7f/juWPlIp4J+EWfVAibODX
         So4ojr3m0nCiBkc5yJ2xQDslQd5fD7Q+NE2z8rmjNAPZp3No6f10VrRsxYGuiklNAUSV
         bILatmu+O3sbc7kHxbpqKXZHl16/DJcVD+YtsdfZUlhUi0pPRK2QJPaERsWUz2Ov7lzg
         6U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027943; x=1774632743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s498isnvbkjVq5qRHxEqvBaM65UxpttgA2LePsrEXuc=;
        b=ZpytrnKN13Wp2AzYCIWrqWLWymCQUFH5Z+yZyVmjnq3z38DHcr7uW0cUedkRScYYJ4
         8pXgBvuNy8FX+BHRAqkq1Bu5poIFekIEfo/BDdhWEL8z9d5Qv4fG8E7WoEOCM8IFJmMf
         /FIlbbYV6AzMvm2oi1iDE/Iqk9dz2kaav26WMyornBRXCn0K3bYJfrm891IokOuEeKFv
         WvxO/Fon/aZlpIri1sVtW9uEoHa1skvFnyB5P7w7mcM4/2X7hAVqU/JPKTHYt5P255UW
         jbEYni941cN348/D3oUKFcCXGxDXiAjaizOeVW28rNpom90jmi/eUZHemnkyVfdqyGW8
         N7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUhXHEn+jRCeFsy8jBVIE3wUNyajbIg/wXqzABymF24PjrylaC8FriEDa9CRL+PrN0kjSb2al0oWyHWqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/88CXpQv+fGZ/jgeRuAheVK4rfl6dwbfVY6Dx8pXYtl2g+1vG
	lfzTiayYtKdH8dl+hYQ2Gzdlu7Ad1VMyX1IcBBN/Xt4/H8nROdx+KlrJgAC2wkbrWCzvB9JauLy
	JyyE47geUblAXYyGRR+VuFecGx4AtY8elXaeg
X-Gm-Gg: ATEYQzw9OSIIYPEDamA/xN1V9R0a9fcH7nEZloJPKlw0F9TLY4RgXhm6oWXBAcemmYa
	24K93vjS6zzbQnCDD+7KjygFngIrAwgxnK7mGql9y6Hbd8RtPhVS5ijLtO7QA/JuzH+qmeN7i30
	ijCwtJxuCLndlvV2LSAlsVYiS+MOv+BPnatp9wganWImLnwXnfV7XDBFx1PW4azelWf5YC2Nijd
	R5mVjmd3ST2/NAnLxu/YaswINXKOdGJ4DlYha/1ZmRpv/te3PM5PUafoUUqbnqLOqzo0VxYh5I0
	8Ln2ACVD
X-Received: by 2002:a05:6512:31c2:b0:5a1:3bd8:a068 with SMTP id
 2adb3069b0e04-5a285b60f8emr1546327e87.30.1774027942443; Fri, 20 Mar 2026
 10:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319091930.1088735-1-kartikey406@gmail.com>
In-Reply-To: <20260319091930.1088735-1-kartikey406@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 21 Mar 2026 02:32:05 +0900
X-Gm-Features: AaiRm506DcRkCfxyBuwxKNkJuIOlTBGqYE3vRA0qF6HLv4jFAiIoA-f43X7QCVQ
Message-ID: <CAKFNMo=Z2wsL5za0VUeYh23nodPusUCC9WasSeR5BHc6tEBu1A@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix missing continue after -ENOENT in nilfs_ioctl_mark_blocks_dirty()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: slava@dubeyko.com, akpm@linux-foundation.org, sato.koji@lab.ntt.co.jp, 
	linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+98a040252119df0506f8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1525-lists,linux-nilfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.711];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konishiryusuke@gmail.com,linux-nilfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nilfs,98a040252119df0506f8];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: EF95B2DECC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you, Deepanshu.

On Thu, Mar 19, 2026 at 6:19=E2=80=AFPM Deepanshu Kartikey wrote:
>
> nilfs_ioctl_mark_blocks_dirty() calls nilfs_bmap_lookup_at_level() to
> get the current block number of each block descriptor. When the lookup
> returns -ENOENT, meaning the block does not exist, it sets bd_blocknr
> to 0 and continues processing.
>
> However, if bd_oblocknr is also 0, the subsequent check:
>
>   if (bdescs[i].bd_blocknr !=3D bdescs[i].bd_oblocknr)
>           continue;
>
> will not skip the block, and nilfs_bmap_mark() will be called on a
> non-existent block. This causes nilfs_btree_do_lookup() to return
> -ENOENT, triggering the WARN_ON(ret =3D=3D -ENOENT).
>
> Fix this by adding a continue statement after setting bd_blocknr to 0
> when the lookup returns -ENOENT, so that dead blocks are always skipped
> regardless of the value of bd_oblocknr.
>
> Fixes: 7942b919f732 ("nilfs2: ioctl operations")
> Reported-by: syzbot+98a040252119df0506f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D98a040252119df0506f8
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  fs/nilfs2/ioctl.c | 1 +
>  1 file changed, 1 insertion(+)

Since this implementation interacts with userland GC, I will check
whether this is a simple missing 'continue' statement or if it was
intentional.
If it is as you pointed out, I will pick it up and send it upstream.

Thanks,
Ryusuke Konishi

>
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index e17b8da66491..1615a314f557 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -745,6 +745,7 @@ static int nilfs_ioctl_mark_blocks_dirty(struct the_n=
ilfs *nilfs,
>                         if (ret !=3D -ENOENT)
>                                 return ret;
>                         bdescs[i].bd_blocknr =3D 0;
> +                       continue;
>                 }
>                 if (bdescs[i].bd_blocknr !=3D bdescs[i].bd_oblocknr)
>                         /* skip dead block */
> --
> 2.43.0
>

