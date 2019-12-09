Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033F41178D4
	for <lists+linux-nilfs@lfdr.de>; Mon,  9 Dec 2019 22:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIVt2 (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 9 Dec 2019 16:49:28 -0500
Received: from mx1.cock.li ([185.10.68.5]:59763 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfLIVt2 (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 9 Dec 2019 16:49:28 -0500
Date:   Tue, 10 Dec 2019 00:49:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
        t=1575928166; bh=gwy/SJZlxYdW22y8wToAQzdumpl+hGteREzcaFrDFTM=;
        h=Date:From:To:Cc:Subject:From;
        b=CA7gpyXLuasA7sD5mbIdleeKxrPZcXGGq7Rr9skWDoFSYgPjG5FbMBM91k/XXT0hG
         /f7Ir63gq17PE9omfYFkpXLPY7EqLCj9h8MChjVCIwSwJ5B4jDagopaNqEYEvXVGkM
         l7R13edL31HiMwiPWMJ++vuHSUqV4OZX3OUjB+GaLRxIBnI+PiE/tAS04vWxhaBJKA
         V2WwMVdslPKrZDpwSqeuZi7f27ki7AjHOVolZgx98rTB04rO/kEmiKRxDqrtKb85AW
         ssZukbW1ZNcxifVPP33X04qWqoDNpPcHOXlXGH8jWKJn4TttoKhDzqqhVahE/NNduC
         2xhy2CcL7LT4g==
From:   L29Ah <l29ah@cock.li>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org
Subject: xattrs support in NILFS2?
Message-ID: <20191209214925.ztpiciplrjdzs2ka@l29ah-x201>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hello and thank you for your work on NILFS2!

I wonder why wasn't https://marc.info/?l=linux-nilfs&m=138935638611281&w=2 accepted back then?
Can it be helped somehow?

-- 
()  ascii ribbon campaign - against html mail
/\  http://arc.pasp.de/   - against proprietary attachments
