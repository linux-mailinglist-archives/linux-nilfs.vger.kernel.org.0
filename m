Return-Path: <linux-nilfs+bounces-1-lists+linux-nilfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E37F2278
	for <lists+linux-nilfs@lfdr.de>; Tue, 21 Nov 2023 01:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6AB280F2F
	for <lists+linux-nilfs@lfdr.de>; Tue, 21 Nov 2023 00:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E8115B6;
	Tue, 21 Nov 2023 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rpcV8e36"
X-Original-To: linux-nilfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7315AB
	for <linux-nilfs@vger.kernel.org>; Tue, 21 Nov 2023 00:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E21C433C8;
	Tue, 21 Nov 2023 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700527629;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=rpcV8e36TlLZ8cIzYXrb4DYO9MDwKI7m9qfsXrnSh3U2RxNUHCAhw5SYs4dwhZmEp
	 z38rkNYZOBqWUI6GzOevePdKeGmu52K0aSnSizoOMJNcjZ9cUQZw4ntkr1LGn6AaE8
	 nzhpCkmPxJE3J+QmObsxNXDz9DPML+Ya7MUVTTxM=
Date: Mon, 20 Nov 2023 19:47:08 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-nilfs@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-sexy-fiery-millipede-c6c5ef@nitro>
Precedence: bulk
X-Mailing-List: linux-nilfs@vger.kernel.org
List-Id: <linux-nilfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nilfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nilfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

