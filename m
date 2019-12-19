Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677DB126F4B
	for <lists+linux-nilfs@lfdr.de>; Thu, 19 Dec 2019 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSVCg (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 19 Dec 2019 16:02:36 -0500
Received: from logand.com ([37.48.87.44]:59300 "EHLO logand.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfLSVCf (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 19 Dec 2019 16:02:35 -0500
Received: by logand.com (Postfix, from userid 1001)
        id 329DF1A8885; Thu, 19 Dec 2019 22:02:34 +0100 (CET)
X-Mailer: emacs 26.3 (via feedmail 11-beta-1 I)
From:   Tomas Hlavaty <tom@logand.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct
In-Reply-To: <CAKFNMo=k1wVHOwXhTLEOJ+A-nwmvJ+sN_PPa8kY8fMxrQ4R+Jw@mail.gmail.com>
References: <8736emquds.fsf@logand.com> <CAKFNMo=k1wVHOwXhTLEOJ+A-nwmvJ+sN_PPa8kY8fMxrQ4R+Jw@mail.gmail.com>
Date:   Thu, 19 Dec 2019 22:02:32 +0100
Message-ID: <87immckp07.fsf@logand.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi Ryusuke,

thanks for your answer.

Ryusuke Konishi <konishi.ryusuke@gmail.com> writes:
> 1) Is the crash reproducible in the environment ?

yes

> 2) Can you mount the corrupted(?) partition from a recent version of
> kernel ?
> 3) Does read-only mount option (-r) work to avoid the crash ?

I'll have access to the computer sometime next week so I'll try this out
and let you know.

Thank you,

Tomas
