# paragraphStream.coffee
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

LINE_START = "LINE_START"
LINE_MIDDLE = "LINE_MIDDLE"

class exports.ParagraphStream extends Transform
    constructor: (options) ->
        super(options || {})
        @linebuffer = ""
        @parabuffer = []
        @state = LINE_START

    _transform: (chunk, encoding, callback) ->
        chunkstr = chunk.toString()
        for c in chunkstr
            if @state is LINE_START
                if c is "\n"
                    if @parabuffer.length > 0
                        @push @parabuffer.join("")
                        @parabuffer = []
                else
                    @state = LINE_MIDDLE
                    @linebuffer += c
            else
                @linebuffer += c
                if c is "\n"
                    @parabuffer.push @linebuffer
                    @linebuffer = ""
                    @state = LINE_START
        callback()

    _flush: (callback) ->
        if @linebuffer.length > 0
            @parabuffer.push @linebuffer
        if @parabuffer.length > 0
            @push @parabuffer.join("")
        callback()

#----------------------------------------------------------------------
# end of paragraphStream.coffee
