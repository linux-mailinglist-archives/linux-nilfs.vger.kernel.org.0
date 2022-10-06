Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF325F652E
	for <lists+linux-nilfs@lfdr.de>; Thu,  6 Oct 2022 13:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiJFLZs (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 6 Oct 2022 07:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiJFLZr (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>); Thu, 6 Oct 2022 07:25:47 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1F40BE1
        for <linux-nilfs@vger.kernel.org>; Thu,  6 Oct 2022 04:25:46 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id n14-20020a056e02100e00b002f9e283e850so1308920ilj.9
        for <linux-nilfs@vger.kernel.org>; Thu, 06 Oct 2022 04:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Fb3N0UxtTZvX+trKxIr8VUlCIOKlpbigxzns62fuw4=;
        b=N8pYrG4Bon+cj4bmv05lxZnRS+ywMNC2x0FT4bT4wv5aB2UzJUgyQZ00w5NnJ7Jfxt
         EkRX7W/5jsNn0TtDCby37yelKNZQo2PvqmMLj5iiSPYzhjeixUrtlUn++2PX6+tCudod
         Wm7Tss3VJl34flMwZ8+HHQNlk2dMhPP0a3T7G0c4RTkWfqz/SkkNx51bWyNbhsHPPJUA
         bd3OrdQmiex6jg5gK8FEAzIbgNdzuyVrMdeCp3Ype2U1NPiOyATEBjka92PAx71kgTzK
         gkAvEDPEGP92s50bqbKnSKX1A2hlG24O8VKClyuCeLS3awMky9F6/d+rOYLy/ABTvDXl
         sHIg==
X-Gm-Message-State: ACrzQf1XvwdUmGDElRkeDhzkfn+UARfznLH/aNUSLaXCU4GsWW1YdRj+
        P0LkUppwBZMtEHCa6eo416FEVRG8nhbpZ6IIHLMc78aCjYmK
X-Google-Smtp-Source: AMsMyM510GTQmrhAg1HADWVwu3sPJWUpoYIDTmm8haY0TW/G6oZ3zkPUwi7rryzb6C+rnQ6zOurSle9Nkh2IrVvfBHFDxEkLWYTz
MIME-Version: 1.0
X-Received: by 2002:a92:6a09:0:b0:2f9:939e:85a9 with SMTP id
 f9-20020a926a09000000b002f9939e85a9mr2104610ilc.111.1665055545480; Thu, 06
 Oct 2022 04:25:45 -0700 (PDT)
Date:   Thu, 06 Oct 2022 04:25:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051dcc805ea5bf48f@google.com>
Subject: [syzbot] KASAN: use-after-free Read in nilfs_permission
From:   syzbot <syzbot+983470d8253700fc9461@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2bca25eaeba6 Merge tag 'spi-v6.1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154675f4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5
dashboard link: https://syzkaller.appspot.com/bug?extid=983470d8253700fc9461
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9885e6765755/disk-2bca25ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e78c91286aa/vmlinux-2bca25ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+983470d8253700fc9461@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in nilfs_permission+0x65/0xb0 fs/nilfs2/inode.c:980
Read of size 8 at addr ffff888079155000 by task syz-executor.2/8538

CPU: 0 PID: 8538 Comm: syz-executor.2 Not tainted 6.0.0-syzkaller-03015-g2bca25eaeba6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 nilfs_permission+0x65/0xb0 fs/nilfs2/inode.c:980
 do_inode_permission fs/namei.c:458 [inline]
 inode_permission+0x22c/0x450 fs/namei.c:525
 may_o_create fs/namei.c:3242 [inline]
 lookup_open fs/namei.c:3376 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0xcea/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_creat fs/open.c:1405 [inline]
 __se_sys_creat fs/open.c:1399 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd71d88a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd71e916168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fd71d9ac120 RCX: 00007fd71d88a5a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007fd71d8e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc40edd1af R14: 00007fd71e916300 R15: 0000000000022000
 </TASK>

Allocated by task 8531:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x97/0x310 mm/slub.c:3289
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 nilfs_find_or_create_root+0x142/0x4f0 fs/nilfs2/the_nilfs.c:747
 nilfs_attach_checkpoint+0xcd/0x4a0 fs/nilfs2/super.c:519
 nilfs_fill_super+0x2e8/0x5d0 fs/nilfs2/super.c:1064
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 8531:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kfree+0xda/0x210 mm/slub.c:4567
 nilfs_evict_inode+0x253/0x3d0 fs/nilfs2/inode.c:924
 evict+0x2a4/0x620 fs/inode.c:665
 nilfs_new_inode+0x6b8/0x8a0
 nilfs_create+0xdc/0x2d0 fs/nilfs2/namei.c:85
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_creat fs/open.c:1405 [inline]
 __se_sys_creat fs/open.c:1399 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0x970 kernel/rcu/tree.c:2796
 free_fib_info net/ipv4/fib_semantics.c:256 [inline]
 fib_info_put include/net/ip_fib.h:578 [inline]
 fib_release_info+0x654/0x720 net/ipv4/fib_semantics.c:281
 fib_table_flush+0xca2/0x1310 net/ipv4/fib_trie.c:2090
 fib_flush net/ipv4/fib_frontend.c:195 [inline]
 fib_disable_ip net/ipv4/fib_frontend.c:1420 [inline]
 fib_netdev_event+0x3bf/0x740 net/ipv4/fib_frontend.c:1489
 notifier_call_chain kernel/notifier.c:87 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:455
 call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 dev_close_many+0x3fb/0x5d0 net/core/dev.c:1545
 unregister_netdevice_many+0x521/0x1aa0 net/core/dev.c:10817
 default_device_exit_batch+0x570/0x5e0 net/core/dev.c:11337
 ops_exit_list net/core/net_namespace.c:167 [inline]
 cleanup_net+0x80c/0xc50 net/core/net_namespace.c:594
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888079155000
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes inside of
 256-byte region [ffff888079155000, ffff888079155100)

The buggy address belongs to the physical page:
page:ffffea0001e45500 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79154
head:ffffea0001e45500 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888012041b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3640, tgid 3640 (syz-executor.4), ts 195699870753, free_ts 192860739281
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmalloc+0x2bd/0x370 mm/slub.c:4425
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 fib_create_info+0xa5a/0x2410 net/ipv4/fib_semantics.c:1449
 fib_table_insert+0x1e5/0x1f50 net/ipv4/fib_trie.c:1236
 fib_magic+0x451/0x650 net/ipv4/fib_frontend.c:1098
 fib_add_ifaddr+0x3ea/0x5c0 net/ipv4/fib_frontend.c:1142
 fib_netdev_event+0x628/0x740 net/ipv4/fib_frontend.c:1480
 notifier_call_chain kernel/notifier.c:87 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:455
 __dev_notify_flags+0x2ef/0x5d0
 dev_change_flags+0xe3/0x190 net/core/dev.c:8615
 do_setlink+0xef5/0x3d40 net/core/rtnetlink.c:2788
 __rtnl_newlink net/core/rtnetlink.c:3547 [inline]
 rtnl_newlink+0x1748/0x1fa0 net/core/rtnetlink.c:3594
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 free_slab mm/slub.c:2073 [inline]
 discard_slab mm/slub.c:2079 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2553
 put_cpu_partial+0x106/0x170 mm/slub.c:2629
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 kmem_cache_alloc_trace+0x1de/0x310 mm/slub.c:3287
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kobject_uevent_env+0x33a/0x8e0 lib/kobject_uevent.c:524
 __kobject_del+0xcd/0x300 lib/kobject.c:585
 kobject_cleanup+0x25d/0x470 lib/kobject.c:664
 net_rx_queue_update_kobjects+0x455/0x4c0 net/core/net-sysfs.c:1128
 netif_set_real_num_rx_queues+0xf9/0x1d0 net/core/dev.c:2941
 veth_init_queues drivers/net/veth.c:1692 [inline]
 veth_newlink+0xa10/0xd10 drivers/net/veth.c:1807
 rtnl_newlink_create net/core/rtnetlink.c:3364 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3581 [inline]
 rtnl_newlink+0x147d/0x1fa0 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x772/0xe60 net/core/rtnetlink.c:6091

Memory state around the buggy address:
 ffff888079154f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888079154f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888079155000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888079155080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079155100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
