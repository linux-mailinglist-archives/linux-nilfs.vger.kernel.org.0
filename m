Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BCB2F7F17
	for <lists+linux-nilfs@lfdr.de>; Fri, 15 Jan 2021 16:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbhAOPKi (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Fri, 15 Jan 2021 10:10:38 -0500
Received: from submit-3.e-mind.com ([188.94.192.49]:41888 "EHLO
        submit-3.e-mind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAOPKi (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Fri, 15 Jan 2021 10:10:38 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2021 10:10:37 EST
Received: from localhost (unknown [127.0.0.1])
        by submit-3.e-mind.com (Postfix) with ESMTP id 35A268510C3
        for <linux-nilfs@vger.kernel.org>; Fri, 15 Jan 2021 15:02:23 +0000 (UTC)
Received: from submit-3.e-mind.com ([127.0.0.1])
        by localhost (submit-3.e-mind.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Emowmdo3wLKr for <linux-nilfs@vger.kernel.org>;
        Fri, 15 Jan 2021 16:02:23 +0100 (CET)
Received: from qmail.e-mind.com (qmail34.e-mind.com [188.94.192.34])
        by submit-3.e-mind.com (Postfix) with SMTP id 28D868510B7
        for <linux-nilfs@vger.kernel.org>; Fri, 15 Jan 2021 16:02:23 +0100 (CET)
Received: (qmail 22822 invoked by uid 0); 15 Jan 2021 15:02:21 -0000
Received: from unknown (HELO ?192.168.143.6?) (185.53.252.165)
  by 0 with SMTP; 15 Jan 2021 15:02:21 -0000
To:     linux-nilfs@vger.kernel.org
From:   gianluca <gianlucarenzi@eurek.it>
Subject: Strange issue on disk usage with nilfs2 and df command
Message-ID: <ab9c4da7-428d-1ed4-c3a6-07d6d90815ba@eurek.it>
Date:   Fri, 15 Jan 2021 16:02:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hello,
I am facing a little annoying issue in a Debian Stretch 9.13 (armel) 
board with rootfilesystem with nilfs2 type.

The system has a iMX28 CPU with 256MB DDR2 Ram and 4GB emmC flash storage.

The system has /var /run /tmp in tempfs ramdisk.

In the beginning the filesystem is full at 50% so about 2Gb.
All the remaining space is technically empty.

The application is writing the same sqlite3 database every 30s or 60s 
dipending on the configuration (it writes few kilobytes every time, so 
the database size increase very little each time).

The rootfs is mounted with: noatime,nodiratime,rw in the /etc/fstab 
configuration file.

The nilfs tools are 2.2.6 as per Debian Stretch version.

The Linux Kernel is 4.9.78 vanilla.

The cleaner configuration file is the standard vanilla Debian version 
with some changes:

protection_period is 60 (original has 3600)

The min_clean_segments is 10% (90% of usage of the disk triggers the 
start of garbage collector)

The max_clean_segments is 20% (80% of usage of the disk triggers the 
stop of the garbage collector)

But in my board it seems something goes partially wrong.

After some days/week of usage:

1- the garbage collector is a running state (nilfs-clean -l)

2- The usage is 90% (df command)

After some time the gc goes in idle but the disk space still at 90%.

If I create a big file to increase the usage of the storage up to 95% of 
real disk space, the gc starts after a while, and it remains running 
forever.

If I delete this big file, it runs for a while, then the space returns 
to 90%. But using lsblk it gives me the 80% or less of filesystem usage.

What the heck is happening?

The GC is working as expected, but it gives me wrong status or wrong 
disk usage (df)...

Weird

Anybody has issued this problem yet?

Regards
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
