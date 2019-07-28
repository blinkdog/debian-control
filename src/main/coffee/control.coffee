# control.coffee
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

FIELD_LINE_SPEC = /^([^\s:]+):(.*)$/

exports.isContinueLine = isContinueLine = (text) ->
    return (text[0] is " ") or (text[0] is "\t")

exports.isFieldLine = isFieldLine =  (text) ->
    return FIELD_LINE_SPEC.test text

exports.parse = parse = (text) ->
    text = stripSignature text
    text = text.trim()
    lines = text.split "\n"
    controlObj = {}
    build = {}
    for line in lines
        if isFieldLine line
            if build.field?
                controlObj[build["field"]] = build["value"]
                build = {}
            field = parseFieldLine line
            build["field"] = field[1].trim()
            build["value"] = field[2].trimLeft()
        if isContinueLine line
            if not Array.isArray build["value"]
                build["value"] = [build["value"]]
            build["value"].push line.trim()
    controlObj[build["field"]] = build["value"]
    return controlObj

exports.parseFieldLine = parseFieldLine = (text) ->
    return FIELD_LINE_SPEC.exec text

exports.stringify = stringify = (obj) ->
    buffer = []
    for key of obj
        if Array.isArray obj[key]
            firstValue = obj[key].shift()
            if firstValue.trim().length > 0
                buffer.push "#{key}: #{firstValue}"
            else
                buffer.push "#{key}:"
            for line in obj[key]
                buffer.push " #{line}"
        else
            buffer.push "#{key}: #{obj[key]}"


    return buffer.join("\n")

exports.stripSignature = stripSignature = (text) ->
    # check the message for PGP signature
    trimmed = text.trim()
    lines = trimmed.split "\n"
    if lines[0] isnt "-----BEGIN PGP SIGNED MESSAGE-----"
        return text
    # looks like we got one, so strip off the signature lines
    state = "HEADER"
    message = []
    for line in lines
        if state is "HEADER"
            if line.trim().length is 0
                state = "MESSAGE"
        else
            if line.trim() is "-----BEGIN PGP SIGNATURE-----"
                break
            else
                if line.trim().length > 0
                    message.push line
    # return the message part
    return message.join("\n")

#----------------------------------------------------------------------
# end of control.coffee
