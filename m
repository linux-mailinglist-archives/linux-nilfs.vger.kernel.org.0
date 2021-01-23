Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B1430162E
	for <lists+linux-nilfs@lfdr.de>; Sat, 23 Jan 2021 16:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbhAWPNA (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 23 Jan 2021 10:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbhAWPM7 (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 23 Jan 2021 10:12:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24442C06174A
        for <linux-nilfs@vger.kernel.org>; Sat, 23 Jan 2021 07:12:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ox12so11896437ejb.2
        for <linux-nilfs@vger.kernel.org>; Sat, 23 Jan 2021 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UU81y8dveKelR/fniJfeNc03EvT3KGTF4ErSDi7GL9M=;
        b=arlV8hvLpgLi2Y2mwgZSsCL/25k6ejP4m5oYu+yooqAfRLy+QDphrrh1lI1p0XtFST
         9PE5fzCDxWWklVOlbHLcjbLR0ctZ4iG2H93q8ZW1sIcuY4sC/9wKrtn9zVDBNFAka2q6
         TpOwhuLBg4EE93TDIVg8b19S0l030KBOyR5cN4YnK11/hbOL0T2ZaV4HdHCNhT7U3hsn
         muVP4QYD2eD1TObujQrBIUIC2A0jNrEsiuqaFMZ1tPbeujG4AKdt72ZbRGJOq+HoZdSn
         KBizwiYWkbhKSwmVYhTNtuBrGm+g2SMIm82fjT7X7X1+apUJPpIqN/XMlQvvaIB1OzIM
         p3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UU81y8dveKelR/fniJfeNc03EvT3KGTF4ErSDi7GL9M=;
        b=ao4WuCz/gE73zcETUSA1QHtmhslckiLUpyvImz6X6YRDl8FReYM09zcRu02Vq+o5Ph
         7MObmr6Ghuy0XnhiBU/ICPRwRCgQ6+Iyf64sc3SCiUDqvcCGqLpeCEB8qVisErLJg2Zq
         Zdp+y4J+b9cUWMm5S+O96B/w/wXR922vqzqP/3pvUj9A6OFH4JbxSdj4c2TB9ccc4Cv9
         yxxmFzLWAqczeYbritdku5d6wRCX68Q9Oq2sz0wKIpbTH4FztpNgnK3xw64V6yj2BBPm
         oxSylpeJgRvIWbtjpUFg22+E0jvjJt3VVrWPJLlsNM9YBeUFmV2nJtYS/He+LMEqCoQQ
         oZ5A==
X-Gm-Message-State: AOAM530Qzmdj6VmouS50qNJNQlFMU/Exj8yU6EDfLVMo2SfrCpItfjyq
        XA6ShTyaRXQUhalTdM7PiJgLwmFxmc1wmZ5MOQg=
X-Google-Smtp-Source: ABdhPJy0yXr+8ZBJjTfY6SGW2RVLR3ozp6qlGEHaCv1YWbVrNjc4rAxl4s8ngSIwqVCw89CXa45eFTBhzYAZrC8DZMQ=
X-Received: by 2002:a17:907:932:: with SMTP id au18mr6107638ejc.91.1611414737711;
 Sat, 23 Jan 2021 07:12:17 -0800 (PST)
MIME-Version: 1.0
References: <YAwwjEuHpfeFDqNo@localhost.localdomain> <FR2P281MB0283D8B316988BB9F697BF3BB2BF0@FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2P281MB0283D8B316988BB9F697BF3BB2BF0@FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 24 Jan 2021 00:12:06 +0900
Message-ID: <CAKFNMo=oenxiKHcHOLFC0Zvd2kPfaTkkvQ+8t+tgk0PxqOVb7w@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: make splice write available again
To:     Joachim.Henke@t-systems.com
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

Thank you for quick patch submission.   It looks good at a glance.
I will check the details of the change and will try testing.

Thanks,
Ryusuke Konishi

On Sat, Jan 23, 2021 at 11:39 PM <Joachim.Henke@t-systems.com> wrote:
>
> Since 5.10, splice() or sendfile() to NILFS2 return EINVAL. This was
> probably caused by commit 36e2c7421f02 ("fs: don't allow splice
> read/write without explicit ops").
>
> This patch initializes the splice_write field in file_operations, like
> most file systems do, to restore the functionality.
>
> Signed-off-by: Joachim Henke <joachim.henke@t-systems.com>
> ---
>  fs/nilfs2/file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 64bc81363c6cc..4c7a662047513 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -141,6 +141,7 @@ const struct file_operations nilfs_file_operations = {
>         /* .release     = nilfs_release_file, */
>         .fsync          = nilfs_sync_file,
>         .splice_read    = generic_file_splice_read,
> +       .splice_write   = iter_file_splice_write,
>  };
>
>  const struct inode_operations nilfs_file_inode_operations = {
