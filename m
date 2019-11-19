Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1ABC1026F1
	for <lists+linux-nilfs@lfdr.de>; Tue, 19 Nov 2019 15:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfKSOgj (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 19 Nov 2019 09:36:39 -0500
Received: from gourmet.spamgourmet.com ([216.75.62.102]:55799 "EHLO
        gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbfKSOgj (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 19 Nov 2019 09:36:39 -0500
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.92)
        (envelope-from <linux-nilfs-ml.via.forwarder@neverbox.com>)
        id 1iX4cQ-0006je-QE
        for linux-nilfs@vger.kernel.org; Tue, 19 Nov 2019 14:36:38 +0000
Received: from aibo.runbox.com ([91.220.196.211])
        by gourmet7.spamgourmet.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <linux-nilfs-ml.via.forwarder@neverbox.com>)
        id 1iX4cQ-0006jE-Fd
        for linux-nilfs@vger.kernel.org; Tue, 19 Nov 2019 14:36:38 +0000
Received: from [10.9.9.204] (helo=mailfront22.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <linux-nilfs-ml.via.forwarder@neverbox.com>)
        id 1iX4cO-0006cN-SR
        for linux-nilfs@vger.kernel.org; Tue, 19 Nov 2019 15:36:36 +0100
Received: by mailfront22.runbox with esmtpsa  [Authenticated alias (690389)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1iX4bm-0005lI-DI
        for linux-nilfs@vger.kernel.org; Tue, 19 Nov 2019 15:35:58 +0100
To:     linux-nilfs@vger.kernel.org
From:   linux-nilfs-ml.via.forwarder@neverbox.com
Subject: Re: BUG: kernel NULL pointer dereference, address: 00000000000000a8
Message-ID: <70b53768-11db-dd75-38c9-5d1786ae88e9@daneng.org>
Date:   Tue, 19 Nov 2019 15:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

I believe I have the same issue as Walton Hoops.

I do not have a serial console, and all my filesystems are NILFS2,

so I do not currently have an easy means to capture the crash.

However, I experienced the same Kernel BUG on upgrading to kernel 5.11

from 5.10. Reverting back to 5.10 results in a clean boot.

The actual kernels I use are the Ubuntu 'mainline kernels'

5.3.10-050310-generic works

5.3.11-050311-generic crashes with Kernel BUG.

So I suspect a change between those two versions has triggered the problem.


