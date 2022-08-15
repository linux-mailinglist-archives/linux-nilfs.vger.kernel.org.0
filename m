Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60302593151
	for <lists+linux-nilfs@lfdr.de>; Mon, 15 Aug 2022 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiHOPJU (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Mon, 15 Aug 2022 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiHOPJT (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Mon, 15 Aug 2022 11:09:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A894D1EECA
        for <linux-nilfs@vger.kernel.org>; Mon, 15 Aug 2022 08:09:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FEYepX032371;
        Mon, 15 Aug 2022 15:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NB4wxJFHXGSD3l6NCcipCQ2XF1sJcWRCBanSROT8VKE=;
 b=q4d8FO67JBCYNK2F5LvK4s+mJp5/HBWXpcSZVxIb9P/5upZvD4ZFP83QNBSAh9G+wUpm
 UhcbqbP76nZuE1Y0tcGqaxbg5TJSC0o8Vf0gwRJw/mQohs65SqtJ9EZ4r0Vt9OhATU88
 GKijZ/uTYOuq6XZuZyKJA/8MDK2XQnMA6n60Cz/h4rcocPOqbQ8Zwhx2RR+kPJLC3CC5
 ZGUyO2J6xRa+UIkASbZkW5aUTCT9SBdo8CZz3jmt6ah9WyOlha6z95Ub4SVqt1UsSly1
 8cFfcxDIauHGI3KC+iitipJR/5UIqX4i31SZoUQdqhYtR98XAqnepk3yqS8QpIwWc9dI Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2cck8dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 15:09:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27FDRu3u035013;
        Mon, 15 Aug 2022 15:09:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d7f9pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 15:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUMOR0c9MCzJ2VkUnzN7BDU7E4Yrmf6hKPc7EoXiU0tNb96UR0uySQVzm2lo3/Lw+y1ZiGz6uGHbOGMH4DpZ5zHVswTYFw/QLGJzEVkH+DAvkKruFRBntpKN8H8v3KxtYlNb1A7CyAt3eONu0v7MP4Fz14fb1uVCYUcwP7BPM+SjUG1kI88QzPP2JF8VwPn49TGpa6prDhXydNY5Px+5VPqv+mNDzf7QZMjg2/JiqjIkkrVf6AimTwIy0Z9wQuKqFdimOXOp8QKBGFVXatnltW2HOhnmy/yZmPxImYj/A89g4Duh2YQPHi6Nt+kX09uhhs1gEdaZwbTGsSWNVnpP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB4wxJFHXGSD3l6NCcipCQ2XF1sJcWRCBanSROT8VKE=;
 b=Z+XQrP8kR0AlW5hvWsgqne2ApvsZgyEDOayIzIMO47Bz+oKRryQxvj6lcsPjzUt6uNU5eQK8sRCSTH9Cq2JjQbxKDgZe+cseBbL5P3jtFmnAIfNI11j6uPM9ehRHobaIpyzQGWKu71F33Nkg6KHnhiZg7HVuxIYREFsgH+EVdXt/d26dazdaz2rjCFfnVAD2GTHih64Fqwj8noDXek+UHB4ERNwYeK7cEC3gk3w4pHxOqRazmVqCSii77wTMnxrEGs7ueZ++CFti60iRpiE7dehtYvnar5uANtSaQGFHxZMztBBr8Km2zc/IfJGrLR9vjwr80h/TTwLSS76Ajbe8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB4wxJFHXGSD3l6NCcipCQ2XF1sJcWRCBanSROT8VKE=;
 b=HiE0TTcoJ/SWiLSmXpBEobI+mD5gNI51xstDXIAKPbX///VoQq2E7zk9eDCjRDP3UxMimTZrkuM25ayAARuDNgti2U+/+uzFF2iD64CvBm5xnlXCdWF8z038pF4ICrnflQGtEKJ/BtaCHrQda1qxhFZOMfPpioxC5eWQ6Mn9+4w=
Received: from IA1PR10MB6124.namprd10.prod.outlook.com (2603:10b6:208:3a8::11)
 by CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 15:09:05 +0000
Received: from IA1PR10MB6124.namprd10.prod.outlook.com
 ([fe80::a184:bc37:9fad:157e]) by IA1PR10MB6124.namprd10.prod.outlook.com
 ([fe80::a184:bc37:9fad:157e%9]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 15:09:05 +0000
From:   John Haxby <john.haxby@oracle.com>
To:     =?utf-8?B?6K645ZiJ6K+a?= <stitch@zju.edu.cn>
CC:     "security@kernel.org" <security@kernel.org>,
        "linux-distros@vs.openwall.org" <linux-distros@vs.openwall.org>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>
Subject: Re: [vs-plain] KASAN: use-after-free in nilfs_mdt_destroy
Thread-Topic: [vs-plain] KASAN: use-after-free in nilfs_mdt_destroy
Thread-Index: AQHYsJXTfuwjLWO17kCggEzVvvbSL62wEL4A
Date:   Mon, 15 Aug 2022 15:09:05 +0000
Message-ID: <8C0C088A-11A4-4D0E-93B9-CA70F0040341@oracle.com>
References: <34e8df4a.848e1.182a1264256.Coremail.stitch@zju.edu.cn>
In-Reply-To: <34e8df4a.848e1.182a1264256.Coremail.stitch@zju.edu.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14a6a222-bdaa-42f0-f689-08da7ed01831
x-ms-traffictypediagnostic: CY5PR10MB6046:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRCEp6TD1NlwmuPOL4NDB+Rvq58UoBz/fkHVki+m3Oula0PyQPUjIsT+S6Rl3aPL/liVlgtoqo71JAYpyDBKbK6YWP+gHOtlQF/8F65ZJHGr3DYzPFI16Dof67Ri3y03hy/L3o9w6lj/T/MBnVYXNRaRZpJ/IGPd2cS3knKSB+A8ycFjTXDGgUISco9yb69vkGvNup38l0EKBV1XultX9ElGLSRdHRanuzw+ue5BVyQfHoSmRhHRX+jiPzYPJyIOdUyYpK6PR4FYGiX5F3bpWn7WM0KAkiocYJ2uJovMIdRr91225sfreaklmCOW7KAkPyfny4ErlPVJYfBNTLCtG/xlCiNerbWbF+I+1/lzPHO4odHrxcIu7UiiDAaSgIzNiSNq3jQWaO6oVA7P7jcVEF32xlJJj/kvgSMUjZBSHB/vtAi45j+tsrwuqbBgoXV3OP7n3+ye1lTwm2F3RtI/JsBLj4kighip45jE5UhixJcn8/3cfYYBYBG50Hf1d1m2BrXtyQmPhVswTJrZOOO3JcxGa9LicWIOStqBeLtTDxm2lsIxhpEYbjV4Zj0RKzYpIK0A/pLWhewVXIHYpbhj22UXbwtT1+aCMhgOTFYDsan7U4No6oXETwCLG1VnRMYQ07LTWx8kz+5yk93247cRwyKuiUWyC2fQ4f5bWwU++VwN/g/p5+usTPj652moyGOIoFz7hF33QIYZnGvdf1Nkoptg8D9dxzzV/Wxm6oLptAXFNjZVT2bHslOpDsljwxQRxGzVQ+UBvMBKR+3Q+DqQTKkqc3O+pYwMEIXJZVJTpROw0TBiY5si+yK2ZjWVmDVcsB7dENSVHxvW8vRFtXGx1LHz9obWck41XFHExyplfnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6124.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(39860400002)(346002)(36756003)(91956017)(76116006)(2906002)(2616005)(33656002)(4744005)(38100700002)(122000001)(186003)(44832011)(83380400001)(99936003)(6506007)(6512007)(41300700001)(86362001)(8936002)(6916009)(5660300002)(54906003)(53546011)(8676002)(66476007)(6486002)(66556008)(966005)(38070700005)(478600001)(66446008)(316002)(66946007)(71200400001)(4326008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUVxVHQ4d1dCNVFnMm9tTm1sTjNRdzhQZC9YUXVpSjlibG1yZXdaa1NueEls?=
 =?utf-8?B?SXFLeks3RDZYL0Ric3dOa2l1NUVyRjliK1pXaXBLNFFjWklwUmdhcXc4T1M3?=
 =?utf-8?B?ekNGeThPZHhpemh6WndYYWFwb2RYaEVTcjZWRXFiaTVFSXlRYW1UN0ZIVDNI?=
 =?utf-8?B?TnBCK0EvbjI3VmJqV2RoQTVxMGdWeHhNTTRFcjJWVC9pOUVTaXlLVUNubVZR?=
 =?utf-8?B?aVoxZGRNY0xGSTlyYWl6cmphMm9jR25XajYzUklRL1Rmc2hlYVgvUlVGTXNI?=
 =?utf-8?B?L1hQRU8zdHNyL0xrNnJzYkxjMHRITXgyMGszRzNLZ3p6NGFXU1VxcXU5UlZW?=
 =?utf-8?B?b3dSaUowSnFhVVBhOVp4VXBnbyt4REpSVXY5YkhjU0RJckRoaWdpRndWL3cz?=
 =?utf-8?B?SHhTUS9HczNRTTVrYkdNODhhM3ZHd0h3ZE1kZmNEOE1Dc0pTL1VsWTlvMzBV?=
 =?utf-8?B?OFVJdFp2Mng5NmNpRjVzSU5qN2piaHFsWmtSODdLVnA1N0Y5Q3ZCMGl1SjFT?=
 =?utf-8?B?MFlWdHNIaHM1M0xWY21JYWNDWWJvbGlxbzRhanJJMnA4cDl0Mi9WN3ZpZkds?=
 =?utf-8?B?R2xJaHZXWTlCQnM3c0FjM1krUi9aUy85V1R3UUVleXMzY0pLYlJTU0luSk5J?=
 =?utf-8?B?QmNLSmplbzYrMFNCR3pzdkVDUVVWZy9MeEFzTlRYWWE5bmFiUlYyMytsZTdY?=
 =?utf-8?B?eFFtYXhESlI5c0Q1S2lYQ0ZRRnErTW1Wc3dSYXZZNUUxa2xnNXFwdWc2SmhG?=
 =?utf-8?B?dVpLUEZvRXFNVU4rL1J4Q3BIaHBLT2VaeTJMbHkwb2VoOHZ4bkVmTUxIMSt6?=
 =?utf-8?B?aWZZSFpSRDR4MWV4RG9hejNVNjBRRnRlNENJM3FZUTFpVkl0Yjd6YWZvMnVO?=
 =?utf-8?B?WXU0Sk1BL3dqWWlBek84S2U4Q3kxcWlpQldNM0U2bXlFd3MveDZOSVEzVzFI?=
 =?utf-8?B?YUttOTQvQVRuWTkwKzdaQkd0eGI2VmRhbnRpQ3B4MmQ5VWt3a3dkYW05Nm1u?=
 =?utf-8?B?ZzJ2elBaOEFNSzRLRUpJTE1HVktlbmNkZnY5dCtSYVFGRFd6c2EyNnMvUXV5?=
 =?utf-8?B?UkhCVGpjaHYrTVhzL0FxWmEyWGVtZ2ZaNG53K2VCdnR4WkZQaE13akwvYnlE?=
 =?utf-8?B?Nkk3YWxBandKWHFiNWxQb0xGZ00zcXVFQzNRSnJrcXJKSWY3bUYvKzJob0tS?=
 =?utf-8?B?TjZ0aXh2WVZRQW1IU1JpaGtFbXFkMnFqdmo4aVQ0aklna09kN1duVjRDU1Rs?=
 =?utf-8?B?ZFpOZDFpVGxrZGRuZnpYQTlldmJadkFBckhLZFJSSHBtdjA0a01oV0ozazZY?=
 =?utf-8?B?ckhFUkxqSlNrUjJRTzVhTVAxZzIxcFRSdW9FcHZaWFhETnRXNmlyQUlGUTV5?=
 =?utf-8?B?amgyQ0tMdms2RTgyeTZLNUhTcGF3NjJoY0R5a000dlQ0YVZibkNIM1hEWmNK?=
 =?utf-8?B?VUUzZW5xK3kzVWJQeE1vOGxObFpiYVJQVU1TUHVyVGlwQmNyNFR1VTl6MW9q?=
 =?utf-8?B?RzRkRkk5RHVqaWFxV2RRZThIcGVlWWhpcG90eTdlbHZGSzFXMUVka2VKQkJr?=
 =?utf-8?B?b2V1N0RyWm9TV2wzYmltNXJIcTRHcGR2ejcwbkRVaEtMRWJneVlkU0I3Qnh5?=
 =?utf-8?B?MXRuVHpoa0ptR0NhZ2E5Z0RMT2M3ajFTZFcyY3dENHN2cXNUL0NpUW0rbmdP?=
 =?utf-8?B?RlFsSDNsVldIR2ttR3IxckNEWTdIbTAwL3R0NXdkQzBhbGRsQVB1NzZmb25E?=
 =?utf-8?B?cTdETmpLcVI5SVR0THJMT1g5SXpUTElsREdQbm4remEvWEoyN1hwdVVEN1BB?=
 =?utf-8?B?U2hKdk1jaXMxQVJxT1h5QlAyQVFTOTZzZUsrcnJYTjBCUGxzUjZqaG5XTXJm?=
 =?utf-8?B?d0toYWVlaGRRRkxJSFNsZGwyUnJWYndweWpHYzd0dlZXVHhRbjJOWklVQ2RL?=
 =?utf-8?B?cVdkZlF0U0M0c1RDY1U4U0JVdEdCMndCSmdtR0RKR24wSHF5NVRBK2VFZDJp?=
 =?utf-8?B?T3I2emdXTXgwVEZRZnN0b0R4RWNyTVJDcmV1NThjdUZGeDZaNzAvZk1wOEIv?=
 =?utf-8?B?VGJxN0NhcjNYS1JNSWxXNDhiVTBQUkpsQ3hjODJjbjFQV3p4RVI1UmtFemQy?=
 =?utf-8?B?VXd1d1JQMTVwN0JXd2lLVU43L3RNR0gxd29jeGIyR3hQNmtINHp4YWw5WVhG?=
 =?utf-8?Q?U0Z5Ov/8Pt3oBYXLyQA0l8A=3D?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1F410261-EFD2-4EED-B98D-AF6A4C46935E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M3lsMmwwOG5mQmF4cDl1NlJvS1VTaEt1a0Z3aXhyVUV4dTkxNWJrZlRIWGwz?=
 =?utf-8?B?OHJwclNZbmltQXkvUlZzU2lyNHBVYmpLaUJrdUV3eVJKdHp2L1lUNENuQWFN?=
 =?utf-8?B?VlRtUFVuRDR0TU9BdnErTG90N3IxMml3azFqWWNlWW01bUVKcjczWmlQNnB4?=
 =?utf-8?B?OThZcnRkWEdWdnhCeVlkSlA3bzByYXhjL3pEYUNYVmJ2VWFFamtpRkNtdHBO?=
 =?utf-8?B?NFQzcEZkMDRZREhPOXBLYk80MEFCVmZsakxyRmd2akV5dy94Rjc5Zi9Tc0Y4?=
 =?utf-8?B?OFFIVE9pMS9YYS9TSGkwcEwwMCtDRVREMGEwMGRGdnFpcHlKakl0NytlWVZI?=
 =?utf-8?B?UW4wMDR3RFFKR3Q1RzI3MVc4SmJOUldNaHJqWnQ0OXZrYTZiTnBSTUZSekx5?=
 =?utf-8?B?em1SV0RQR0FXOXNTZU5QZTAzN2hiWU9pQ2VKYm56TFRXdEhzYlFsbDlPM3dn?=
 =?utf-8?B?S0srbWVXRXl6MnpsYk9hWXJwZEp1M0IzbGRFb3c0a0dqSmhMbU1ubFlrb2Rx?=
 =?utf-8?B?aDNuSmo2SThzQVZ2MEoweGhMOGZ3eWZDdU52Vll2Wi9rR3JRVVpQV0g1ZDhn?=
 =?utf-8?B?Rk9raHJEVHgxK1dVdS9qcVF2cERGVTRjTkFoS0JkUVlVMndCUzIzZHRiSGFm?=
 =?utf-8?B?Y1BoWjFndjFDQXpaVzJKSk5UWHI1OFN1VUFxbXM1NXZPRjVmeGVIWnB1eis3?=
 =?utf-8?B?UCtXU2N2UTBUMmVOWHQvNWpLRmplY0I1NFhVbzlMc1VPTmpFZ3l3Q1ZLMTZh?=
 =?utf-8?B?NU1VeTdmeEk5VUdQVjVNSkhwQ1pMemRmWkxZMGFKVEpSTVRuZ1U2MjAwZzkz?=
 =?utf-8?B?N21DV1VNd1A1UTFRRFpZM2VaS2JMVmpWRTdRWWVHZlVIZ0J2enFDSDMybFdl?=
 =?utf-8?B?UHJuL3E3SlhjeXNRMmIrUnpXMEQwL0NFSWxVNkFsRHZ2SE5wWFREdjV0aW5B?=
 =?utf-8?B?TjRSV1VKY2RJL04yL1hHUmYxREdjaDJsOWw5WXJhMFZHNGVZUnl3eVpGVnYx?=
 =?utf-8?B?bmROVGJvaGNDR0NEek53cmxFaHlwZnN1Q2x4cENYaUhXZnQxS3I3ZlRud0VU?=
 =?utf-8?B?MHFFOVgzcVVEWEYxZndqeXVGcGRpUWRNQkRTRC9VWW1UNWh5N1FTcmxRYnF4?=
 =?utf-8?B?cjJ1eU9YTTZRd1NKcmF0ck1sR0JHdmdSNXpBWVd5QXB2UjM1Zk1EZ2ZKcXcz?=
 =?utf-8?B?WUtGT21HQ1ZFK1VlTWxHdjZKcXBPbVIrMGE3WU9CRG00UHkyK2hDelhIRDh2?=
 =?utf-8?B?blRJbDFidzlPL1Z6c0RnUWZscUlKeXQ0dGFCR05PSFBEK3RxRG1abHV6MnBO?=
 =?utf-8?B?Sk9MbzVNdVRQd2VuVEt0bmp0RE9BalZrQ1dKemlrcnJaa3pHQnl2Z3crMTNG?=
 =?utf-8?B?SVpyWldYaXdnK1hRa0dMZEhoYk9LNGlnYitnbUpCNHFBUjM3MjlpLzRWWlVp?=
 =?utf-8?B?TFB0aDBDaTBPTW1mdUp6ZGptblZMbzBYZEYwN2lrcHpFM2E0d1lrcG1tOFA2?=
 =?utf-8?Q?TXfm+Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6124.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a6a222-bdaa-42f0-f689-08da7ed01831
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 15:09:05.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zV1zf12McR6V16JzO7mCZ2zV4DCOS6s+/J0M5tlzPkZCGHWAEmlhLpZrrf478X9qZH6fj7KaEcYmqTAPmzDFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=870
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150060
X-Proofpoint-GUID: mU4WMSz7kb_62gki6PzVGcT96zDlniri
X-Proofpoint-ORIG-GUID: mU4WMSz7kb_62gki6PzVGcT96zDlniri
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

--Apple-Mail=_1F410261-EFD2-4EED-B98D-AF6A4C46935E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 15 Aug 2022, at 11:56, =E8=AE=B8=E5=98=89=E8=AF=9A =
<stitch@zju.edu.cn> wrote:
>=20
> Hi developers,
>=20
> We may found a flaw in the fs module which can lead to UAF write or =
DoS.
> We would appreciate a CVE ID if this is a security issue.
>=20

Confirming that your message made it through to linux-distros, but you =
haven't mentioned a date when this would be made public.  However,

> Someone found the similar problem: =
https://groups.google.com/g/syzkaller-bugs/c/z2WroC3_BSw.
>=20
> Fix this bug by moving the assignment of inode->i_private before =
security_inode_alloc.

There's already a public discussion about that and if, indeed, that's =
the same bug then you should take this to oss-security as simply a =
rediscovery of an existing bug.

I'll leave it to Red Hat to decide whether to allocate a CVE number for =
this issue. It needs significant privileges to exploit it; the only real =
question is whether you could use those privileges to crash the machine =
anyway.

jch

--Apple-Mail=_1F410261-EFD2-4EED-B98D-AF6A4C46935E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQT+pxvb11CFWUkNSOVFC7t+lC+jyAUCYvphkAAKCRBFC7t+lC+j
yLtZAQCp6LrHUxK+9ACDzogU9XE3HogPasFVmXwOqFgmyRehDwD+ONv3fT8yq6g7
ZyYQ/AZxxv3bfpDsyogZea4GJtWDgvw=
=/9pF
-----END PGP SIGNATURE-----

--Apple-Mail=_1F410261-EFD2-4EED-B98D-AF6A4C46935E--
