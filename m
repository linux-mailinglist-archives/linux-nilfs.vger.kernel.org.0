Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C013015FD
	for <lists+linux-nilfs@lfdr.de>; Sat, 23 Jan 2021 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbhAWOjS (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Sat, 23 Jan 2021 09:39:18 -0500
Received: from mailout11.telekom.de ([194.25.225.207]:19081 "EHLO
        mailout11.telekom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAWOjQ (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Sat, 23 Jan 2021 09:39:16 -0500
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jan 2021 09:39:14 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=t-systems.com; i=@t-systems.com; q=dns/txt; s=mail;
  t=1611412755; x=1642948755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r9Yy2Nt+b2nnEDqG3mFDIzNmoSgNWzVdxHU4e5rfr3g=;
  b=iMlwUQ3rgTZm9lt9wmIR0fFkP4X20OU0eXUK+BLheBfh6NAEZcyBuN4X
   ZW7G3s1owWxwIEaNt5Aii4+dLdEtY8BxcOM/obs5Otjkb8hQM7kpNoUuf
   Sfk4Tp5YmvvpNvORPsGvCph4cs6x+i2CJt8nSz40BkpBxH7o7I+5sNkPS
   H0eVjMJ2yhvAU7HyGR4+iNs5BcnPalDruD4FicYFLGSsxXioDeRyFTkVX
   eEu5ejSSVgw1m2BNevan6WCGHyyljVqaq7iWTAi+/svwXVlCCpcu6vr8U
   e+0J9Ueo+IWb8Hq5HabC4H7+y1Jqj59tJx0nBvUnqniVm7ZZ6Vxy2Ga/w
   Q==;
Received: from qdezc2.de.t-internal.com ([10.171.255.37])
  by MAILOUT11.dmznet.de.t-internal.com with ESMTP/TLS/DHE-RSA-AES128-SHA256; 23 Jan 2021 15:27:18 +0100
IronPort-SDR: y9PVrXO1NKx5KkGoyRxS5iejeys9qxJiQ9ONAPaYsfRyEZlJTW+HD2Czq8rtP9hpZlhBOFr6Mv
 gKjLqM3ebGixCElGYrHUMMA2DdIFZOTSc=
X-IronPort-AV: E=Sophos;i="5.79,369,1602540000"; 
   d="scan'208";a="277056278"
X-MGA-submission: =?us-ascii?q?MDHuZbumXWuUZjVe6Hbw1l1ko99OjPI4tD+Lwp?=
 =?us-ascii?q?sc68Ccohvi73dvMqFjMvOW6WV6rBOSZ6n04nH188lRQ/S1TXSE3/lCTI?=
 =?us-ascii?q?IiAFeWy93vj8o+rqZecjbNw67Yk0BT1ha+LyiyJMI8Z8CVavM9UUXcjX?=
 =?us-ascii?q?73nUJo71umC1//t47xgkPlFA=3D=3D?=
Received: from he199743.emea1.cds.t-internal.com ([10.169.119.51])
  by qde0ps.de.t-internal.com with ESMTP/TLS/ECDHE-RSA-AES128-SHA256; 23 Jan 2021 15:27:17 +0100
Received: from HE105864.EMEA1.cds.t-internal.com (10.169.119.41) by
 HE199743.emea1.cds.t-internal.com (10.169.119.51) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sat, 23 Jan 2021 15:27:17 +0100
Received: from HE104163.emea1.cds.t-internal.com (10.171.40.38) by
 HE105864.EMEA1.cds.t-internal.com (10.169.119.41) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2 via Frontend Transport; Sat, 23 Jan 2021 15:27:17 +0100
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.174)
 by O365mail05.telekom.de (172.30.0.230) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 23 Jan 2021 15:27:15 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv/AO16KqBcHqY0YA2AqPXnA/AJW5T9bwp5sP2tiHu8hJ6yKiS4SVnzgjKx1kfteGmj8wmAkFQJZLITyCWiU30KJ4RhENanAG4IHm9R0V9Z7aMDMNXA0kdWWzSdncycDWpVyRg0juAUC4meZcdf8EQwaun+eMA+aS5PxRMsxhc68pyoycG9g9DZTp5roCydywjiHZfdPw+8Rg3VEyHEJ+5QljAZMHFZgQNZR0D/kncq3YfatF3ZmpWhmELGwDo/gp4D5S6qj7hI6mUadDi5Gr/OYcx94DA5Quj6LWYiADlFBYBWl+X+fxXjF0WpkfcwkTn2BwTGnwk5ZrI/w6gBMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Yy2Nt+b2nnEDqG3mFDIzNmoSgNWzVdxHU4e5rfr3g=;
 b=c8hDS6Vy/xmqei1b6qGBBp0eoPA4Nw59QCaEZit/qMM0x+nPw2a7MBqTWdR4YNh+oAJPJYb1UQNfF7W8oqyCFdDocbyk1tFUzz8dt04R3+XHGxMSa1t8vhxazWWtJnVoHrsypndT4oFIU5szL3HAExJ6P5jECIEZiGJBMvkMN0hych4SFfDUt/oXQzjf0Ow8vr4h/pj2YKMR5YZFMTiw8zWfRno5kEver0JXt9pyOcJEtpPhtgeiDoXGRfPO4i80qhkby6MC9m4DffggRZrm+atW32UypOagd/7GdXnfyZuCHgDWIKvQQHBwEMwGzzzf+keFYzkAfm2oEzqDYaKfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=t-systems.com; dmarc=pass action=none
 header.from=t-systems.com; dkim=pass header.d=t-systems.com; arc=none
Received: from (2603:10a6:d10:f::8) by FR2P281MB0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:10::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6; Sat, 23 Jan
 2021 14:27:16 +0000
Received: from FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdd1:1371:436c:d6e0]) by FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdd1:1371:436c:d6e0%8]) with mapi id 15.20.3805.006; Sat, 23 Jan 2021
 14:27:16 +0000
