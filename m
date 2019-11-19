Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF7101293
	for <lists+linux-nilfs@lfdr.de>; Tue, 19 Nov 2019 05:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKSElG (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 18 Nov 2019 23:41:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41563 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbfKSElG (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 18 Nov 2019 23:41:06 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1114C2205C
        for <linux-nilfs@vger.kernel.org>; Mon, 18 Nov 2019 23:41:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Nov 2019 23:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waltonhoops.com;
         h=to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=rZYkeiGRUdWozJoyHdDx3nT2cj
        gXdeFeiJntvhU3M5c=; b=ERc2J+thisaZ0ZNzZANI/UWKQv+iHxGEHfYFQorZYI
        fG2klD5cusqj4CREmRQEhLjNJ9vCVcwppSy6fmZL/1lvXIbzUU46IdHd4hhXTw8A
        jicC3BGbMyyGNfcswNcwQPFa8N/j/V5rIsVaCN5wj22pp6lS8/7trsUZPzh1gBxq
        kbX9QMO1GoYGzI7jlcM6uobROCaR/FMpWsABl62b7utHyVfjHrOgG2sXwKds1o3R
        j7oEaTygL8lQNiIG/EAVWHShbwze3dnbRFsbS0tFlhm8CZA3CJodIUTYTB4yzRUw
        wqsPYrAF/qrbwd75mk+JxgUQUvXuQqKVo1EEfr0vrMKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rZYkei
        GRUdWozJoyHdDx3nT2cjgXdeFeiJntvhU3M5c=; b=KPuKzs3Upi216gfyBm3n07
        fRXm0bOTcuA39GLf2GWWmbYmKU+SRtlQOUN8TOI8vMtmypIJcnMbvC6nX7I2mIr7
        TghQOcbm9kqSQ3+0P/due3dVdIaxosp4YhrR1O+s7dcXOJpcAPfLiAvT7Otb2q5h
        2LQjc1bce0vCHdWJfb57r0mdQWneRvBGsPivnXampDhglQFQY2CsspZoe51zq3wb
        W/WbrQZ6YlK+vVeXAaVu75/6V2ca5OZyj8VYWCXMKMrJG/qgtmDvQy5gHdF7ORNx
        OWyCAXr+K/SCgeajYgyRFJhM4lzB0C8fQv/Fej7YRaVD34XZdD3QixIQPO4QBKAA
        ==
X-ME-Sender: <xms:X3LTXUt7LalWj8GQkDshu9-AZqecvd8vX1Wyzcg-G8i7SV6IAikMDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudegjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtkeertd
    dtfeejnecuhfhrohhmpeghrghlthhonhcujfhoohhpshcuoehmvgesfigrlhhtohhnhhho
    ohhpshdrtghomheqnecuffhomhgrihhnpeifrghlthhonhhhohhophhsrdgtohhmnecukf
    hppedujeegrddvjedrudehtddrudegieenucfrrghrrghmpehmrghilhhfrhhomhepmhgv
    seifrghlthhonhhhohhophhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:X3LTXRr9m1VPGCU74egBtuTnaQdlyPK5crniC_JByqqnedAtevAlsg>
    <xmx:X3LTXSaFq8wRf8WbuRwNiAdhgLsYJFcQN79ypHIwvU7GPSYBQlVx4Q>
    <xmx:X3LTXSzML0jWYCZ0mrqe8GR46rkHZE9N42_lX6URMc4HJwrNYfVIdg>
    <xmx:YHLTXSyY3NUP8bITcHIoom3P930WltU4b_2vofMLsCY1_y5UKKc1mg>
Received: from lap.waltonhoops.com (unknown [174.27.150.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C46780059
        for <linux-nilfs@vger.kernel.org>; Mon, 18 Nov 2019 23:41:03 -0500 (EST)
To:     linux-nilfs@vger.kernel.org
From:   Walton Hoops <me@waltonhoops.com>
Autocrypt: addr=me@waltonhoops.com;
 keydata= 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
Subject: BUG: kernel NULL pointer dereference, address: 00000000000000a8
Message-ID: <326f16f5-05b6-652e-1164-3613e96e1453@waltonhoops.com>
Date:   Mon, 18 Nov 2019 21:41:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hello,

I apologize for not replying to the original thread, I was not
subscribed to this list when it was sent.

I am having a nearly identical issue to Tomas Hlavaty, however I don't
think it was caused by corruption or an unclean shutdown. Immediately
after upgrading my kernel to 5.3.11 I rebooted, and received a similar
message (included below). Rolling the kernel back to 5.2.10 (the oldest
I had easily available) made the system boot-able again.

The full message/trace is below:
[    6.274360] NILFS version 2 loaded
[    6.275461] NILFS (dm-2): mounting unchecked fs
[    6.316889] NILFS (dm-2): recovery complete
[    6.318609] NILFS (dm-2): segctord starting. Construction interval =
5 seconds, CP frequency < 30 seconds
[    6.524132] systemd[1]: Successfully credited entropy passed from
boot loader.
[    6.527313] systemd[1]: systemd 243.78-2-arch running in system mode.
(+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    6.539380] systemd[1]: Detected architecture x86-64.
[    6.545163] systemd[1]: Set hostname to <lap.waltonhoops.com>.
[    6.770464] systemd[1]: Started Emergency Shell.
[    6.770916] systemd[1]: Reached target Emergency Mode.
[    6.771425] systemd[349]: emergency.service: Executable /bin/plymouth
missing, skipping: No such file or directory
[    6.772146] systemd[1]: Startup finished in 6.953s (firmware) +
4.746s (loader) + 6.469s (kernel) + 299ms (userspace) = 18.469s.
[   21.698147] BUG: kernel NULL pointer dereference, address:
00000000000000a8
[   21.698221] #PF: supervisor read access in kernel mode
[   21.698267] #PF: error_code(0x0000) - not-present page
[   21.698324] PGD 0 P4D 0
[   21.698353] Oops: 0000 [#1] PREEMPT SMP PTI
[   21.698394] CPU: 0 PID: 326 Comm: segctord Tainted: G     U
 5.3.11-zen1-1-zen #1
[   21.698463] Hardware name: LENOVO 20FQCTO1WW/20FQCTO1WW, BIOS
N1FET70W (1.44 ) 06/25/2019
[   21.698536] RIP: 0010:percpu_counter_add_batch+0x26/0xb0
[   21.698584] Code: 1f 44 00 00 41 56 41 55 49 89 f5 41 54 55 48 89 fd
bf 01 00 00 00 53 89 d3 e8 16 d7 b7 ff 48 c7 c7 20 04 d5 9f e8 ba 4e fb
ff <48> 8b 45 20 48 63 d3 65 44 8b 30 4d 63 e6 4d 01 ec 4c 39 e2 7e 0a
[   21.698730] RSP: 0018:ffffae868045bc78 EFLAGS: 00010002
[   21.698777] RAX: 0000000080000002 RBX: 0000000000000018 RCX:
0000000000000001
[   21.698837] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffffffff9fd50420
[   21.698897] RBP: 0000000000000088 R08: ffff965f0ad09470 R09:
0000000000000018
[   21.698956] R10: 0000000000000002 R11: ffff965f217fc000 R12:
0000000000000000
[   21.699016] R13: 0000000000000001 R14: ffff965f0852f648 R15:
ffffe759101f2b00
[   21.699076] FS:  0000000000000000(0000) GS:ffff965f11400000(0000)
knlGS:0000000000000000
[   21.699143] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.699192] CR2: 00000000000000a8 CR3: 000000012d80a002 CR4:
00000000003606f0
[   21.699252] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   21.699312] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   21.699371] Call Trace:
[   21.699407]  __test_set_page_writeback+0x2a4/0x320
[   21.699471]  nilfs_segctor_do_construct+0xd42/0x2640 [nilfs2]
[   21.699529]  ? preempt_count_add+0x68/0xa0
[   21.699570]  ? _raw_spin_lock+0x13/0x30
[   21.699622]  nilfs_segctor_construct+0x1f4/0x2f0 [nilfs2]
[   21.699682]  nilfs_segctor_thread+0x17b/0x420 [nilfs2]
[   21.699732]  ? wait_woken+0x70/0x70
[   21.699774]  kthread+0x131/0x170
[   21.699817]  ? nilfs_transaction_lock+0x250/0x250 [nilfs2]
[   21.699867]  ? kthread_park+0x80/0x80
[   21.699903]  ret_from_fork+0x35/0x40
[   21.699940] Modules linked in: ip_tables x_tables nilfs2 dm_thin_pool
dm_persistent_data libcrc32c crc32c_generic dm_bio_prison dm_bufio
hid_generic usbhid hid dm_crypt dm_mod crct10dif_pclmul crc32_pclmul
crc32c_intel rtsx_pci_sdmmc ghash_clmulni_intel mmc_core serio_raw atkbd
libps2 aesni_intel aes_x86_64 crypto_simd cryptd xhci_pci glue_helper
xhci_hcd rtsx_pci i8042 serio i915 i2c_algo_bit drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops drm intel_agp intel_gtt
agpgart
[   21.700293] CR2: 00000000000000a8
[   21.700326] ---[ end trace 001ed76babb2cd83 ]---
[   21.700385] RIP: 0010:percpu_counter_add_batch+0x26/0xb0
[   21.700433] Code: 1f 44 00 00 41 56 41 55 49 89 f5 41 54 55 48 89 fd
bf 01 00 00 00 53 89 d3 e8 16 d7 b7 ff 48 c7 c7 20 04 d5 9f e8 ba 4e fb
ff <48> 8b 45 20 48 63 d3 65 44 8b 30 4d 63 e6 4d 01 ec 4c 39 e2 7e 0a
[   21.700578] RSP: 0018:ffffae868045bc78 EFLAGS: 00010002
[   21.700624] RAX: 0000000080000002 RBX: 0000000000000018 RCX:
0000000000000001
[   21.700684] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffffffff9fd50420
[   21.700744] RBP: 0000000000000088 R08: ffff965f0ad09470 R09:
0000000000000018
[   21.700803] R10: 0000000000000002 R11: ffff965f217fc000 R12:
0000000000000000
[   21.700862] R13: 0000000000000001 R14: ffff965f0852f648 R15:
ffffe759101f2b00
[   21.700922] FS:  0000000000000000(0000) GS:ffff965f11400000(0000)
knlGS:0000000000000000
[   21.700989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.701039] CR2: 00000000000000a8 CR3: 000000012d80a002 CR4:
00000000003606f0
[   21.701099] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   21.701158] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   21.701231] note: segctord[326] exited with preempt_count 2

If there is more information I can provide to help troubleshoot, please
let me know.

Walton
