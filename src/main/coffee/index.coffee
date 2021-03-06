# index.coffee
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

exports.LineStream = require("./lineStream").LineStream
exports.ParagraphStream = require("./paragraphStream").ParagraphStream
exports.VERSION = require("../package.json").version
exports.isContinueLine = require("./control").isContinueLine
exports.isFieldLine = require("./control").isFieldLine
exports.parse = require("./control").parse
exports.stringify = require("./control").stringify
exports.stripSignature = require("./control").stripSignature

#----------------------------------------------------------------------
# end of index.coffee
