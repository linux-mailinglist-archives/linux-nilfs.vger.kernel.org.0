Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E341101F4
	for <lists+linux-nilfs@lfdr.de>; Tue,  3 Dec 2019 17:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfLCQSc (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 3 Dec 2019 11:18:32 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52441 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfLCQSb (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 3 Dec 2019 11:18:31 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8FC2BC5F;
        Tue,  3 Dec 2019 11:18:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 11:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waltonhoops.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=F
        /9eYKBtFJwO7Di3yc3FSrFnOEikDYWJLr3fzXYrhq4=; b=a4vNzRYDggXwhYYCh
        FT7Rp1tn4O0V42gVfuZzcG4JZKs28N2oJi39Dzk5FCbdcZ8BPk8TE1gvTzGYVoEa
        bQjtw+2cPdC/3aRtHE5KQYBRvpeRh9n56cGTnKc21bFQzBF2vZLnXKcL+VNbzYLQ
        OE9RIuEWSaLUppcbQ+F/8rkGOTLBvixxWspTvsNwOVH+lAfdbvnVaulmC7WN6mPU
        tNvnfIBHeQDKF7T2O/A/F9zGFQ6JD7Kk7f682N+4XpCqO8rcOEbkpP+IjUV+nzi7
        UQ0hO5t4KBnDuaU1JmkVoEn5IHL5VfDGSPApX5Y2Zv29jkzy0LDImDZpCOeRcYvi
        26oKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=F/9eYKBtFJwO7Di3yc3FSrFnOEikDYWJLr3fzXYrh
        q4=; b=s/Z3VcPnS4udR+b75pOqc6HIFBoeccmeIXV26QlYaNudIzTgMU05pNoB5
        2aapNEjJ53zZofCdCTCvdIr6GhfWGtwZZ0rFzIg+I98ESPJqpYvZ/ltNNbxzXXdu
        vrq88J0PQLOHy3SUeIBB4R7nRxR+oA8Dfh3S8IikqV8XLW9OIoDDbQN9bVAVu03F
        Axy2JR5qGIMBLCoc54a05xt0CD5+WWWbzrhf8SbhjOfV8B2W3O9jgh8E79ejBipE
        Ww5vI1+p2c5l/Y45FdgATPMV2nrnGdtgofcqp0oyFbhEblGldVwLJRqhhI+xg8bk
        xZ/anKpUc2eLE5QlFicDNPpZwdwcw==
X-ME-Sender: <xms:1YrmXZSVzvrpEtDh2ZD5_AAA6vRE-31DcoBGEqoxot27BjiNY6-EVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeghrghlthhonhcujfhoohhpshcuoehmvgesfigrlhhtohhn
    hhhoohhpshdrtghomheqnecukfhppedujeegrddvjedrvddvkedrfeeinecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmvgesfigrlhhtohhnhhhoohhpshdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:1YrmXed3a60G-2YQ8OdRjJ6HP-ZArgK8T5kcms_uiM4Wc6ljiUNY3A>
    <xmx:1YrmXZjwt9v3yAff6fYbF0bMIROrnZvZqVbSuUZFEYoCSFK8_Anz6Q>
    <xmx:1YrmXR9IxDl5BF6RPGWOjUvS-dC9NjQzSWF6fA9W4ObkYepQFLRMhg>
    <xmx:1ormXXJAN6ny6mX_rhrJYHKYONSLKsvhGaVsjqU9juVuLeE9Kbiz1w>
Received: from lap.waltonhoops.com (unknown [174.27.228.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0CBCE8005B;
        Tue,  3 Dec 2019 11:18:28 -0500 (EST)
Subject: Re: BUG: kernel NULL pointer dereference, address: 00000000000000a8
To:     linux-nilfs <linux-nilfs@vger.kernel.org>
Cc:     Tomas Hlavaty <tom@logand.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>
References: <70b53768-11db-dd75-38c9-5d1786ae88e9@daneng.org>
 <CAKFNMoks2DGE=BeEXR60DTXSXWbsfPogGReD8EjV=YqyMjTMjA@mail.gmail.com>
 <CAKFNMomjWkNvHvHkEp=Jv_BiGPNj=oLEChyoXX1yCj5xctAkMA@mail.gmail.com>
From:   Walton Hoops <me@waltonhoops.com>
Autocrypt: addr=me@waltonhoops.com;
 keydata= mQINBFMWVNkBEADXhAOyRFf2nOIYZBO29v5sWkMLTiNS2GKLlBN6QTdYhQO5AdkucY+fElfl
 xCrhL8M6MM3faUkq/5NVQ6jj6M5kIqJTBQaDGB2xxXpDqk/3TDjLHPMnauJTOCFiEzxHAzz1
 zCO6Ppc7lWtiyTSt+w+tidgtTmzWkPnSc/HAnl+BCwe4aSDfAIxY2hQ+bCSsOIzFf8MRdtIT
 zbJ8EhWK7MwkBNAE/m22fwUpvTgnmcaIaXybvadd675NU40X9adj5XjSHE+R51B7Aab47gWF
 fpOcIrce0PTbnSH1TbwEy75udwQzOqnieF7MxfaUZK2dO5kPVbkMORsp4ZbZoUp/EKtiTffb
 2TYIKShyJBt7+mDCmQaRtmYgEfbFrBJ3RV+L9cW4Cyv9mj04qXyCjFayszPGRvWL/KSZ9tap
 Pz1kE8PC+S5Pw2HwiXZJknegfceLamqMbW2vGb6PWwxULgDLdvNGp0MO/4MSqm7rcxELDmP/
 k3pbsNyvalDaBoKxdXe8ccz1Lkiy2EiVlhrPbTuS38Vw4az8moyQ61C5ePq6tDY7FFJx3w8m
 oOkenCYyZ25j1enUzzdjsS0mrUgMoV5fom54kDqEX7uhi/QpYbWCR6+ABDq998KWsNt2sFPa
 X+3Snn3VhJh5TLgl9lqG8oYfagIFA1E4YBxwD/Yv37aB6rRdawARAQABtCFXYWx0b24gSG9v
 cHMgPG1lQHdhbHRvbmhvb3BzLmNvbT6JAk4EEwEIADgCGwMFCwkIBwMFFQoJCAsFFgIDAQAW
 IQQCgcCCtiklriUysYfncofgH3fi5QUCXFpcXwUJEMjVhgAKCRDncofgH3fi5b45EACtBlXa
 drkzOhGiUa2S/fh4zcXPLmY8I+oej0JFDNQQkRtoUS8OfT1jkiaF4UMMUSoIfUi1/bMcg6Su
 7PulWfD6tnT28Knf+tCpM4FLcKKjp50zA45wvfgPChuM2OKlPCtsoKqv/peNCvOBDTS22Puf
 rS3dVxXfoQvhr7uhIE9AC1gapEm406GAagxG/+1mCqYSiIjS3Svy3VFGH4OvID+jSVjmpewn
 Ykgnc9SCXXYx6/q7vMHqXbLytDrq5biFmQ6E1RwS/8QgpBhAOvsGuLn9G5THoy0McoV7RCOz
 qNh+YYRHvPH3oFGBRYS0lfGIzNySRLrDXePWW+CuFWb1IUzdLtWOHx9yQ04w8/4nF8xkzZSi
 x2cHAw9eI+kyi6poo3OVmAsVzWb2PZJHuSWh9BshOMmNts1S+Nq/d+jQozGAUmkLANWDncMU
 Tx8fliPXCf0NHGaJ2hy/PV0FDzuk7dMTSIzKMTy6XAFOa9f868zQXS8v7rzdqgoALs80UMEQ
 +1D24APW3ToN+8ZHLMIevEymzZ7k+3mzW76hJOd/I/SO9gbjDYV6mD2B6E/jE9ONVpvVurv7
 nNmP5OinonVrgNVUkuGa5u+RRXmdXLZdrwe9D5kNz7TWUEWiMklGcTpS/RtjPCFD7+UEDm4X
 GAg3QLzQiJEF5AOZoAIvGi9wiY7nubkCDQRTFlTZARAAvase3mpEUrvP6Brj7uTKEBPehRta
 ex8l+ERbC/YD2OBCF1YYEni1RfM+eukhMv0iPfQhfW6l/htsulh2zTRMuffKR3cwNMP4EgIr
 Egw1UqNWCW2qjwDhr16zxqZQN/kb2iPjyirn5gztW0XtnFqo8+jDZiBsgKGFkCqt73CmiNID
 De23OMLPEgmFnr7etX89tBKOYp2zxO6J8un7AATvi9y+pJE2QOsHlR4OkXhvVC+9/80zEyKQ
 EIwsOUzVVV0CVLmtqJ5luhnp8vzGAp++v4K5Q2KgD9+3lrAoi1o5app+hppJgQ617y2cGwgD
 SnmuoVH9s27dk314IFm578wr8tGMcRIJUVeTeu9WMz0suVS5YfuIMgNhBcsprKC36jtYueVt
 q0waZQSIdIumXLf2x1NQbk5N90mFB1pb89gF0FEtYRPAlEJ2zLD5iCYeCW3nUJeiNoAkAG0H
 DGGDBnp5g8JAtcquJeZh40sksjmVT5SGFX45sqKvSDs9ESUwv82YEm/DzDTZ6/KA0zEboCAt
 9fndmSNumh/91BpqNomiFH5Z0ZCtSXKN7Ijpbut+U23Pj9oko5Ll2YNu/wDbPkPg3rY+pI1G
 j/rB0ETo4TTL1n1NEhEuZxh5JX5MBvtId0q2Um7gdnshbDOtmAYGVZ+uVT4dTwl0IGYhIENa
 z+xYAF0AEQEAAYkCPAQYAQgAJgIbDBYhBAKBwIK2KSWuJTKxh+dyh+Afd+LlBQJcWlxfBQkQ
 yNWGAAoJEOdyh+Afd+LliNQQAK+hUuD1fWH7hbLQesneEm08Y4rHelLo4vW8IwzX8JPD+Ntx
 Ojrw+0do0stbnzZuamT0f1x9TbJUnlEk10dkx7eYw3h84q7vESNveKSf/sSCYntMqaliIaEL
 1qdLoCwmMoJDTZgLxoe8OuDfm1tWkPFEylYq55NwwyL1L7db9Ylr3+uR31LCEiO9kmtvXsgC
 99MEjZAprQ1ZE95Uf5QfwvTmqHs9XuY2G0FKYpUglHgCuNg4uSsqwaBKhdMro5CV1OKGjnVw
 fxbc3PhIYEpdmTe39nSGjqBQjfQZ80prxMZ2KU7RbaPZo2SvHXU/24ehhEI30jGDC7FuQffX
 KGrPMU1tZ6IUFSdCmLZG3CIaPMkGU7nXVKicDv4Vh3q0F/FD0gx94vD9b0dd83lkCL+s1mZ8
 E1NSkEZkq/1Tf2NTWjJ+jr61i1HrLo3ftUwsmS+5CFcvg23RXsOrOzm8u5FASNZOGWeXbXKa
 B16+rrgIjubmwQeu5aKUst1WPNKH3TODwWRiwM0pOlyr6ZJFiQDIVbf3ziHzpD5+jIiqKPzo
 1Hv90AItbJIiWmubGrCzZygl+yD/CT4iUFc1o15N7b8zd+hLJO7Je6jS4L9akrgfebrjCPzS
 R0cqzmOL0TXQ/Zt542KAPHwi1SZO0UcK+5lsZx600YBRZKAYMfSp9CaH5Fpk
Message-ID: <67cba1e3-89cb-db0d-43c3-fa4bdfba0781@waltonhoops.com>
Date:   Tue, 3 Dec 2019 09:18:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKFNMomjWkNvHvHkEp=Jv_BiGPNj=oLEChyoXX1yCj5xctAkMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

FYI, Arch got 5.4.1 this morning, and it looks like the issue is still
present.

On 11/20/19 12:34 AM, Ryusuke Konishi wrote:
> As the result of bisection,  it turned out that commit
> f4bdb2697ccc9cecf1a9de86905c309ad901da4c on 5.3.y
> ("mm/filemap.c: don't initiate writeback if mapping has no dirty pages")
> triggers the crash.
> 
> This patch was back ported from upstream kernel 5.4-rc1, and
> applied to 4.19.84 as well.
> 
> Will look into the change further and why it doesn't hit latest
> kernels (5.4-rc8, etc).
> 
> Regards,
> Ryusuke Konishi
> 
> 
> 
> 
> 
> 
> On Wed, Nov 20, 2019 at 12:46 AM Ryusuke Konishi
> <konishi.ryusuke@gmail.com> wrote:
>>
>> Yeah,  this looks a regression of the 5.3.11 stable kernel.
>>
>> I could reproduce the crash with 5.3.11.
>>
>> 5.3, 5.3.10 and 5.4-rc8 all worked fine.
>>
>> The regression would be identified by bisecting commits
>> between kernel 5.3.10 and 5.3.11.
>>
>> Thanks,
>> Ryusuke Konishi
>>
>> 2019年11月19日(火) 23:40 <linux-nilfs-ml.via.forwarder@neverbox.com>:
>>>
>>> I believe I have the same issue as Walton Hoops.
>>>
>>> I do not have a serial console, and all my filesystems are NILFS2,
>>>
>>> so I do not currently have an easy means to capture the crash.
>>>
>>> However, I experienced the same Kernel BUG on upgrading to kernel 5.11
>>>
>>> from 5.10. Reverting back to 5.10 results in a clean boot.
>>>
>>> The actual kernels I use are the Ubuntu 'mainline kernels'
>>>
>>> 5.3.10-050310-generic works
>>>
>>> 5.3.11-050311-generic crashes with Kernel BUG.
>>>
>>> So I suspect a change between those two versions has triggered the problem.
>>>
>>>
