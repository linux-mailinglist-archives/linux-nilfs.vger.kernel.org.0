Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5275143C
	for <lists+linux-nilfs@lfdr.de>; Thu, 13 Jul 2023 01:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGLXNO (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 12 Jul 2023 19:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjGLXMr (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 12 Jul 2023 19:12:47 -0400
X-Greylist: delayed 2592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 16:12:28 PDT
Received: from SMTP.sabi.co.uk (SMTP.sabi.co.UK [185.17.255.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCE26AE
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Jul 2023 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=root.for.sabi.co.uk; s=dkim-00; h=From:References:In-Reply-To:Subject:To:
        Date:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3noleI4cFJm1LhhKIDY7EYrlpTYYecpFopAnL7reDec=; b=Wr5Lh5dDSPSewi+jnNBwrxp8NR
        hszAHG1P4RgGlfm59tnhhw/xYvAbd6TTHzymDXIoauncZD2dFWSxkyAdh8RpxVJES5BGhpgvveLtc
        Z2EnWWwdt1yPHfuXr/np6MrXKOv8LP6HQvrIPEXX6eusOR28Y02w7FFdSNu5DUnbm9L5cFESInhAI
        GHLUAGbwmwKOcSgayuFf/5Sy3ZcnWH5PW+xNhgi6fvstBFw4D1HPjJ2u/1Yi8WHjd3qAgrTAG+Rm4
        wBCF+kEUIJERAjaXudG6ozMPnmOdN6WM0tB1mBjJl67SyXAd4D4GrGc9CTLmbrC6ydFL24CK5VkRB
        HlL2FdQA==;
Received: from [86.146.136.132] (helo=cyme.ty.sabi.co.uk)
        by SMTP.sabi.co.uk with esmtpsa(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)Exim 4.93
        id 1qJiKf-009ccO-TSby authid <sabity>with cram
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Jul 2023 22:29:13 +0000
Received: from [127.0.0.1] (helo=petal.ty.sabi.co.uk)
        by cyme.ty.sabi.co.uk with esmtps(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)Exim 4.93
        id 1qJiKb-001ZZD-8P
        for <linux-nilfs@vger.kernel.org>; Wed, 12 Jul 2023 23:29:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25775.10549.41499.886957@petal.ty.sabi.co.uk>
Date:   Wed, 12 Jul 2023 23:29:09 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To:     list Linux fs NILFS <linux-nilfs@vger.kernel.org>
Subject: Re: {WHAT?} read checksum verification
In-Reply-To: <174f995c-e794-74c4-24d6-52451f3f3f28@prnet.org>
References: <174f995c-e794-74c4-24d6-52451f3f3f28@prnet.org>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
From:   pg@nilfs.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

> I used NILFS over ISCSI. I had random block corruption during
> one week, silently destroying data until NILFS finally
> crashed. First of all, I thought about a NILFS bug, so I
> created a BTRFS volume

I use both for main filesystem and backup for "diversity", and I
value NILFS2 because it is very robust (I don't really use
either filesystems snapshotting features).

> and restored the backup from one week earlier to it. After
> minutes, the BTRFS volume gave checksum errors, so the
> culrprit was found, the ISCSI server.

There used to be a good argument that checksumming (or
compressing) data should be end-to-end and checksumming (or
compressing) in the filesystem is a bit too much, but when LOGFS
and NILFS/nILFS2 were designed I guess CPUs were too slow to
checksum everything. Even excellent recent filesystems like F2FS
don't do data integrity checking for various reasons though.

In theory your iSCSI or its host-adapter should have told you
about errors... Many can enable after-write verification (even
if its quite expensive). Alternatively some people run regularly
silent-corruption detecting daemons if their hardware does not
report corruption or it escapes the relevant checks for various
reasons:

https://indico.desy.de/event/257/contributions/58082/attachments/37574/46878/kelemen-2007-HEPiX-Silent_Corruptions.pdf
https://storagemojo.com/2007/09/19/cerns-data-corruption-research/

> [...] NILFS creates checksums on block writes. It would really
> be a good addition to verify these checksums on read [...]

It would be interesting to have data integrity checking or
compression in NILFS2, and log-structured filesystem makes that
easier (Btrfs code is rather complex instead), but modifying
mature and stable filesystems is a risky thing...

My understanding is that these checksums are not quite suitable
for data integrity checks but are designed for log-sequence
recovery, a bit like journal checksums for journal-based
filesystems.

https://www.spinics.net/lists/linux-nilfs/msg01063.html
"nilfs2 store checksums for all data. However, at least the
current implementation does not verify it when reading.
Actually, the main purpose of the checksums is recovery after
unexpected reboot; it does not suit for per-file data
verification because the checksums are given per ``log''."
