# lineStreamTest.coffee
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

mut = require "../lib/lineStream"

BZIP2_DSC = """-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Format: 3.0 (quilt)
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
 b3bf7c9a957fa3a71661e45a58ab7eb0 59875 bzip2_1.0.6-8.1.debian.tar.bz2

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAliOPp0ACgkQ57/I7JWG
EQkJ8hAAy80uTNBPnbKrQ6p7mBPtqlB21EmbrIKpkSu8AZ5Qlk2EbZ52OV/6ZjfU
pZIddkkIwZx0pYM7xVL4T/TzAG+uiNbmbZQI0Yz4ey9w9K1fjQ9HRgRIHseV58cW
5Y9AfK01yZybNWU3vS2hrcwM/HYhevG5FQmGBHLaBbdTgyUXu+pAKjPoY5mcLCPn
4rChY78E27y6vFq0seHDWqM8Kv5GzR7KhfvZHozLWKIx4hV970O9vT8W3yFRJy8U
gEF91rG0v0oPV4Z3RUSJ1fBxEamMAIcxCX1DVbFzZJeZG4uXBc7FmFId/do/e9jJ
zKt4JakbQxQ7EwPIxYJqb1NwC1G//YHq4KlY5SadrscHVBsZn0cptIQUfOJFrJHZ
9ZWAR07e0In7PL9cKEhO41ayuZqe3+L1OkYCJ6XoinaRkjdRJ+uWAydEd3LHoabO
ehgZCPowPk9EYyNo7TJMlnlTr+Z3Ih5BgzSDn323oroHZjyCSFiWZPyniG+2SFaC
AZKV54aV8fiYBqZWdJ6UZOPb8Ec+VQkimrFuiCvUQPGUl7TsaSl4Ewf9uofjfvMs
y3NVagV/BDkiX5cdFQJDQYWhfmPph3lBUjH+kvfDW0JMs+hUu9o9fwkFmsmvmveC
8WP6RPN429/fs94mZcRTkbym1+i5qw7Gw/OLQLpq4Bn3NjLSqVA=
=BdMq
-----END PGP SIGNATURE-----
"""

describe "lineStream", ->
    it "should supply a LineStream class", ->
        mut.LineStream.should.be.ok()
        mut.LineStream.should.be.a.Function()

    it "should break things down line by line", (done) ->
        RESULT = ("#{x}\n" for x in BZIP2_DSC.split "\n").reverse()
        dscFile = fs.createReadStream("src/test/data/bzip2_1.0.6-8.1.dsc")
        ls = new mut.LineStream()
        ls.on "data", (line) ->
            line.toString().should.equal RESULT.pop()
        ls.on "end", ->
            done() if RESULT.length is 0
        dscFile.pipe ls
        return true

#----------------------------------------------------------------------
# end of lineStreamTest.coffee
