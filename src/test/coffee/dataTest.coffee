# dataTest.coffee
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

EXTENDED_TIMEOUT = 10000

{exec} = require "child_process"
fs = require "fs"
{Readable} = require "stream"
should = require "should"

{ParagraphStream} = require "../lib/paragraphStream"
{parse, stringify} = require "../lib/control"

execAsync = (command) ->
    return new Promise (resolve, reject) ->
        exec command, (err, stdout, stderr) ->
            return reject err if err?
            resolve {stdout: stdout, stderr: stderr}

xdescribe "data", ->
    it "should unpack the data properly", ->
        this.timeout EXTENDED_TIMEOUT
        await execAsync "mkdir -p test/data"
        await execAsync "xz --decompress --to-stdout src/test/data/Packages.xz >test/data/Packages"
        await execAsync "xz --decompress --to-stdout src/test/data/Sources.xz >test/data/Sources"
        return true

    it "should have 56805 paragraphs in Packages", ->
        this.timeout EXTENDED_TIMEOUT
        return new Promise (resolve, reject) ->
            numPackages = 0
            packages = fs.createReadStream "test/data/Packages"
            ps = new ParagraphStream()
            ps.on "data", (para) ->
                numPackages++
            ps.on "end", ->
                return resolve true if numPackages is 56805
                reject new Error "found #{numPackages} packages"
            packages.pipe ps

    it "should have 28497 paragraphs in Sources", ->
        this.timeout EXTENDED_TIMEOUT
        return new Promise (resolve, reject) ->
            numPackages = 0
            packages = fs.createReadStream "test/data/Sources"
            ps = new ParagraphStream()
            ps.on "data", (para) ->
                numPackages++
            ps.on "end", ->
                return resolve true if numPackages is 28497
                reject new Error "found #{numPackages} packages"
            packages.pipe ps

    it "should round trip the paragraphs in Packages", ->
        this.timeout EXTENDED_TIMEOUT
        return new Promise (resolve, reject) ->
            numPackages = 0
            packages = fs.createReadStream "test/data/Packages"
            ps = new ParagraphStream()
            ps.on "data", (para) ->
                para = para.toString().trim()
                obj = parse para
                control = stringify obj
                control.should.eql para
            ps.on "end", ->
                resolve true
            packages.pipe ps

    it "should round trip the paragraphs in Sources", ->
        this.timeout EXTENDED_TIMEOUT
        return new Promise (resolve, reject) ->
            numPackages = 0
            packages = fs.createReadStream "test/data/Sources"
            ps = new ParagraphStream()
            ps.on "data", (para) ->
                para = para.toString().trim()
                lines = para.split "\n"
                lines = (x.trimRight() for x in lines)
                lines = (x.replace(/^\s+/, " ") for x in lines)
                para = lines.join("\n")
                obj = parse para
                control = stringify obj
                control.should.eql para
            ps.on "end", ->
                resolve true
            packages.pipe ps

#----------------------------------------------------------------------
# end of dataTest.coffee
