Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B5B7529
	for <lists+linux-nilfs@lfdr.de>; Thu, 19 Sep 2019 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfISIdp (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Thu, 19 Sep 2019 04:33:45 -0400
Received: from mail-sy3aus01hn2035.outbound.protection.outlook.com ([52.103.199.35]:6401
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387715AbfISIdp (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Thu, 19 Sep 2019 04:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaLHLfbqkxeEw/D8DSW3Gqh6xMMqTfiTz8U+nRUu2eibjSNb+Dvo0oyIy3RMoN8eDQHPtcc2aH2Qob5bqAXTfD0EEt8Gx4+B7C/Bfr6m6DsB3EtVW7WiNVKfqseHgKfeEz1i+5BWZWHYqBVERFRmy1iHBZroX0V1d1+umZ8oU98z+4eZI/Jq44XfAtFGE9213llbJ9FayrDnCFD24Rc1LPccEZ+6BKmYwPWDD9kvn0zoD52/uo09GkPjrPTbWkfSJ5gHMRj1rzyRmz7LeIfjgpO3NGqzvdUDi84ECzum6TXK+Xl2vK2KcK9Y/PXjzunSoT3QhxK+tBAQ6SMxVcDKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctOHH2mTYytKOkOB/KQgjBv82LXnbGG7XKgNOOQYhPo=;
 b=AFDEZj8beGq7w/ZFOMRqsBSkep2mBK8hfJe8EbEZB0npyhaiILEfNxpm7UYpD+LUW/ofQR8RPkiLls1yc+oCa5Rn/5M69oB9NxaYYslvwz1HNFBzpEGFhs7qhL9LVcNL0IIbq3RHugQ9K3A3dszeoo/ohn0DyPAADGT2u+lpvq3yYjdFVMhtGRKdKw3wBbn3rZkc0IOPs8dvBFnTgcvsejId3dXE4GYlUGnrse0UI3IQRUaTrBnkxGWVDTceu050lKqBZkoQBw6jLM8wuwh+gqpXNJlxiaZkOHrEnK4YvHt8tCAB1rOccc3fDJxcgvC4Sk2kFiOZEMDE/IgFENG98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.uts.edu.au; dmarc=pass action=none
 header.from=student.uts.edu.au; dkim=pass header.d=student.uts.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=studentutsedu.onmicrosoft.com; s=selector2-studentutsedu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctOHH2mTYytKOkOB/KQgjBv82LXnbGG7XKgNOOQYhPo=;
 b=A1bJWUESE+JKDh9ueqotycDdU93gyKFzcdayhg+56jNyKS3dILZm9Rn3GemuQQf7gfbg4md6hT6ykkCxax8GMLEdan24XWko3ag0/ayKdQraJ4/KeQBGcfk7PFB9RKPNhJywqKXLZ9z/7nDyHTahIaC1NaQIDYr49LgqlCViRkg=
Received: from ME2PR01MB3633.ausprd01.prod.outlook.com (52.134.223.18) by
 ME2PR01MB2337.ausprd01.prod.outlook.com (52.134.204.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 08:33:40 +0000
Received: from ME2PR01MB3633.ausprd01.prod.outlook.com
 ([fe80::f034:a98e:7dbf:5bb8]) by ME2PR01MB3633.ausprd01.prod.outlook.com
 ([fe80::f034:a98e:7dbf:5bb8%7]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 08:33:40 +0000
From:   <13545482@student.uts.edu.au>
To:     Arbin Pandeya <Arbin.Pandeya@student.uts.edu.au>
Subject: Darlehensangebot
Thread-Topic: Darlehensangebot
Thread-Index: AQHVbsTwyPl11NzyOkyodpXT2T23WQ==
Date:   Thu, 19 Sep 2019 08:33:40 +0000
Message-ID: <ME2PR01MB3633544519B96E637195F657A7890@ME2PR01MB3633.ausprd01.prod.outlook.com>
Reply-To: "chelsealoan4@gmail.com" <chelsealoan4@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0266.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::14) To ME2PR01MB3633.ausprd01.prod.outlook.com
 (2603:10c6:220:30::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arbin.Pandeya@student.uts.edu.au; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [154.160.2.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21804963-e036-4893-54b2-08d73cdc12ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:ME2PR01MB2337;
x-ms-traffictypediagnostic: ME2PR01MB2337:
x-microsoft-antispam-prvs: <ME2PR01MB2337512C08585F6DC57D369E91890@ME2PR01MB2337.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(99286004)(25786009)(3846002)(6116002)(7116003)(6506007)(386003)(486006)(476003)(6862004)(7416002)(102836004)(26005)(305945005)(55016002)(6636002)(7696005)(14454004)(52116002)(6436002)(66476007)(66556008)(7736002)(74316002)(9686003)(5003540100004)(52536014)(64756008)(66446008)(2171002)(786003)(3480700005)(71200400001)(71190400001)(5660300002)(256004)(66946007)(14444005)(2906002)(33656002)(478600001)(66806009)(186003)(22416003)(8796002)(316002)(8936002)(8676002)(81166006)(81156014)(2860700004)(88552002)(221733001)(66066001)(66574012)(325944009)(43066004)(4744005)(81742002);DIR:OUT;SFP:1501;SCL:1;SRVR:ME2PR01MB2337;H:ME2PR01MB3633.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:de;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: student.uts.edu.au does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EX661ihQHFVlNLfATmnlb2obVAnMNybMq26MtVP5niQFHmJ+d0vWpRGxJAf8CdLLeRk+qttt/O2Cv0yi3vp9jSBxM2p//Fzf5pPEhS1ry54LNpYGg76hPN44br2MsY0bkA8fsTKF8H7ZQp+hTZhWlxjMtv+HQZGuR8tJvujWrFf2tKTGENt0uHQrec0sCsYZQq/Y8XSUgiD1nGCN1wN96We1d/4xf7ZeWGQniyl8h3rYY0O2h3Jaa8idkXf/i4g0b7APljLdCh2DhLjwOwnsWp9kHDkRXnRommKumJUiUC76XQ924ccvmBa4l96Tv/lAswn/HA0BNT3ZzDa1Jn+I5UsH2AdiaQzlg4BSvgUDXGneYOWjbhM+tl3k5FsZFlCbpM6/6RFZ9uz+Lb4qbJOxcetUa9rNygjPxzxTz1dZa/c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7749CA0C358DDA47B0DE4D8AA767925E@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.uts.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 21804963-e036-4893-54b2-08d73cdc12ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 08:33:40.4969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8911c26-cf9f-4a9c-878e-527807be8791
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sooGrXPf4FCv2Sys/tRJ6JhqFXXcIrz6eWiyIAi20zBAf4dert1SK+TlzE/KrRzQ73ReWN8p6r4SHXCGZV+vCsJzBpbhRja5EmPTgLlN52g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB2337
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

Sch=F6nen Tag

Ben=F6tigen Sie ein echtes Darlehen online, um Ihre Rechnungen zu sichern u=
nd starten Sie ein
neues Gesch=E4ft? Ben=F6tigen Sie einen pers=F6nlichen Kredit? Wir bieten a=
lle Arten von Darlehen
mit 3% zinssatz und auch mit einem erschwinglichen r=FCckzahlungsbedingunge=
n.

F=FCr weitere Informationen antworten Sie mit den unten stehenden Informati=
onen.

Name:
Land:
Zustand:
Ben=F6tigte Menge:
Dauer:
Telefonnummer:
Monatliches Einkommen:

Bitte beachten Sie, dass auf Kontakt-E-Mail:
chelsealoan4@gmail.com
