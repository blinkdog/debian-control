# debian-control
Parse package control files from Debian

## Motivation
TODO: Explain why someone would use this software

## API and Examples
TODO: Explain how someone would use this software

### Control Parsing
TODO: Explain how someone would use the control parsing functions

#### isContinueLine
TODO: Explain how someone would use the isContinueLine function

#### isFieldLine
TODO: Explain how someone would use the isFieldLine function

#### parse
TODO: Explain how someone would use the parse function

#### stringify
TODO: Explain how someone would use the stringify function

#### stripSignature
TODO: Explain how someone would use the stripSignature function

### LineStream
TODO: Explain how someone would use the LineStream class

### ParagraphStream
TODO: Explain how someone would use the ParagraphStream class

## Development
In order to make modifications to `debian-control`, you'll need to establish
a development environment:

    git clone https://github.com/blinkdog/debian-control
    cd debian-control
    npm install
    node_modules/.bin/cake rebuild

The `cake` command will list the tasks available in the `Cakefile`:

    node_modules/.bin/cake

### Code Coverage
You can see a test coverage report for `debian-control` using a task from
the Cakefile:

    node_modules/.bin/cake coverage

This task will attempt to open the coverage report in a new tab in Mozilla
Firefox. If you want to use another browser, you'll need to modify the
`BROWSER_COMMAND` at the top of the `Cakefile` to specify your preferred
browser for viewing the coverage report.

### Source files
The source files are located in `src/main/coffee`.

The test source files are located in `src/test/coffee`.

## References
* [Debian Policy Manual Chapter 5: Control files and their fields](https://www.debian.org/doc/debian-policy/ch-controlfields.html)
* [RFC 5322: Internet Message Format](https://tools.ietf.org/html/rfc5322)

## License
debian-control  
Copyright 2019 Patrick Meade.  

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
