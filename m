Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E6482439
	for <lists+linux-nilfs@lfdr.de>; Fri, 31 Dec 2021 14:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhLaNkd (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 31 Dec 2021 08:40:33 -0500
Received: from hk1.smtp-gateway.net ([158.255.208.113]:45788 "EHLO
        hk1.smtp-gateway.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhLaNkd (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 31 Dec 2021 08:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtp-gateway.net; s=dkim2k; h=Date:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Message-ID:From:To:References:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=69CLJzY9ba09nXkleT2Tjvx94etr4TfFGr5y1EDAI0w=; b=lnv5PbVz682xl+2W42saqNESRe
        glEDRsMeBPS2xtXZiToZz+cApESDFQ0HMw/dfboQ6Z+ChmcjIE/aXIq6zrKmVB4tHuE16SMHWbrd4
        NFp77RyE/LXFIGsj9LW1/KrH4gsIjrHCrlzMGuN7ttObq/nXlBwNejdf5a5AeW4zvigeg+AWhdZUL
        8/HU4mRALLufJSbTXOpHAt+WdapDBkIbqBD4dDfFEzX2ZvgkEMbGHb8qRmK59GFOCT+OlYHeDEgqy
        rK1uJn97TuM313bHQKjCbS3vu5oJ0Af0pjOOdAMu8EnyROKJX8qjV7V/O77F8wDDC+uG63YZ9845Z
        UaF6h2OA==;
Subject: Re: couldn't mount because of unsupported optional features
 (477e7ad1e859f753)
References: <39575f5e-b47a-d971-6c15-35985a35c9d5@levsen.org>
 <CAKFNMo=gkj_9wzw+qjmfHr53-4WZeMjSgwHnrDakfTdZkSGdNw@mail.gmail.com>
To:     linux-nilfs@vger.kernel.org
From:   Hendrik Levsen <hendrik@levsen.org>
Message-ID: <726f32ef-5adc-d3d8-a926-a3a112f49ad1@levsen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKFNMo=gkj_9wzw+qjmfHr53-4WZeMjSgwHnrDakfTdZkSGdNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Date:   Fri, 31 Dec 2021 13:40:34 +0000
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Peter and Ryusuke,

Awesome thanks for the detailed info and pointers. As for the risky
recovery attempts, presumably I can just copy the whole block device
block-by-block to a new disk or even a file and mess with it there to my
heart's content.

-- h.


