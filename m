Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C144823D9
	for <lists+linux-nilfs@lfdr.de>; Fri, 31 Dec 2021 12:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhLaL5P (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 31 Dec 2021 06:57:15 -0500
Received: from SMTP.sabi.co.UK ([185.17.255.29]:39454 "EHLO sabi.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhLaL5P (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 31 Dec 2021 06:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=root.for.sabi.co.uk; s=dkim-00; h=From:References:In-Reply-To:Subject:To:
        Date:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uH3vTVgjOmET+Jp6ze2MZw6Q8dc31sUJIfacxiNzRhc=; b=Zf3KX9fyXdBbCYCstLHa6JQnMN
        fxJIUBvEYXg59NZCRyIMDjoB0H2OKyK8sdAVuD/ajS8t94oIo2WMBJrlgZrP4LYlzEhS206Qgk6Zk
        5efZ4C5hFGaj6Dy0SPEoD3vhOwPrSqHIYbRYXJU4rJ9RARE7/JAmuSYHxCabMrcI9r6jkiOiOWhMl
        lW9OzBEt0ZGllY3nZ+MTvAqlCB3Z6KZSjiOnD4NPzmNXgI6R81pOw9TTHWNP42JAQvwfKS6S4fEZ2
        /kilYBwKQ3bpFND09fTq+/rZ1+kniHx0/dnzk+7axe8+3/YD/xz139TuBbXbJDfO9IaCX5ZucMiFE
        nECP8AMg==;
Received: from dynamic-089-204-138-234.89.204.138.pool.telefonica.de ([89.204.138.234] helo=sabi.co.uk)
        by sabi.co.uk with esmtpsa(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)(Exim 4.93 id 1n3GX3-00GK8d-Rg   id 1n3GX3-00GK8d-Rgby authid <sabity>with cram
        for <linux-nilfs@vger.kernel.org>; Fri, 31 Dec 2021 11:57:13 +0000
Received: from [127.0.0.1] (helo=cyme.ty.sabi.co.uk)
        by sabi.co.uk with esmtp(Exim 4.93 5)
        id 1n3GVD-002fkw-7E
        for <linux-nilfs@vger.kernel.org>; Fri, 31 Dec 2021 11:55:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25038.61349.479758.553027@cyme.ty.sabi.co.uk>
Date:   Fri, 31 Dec 2021 11:55:17 +0000
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To:     list Linux fs NILFS <linux-nilfs@vger.kernel.org>
Subject: Re: couldn't mount because of unsupported optional features
 (477e7ad1e859f753)
In-Reply-To: <25038.60666.361700.270143@cyme.ty.sabi.co.uk>
References: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
        <25037.40801.808565.662504@cyme.ty.sabi.co.uk>
        <37be5d12-adea-6399-65c3-6d50008c18ff@levsen.org>
        <25038.60666.361700.270143@cyme.ty.sabi.co.uk>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
From:   pg@nilfs.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-Blacklisted-At: 
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

>> This looks like a good idea, linear scan for segment nodes:
>> https://www.spinics.net/lists/linux-nilfs/msg02198.html Could
>> be the start of the fsck that never happened.

There was something like that:

  https://www.mail-archive.com/linux-nilfs@vger.kernel.org/msg01391.html

The same person has written a very detailed overview of the
implementation of NILFS2:

  http://dubeyko.com/development/FileSystems/NILFS/nilfs2-design.pdf
