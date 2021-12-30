Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6B481B04
	for <lists+linux-nilfs@lfdr.de>; Thu, 30 Dec 2021 10:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhL3JQg (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 30 Dec 2021 04:16:36 -0500
Received: from hk1.smtp-gateway.net ([158.255.208.113]:43196 "EHLO
        hk1.smtp-gateway.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbhL3JQg (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 30 Dec 2021 04:16:36 -0500
X-Greylist: delayed 1775 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Dec 2021 04:16:36 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtp-gateway.net; s=dkim2k; h=Date:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A9Kmo6hdjHYTyOizCQiXQsMlZ3MMb34tY2IHqV33drI=; b=GVZJovV39ZeMMnF6ewdyuS4SIn
        ru/J56RitbWeNHBJDaqIlAWzm9HGE045+0K/yV+b1u/fD0Q4lQyW85wwyy+SD7xrhetqg4/vPSZ8K
        yYuxhQYzem+g2f6C/zcEsCczVXAREErMnSyu96bHeMLUg0ZwTCg+E51uM/AVK+viC8iBsgtETndoJ
        Ud49eSkCoHxSQaP1M9PirIF6ZbButEDR0G0saaN2CBN/AhEYDfArzQYRTGvhtw6f5SmCsNs40bZ9T
        pXAvkJLlFqABVEsbDipb96zJFJJ8TAqY6HMM1jcJRO2ikhi31tXD6g1djxYB7HHZTeUhzHObep7eG
        PqJgdAug==;
To:     linux-nilfs@vger.kernel.org
From:   Hendrik Levsen <hendrik@levsen.org>
Subject: couldn't mount because of unsupported optional features
 (477e7ad1e859f753)
Message-ID: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Date:   Thu, 30 Dec 2021 09:16:37 +0000
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

Trying to mount a NILFS partition fails with "couldn't mount because of
unsupported optional features (477e7ad1e859f753)". Neither the OS nor
the partition have been touched/modified since the last successful
mount. Might the underlying block device be corrupt? Is
"477e7ad1e859f753" a valid set of feature flag?

Thank you

Hendrik


