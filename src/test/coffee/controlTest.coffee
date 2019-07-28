# controlTest.coffee
# Copyright 2019 Patrick Meade.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#----------------------------------------------------------------------

fs = require "fs"
should = require "should"

mut = require "../lib/control"

BZFLAG_CONTROL_OBJ =
    "Package": "bzflag-server"
    "Source": "bzflag (2.4.18-1)"
    "Version": "2.4.18-1+b1"
    "Installed-Size": "3967"
    "Maintainer": "Debian Games Team <pkg-games-devel@lists.alioth.debian.org>"
    "Architecture": "amd64"
    "Depends": "lsb-base (>= 3.0-6), libc-ares2 (>= 1.7.0), libc6 (>= 2.27), libcurl3-gnutls (>= 7.16.2), libgcc1 (>= 1:3.0), libncurses6 (>= 6), libstdc++6 (>= 5.2), libtinfo6 (>= 6), zlib1g (>= 1:1.1.4)"
    "Enhances": "bzflag-client"
    "Description": "3D first person tank battle game -- server"
    "Homepage": "http://bzflag.org/"
    "Description-md5": "029282d17f4701a2726858e1ad73784a"
    "Tag": [
        "game::arcade, interface::3d, interface::daemon, interface::graphical,"
        "interface::x11, network::server, network::service, protocol::ssl,"
        "role::program, uitoolkit::ncurses, use::gameplaying, x11::application" ]
    "Section": "games"
    "Priority": "optional"
    "Filename": "pool/main/b/bzflag/bzflag-server_2.4.18-1+b1_amd64.deb"
    "Size": "1032408"
    "MD5sum": "552a127e2c376d72947b890473270168"
    "SHA256": "c7f1621ad14d1e5a4ce5fc233abc19376646ce9fac83bf8b522634b95105fffc"

BZFLAG_SERVER_CONTROL = """Package: bzflag-server
Source: bzflag (2.4.18-1)
Version: 2.4.18-1+b1
Installed-Size: 3967
Maintainer: Debian Games Team <pkg-games-devel@lists.alioth.debian.org>
Architecture: amd64
Depends: lsb-base (>= 3.0-6), libc-ares2 (>= 1.7.0), libc6 (>= 2.27), libcurl3-gnutls (>= 7.16.2), libgcc1 (>= 1:3.0), libncurses6 (>= 6), libstdc++6 (>= 5.2), libtinfo6 (>= 6), zlib1g (>= 1:1.1.4)
Enhances: bzflag-client
Description: 3D first person tank battle game -- server
Homepage: http://bzflag.org/
Description-md5: 029282d17f4701a2726858e1ad73784a
Tag: game::arcade, interface::3d, interface::daemon, interface::graphical,
 interface::x11, network::server, network::service, protocol::ssl,
 role::program, uitoolkit::ncurses, use::gameplaying, x11::application
Section: games
Priority: optional
Filename: pool/main/b/bzflag/bzflag-server_2.4.18-1+b1_amd64.deb
Size: 1032408
MD5sum: 552a127e2c376d72947b890473270168
SHA256: c7f1621ad14d1e5a4ce5fc233abc19376646ce9fac83bf8b522634b95105fffc"""

BZIP2_CONTROL_OBJ =
    "Format": "3.0 (quilt)"
    "Source": "bzip2"
    "Binary": "libbz2-1.0, libbz2-dev, bzip2, bzip2-doc"
    "Architecture": "any all"
    "Version": "1.0.6-8.1"
    "Maintainer": "Anibal Monsalve Salazar <anibal@debian.org>"
    "Uploaders": "Santiago Ruano Rincón <santiago@debian.org>"
    "Homepage": "http://www.bzip.org/"
    "Standards-Version": "3.9.6"
    "Vcs-Browser": "http://git.debian.org/?p=collab-maint/bzip2.git"
    "Vcs-Git": "git://git.debian.org/collab-maint/bzip2.git"
    "Build-Depends": "dpkg-dev (>= 1.16.0), debhelper (>= 9), dh-exec"
    "Build-Depends-Indep": "texinfo"
    "Package-List": [
        ""
        "bzip2 deb utils standard arch=any"
        "bzip2-doc deb doc optional arch=all"
        "libbz2-1.0 deb libs important arch=any"
        "libbz2-dev deb libdevel optional arch=any" ]
    "Checksums-Sha1": [
        ""
        "3725a0554fa6bb654ef2728fef36bc06aed4e388 708737 bzip2_1.0.6.orig.tar.bz2"
        "d179574585850a3833300f8bee56249612bf5ca4 59875 bzip2_1.0.6-8.1.debian.tar.bz2" ]
    "Checksums-Sha256": [
        ""
        "d70a9ccd8bdf47e302d96c69fecd54925f45d9c7b966bb4ef5f56b770960afa7 708737 bzip2_1.0.6.orig.tar.bz2"
        "bdbe7bf29e014e44d79bb7c733fe63cae990ab50882a4a07867cf69c61ad72b7 59875 bzip2_1.0.6-8.1.debian.tar.bz2" ]
    "Files": [
        ""
        "2a1df12bd405cc86790291797673753c 708737 bzip2_1.0.6.orig.tar.bz2"
        "b3bf7c9a957fa3a71661e45a58ab7eb0 59875 bzip2_1.0.6-8.1.debian.tar.bz2" ]

