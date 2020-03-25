Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B703B1929F8
	for <lists+linux-nilfs@lfdr.de>; Wed, 25 Mar 2020 14:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgCYNfm (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Wed, 25 Mar 2020 09:35:42 -0400
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:37746 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727909AbgCYNfk (ORCPT
        <rfc822;linux-nilfs@vger.kernel.org>);
        Wed, 25 Mar 2020 09:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585143339; bh=nsAyPwkemNeL87rMS1ibhNNgHS5xstRdBLec2dLtids=; h=Date:From:Reply-To:Subject:References:From:Subject; b=G+o/VkLgi8gnbDwcKlZ7qQEQerudXuirX9E5/ehc9RFQmrqmJXTKZ7UzxxRwFJjOf6QRjzElapI3jp1iANCv6Mg/lul5W3qj1Qfxi4Avf9KAywIDmX3WWdJOSDWdGI8/zPWL8hrvb3qYMTWNA7HkQVHaKW7kEICGumWQsdf+pqPOwF0Iq1ymiA82Sw4Biuwew3rLfI1g1gsmbt3yx9B1QMMcgvFNcv4FqA3TA4X0SkZsjMIX5w9ZBR86xLJpjUYkzHON0ltnGbIOGcaHSbkpN03YJvHMgpSmRQxmaI2r8dc4oQyRhRkhCZHI+Z1DlJr0+lNY9nx9tKW6K4TC+ldWDQ==
X-YMail-OSG: ugsJ8WIVM1nkssusk18zAp4A.Ki3lZ6aTYt5yxn_kOgZVQekHoIyGIIFo9PsUIY
 YbCzlmARxEjmI7w3RlHWejZ2cRqi_N.vRxi5NGvL1TAyj0NVzaBrhDSU3tdA69d5Wdw6OWG5p5gF
 O_lEylyz6ehWM42oE2BVoAtjHQoyoqxN8_GyROT2laALfUpvBZUUkQOKe134f9jWwKRaGbyvNU8P
 0hAuTYQhdcmmNZayHGQaL9.YRcecSfkf4.CA0NbDzLw29.iFf530ThioS1cxHe2OLBIBr.5ZfiNm
 n96xDI_jValA1cv2y6i8hYTA5dPGvNH3TEXrbCG.sY54bnGtAL.wkRZyYnRkx9pgvOjBhydgBT0U
 KVA7URySAVJ47w_39v9YJMRddSUQV537f0Ij6qnaT36gyHbjItKLeO2FAzogeAiMeGIMchn1waRO
 yFZJkOakMBEk1rDy1na7vyum2GcD3Ac3H6etgIaO_EPZiE7bv9c0bOCQaJT5Aj4lcxfw5PNX8D6W
 9u9bWJL5dkaegaMknSG9GPP_L93r9xR3L.f4XAhv5xEzu5id3SafkzKG49fDdxtUh0DMai4rbGgO
 m6MEIzA6kZG2VG8v85yz2f8mCxhxbIynnQ9SPh1GrBW_jTwP6u8Eovzb4Ou2wImQnJz1wdQq6WNm
 QOHEN0SCQxjdQZYPuaJKyT05tz4kX82PfCnsvsFeMNLmoYyD9C3rJeoOKEotqmh129147Om7Ab8i
 ZMFdwBwwWESTxBnyrHo_R7l.VyldKws_yM6UoIIW3XALofvn3S04Uw7QU2bpdLtF2Bg3VdkHd9DG
 9HJ83P4r.Nwycvf6CAOB0lwdCb54tPHSpq1hhv592yhj1mGTkwxfW0xweFI6wTfz0MDs4Vnb.Ytj
 j4JEKz3NOSoelYqZv04w9UPJpqxqPPskowlLQSMjqbVRbS7r767uFkqOSrf16D3iBsezcw53o2ki
 ZiZeB1IK1ff0eZMZzawupK8zlytama7Mkxu41lpjRHcfBIjXiEJhTq_6jYkx5m3ZjwnYkGaOE3A9
 MWAiw8jd8DC7wUeGIAWeA43r4MPsRmSWmgMXB1exT9faWqhHM3MnFOXDttBJ9y.FkY5cKcYe8Ysr
 mPfPQk1xASlYgVkqhNUcrOZZuqkAGv_2EM0ZTgveOdsVpl8uWyePpPkEX2CD_K20JF9pBZk5x.ju
 7cjdIg0l5gJ41KbNrrr0cuoEgAsJPXvPbBTT15qbC5ix.nJCp81cqck9skTtfB99OWm0E_2KYR84
 S.LGlMjSnXhYm.UUeJG1s_v4VmB2RdgxLvyWAoIa1xsrvAmgwvA8xUM7IYRi1lhxWvs8GX4exHQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Wed, 25 Mar 2020 13:35:39 +0000
Date:   Wed, 25 Mar 2020 13:35:38 +0000 (UTC)
From:   Ms Theresa Heidi <james29234@gmail.com>
Reply-To: mstheresaaheidi@yahoo.com
Message-ID: <577705076.1166984.1585143338284@mail.yahoo.com>
Subject: =?UTF-8?B?55eF6Zmi44GL44KJ44Gu57eK5oCl44Gu5omL57SZ?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
References: <577705076.1166984.1585143338284.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15518 YMailNodin Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36 OPR/66.0.3515.115 (Edition Campaign 34)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

6Kaq5oSb44Gq44KL5pyA5oSb44Gu5Lq644CBICAgICANCg0KIOaFiOWWhOWvhOS7mOazqOaEj+a3
seOBj+iqreOCk+OBp+OBj+OBoOOBleOBhOOAguOBk+OBruaJi+e0meOBjOOBguOBquOBn+OBq+mp
muOBj+OBi+OCguOBl+OCjOOBquOBhOOBk+OBqOOBr+S6i+Wun+OBp+OBmeOAguOBneOCjOOBq+OC
guOBi+OBi+OCj+OCieOBmuOAgeengeOBr+OBguOBquOBn+OBq+azqOaEj+OCkuaJleOBo+OBpuen
geOBq+iBnuOBhOOBpuOBj+OCjOOCi+OCiOOBhuOBq+ismeiZmuOBq+OBguOBquOBn+OBq+mgvOOB
v+OBvuOBmeOAgeengeOBr+engeOBruW/g+OBq+a3seOBhOaCsuOBl+OBv+OCkuOCguOBo+OBpuOB
k+OBruODoeODvOODq+OCkuabuOOBhOOBpuOBhOOBvuOBmeOAgeengeOBr+OCpOODs+OCv+ODvOOD
jeODg+ODiOOCkuS7i+OBl+OBpumAo+e1oeOBmeOCi+OBk+OBqOOCkumBuOaKnuOBl+OBvuOBl+OB
n+OAguODl+ODreODleOCo+ODvOODq+OAgg0KDQrnp4Hjga7lkI3liY3jga/jg4bjg6zjgrXjg7vj
g4/jgqTjg4fjgqPjgZXjgpPjgafjgZnjgILnp4Hjga/jg5Xjg6njg7Pjgrnjga7jg43jgqTjg4bj
gqPjg5bjgafjgZnjgILnj77lnKjjgIHjgqTjgrnjg6njgqjjg6vjga7np4Hnq4vnl4XpmaLjgavl
haXpmaLjgZfjgabjgYTjgb7jgZnjgII2Muats+OBp+OAgee0hDTlubTliY3jgavlpKvjga7mrbvj
ga7nm7TlvozjgavogrrnmYzjgajoqLrmlq3jgZXjgozjgb7jgZfjgZ/jgIIg44CB5b2844GM5YON
44GE44Gm44GE44Gf44GZ44G544Gm44KS56eB44Gr5q6L44GX44Gm44GP44KM44G+44GX44Gf44CC
6IK644GM44KT44Gu5rK755mC44KS5Y+X44GR44Gm44GE44KL55eF6Zmi44Gu44Op44OD44OX44OI
44OD44OX44KS5L2/55So44GX44Gm44GE44G+44GZDQoNCuS6uueUn+OBruacgOW+jOOBruaXpeOB
q+i/keOBpeOBhOOBpuOBhOOCi+OBk+OBqOOBr+aYjuOCieOBi+OBp+OAgeiCuueZjOOBruOBn+OC
geOBq+WMu+W4q+OBjOengeOBqzHlubTplpPjga/ntprjgYvjgarjgYTjgajnp4HjgavoqIDjgaPj
gZ/jga7jgafjgIHjgYrph5Hjga7jgZ/jgoHjgavjgYrph5HjgpLjgoLjgYblv4XopoHjgajjgZXj
gYjjgZfjgb7jgZvjgpPllY/poYzvvJrkuqHjgY/jgarjgaPjgZ/lpKvjgYvjgonlvJXjgY3ntpnj
gYTjgaDos4fph5HjgIExNTAw5LiH57Gz44OJ44Or77yIVVMgJCAxNSwwMDAsMDAwLDAw77yJ44Gu
5ZCI6KiI44GM44GC44KK44G+44GZ44GM44CB44GT44Gu44GK6YeR44Gv44G+44Gg5aSW5Zu96YqA
6KGM44Gr44GC44KK44CB57WM5Za26Zmj44Gv5Y+X44GR5Y+W44KL44Gf44KB44Gr55yf44Gu5omA
5pyJ6ICF44Go44GX44Gm56eB44Gr5pu444GN44G+44GX44Gf56eB44Gu55eF5rCX44Gu44Gf44KB
44Gr5p2l44KL44GT44Go44GM44Gn44GN44Gq44GE44GL44CB5rKh5Y+O44GV44KM44KL44GL44KC
44GX44KM44Gq44GE44Gu44Gn44CB44Gd44KM44KS6Z2e5bi444Gr6ZW344GP5L+d44Gk44Gf44KB
44Gu44GK6YeR44CB44G+44Gf44Gv44KA44GX44KN56eB44Gu5Luj44KP44KK44Gr44Gd44KM44KS
5Y+X44GR5Y+W44KL44Gf44KB44Gr6Kqw44GL44Gr5om/6KqN44Gu5omL57SZ44KS55m66KGM44GX
44G+44GZ44CCDQoNCuOBk+OBruOBiumHkeOCkuWkluWbveOBrumKgOihjOOBi+OCieW8leOBjeWH
uuOBl+OBpuOAgeekvuS8muOBruaBteOBvuOCjOOBquOBhOS6uuOAheOBuOOBruaFiOWWhOa0u+WL
lS/mlK/mj7Tjga7jgZ/jgoHjga7os4fph5HjgpLkvb/jgYbjga7jgpLmiYvkvJ3jgaPjgabjgbvj
gZfjgYTjgafjgZnjgILjgZPjga7jgYrph5HjgYzjgYLjgarjgZ/jga7pgbjjgpPjgaDntYTnuZTj
gavmipXos4fjgZXjgozjgovjgZPjgajjgpLnp4Hjga/mnIDlvozjgavmnJvjgb/jgb7jgZnjgIIN
Cg0K56eB44Gr5L2V44GL44GM6LW344GT44KL5YmN44Gr44CB44GT44KM44KJ44Gu5L+h6KiX5Z+6
6YeR44KS6Kqg5oSP44KS5oyB44Gj44Gm5Yem55CG44GZ44KL44GT44Go44KS44GE44Go44KP44Gq
44GE44CB44G+44Gf44Gv6IiI5ZGz44GM44GC44KM44Gw44CB56eB44Gv44GC44Gq44Gf44Gr6YCj
57Wh44GZ44KL44GT44Go44Gr44GX44G+44GX44Gf44CC44GT44KM44Gv55uX44G+44KM44Gf44GK
6YeR44Gn44Gv44Gq44GP44CB5Y2x6Zm644Gv44GC44KK44G+44Gb44KT44CCMTAw77yF44Oq44K5
44Kv44GM44Gq44GP44CB5a6M5YWo44Gq5rOV55qE6Ki85oug44GM44GC44KK44G+44GZ44CCDQoN
CuengeOBr+OAgeOBguOBquOBn+OBruWAi+S6uueahOOBquS9v+eUqOOBruOBn+OCgeOBq+WQiOio
iOmHkemhjeOBrjQ177yF44KS5Y+W44KK44CBNTXvvIXjgpLmhYjlloTlm6PkvZPjgavlr4Tku5jj
gZfjgabjgbvjgZfjgYTjgILnp4Hjga7mnIDlvozjga7poZjmnJvjgpLljbHpmbrjgavjgZXjgonj
gZnjgojjgYbjgarjgoLjga7jga/mrLLjgZfjgY/jgarjgYTjga7jgafjgIHnp4Hjga7lv4Pjga7m
rLLmnJvjgpLpgZTmiJDjgZnjgovjgZ/jgoHjgavjgIHjgZPjga7ku7bjgavlr77jgZnjgovjgYLj
garjgZ/jga7mnIDlpKfpmZDjga7mqZ/lr4bmgKfjgajkv6HpoLzjgavmhJ/orJ3jgZfjgb7jgZnj
gIINCiAgICAgICAgDQrjgYLjgarjgZ/jga7mnIDmhJvjga7lp4nlprnjgIINCuODhuODrOOCteOD
u+ODj+OCpOOCuOWkq+S6ug==
