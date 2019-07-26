# lineStream.coffee
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

{Transform} = require "stream"

class exports.LineStream extends Transform
    constructor: (options) ->
        super(options || {})
        @buffer = Buffer.alloc 0

    _transform: (chunk, encoding, callback) ->
        @buffer = Buffer.concat [@buffer, chunk]
        loop
            nextLineEnding = @buffer.indexOf "\n"
            if nextLineEnding >= 0
                @push @buffer.slice 0, nextLineEnding+1
                @buffer = @buffer.slice nextLineEnding+1
            else
                break
        callback()

    _flush: (callback) ->
        callback null, @buffer

#----------------------------------------------------------------------
# end of lineStream.coffee
