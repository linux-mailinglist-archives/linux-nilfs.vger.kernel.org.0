Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3F17B919
	for <lists+linux-nilfs@lfdr.de>; Fri,  6 Mar 2020 10:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgCFJTl (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 6 Mar 2020 04:19:41 -0500
Received: from 13thmonkey.org ([80.100.255.32]:62096 "EHLO
        dropje.13thmonkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgCFJTk (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Fri, 6 Mar 2020 04:19:40 -0500
Received: by dropje.13thmonkey.org (Postfix, from userid 103)
        id 7C4E6C1EB14; Fri,  6 Mar 2020 10:19:39 +0100 (CET)
Date:   Fri, 6 Mar 2020 10:19:39 +0100
From:   Reinoud Zandijk <reinoud@NetBSD.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org
Subject: B-tree implemenation
Message-ID: <20200306091939.GA18929@dropje.13thmonkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Dear Ryusuke,

before i start reverse enginering your B-tree implentation in NiLFS :) I
wonder how its implementation is taking care of random writes at random
offsets in a file? Say a received bittorrent file?

Will it enumerate the blocks written in a b-tree list and insert between
elements in the list if there is space? And if not, insert a level of B-tree?
Will it try to rebalance the tree or will in practice the number of levels of
B-tree suffice?

Is rebalancing the B-tree of an inode seen as part of the apparently not yet
implemented defragmentation?

With regards,
Reinoud

