Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B763B592E3E
	for <lists+linux-nilfs@lfdr.de>; Mon, 15 Aug 2022 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiHOLgy (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 15 Aug 2022 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHOLgx (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 15 Aug 2022 07:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336D12D39
        for <linux-nilfs@vger.kernel.org>; Mon, 15 Aug 2022 04:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F7E061159
        for <linux-nilfs@vger.kernel.org>; Mon, 15 Aug 2022 11:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE90C433C1;
        Mon, 15 Aug 2022 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660563411;
        bh=RUBiTWx88xXU8yVcchK6WhGJDZzS2sucOuvbvrU6PCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYjXdOsnUKk4hznS7izxVtlOe9jlzlaaCOwjeezkoF3yvYL4Of8MdwQJ1bRSGTWZT
         tTzBs7X1inlH2WfwUEs70J6DYbdy4+mxDVgOeaxVVmvS9bnetCmRkyC53j2MQlvX1D
         mzbGirEHEAgCHcXTA8doQ1UfGeL9FO4BY9mN3cGc=
Date:   Mon, 15 Aug 2022 13:36:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6K645ZiJ6K+a?= <stitch@zju.edu.cn>
Cc:     security@kernel.org, linux-distros@vs.openwall.org,
        konishi.ryusuke@gmail.com, viro@zeniv.linux.org.uk,
        syzkaller@googlegroups.com, linux-nilfs@vger.kernel.org
Subject: Re: [vs] KASAN: use-after-free in nilfs_mdt_destroy
Message-ID: <Yvovz7FKlHLNpNaf@kroah.com>
References: <34e8df4a.848e1.182a1264256.Coremail.stitch@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34e8df4a.848e1.182a1264256.Coremail.stitch@zju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Mon, Aug 15, 2022 at 06:56:55PM +0800, 许嘉诚 wrote:
> Hi developers,
> 
> We may found a flaw in the fs module which can lead to UAF write or DoS.
> We would appreciate a CVE ID if this is a security issue.

As our documentation states, us at security@kernel.org do not assign
CVEs or deal with them at all.

> 
> HEAD commit: 3d7cb6b04c3f Linux-5.19
> git tree: upstream 
> console output:https://drive.google.com/file/d/1PoH9PUdMilsrKtq1oGHu_shM3dggNFAB/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1wgIUDwP5ho29AM-K7HhysSTfWFpfXYkG/view?usp=sharing
> syz repro: https://drive.google.com/file/d/19N1Xh8TVoSUr_2J8j-bWXktL21SvRx_9/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/1R1rYseY7JBDCSfLAP4pjSCoMVgkr7l5b/view?usp=sharing
> 
> Description
> In alloc_inode, inode_init_always could return -NOMEM if
> security_inode_alloc fails. In its error handling, i_callback and
> nilfs_free_inode will be called. However, because inode->i_private is
> not initialized due to the failure of security_inode_alloc, the function
> nilfs_is_metadata_file_inode can return true and nilfs_mdt_destroy will
> 
> 
> be executed to lead to GPF bug.
> 
> 
> 
> 
> Someone found the similar problem: https://groups.google.com/g/syzkaller-bugs/c/z2WroC3_BSw.

Great, can you work on this in public on that thread then?  Have you
tested the proposed patch that is provided there to see if it solves it
or not?

> Fix this bug by moving the assignment of inode->i_private before security_inode_alloc.

That's what the existing patch looks to do, does that work?

And again, as this is public, why notify us and not just work to solve
this in public with the developers involved?

thanks,

greg k-h