BZIP2_DSC_NO_SIGNATURE = """Format: 3.0 (quilt)
Source: bzip2
Binary: libbz2-1.0, libbz2-dev, bzip2, bzip2-doc
Architecture: any all
Version: 1.0.6-8.1
Maintainer: Anibal Monsalve Salazar <anibal@debian.org>
Uploaders: Santiago Ruano Rincón <santiago@debian.org>
Homepage: http://www.bzip.org/
Standards-Version: 3.9.6
Vcs-Browser: http://git.debian.org/?p=collab-maint/bzip2.git
Vcs-Git: git://git.debian.org/collab-maint/bzip2.git
Build-Depends: dpkg-dev (>= 1.16.0), debhelper (>= 9), dh-exec
Build-Depends-Indep: texinfo
Package-List:
 bzip2 deb utils standard arch=any
 bzip2-doc deb doc optional arch=all
 libbz2-1.0 deb libs important arch=any
 libbz2-dev deb libdevel optional arch=any
Checksums-Sha1:
 3725a0554fa6bb654ef2728fef36bc06aed4e388 708737 bzip2_1.0.6.orig.tar.bz2
 d179574585850a3833300f8bee56249612bf5ca4 59875 bzip2_1.0.6-8.1.debian.tar.bz2
Checksums-Sha256:
 d70a9ccd8bdf47e302d96c69fecd54925f45d9c7b966bb4ef5f56b770960afa7 708737 bzip2_1.0.6.orig.tar.bz2
 bdbe7bf29e014e44d79bb7c733fe63cae990ab50882a4a07867cf69c61ad72b7 59875 bzip2_1.0.6-8.1.debian.tar.bz2
Files:
 2a1df12bd405cc86790291797673753c 708737 bzip2_1.0.6.orig.tar.bz2
 b3bf7c9a957fa3a71661e45a58ab7eb0 59875 bzip2_1.0.6-8.1.debian.tar.bz2"""

CONTROL_FUNCTIONS = [ "isContinueLine", "isFieldLine", "parse", "stringify", "stripSignature" ]

readFileAsync = (filename) ->
    return new Promise (resolve, reject) ->
        fs.readFile filename, {encoding: "utf8"}, (err, data) ->
            return reject err if err?
            resolve data

describe "control", ->
    it "should supply some functions", ->
        mut.should.have.properties CONTROL_FUNCTIONS
        for func in CONTROL_FUNCTIONS
            mut[func].should.be.a.Function()

    describe "isContinueLine", ->
        it "should recognize continuation lines", ->
            mut.isContinueLine("Checksums-Sha256:").should.equal false
            mut.isContinueLine(" d70a9ccd8bdf47e302d96c69fecd54925f45d9c7b966bb4ef5f56b770960afa7 708737 bzip2_1.0.6.orig.tar.bz2").should.equal true
            mut.isContinueLine("\tbdbe7bf29e014e44d79bb7c733fe63cae990ab50882a4a07867cf69c61ad72b7 59875 bzip2_1.0.6-8.1.debian.tar.bz2").should.equal true

    describe "isFieldLine", ->
        it "should recognize field lines", ->
            mut.isFieldLine("Checksums-Sha256:").should.equal true
            mut.isFieldLine(" d70a9ccd8bdf47e302d96c69fecd54925f45d9c7b966bb4ef5f56b770960afa7 708737 bzip2_1.0.6.orig.tar.bz2").should.equal false
            mut.isFieldLine("\tbdbe7bf29e014e44d79bb7c733fe63cae990ab50882a4a07867cf69c61ad72b7 59875 bzip2_1.0.6-8.1.debian.tar.bz2").should.equal false

    describe "parse", ->
        it "should be able to parse a control file without a signature", ->
            obj = mut.parse BZIP2_DSC_NO_SIGNATURE
            obj.should.eql BZIP2_CONTROL_OBJ

        it "should be able to parse a control file with a signature", ->
            bzip2dsc = await readFileAsync "src/test/data/bzip2_1.0.6-8.1.dsc"
            obj = mut.parse bzip2dsc
            obj.should.eql BZIP2_CONTROL_OBJ

        it "should be able to parse a control file including a multiline", ->
            obj = mut.parse BZFLAG_SERVER_CONTROL
            obj.should.eql BZFLAG_CONTROL_OBJ

    describe "stringify", ->
        it "should be able to stringify a control object", ->
            obj = mut.parse BZIP2_DSC_NO_SIGNATURE
            obj.should.eql BZIP2_CONTROL_OBJ
            control = mut.stringify BZIP2_CONTROL_OBJ
            control.should.eql BZIP2_DSC_NO_SIGNATURE

    describe "stripSignature", ->
        it "should strip the signature of a PGP signed control file", ->
            bzip2dsc = await readFileAsync "src/test/data/bzip2_1.0.6-8.1.dsc"
            stripBzip2dsc = mut.stripSignature bzip2dsc
            stripBzip2dsc.should.equal BZIP2_DSC_NO_SIGNATURE

        it "should pass a control file without a PGP signature", ->
            bzip2dsc = await readFileAsync "src/test/data/bzip2_1.0.6-9.1.not-signed.dsc"
            stripBzip2dsc = mut.stripSignature bzip2dsc
            stripBzip2dsc.should.equal bzip2dsc
            (stripBzip2dsc == bzip2dsc).should.equal true

#----------------------------------------------------------------------
# end of controlTest.coffee
