Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF9D4D692D
	for <lists+linux-nilfs@lfdr.de>; Fri, 11 Mar 2022 20:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351167AbiCKTpH (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 11 Mar 2022 14:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCKTpG (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 11 Mar 2022 14:45:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 789D9A76E3
        for <linux-nilfs@vger.kernel.org>; Fri, 11 Mar 2022 11:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647027841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=quSeLBIA17zh8rA64UKWmmO/ORLBHUVanWUm7J4TrgM=;
        b=T56eQkZOQqJ0RrLQh+AMqWwH5TDcWtPiKdXihC5Q7hHQfsD3m5uBJ5yVc3pTRMYXbU67QM
        tyexXvnJ6yfg2KOeGokU0Sw6Uaw9hs3RkkKLv/Y16+G3mh8wu4CcIYz0YlhVr6yX4/8+Gn
        9ILUi3jSRdzJfBG5sPB+w/XieYfEg+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-SsHBTZ7SM8uyxtP-jQQ2jw-1; Fri, 11 Mar 2022 14:44:00 -0500
X-MC-Unique: SsHBTZ7SM8uyxtP-jQQ2jw-1
Received: by mail-wr1-f71.google.com with SMTP id w17-20020adfec51000000b001f068bc3342so3173385wrn.6
        for <linux-nilfs@vger.kernel.org>; Fri, 11 Mar 2022 11:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:organization:cc:to:subject
         :content-transfer-encoding;
        bh=quSeLBIA17zh8rA64UKWmmO/ORLBHUVanWUm7J4TrgM=;
        b=5aKHObP5rGYWDyVzdUvdOIih/ocNrN2oe2eGWKCIvzyNZjFevdYEfAjFj4+LGou6Yd
         5jZqjVZdDR8ZZTcXnklj3ysuUzwzOgTq3A5npPetkuBl06rxf+T7znWUsaG+4N3WZx05
         U4p6uR2AaZAHKEY4Naa6eCeqDmMytM+I3lTzK2jUjcWnRAXneM1QPy3qFREkb7ToU8so
         9QcUvIInZz3jhC+/J5POQ80tZhDPjfc1JfAMhsAvLPiTPK0nPwC0nDd1/H2frLY/RJmg
         Ld3wUtw7vNzlH1Jaodh5r/SGUiPQKw+9WCMnoYYqkGj+ehFBZxyqwSCHlbppLERAYr0Y
         7CCg==
X-Gm-Message-State: AOAM532ITdndzvePsAH+6WrJRxumCPM/cvn/ZRdhIhzxA5iwijPKpUjG
        9VrQZxMg7ZlXHEkFA7BSyoiwQRaZF3TDzvOubpHGCE80CMDcXlfAXZvNaDQboqkzQ92ZwjgTTwy
        zyRBMa/D38T0vHiC62QO0TVA=
X-Received: by 2002:a05:6000:178c:b0:203:86a7:e49 with SMTP id e12-20020a056000178c00b0020386a70e49mr7792102wrg.640.1647027838735;
        Fri, 11 Mar 2022 11:43:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrKJvbbc0vQ4tbkl8NoDd30LeS8I2oihg1TLxEdophvnp1UGoZEJKLILqrDRHDZoRZfYsbgg==
X-Received: by 2002:a05:6000:178c:b0:203:86a7:e49 with SMTP id e12-20020a056000178c00b0020386a70e49mr7792090wrg.640.1647027838406;
        Fri, 11 Mar 2022 11:43:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d698c000000b001f1d8bb4618sm10208700wru.36.2022.03.11.11.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 11:43:58 -0800 (PST)
Message-ID: <9a20b33d-b38f-b4a2-4742-c1eb5b8e4d6c@redhat.com>
Date:   Fri, 11 Mar 2022 20:43:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-nilfs@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: nilfs: WARNING: CPU: 2 PID: 1510 at include/linux/backing-dev.h:269
 __folio_mark_dirty+0x31d/0x3b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi,

playing with swapfiles on random file systems, I stumbled over the
following nilfs issue (and reproduced it on latest greatest
linux/master -- v5.17-rc7+). I did not try finding out when this 
was introduced and I did not run into this issue on other file
systems I tried.


[root@vm-0 ~]# mkfs.nilfs2 /dev/vdc 
WARNING: Device /dev/vdc appears to contain an existing xfs superblock.
WARNING: All data will be lost after format!

DO YOU REALLY WANT TO FORMAT DEVICE /dev/vdc?

Continue? [y/N] y
mkfs.nilfs2 (nilfs-utils 2.2.8)
Start writing file system initial data to the device
       Blocksize:4096  Device:/dev/vdc  Device Size:32212254720
File system initialization succeeded !! 
[root@vm-0 ~]# mount /dev/vdc /mnt/swap
[   51.908189] NILFS version 2 loaded
[root@vm-0 ~]# dd if=/dev/zero of=/mnt/swap/swapfile bs=1024 count=1048576,
[  163.245821] ------------[ cut here ]------------
[  163.246577] WARNING: CPU: 7 PID: 4529 at include/linux/backing-dev.h:269 __folio_mark_dirty+0x31d/0x3b0
[  163.247705] Modules linked in: nilfs2 rfkill isofs intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm irqbypass joydev i2c_i801 pcspkr i2c_smbus lpc_ich drm fuse ip_tag
[  163.251013] CPU: 7 PID: 4529 Comm: dd Kdump: loaded Tainted: G        W         5.17.0-rc7+ #57
[  163.252035] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
[  163.253299] RIP: 0010:__folio_mark_dirty+0x31d/0x3b0
[  163.253875] Code: e8 78 e0 ad 00 85 c0 0f 85 33 fe ff ff 48 8b 83 a8 01 00 00 be ff ff ff ff 48 8d 78 70 e8 5b e0 ad 00 85 c0 0f 85 16 fe ff ff <0f> 0b e9 0f fe ff ff e8 87 e1 ad 00 85 c0 74 89 80 3d 8d 2c 921
[  163.256034] RSP: 0018:ffffacba489b38a8 EFLAGS: 00010046
[  163.256646] RAX: 0000000000000000 RBX: ffff973e08ff6370 RCX: 0000000000000001
[  163.257485] RDX: 0000000000000000 RSI: ffffffff8b5d4335 RDI: ffffffff8b668ab6
[  163.258306] RBP: 0000000000000282 R08: 0000000000000000 R09: 0000000000000030
[  163.259127] R10: ffff973e089641a8 R11: 0000000000004000 R12: ffff973e08ff6138
[  163.259945] R13: 0000000000000001 R14: 0000000000000001 R15: fffff3b08452fbc0
[  163.260796] FS:  00007ff23cc945c0(0000) GS:ffff97455fb80000(0000) knlGS:0000000000000000
[  163.261731] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.262432] CR2: 000055d0601de000 CR3: 00000001142a6000 CR4: 0000000000350ee0
[  163.263263] Call Trace:
[  163.263568]  <TASK>
[  163.263845]  mark_buffer_dirty+0x10f/0x170
[  163.264366]  nilfs_btree_convert_and_insert+0x3f9/0x490 [nilfs2]
[  163.265126]  nilfs_bmap_insert+0xc6/0x110 [nilfs2]
[  163.265740]  ? lock_is_held_type+0xe4/0x140
[  163.266260]  nilfs_mdt_get_block+0x190/0x3b0 [nilfs2]
[  163.266898]  ? lock_release+0x139/0x2d0
[  163.267366]  nilfs_palloc_get_block+0x5e/0xd0 [nilfs2]
[  163.267978]  nilfs_palloc_get_entry_block+0x88/0x90 [nilfs2]
[  163.268682]  nilfs_dat_prepare_alloc+0x30/0x60 [nilfs2]
[  163.269314]  nilfs_direct_insert+0x111/0x140 [nilfs2]
[  163.269915]  nilfs_bmap_insert+0xa8/0x110 [nilfs2]
[  163.270490]  ? rcu_read_lock_sched_held+0x3f/0x60
[  163.271080]  ? trace_nilfs2_transaction_transition+0x29/0xd0 [nilfs2]
[  163.271836]  ? nilfs_transaction_begin+0x150/0x2f0 [nilfs2]
[  163.272498]  nilfs_get_block+0xcd/0x200 [nilfs2]
[  163.273061]  __block_write_begin_int+0x11e/0x630
[  163.273664]  ? __nilfs_mark_inode_dirty+0xa0/0xa0 [nilfs2]
[  163.274335]  ? __nilfs_mark_inode_dirty+0xa0/0xa0 [nilfs2]
[  163.274980]  block_write_begin+0x53/0x110
[  163.275461]  nilfs_write_begin+0x52/0xb0 [nilfs2]
[  163.276034]  generic_perform_write+0xac/0x1d0
[  163.276559]  ? file_update_time+0x3e/0x120
[  163.277053]  ? lock_acquire+0xd4/0x2d0
[  163.277540]  __generic_file_write_iter+0xdb/0x1a0
[  163.278122]  generic_file_write_iter+0x5d/0xb0
[  163.278695]  new_sync_write+0x10e/0x190
[  163.279197]  vfs_write+0x29c/0x3a0
[  163.279632]  ksys_write+0x58/0xd0
[  163.280068]  do_syscall_64+0x3b/0x90
[  163.280501]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  163.281107] RIP: 0033:0x7ff23cbb9e87
[  163.281591] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 744
[  163.283807] RSP: 002b:00007ffff781cf58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  163.284673] RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007ff23cbb9e87
[  163.285530] RDX: 0000000000000400 RSI: 000055d0601de000 RDI: 0000000000000001
[  163.286389] RBP: 000055d0601de000 R08: 000055d0601dd5a0 R09: 00007ff23cc8ca60
[  163.287233] R10: 000055d0601de000 R11: 0000000000000246 R12: 0000000000000000
[  163.288097] R13: 0000000000000000 R14: 0000000000000400 R15: 000055d0601de000
[  163.288923]  </TASK>
[  163.289197] irq event stamp: 4362
[  163.289597] hardirqs last  enabled at (4361): [<ffffffff8a3a3f04>] folio_memcg_lock+0x144/0x240
[  163.290667] hardirqs last disabled at (4362): [<ffffffff8add94d0>] _raw_spin_lock_irqsave+0x60/0x70
[  163.291720] softirqs last  enabled at (4176): [<ffffffffc0742bc6>] nilfs_palloc_commit_alloc_entry+0x16/0x60 [nilfs2]
[  163.292929] softirqs last disabled at (4172): [<ffffffff8a308c6e>] wb_wakeup_delayed+0x2e/0x70
[  163.293952] ---[ end trace 0000000000000000 ]---
[  163.419320] ------------[ cut here ]------------
[  163.420427] WARNING: CPU: 11 PID: 4522 at include/linux/backing-dev.h:269 __folio_start_writeback+0x2cf/0x2e0
[  163.422157] Modules linked in: nilfs2 rfkill isofs intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm irqbypass joydev i2c_i801 pcspkr i2c_smbus lpc_ich drm fuse ip_tag
[  163.426893] CPU: 11 PID: 4522 Comm: segctord Kdump: loaded Tainted: G        W         5.17.0-rc7+ #57
[  163.428510] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
[  163.430462] RIP: 0010:__folio_start_writeback+0x2cf/0x2e0
[  163.431433] Code: 24 10 85 c0 0f 85 6f ff ff ff 48 8b 82 a8 01 00 00 83 ce ff 48 8d 78 70 e8 fe f4 ad 00 48 8b 54 24 10 85 c0 0f 85 4f ff ff ff <0f> 0b e9 48 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 000
[  163.434154] RSP: 0018:ffffacba489abd10 EFLAGS: 00010046
[  163.434902] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  163.435902] RDX: ffff973e13023370 RSI: ffffffff8b5d4335 RDI: ffffffff8b668ab6
[  163.436913] RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000000001
[  163.437912] R10: 0000000000000000 R11: 000000000003b460 R12: ffff974587182000
[  163.438912] R13: 0000000000000001 R14: ffff973e13023130 R15: fffff3b0841ab640
[  163.439913] FS:  0000000000000000(0000) GS:ffff974d5f800000(0000) knlGS:0000000000000000
[  163.441039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.441858] CR2: 00007f8c9c010cf8 CR3: 0000000883614000 CR4: 0000000000350ee0
[  163.442862] Call Trace:
[  163.443243]  <TASK>
[  163.443585]  nilfs_begin_page_io+0x63/0x80 [nilfs2]
[  163.444298]  nilfs_segctor_do_construct+0xb28/0x1c80 [nilfs2]
[  163.445134]  nilfs_segctor_construct+0x1f4/0x2f0 [nilfs2]
[  163.445915]  nilfs_segctor_thread+0x10f/0x400 [nilfs2]
[  163.446666]  ? nilfs_segctor_construct+0x2f0/0x2f0 [nilfs2]
[  163.447441]  kthread+0xf2/0x120
[  163.447761]  ? kthread_complete_and_exit+0x20/0x20
[  163.448224]  ret_from_fork+0x22/0x30
[  163.448588]  </TASK>
[  163.448820] irq event stamp: 29944
[  163.449158] hardirqs last  enabled at (29943): [<ffffffff8a3a3f04>] folio_memcg_lock+0x144/0x240
[  163.449981] hardirqs last disabled at (29944): [<ffffffff8add94d0>] _raw_spin_lock_irqsave+0x60/0x70
[  163.450838] softirqs last  enabled at (17046): [<ffffffff8a0f0c2b>] __irq_exit_rcu+0xfb/0x150
[  163.451638] softirqs last disabled at (17041): [<ffffffff8a0f0c2b>] __irq_exit_rcu+0xfb/0x150
[  163.452433] ---[ end trace 0000000000000000 ]---
[  163.460194] ------------[ cut here ]------------
[  163.460654] WARNING: CPU: 11 PID: 4522 at include/linux/backing-dev.h:269 __folio_end_writeback+0x38b/0x420
[  163.461537] Modules linked in: nilfs2 rfkill isofs intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm irqbypass joydev i2c_i801 pcspkr i2c_smbus lpc_ich drm fuse ip_tag
[  163.464027] CPU: 11 PID: 4522 Comm: segctord Kdump: loaded Tainted: G        W         5.17.0-rc7+ #57
[  163.464876] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
[  163.465911] RIP: 0010:__folio_end_writeback+0x38b/0x420
[  163.466410] Code: 0f 85 53 fe ff ff 49 8b 87 a8 01 00 00 83 ce ff 48 8d 78 70 e8 86 db ad 00 4c 8b 0c 24 4c 8b 44 24 08 85 c0 0f 85 2f fe ff ff <0f> 0b e9 28 fe ff ff 48 8b 35 67 1a 52 01 b8 01 00 00 00 48 c77
[  163.468102] RSP: 0018:ffffacba489abd48 EFLAGS: 00010046
[  163.468588] RAX: 0000000000000000 RBX: ffff973e13023130 RCX: 0000000000000001
[  163.469241] RDX: 0000000000000000 RSI: ffffffff8b5d4335 RDI: ffffffff8b668ab6
[  163.469897] RBP: fffff3b0841ab640 R08: 0000000000000206 R09: ffff973e13023138
[  163.470547] R10: 0000000000000000 R11: 000000000003b6e0 R12: fffff3b0848c9e01
[  163.471213] R13: 0000000000000001 R14: 0000000000000001 R15: ffff973e13023370
[  163.471869] FS:  0000000000000000(0000) GS:ffff974d5f800000(0000) knlGS:0000000000000000
[  163.472604] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.473137] CR2: 00007f8c9c010cf8 CR3: 0000000883614000 CR4: 0000000000350ee0
[  163.473790] Call Trace:
[  163.474035]  <TASK>
[  163.474253]  folio_end_writeback+0x2a/0xc0
[  163.474647]  nilfs_segctor_do_construct+0x181f/0x1c80 [nilfs2]
[  163.475200]  nilfs_segctor_construct+0x1f4/0x2f0 [nilfs2]
[  163.475710]  nilfs_segctor_thread+0x10f/0x400 [nilfs2]
[  163.476196]  ? nilfs_segctor_construct+0x2f0/0x2f0 [nilfs2]
[  163.476733]  kthread+0xf2/0x120
[  163.477046]  ? kthread_complete_and_exit+0x20/0x20
[  163.477507]  ret_from_fork+0x22/0x30
[  163.477861]  </TASK>
[  163.478082] irq event stamp: 51868
[  163.478408] hardirqs last  enabled at (51867): [<ffffffff8a3a3f04>] folio_memcg_lock+0x144/0x240
[  163.479233] hardirqs last disabled at (51868): [<ffffffff8add94d0>] _raw_spin_lock_irqsave+0x60/0x70
[  163.480066] softirqs last  enabled at (35082): [<ffffffff8a0f0c2b>] __irq_exit_rcu+0xfb/0x150
[  163.480861] softirqs last disabled at (35075): [<ffffffff8a0f0c2b>] __irq_exit_rcu+0xfb/0x150
[  163.481650] ---[ end trace 0000000000000000 ]---
1048576+0 records in
1048576+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 11.4729 s, 93.6 MB/s



After that, the fs behaves weird:

[root@vm-0 ~]# mkswap /mnt/swap/swapfile 
mkswap: /mnt/swap/swapfile: insecure permissions 0644, 0600 suggested.
Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
no label, UUID=c0fb0051-c7e4-4235-b4a0-b992a39ba71f
[root@vm-0 ~]# swapon /mnt/swap/swapfile 
swapon: /mnt/swap/swapfile: insecure permissions 0644, 0600 suggested.
[  215.368832] swapon: swapfile has holes
swapon: /mnt/swap/swapfile: swapon failed: Invalid argument


Even another dd run doesn't do the trick and swapon keeps complaining
about holes. Not sure if the latter is just expected on nifs or a side product
of the warnings.

-- 
Thanks,

David / dhildenb

