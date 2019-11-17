Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67784FFAF9
	for <lists+linux-nilfs@lfdr.de>; Sun, 17 Nov 2019 18:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfKQRld (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sun, 17 Nov 2019 12:41:33 -0500
Received: from logand.com ([37.48.87.44]:34478 "EHLO logand.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfKQRld (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Sun, 17 Nov 2019 12:41:33 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 12:41:30 EST
Received: by logand.com (Postfix, from userid 1001)
        id B50FA19F485; Sun, 17 Nov 2019 18:34:43 +0100 (CET)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   Tomas Hlavaty <tom@logand.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8 in nilfs_segctor_do_construct
Date:   Sun, 17 Nov 2019 18:34:39 +0100
Message-ID: <8736emquds.fsf@logand.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Hi Ryusuke,

today I got this bug in kernel, which seems to be related to nilfs2.

It was likely caused by improper shutdown and following nilfs2 partition
corruption.  Now I can still read the data, but on the whole the
computer is not useable, because starting a process which uses the
corrupted file system simply crashes in kernel.  I am actually not sure
if the filesystem is corrupted, as I don't know about any tool to check
that.  The relevant parts of dmesg log are bellow.

Please let me know if you are the right contact or if you need more info
about the problem.

Thank you,

Tomas

[    0.000000] Linux version 4.19.84 (nixbld@localhost) (gcc version 8.3.0 (GCC)) #1-NixOS SMP Tue Nov 12 18:21:46 UTC 2019
[    0.000000] Command line: initrd=\efi\nixos\4s51zw36kd1qb0ymk0charxjg8x6k5k3-initrd-linux-4.19.84-initrd.efi systemConfig=/nix/store/gdbxhzysr929abrymjqala0b5bh2fqmv-nixos-system-ushi-19.09.1258.07e66484e67 init=/nix/store/gdbxhzysr929abrymjqala0b5bh2fqmv-nixos-system-ushi-19.09.1258.07e66484e67/init loglevel=4



[   37.741106] systemd-journald[470]: Received client request to flush runtime journal.
[   37.749084] systemd-journald[470]: File /var/log/journal/55a4ea9159c14c0bb8767a43819c6927/system.journal corrupted or uncleanly shut down, renaming and replacing.
[   37.810819] audit: type=1130 audit(1573985039.617:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj==unconfined msg='unit=systemd-udevd comm="systemd" exe="/nix/store/v8flm2h07zcfg5k5npz56m0ayj0qm1q8-systemd-243/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'

[   38.321561] NILFS version 2 loaded
[   38.323236] NILFS (dm-1): mounting unchecked fs


[   38.349185] NILFS (dm-1): recovery complete
[   38.353228] NILFS (dm-1): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds

[   63.543941] systemd-journald[470]: File
/var/log/journal/55a4ea9159c14c0bb8767a43819c6927/user-1000.journal
corrupted or uncleanly shut down, renaming and replacing.

[12637.085548] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
[12637.085558] PGD 0 P4D 0
[12637.085567] Oops: 0000 [#1] SMP PTI
[12637.085574] CPU: 0 PID: 657 Comm: segctord Not tainted 4.19.84 #1-NixOS
[12637.085577] Hardware name: ASUSTeK COMPUTER INC. VivoBook 15_ASUS Laptop X507MA_R507MA/X507MA, BIOS X507MA.301 09/14/2018
[12637.085589] RIP: 0010:percpu_counter_add_batch+0x4/0x60
[12637.085593] Code: 89 e6 89 c7 e8 dd 3b 28 00 3b 05 fb e0 b6 00 72 d8 4c 89 ee 48 89 ef e8 7a 63 2a 00 48 89 d8 5b 5d 41 5c 41 5d c3 41 54 55 53 <48> 8b 47 20 65 44 8b 20 49 63 ec 48 63 ca 48 01 f5 48 39 e9 7e 0a
[12637.085597] RSP: 0018:ffff9d1b00a0bd20 EFLAGS: 00010006
[12637.085601] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000018
[12637.085604] RDX: 0000000000000018 RSI: 0000000000000001 RDI: 0000000000000088
[12637.085608] RBP: ffff8df67a2988d0 R08: 0000000000000000 R09: ffff8df66fe0cfe0
[12637.085611] R10: 0000000000000230 R11: 0000000000000000 R12: 0000000000000000
[12637.085614] R13: ffff8df67a298758 R14: ffff8df67a2988c8 R15: ffffccd684229a80
[12637.085618] FS:  0000000000000000(0000) GS:ffff8df67ba00000(0000) knlGS:0000000000000000
[12637.085621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12637.085624] CR2: 00000000000000a8 CR3: 000000011ac0a000 CR4: 0000000000340ef0
[12637.085628] Call Trace:
[12637.085640]  __test_set_page_writeback+0x37c/0x3f0
[12637.085663]  nilfs_segctor_do_construct+0x184e/0x2040 [nilfs2]
[12637.085680]  nilfs_segctor_construct+0x1f5/0x2e0 [nilfs2]
[12637.085693]  nilfs_segctor_thread+0x129/0x370 [nilfs2]
[12637.085706]  ? nilfs_segctor_construct+0x2e0/0x2e0 [nilfs2]
[12637.085713]  kthread+0x112/0x130
[12637.085719]  ? kthread_bind+0x30/0x30
[12637.085728]  ret_from_fork+0x1f/0x40
[12637.085734] Modules linked in: ctr ccm af_packet msr 8021q snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic hid_multitouch arc4 ath9k ath9k_common ath9k_hw ath mac80211 snd_soc_skl snd_soc_skl_ipc spi_pxa2xx_platform asus_nb_wmi snd_soc_sst_ipc snd_soc_sst_dsp asus_wmi 8250_dw i2c_designware_platform sparse_keymap i2c_designware_core wmi_bmof i915 snd_hda_ext_core nilfs2 snd_soc_acpi_intel_match snd_soc_acpi uvcvideo videobuf2_vmalloc nls_iso8859_1 videobuf2_memops videobuf2_v4l2 snd_soc_core nls_cp437 rtsx_usb_ms intel_telemetry_pltdrv vfat intel_punit_ipc intel_telemetry_core fat intel_pmc_ipc memstick videobuf2_common snd_compress kvmgt vfio_mdev mdev ath3k vfio_iommu_type1 vfio btusb ac97_bus snd_pcm_dmaengine btrtl x86_pkg_temp_thermal intel_powerclamp btbcm cec coretemp btintel
[12637.085819]  crct10dif_pclmul crc32_pclmul videodev snd_hda_intel bluetooth drm_kms_helper ghash_clmulni_intel deflate media efi_pstore intel_cstate pstore intel_rapl_perf cfg80211 snd_hda_codec joydev mousedev evdev wdat_wdt serio_raw mac_hid efivars drm snd_hda_core snd_hwdep ecdh_generic snd_pcm snd_timer mei_me idma64 virt_dma snd intel_gtt agpgart i2c_i801 i2c_algo_bit mei fb_sys_fops syscopyarea soundcore rfkill processor_thermal_device sysfillrect sysimgblt intel_lpss_pci intel_soc_dts_iosf thermal wmi intel_lpss i2c_hid i2c_core battery tpm_crb button ac tpm_tis tpm_tis_core asus_wireless video pcc_cpufreq tpm rng_core pinctrl_geminilake int3400_thermal int3403_thermal pinctrl_intel int340x_thermal_zone acpi_thermal_rel iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6
[12637.085912]  nf_defrag_ipv4 libcrc32c ip6t_rpfilter ipt_rpfilter ip6table_raw iptable_raw xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_tcpudp ip6table_filter ip6_tables iptable_filter sch_fq_codel loop cpufreq_powersave tun tap macvlan bridge stp llc kvm_intel kvm irqbypass efivarfs ip_tables x_tables ipv6 crc_ccitt autofs4 ext4 crc32c_generic crc16 mbcache jbd2 fscrypto dm_crypt algif_skcipher af_alg rtsx_usb_sdmmc mmc_core rtsx_usb hid_generic usbhid hid sd_mod input_leds led_class atkbd libps2 ahci libahci xhci_pci libata xhci_hcd aesni_intel usbcore aes_x86_64 crypto_simd scsi_mod cryptd glue_helper crc32c_intel usb_common rtc_cmos i8042 serio dm_mod
[12637.086000] CR2: 00000000000000a8
[12637.086005] ---[ end trace ee0079180c990cd2 ]---
[12637.120805] RIP: 0010:percpu_counter_add_batch+0x4/0x60
[12637.120807] Code: 89 e6 89 c7 e8 dd 3b 28 00 3b 05 fb e0 b6 00 72 d8 4c 89 ee 48 89 ef e8 7a 63 2a 00 48 89 d8 5b 5d 41 5c 41 5d c3 41 54 55 53 <48> 8b 47 20 65 44 8b 20 49 63 ec 48 63 ca 48 01 f5 48 39 e9 7e 0a
[12637.120809] RSP: 0018:ffff9d1b00a0bd20 EFLAGS: 00010006
[12637.120811] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000018
[12637.120812] RDX: 0000000000000018 RSI: 0000000000000001 RDI: 0000000000000088
[12637.120814] RBP: ffff8df67a2988d0 R08: 0000000000000000 R09: ffff8df66fe0cfe0
[12637.120815] R10: 0000000000000230 R11: 0000000000000000 R12: 0000000000000000
[12637.120816] R13: ffff8df67a298758 R14: ffff8df67a2988c8 R15: ffffccd684229a80
[12637.120818] FS:  0000000000000000(0000) GS:ffff8df67ba00000(0000) knlGS:0000000000000000
[12637.120820] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12637.120821] CR2: 00000000000000a8 CR3: 0000000138e0a000 CR4: 0000000000340ef0
