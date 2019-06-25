Return-Path: <linux-nilfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nilfs@lfdr.de
Delivered-To: lists+linux-nilfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E44555F6
	for <lists+linux-nilfs@lfdr.de>; Tue, 25 Jun 2019 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfFYRcf (ORCPT <rfc822;lists+linux-nilfs@lfdr.de>);
        Tue, 25 Jun 2019 13:32:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727652AbfFYRcf (ORCPT <rfc822;linux-nilfs@vger.kernel.org>);
        Tue, 25 Jun 2019 13:32:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E8FBAD8A;
        Tue, 25 Jun 2019 17:32:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D2B6DA8F6; Tue, 25 Jun 2019 19:33:16 +0200 (CEST)
Date:   Tue, 25 Jun 2019 19:33:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
Message-ID: <20190625173316.GU8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, matthew.garrett@nebula.com,
        yuchao0@huawei.com, tytso@mit.edu, shaggy@kernel.org,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
 <156116138952.1664814.16552129914959122837.stgit@magnolia>
 <20190625105725.GB26085@infradead.org>
 <20190625170248.GS8917@twin.jikos.cz>
 <20190625171616.GB2230847@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625171616.GB2230847@magnolia>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-nilfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nilfs.vger.kernel.org>
X-Mailing-List: linux-nilfs@vger.kernel.org

On Tue, Jun 25, 2019 at 10:16:16AM -0700, Darrick J. Wong wrote:
> On Tue, Jun 25, 2019 at 07:02:48PM +0200, David Sterba wrote:
> > On Tue, Jun 25, 2019 at 03:57:25AM -0700, Christoph Hellwig wrote:
> > > On Fri, Jun 21, 2019 at 04:56:29PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > > 
> > > > Create a generic checking function for the incoming FS_IOC_FSSETXATTR
> > > > fsxattr values so that we can standardize some of the implementation
> > > > behaviors.
> > > > 
> > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  fs/btrfs/ioctl.c   |   21 +++++++++-------
> > > >  fs/ext4/ioctl.c    |   27 ++++++++++++++------
> > > >  fs/f2fs/file.c     |   26 ++++++++++++++-----
> > > >  fs/inode.c         |   17 +++++++++++++
> > > >  fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++++++++++----------------------
> > > >  include/linux/fs.h |    3 ++
> > > >  6 files changed, 111 insertions(+), 53 deletions(-)
> > > > 
> > > > 
> > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > index f408aa93b0cf..7ddda5b4b6a6 100644
> > > > --- a/fs/btrfs/ioctl.c
> > > > +++ b/fs/btrfs/ioctl.c
> > > > @@ -366,6 +366,13 @@ static int check_xflags(unsigned int flags)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void __btrfs_ioctl_fsgetxattr(struct btrfs_inode *binode,
> > > > +				     struct fsxattr *fa)
> > > > +{
> > > > +	memset(fa, 0, sizeof(*fa));
> > > > +	fa->fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);
> > > 
> > > Is there really much of a point in this helper? Epeciall as
> > > the zeroing could easily be done in the variable declaration
> > > line using
> > > 
> > > 	struct fsxattr fa = { };
> > 
> > Agreed, not counting the initialization the wrapper is merely another
> > name for btrfs_inode_flags_to_xflags. I also find it slightly confusing
> > that __btrfs_ioctl_fsgetxattr name is too close to the ioctl callback
> > implementation btrfs_ioctl_fsgetxattr but only does some initialization.
> 
> Ok; it's easily enough changed to:
> 
> 	struct fsxattr old_fa = {
> 		.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags),
> 	};

Works for me, thanks.