From:   <Joachim.Henke@t-systems.com>
To:     <linux-nilfs@vger.kernel.org>
CC:     <Joachim.Henke@t-systems.com>
Subject: [PATCH] nilfs2: make splice write available again
Thread-Topic: [PATCH] nilfs2: make splice write available again
Thread-Index: AQHW8ZLWmjgIrxhwu0+bLhgO3c3pjao1RBCQ
Date:   Sat, 23 Jan 2021 14:27:16 +0000
Message-ID: <FR2P281MB0283D8B316988BB9F697BF3BB2BF0@FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM>
References: <YAwwjEuHpfeFDqNo@localhost.localdomain>
In-Reply-To: <YAwwjEuHpfeFDqNo@localhost.localdomain>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=t-systems.com;
x-originating-ip: [80.187.117.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c41a50ea-3dd3-43a5-b28f-08d8bfaafbb3
x-ms-traffictypediagnostic: FR2P281MB0073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <FR2P281MB0073F8C1B46DF7CE95501628B2BF0@FR2P281MB0073.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGwEqWRMiJ0bYJrNr1wAkD6T0YYEkX0DLV9zMKE7Ogx6qdOFJJbAg3TOBZE8fRF02f2669y7TWdXgdd+ARc2PufapOcrYUoWP9jZt1lwrlCspUVPCP6fXyNDuXsq8Jqjj7SLsGdl+2EuUub8BdYI/5CZb7TbNliSQmhzp5MTd/1qPvhOzbkiDgQdIqb/tusRgdxny5bPWRfK44m1fZLrIU1bForqasQtsrpBiTodP2N0NHYByTd9Jy5aUwpfJQvqvt0Kva1HbKKPRNvvxK021Ea5XYIQwt0+X99fHtjilTapLVdIoG9cRxd/bLe3Jx5Js61WRDLsjmzOLj/8V0GAJlihFZPKhce44YOpoDHEAcKHEAvrtIEcF6FxnnK6jdPlMXKtXBAyBdcNw9/eVMiGKZPyWhiS3inKc365XfMNbvUG3mAC8NuPoM16RmvDy2KMKEEUM0quFCY1hMzfP8fNh22bfhH2IeJtrfN+rbD/Mkmugo+PhPZ+dxjRt7+loYdRLcektH5daIQVeMN14cv8WpBFGRh11iXnJTfubRN4Ncknc44bDCscIbOXxlFnBKVlKAmDICHOWMMg04UyDOjOUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(52536014)(33656002)(186003)(83380400001)(6506007)(8936002)(26005)(8676002)(9686003)(498600001)(66476007)(66556008)(64756008)(66446008)(5660300002)(66946007)(55016002)(76116006)(107886003)(4326008)(4744005)(2906002)(71200400001)(86362001)(6916009)(7696005)(131093003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TmxXNmtjQ3BDbnhxY01hVUFsT1crZVZiZSt2Vy9TVEp2Y1RyOFdVNjRuTFNi?=
 =?utf-8?B?RGYwZjVramlmUTB1a1E1KzdVMExMNUlpVDhMbUMzVUFyb2lVc0dZbTQ2b0ha?=
 =?utf-8?B?V2VVTEJCdFRCNUJQaXRsemEzbDVqaGZwMURELzRFU0l5Vk4xWmg2UXlCVjQ2?=
 =?utf-8?B?Wm16ZVFhRVpHeVZPdnNreWtyTTFMVzA4QmlNSjVMZE9uV1NrTGhwY01IM2t1?=
 =?utf-8?B?Znp5TVdvd2lXZTAzMTRvZlRxSnIwWTJETUlrdnVEQzFMUytYK3VVY09lYzBh?=
 =?utf-8?B?MzNFeEFrZTAwWjBjNldBazVSUHEvTXRSdU8zeWxXWlZnOGdsdUgxL3RNaHJw?=
 =?utf-8?B?ekZreVRUU05LQTdQbE45eWp6WElXMjg2V3RXc1RzNTN6STVQWHNPaWxwVDJs?=
 =?utf-8?B?RUJQNkcxTlgxaXhvOGI0Z0NFODl4S09xK3JWUUlmL0dEVzdlRkdGYi9zMzBs?=
 =?utf-8?B?SzFXUTBJa3EyRzdrZjFHUzBmbEpCZG5HaVpWOFMxZHgzZnZDM0Z3ZzFNdGpN?=
 =?utf-8?B?MWJnK2xCZUpiUjhvczFvT0xzbjZwWUJxMlpIYUdPempQcWpzNEdDZ3lpMVlS?=
 =?utf-8?B?OUJONCt6RmxCanNKTkxXYk5jRllEQ2gzdVZOUmRvWW5hUUxvWXRYcEE1T21S?=
 =?utf-8?B?M25jb3IxMVJSRCtla28xZlhad2tDTFdHNjRqOXE5RHA1am5sajhXUEpwTG5r?=
 =?utf-8?B?MGwyWTdNR2czN0loRlJudHRGTmZBeUYzdURINFN4dFIrSVVDaGRiT05IL3A4?=
 =?utf-8?B?RVBIelMrdTFZWFBxbkJ2V2daYmJrK1hnVUhENDc5TU1Cb1MrZWZhVUs4WW1z?=
 =?utf-8?B?bHpZbitxRXZDWDgzSDJhbDhhbGNKOHpya3grb2N4RmQzaFkyOVZEOWFZTTJ6?=
 =?utf-8?B?WERGb3M1ZmxHVk9wZFpiZ05mdVdzV1pqTTZrdkpTRXpCZTV4Y09pMmEzbitw?=
 =?utf-8?B?cm9sUjJya2FUd2wzRGVHVnQ5NXRGOVdaVHdIZ01QOVJSNnRlQ2NSdWwydVNv?=
 =?utf-8?B?YmNyNkZKSlNjbmRNcEZOTUk1WG5QTm9jditKRWl5cG9XRDF6UGszbGRjRFBF?=
 =?utf-8?B?Vm5IbVRvUnlMd0NvWHpVRHN6cXBBWkxkaHdBUy9JSGJQODVNb2E1SnBWOWVy?=
 =?utf-8?B?OFByZWczMElvSVNIN2Y0VzR6M0tWZ0dKUUFSbmIxS2RWMkNMZWtRcEhjMFVx?=
 =?utf-8?B?T1FPSGMva3ZuM3haWUVDTXBhbTlnb1V5cjREdDhMWFlDcVZuOHpBOFV4WDQ0?=
 =?utf-8?B?QzV5U0xxbmVHM1JjdHEwanRiVXZ2cjAzWWFwZ0RDeS81Rm1Fbk1RaHRNZlVM?=
 =?utf-8?Q?w2+WdVUmjUkXY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c41a50ea-3dd3-43a5-b28f-08d8bfaafbb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 14:27:16.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bde4dffc-4b60-4cf6-8b04-a5eeb25f5c4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVjBuf9sg0Loj1ckj0opOqUvE/yDiqedch9rGB6uwVmJ7Ir7NbhDJhrhx9awUQ0M3y/m5d0N8DkdUYTxnlFHPLUDqQpNl/ZmdzYOloUibBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0073
X-TM-SNTS-SMTP: 95566320ECA26A86F4D6599A4323468BFEC94A95E3DFD916BC1453408A8E6FED2000:8
X-OriginatorOrg: t-systems.com
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

U2luY2UgNS4xMCwgc3BsaWNlKCkgb3Igc2VuZGZpbGUoKSB0byBOSUxGUzIgcmV0dXJuIEVJTlZB
TC4gVGhpcyB3YXMNCnByb2JhYmx5IGNhdXNlZCBieSBjb21taXQgMzZlMmM3NDIxZjAyICgiZnM6
IGRvbid0IGFsbG93IHNwbGljZQ0KcmVhZC93cml0ZSB3aXRob3V0IGV4cGxpY2l0IG9wcyIpLg0K
DQpUaGlzIHBhdGNoIGluaXRpYWxpemVzIHRoZSBzcGxpY2Vfd3JpdGUgZmllbGQgaW4gZmlsZV9v
cGVyYXRpb25zLCBsaWtlDQptb3N0IGZpbGUgc3lzdGVtcyBkbywgdG8gcmVzdG9yZSB0aGUgZnVu
Y3Rpb25hbGl0eS4NCg0KU2lnbmVkLW9mZi1ieTogSm9hY2hpbSBIZW5rZSA8am9hY2hpbS5oZW5r
ZUB0LXN5c3RlbXMuY29tPg0KLS0tDQogZnMvbmlsZnMyL2ZpbGUuYyB8IDEgKw0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvbmlsZnMyL2ZpbGUuYyBi
L2ZzL25pbGZzMi9maWxlLmMNCmluZGV4IDY0YmM4MTM2M2M2Y2MuLjRjN2E2NjIwNDc1MTMgMTAw
NjQ0DQotLS0gYS9mcy9uaWxmczIvZmlsZS5jDQorKysgYi9mcy9uaWxmczIvZmlsZS5jDQpAQCAt
MTQxLDYgKzE0MSw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgbmlsZnNfZmlsZV9v
cGVyYXRpb25zID0gew0KIAkvKiAucmVsZWFzZQk9IG5pbGZzX3JlbGVhc2VfZmlsZSwgKi8NCiAJ
LmZzeW5jCQk9IG5pbGZzX3N5bmNfZmlsZSwNCiAJLnNwbGljZV9yZWFkCT0gZ2VuZXJpY19maWxl
X3NwbGljZV9yZWFkLA0KKwkuc3BsaWNlX3dyaXRlCT0gaXRlcl9maWxlX3NwbGljZV93cml0ZSwN
CiB9Ow0KDQogY29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlvbnMgbmlsZnNfZmlsZV9pbm9kZV9v
cGVyYXRpb25zID0gew0K
