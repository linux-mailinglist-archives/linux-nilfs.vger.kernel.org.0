Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CFB170211
	for <lists+linux-nilfs@lfdr.de>; Wed, 26 Feb 2020 16:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgBZPPE (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 26 Feb 2020 10:15:04 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:40881 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZPPD (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 26 Feb 2020 10:15:03 -0500
Received: by mail-pg1-f178.google.com with SMTP id t24so1426637pgj.7
        for <linux-nilfs@vger.kernel.org>; Wed, 26 Feb 2020 07:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:to:cc:subject:from:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wI1GsLnjFMP9Dm9JS/xs2U8x9zCxeZWv1ClCqCrijjQ=;
        b=oAlodPMZl2QkSxDMZEVbxJHeLKkpVGq1wqZ4k4+60sKc0H/PkfFpqEzpnKsroq7YPJ
         rYvIlp4K1ixcd1Q2kIDpSPRkGHKqrYjJ3uDMrjQpetn8FXV78nUOcHBx2jnGs4aYjD5W
         UUbr+uNj3c9+4DDxOSc0cuFStwooZYvpBJs4MSxeCO8HE+UhW7H7Xceg18e8g4FueaX/
         inoHWtuXez1HJW6t1wAqSfH5MidGcoIxCsg0dOKw9JPbCxKS76di0LgH95Etbov4vugq
         MUo/1jdXRprm6iFDbRe+EdSpc0S+CXeMQetxJAvU4HpAPS3Bh8ryg9tv01AKuP9tcIAo
         HOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:to:cc:subject:from:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wI1GsLnjFMP9Dm9JS/xs2U8x9zCxeZWv1ClCqCrijjQ=;
        b=qDNH4yctzSu5AzeJHRHuxy1NORLbacScQb6wkdijn0/GxM2QM+zoR0KyKcRB2sQtWZ
         MF5k5/yAzv6wf8H7BEW9ydTk8d+DyvrSwBQeT9X1oWNvY+PyyHyQTAVIHC61JE0+llwC
         l6XC3uuvyqezMs7/4gOT4ZRtZKT6BPOO89w/OIt4c2Y4/jkG488A0b1NJwVRRNtOFslH
         HFxtMe4ssGWN46OJ4SXLpJ08FgAI+FF4qeO2ok8sGB5jg76Aw4O8wqu7HbYQvq5vRHPg
         lJa7an5Im/7QCVi3SCQuXOH73J+TC/9sShN8OgBcEw8aeUoHSaNt5rmb4GaQ2fN/fMuJ
         K4Eg==
X-Gm-Message-State: APjAAAW722Tzq3bsDeiR4eIdwEcR9HGeK/dIJH/kH4YlSJMXq4j5O196
        ls0rnlwuDbKmNe5DTu/sATQ=
X-Google-Smtp-Source: APXvYqxMM3VyyGrJJQxR3erJgdBSWgyprx7QudA3QE2H62KPGtr/ETtNzMlR+ngHcgoR+jBqRH+jXw==
X-Received: by 2002:a63:e803:: with SMTP id s3mr4268600pgh.237.1582730102544;
        Wed, 26 Feb 2020 07:15:02 -0800 (PST)
Received: from localhost (i60-36-86-168.s42.a014.ap.plala.or.jp. [60.36.86.168])
        by smtp.gmail.com with ESMTPSA id h2sm3134112pgv.40.2020.02.26.07.14.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 07:15:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 00:14:57 +0900 (JST)
Message-Id: <20200227.001457.2102675267682326035.konishi.ryusuke@lab.ntt.co.jp>
To:     Reinoud Zandijk <reinoud@NetBSD.org>
Cc:     linux-nilfs@vger.kernel.org, konishi.ryusuke@gmail.com
Subject: Re: NiLFS support on Pinebook
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
In-Reply-To: <20200226102235.GA2060@dropje.13thmonkey.org>
References: <20200226102235.GA2060@dropje.13thmonkey.org>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi Reinoud,

> when i mount a partition it gives the error "mount.nilfs2: cannot find or load
> nilfs2 filesystem". Does this mean the linux kernel has no nilfs2 module
> shipped with it, but only the tools?

We see this message if nilfs2 kernel module (nilfs2.ko) doesn't exists in
/lib/modules/$(uname -r)/... .

Some distros don't have nilfs2 module (e.g. RHEL/CentOS), and some
need an extra package like kernel-modules-extra (e.g. Fedora).

I don't know that is there in the Pinebook.

Regards,
Ryusuke Konishi

On Wed, 26 Feb 2020 11:22:35 +0100, Reinoud Zandijk <reinoud@NetBSD.org> wrote:
> Dear folks, dear Ryusuke,
> 
> I am trying to use NiLFS2 on my Pinebook that identifies itself as GNU/Linux
> on aarch64. It allows me to install nilfs-tools wich seem to work fine but
> when i mount a partition it gives the error "mount.nilfs2: cannot find or load
> nilfs2 filesystem". Does this mean the linux kernel has no nilfs2 module
> shipped with it, but only the tools?
> 
> How can I install the nilfs2 filesystem? Or is that up to the distribution and
> out of my control?
> 
> With regards,
> Reinoud
> 
