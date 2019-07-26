# paragraphStreamTest.coffee
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

mut = require "../lib/paragraphStream"

PACKAGES_PARAGRAPHS = [ "bzflag-server", "bzip2", "bzip2-doc", "libbz2-1.0", "libbz2-dev", "bzr" ]
SOURCES_PARAGRAPHS = [ "bzflag", "bzip2", "bzip2", "bzr" ]

describe "paragraphStream", ->
    it "should supply a ParagraphStream class", ->
        mut.ParagraphStream.should.be.ok()
        mut.ParagraphStream.should.be.a.Function()

    it "should break things down paragraph by paragraph", ->
        return new Promise (resolve, reject) ->
            PACKAGES = PACKAGES_PARAGRAPHS.slice(0).reverse()
            packages = fs.createReadStream("src/test/data/Packages-excerpt")
            pps = new mut.ParagraphStream()
            pps.on "data", (para) ->
                para = para.toString()
                name = PACKAGES.pop()
                if para.indexOf("Package: #{name}") < 0
                    reject new Error "Unable to find - Package: #{name}"
            pps.on "end", ->
                resolve true if PACKAGES.length is 0
            packages.pipe pps

    it "should break things down paragraph by paragraph again", ->
        return new Promise (resolve, reject) ->
            SOURCES = SOURCES_PARAGRAPHS.slice(0).reverse()
            sources = fs.createReadStream("src/test/data/Sources-excerpt")
            sps = new mut.ParagraphStream()
            sps.on "data", (para) ->
                para = para.toString()
                name = SOURCES.pop()
                if para.indexOf("Package: #{name}") < 0
                    reject new Error "Unable to find - Package: #{name}"
            sps.on "end", ->
                resolve true if SOURCES.length is 0
            sources.pipe sps

    it "should not send empty paragraphs", ->
        return new Promise (resolve, reject) ->
            numPackages = PACKAGES_PARAGRAPHS.length
            packages = fs.createReadStream("src/test/data/Packages-excerpt-extra-lines")
            pps = new mut.ParagraphStream()
            pps.on "data", (para) ->
                numPackages--
                reject new Error "numPackages went negative" if numPackages < 0
            pps.on "end", ->
                resolve true if numPackages is 0
            packages.pipe pps

#----------------------------------------------------------------------
# end of paragraphStreamTest.coffee
