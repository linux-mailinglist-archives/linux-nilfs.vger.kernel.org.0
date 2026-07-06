Return-Path: <linux-nilfs+bounces-1651-lists+linux-nilfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iq19MZPhS2rsbwEAu9opvQ
	(envelope-from <linux-nilfs+bounces-1651-lists+linux-nilfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nilfs@lfdr.de>; Mon, 06 Jul 2026 19:10:43 +0200
X-Original-To: lists+linux-nilfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 974DB713B3E
	for <lists+linux-nilfs@lfdr.de>; Mon, 06 Jul 2026 19:10:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eGe62k1h;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nilfs+bounces-1651-lists+linux-nilfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nilfs+bounces-1651-lists+linux-nilfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C44E304C192
	for <lists+linux-nilfs@lfdr.de>; Mon,  6 Jul 2026 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB0433E7F;
	Mon,  6 Jul 2026 16:39:34 +0000 (UTC)
X-Original-To: linux-nilfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C3377555
	for <linux-nilfs@vger.kernel.org>; Mon,  6 Jul 2026 16:39:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355973; cv=pass; b=arqEQ/h5EQds79uJEkpBOWUspuo9KuiLdi1xkW1IHcVZxPBbI9uMaBob5H3VNBqc0ZEpRlX5vNERVNBvJ8MLo46B3QF2FmG7yAhmG05stBs3z37skhLoTIrptP3BA0UKMVA8SFDOYZybQSiYKhd/zOBvbf0z88WbuUnIGhp9bfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355973; c=relaxed/simple;
	bh=+PbLnib61APfYjnmnyskwAXY2QadFtZGs6EDVowezcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD8jAINEx0TTt2NGWAUei54m3OA6UNgVzJ2c3LNBB5/JuFdjyXcjLiur5yH2BbNo+JRiyLjNCoC37bbjYQobm4ff/+2jf5bxRhJpw4GfGmgdEohIcdlflyFyJPT4r7ayKNRziHA0u4gBcJcBgBpCrlH329yFId+xUgl3yH29/bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGe62k1h; arc=pass smtp.client-ip=209.85.167.45
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so3111374e87.0
        for <linux-nilfs@vger.kernel.org>; Mon, 06 Jul 2026 09:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355970; cv=none;
        d=google.com; s=arc-20260327;
        b=LbWTT8QcFiWnLEsCvQfnh7fkex3clBzZPzDQrLU6cpm6ArBMfxhBTsfH6jPh9Z9YOe
         1yO+VqYDLay2aQbb2KXzOCrES7Dc/Fe3j3Lk/bgLYuY1rdyF7Ee0u7dSrJYdLjOBTUZM
         HNvWMW1J+xJTwmYOPtc5faq/V5zSxqv7Dq1pkACgEOLJIGfrr5EXjmRbDokZwUMKqkBc
         JcTiPC6reZks8HjuvNXUqH7VN+JyXr9klCX1hCHh6mGnjp09Q6mo6E0RMQfq7+5+TiNF
         v3MxT/C2Oj5M5kRSHL8ojdtigkmAusWsjpcYClsHV7pIS/SkgCd5a5V9Ya8fEi2iknQJ
         HuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cvoTg9ad1wx2kMvdJBqMndhT+qD24xoYzsAI9ooeOJY=;
        fh=7YxcnamWNPpa3mZhNdizRy3T04owP5OhsvRy49jINKY=;
        b=btgFrPsGJMavnALGroMT4MAgSawMSEwShsUao4VMAALqWSXoR2j+6lU81lwliZ3odC
         Xm5rKE+FQuVeCGcAeAKlPgBXMfoIhYoKBYUiQnvGiJUr4ZNhszkfumhjqlo7ZKq6hw5q
         xyWyNvd4DpsQ5wP2MKaAXL2xVc3eAZo+l2FT6QEZdodsmocxifv0ZZmDLVndGqO/3nPK
         DtD1rkbqTAUnnvJtO92fM3knIomwh0Z9J7HNMfCQuhtefu6+6azfKSbEVNQ9maedoWXd
         ZZ3bUhxPk+5PvivhaJmc9jjgasqjbUoalSbHgUJeMHaD/edth7jd/p843TN16qmle20o
         JwCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355970; x=1783960770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvoTg9ad1wx2kMvdJBqMndhT+qD24xoYzsAI9ooeOJY=;
        b=eGe62k1h0IUtGP9u0U4vr4UxN8jlUSM4m8zDOP1SugHfuuCXBLS+/L6SofMtTXjta4
         aBycW7J5nWyapiJ+VuLs8hPKDnGNsgUuIP6INj98f28stDrNH4OgREnG1YgentrlR1dn
         WAwZRcRVS0Y1fTFoK1E5GjrIUUqtHFUpoeOfXPUxO6NsH7henMikPEpnSjYBVtZu1HSg
         mg3z0Qahr3RZpa9SdVWhDrjy5QBZgejTgANkBlNWLsNyRrgxpvC1dDW2n+rZXgYKCCrz
         rcbGCqV+ejnXB/ne2cubAhUXau3iQsMqI7/H0/redJiacit/XV1zejOO0HJniePKdFJq
         ++uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355970; x=1783960770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvoTg9ad1wx2kMvdJBqMndhT+qD24xoYzsAI9ooeOJY=;
        b=VzQ1U65UsGaLSXYcY/OHQrFH89V42acZ3mVpgI+nxFhIQC74lV3Hu5RrwtCT+RPq1I
         gDs61ef9itIlpVAbEfJPyfQG8QdmC6H/HhzSEXLNo8ClpV3l4Q5CQWoO395lfB4LMWjy
         WZxkE7cpJzUbFlDAtFuokolLZBXH2qrXp8oy52MG1h95X87hDG8ERcBUd56Z24e7anVn
         rCzT36liGiyYP4T+U9iAufIhRQ2MUs/GSdkI4tBQGuDluKmPQ1g/dv/u60WnCDJEah9i
         dD4jbMJkajJCXXoJ2P4vkL5OGi4BBu+2CPwRia6zA9Xy++xjq1a0X/mjaaUc1BuhBE6u
         r2IA==
X-Forwarded-Encrypted: i=1; AHgh+RoAaFU34qOua0eRqktKm6HOZw0BPshj+soiDw7Cs6iuWTcttDxeL8DTEulwKhDYMnogi4p4fh4TAzUnBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2lSBeb+2JHJNW0p9fX04T+nnbGi2ExpTIn0ee/5gpzDhAfSVj
	vWX0BhUM3o2OlHedN51WfmnEtXZWm2dkosRShI3Zv8Vcq+0W1bT4/tPLoNFsF0hZ0v4LXTzEqrJ
	81PRbOKihWpuSwgWrBcyKI9f4gj+t8BI=
X-Gm-Gg: AfdE7clur+Cz0NiLCAXCNHtY3/9B6jKSF0GjzGyoSF0wg0ZCMbGdaUnusxi/S/0vaG7
	3ClSDR8sGjEuBRLGZeBZHCij6Z5xtLfqrOWB15QVVqMIuIbHoHzxp65XChW0SBEZg9JaiPuXkN8
	MOmxI5WnmWNy8EWa0B8MsilLkvlew/oxUNs/K98tm5SeYaSPx0PmUVEaPBl59oYj+OnVQcmkWN/
	+gP5QJYPAfosnPTTechdZZFEOLAL/D/4IiazYuc5O9pCN55gJnrFqKsf1RAZu9cxvx5DmZO7A==
X-Received: by 2002:ac2:43ae:0:b0:5ae:a9eb:eff1 with SMTP id
 2adb3069b0e04-5b007bb3dbdmr189547e87.58.1783355969356; Mon, 06 Jul 2026
 09:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706110807.2835-1-igorpetindev@gmail.com>
In-Reply-To: <20260706110807.2835-1-igorpetindev@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 7 Jul 2026 01:39:12 +0900
X-Gm-Features: AVVi8CczTT5KlfH-SiqY0iMIhJ5KPmVre-5_GNs_ihtoheQl9ZA1CbHBn-4L1Lk
Message-ID: <CAKFNMo=XyMb_Tmm4F1awoyB0f=ndmp9vmRn44+fAQBmABtmTEg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: handle corrupted checkpoint count gracefully
 during deletion
To: Igor Putko <igorpetindev@gmail.com>
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+79b815da3aec0a6a4d02@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:igorpetindev@gmail.com,m:slava@dubeyko.com,m:linux-nilfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+79b815da3aec0a6a4d02@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[konishiryusuke@gmail.com,linux-nilfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1651-lists,linux-nilfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konishiryusuke@gmail.com,linux-nilfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nilfs,79b815da3aec0a6a4d02];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 974DB713B3E

On Mon, Jul 6, 2026 at 8:08=E2=80=AFPM Igor Putko wrote:
>
> Syzkaller reported a kernel warning in nilfs_cpfile_delete_checkpoints()
> due to a corrupted checkpoint count on the storage medium where
> le32_to_cpu(cp->cp_checkpoints_count) is less than the number of
> checkpoints being deleted.
> Triggering a WARN_ON() for disk image corruption is suboptimal. Fix
> this by returning -EIO and reporting a filesystem error via
> nilfs_error() instead of interrupting execution with a kernel warning.
>
> Reported-by: syzbot+79b815da3aec0a6a4d02@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D79b815da3aec0a6a4d02
> Signed-off-by: Igor Putko <igorpetindev@gmail.com>
> ---
>  fs/nilfs2/cpfile.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Thanks for the patch proposal!

A filesystem inconsistency is indeed the root cause, and WARN_ON is
undesirably catching it.

The proposed fix looks appropriate to me, so I plan to apply it after
running some tests on my end.

Thanks,
Ryusuke Konishi

>
> diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
> index 4bbdc832d..d3349fa58 100644
> --- a/fs/nilfs2/cpfile.c
> +++ b/fs/nilfs2/cpfile.c
> @@ -81,18 +81,26 @@ nilfs_cpfile_block_add_valid_checkpoints(const struct=
 inode *cpfile,
>         return count;
>  }
>
> -static unsigned int
> +static int
>  nilfs_cpfile_block_sub_valid_checkpoints(const struct inode *cpfile,
>                                          struct buffer_head *bh,
>                                          unsigned int n)
>  {
>         struct nilfs_checkpoint *cp;
> -       unsigned int count;
> +       unsigned int checkpoints_count;
> +       int count;
>
>         cp =3D kmap_local_folio(bh->b_folio,
>                               offset_in_folio(bh->b_folio, bh->b_data));
> -       WARN_ON(le32_to_cpu(cp->cp_checkpoints_count) < n);
> -       count =3D le32_to_cpu(cp->cp_checkpoints_count) - n;
> +       checkpoints_count =3D le32_to_cpu(cp->cp_checkpoints_count);
> +       if (unlikely(checkpoints_count < n)) {
> +               nilfs_error(cpfile->i_sb,
> +                           "deleted checkpoints count %u exceeds block c=
ount %u",
> +                           n, checkpoints_count);
> +               kunmap_local(cp);
> +               return -EIO;
> +       }
> +       count =3D checkpoints_count - n;
>         cp->cp_checkpoints_count =3D cpu_to_le32(count);
>         kunmap_local(cp);
>         return count;
> @@ -522,6 +530,10 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cp=
file,
>                 count =3D nilfs_cpfile_block_sub_valid_checkpoints(cpfile=
, cp_bh,
>                                                                  nicps);
>                 brelse(cp_bh);
> +               if (unlikely(count < 0)) {
> +                       ret =3D count;
> +                       break;
> +               }
>                 if (count)
>                         continue;
>
> --
> 2.47.3
>

