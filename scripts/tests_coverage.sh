#!/bin/bash
set -euxo pipefail
trap 'cd ${PWD}' EXIT

coverage erase
coverage run -m pytest
coverage run -a -m simg ./tests/datas/ --mode averageHash --flip-v --flip-h --recurse | grep "./tests/datas/2/imageWhiteCircle1fvfh.png;60;60;6;56;28;60;0;0;56;0;4;0;"
coverage run -a -m qsimg ./tests/datas/ "./tests/datas/2/imageWhiteCircle1fvfh.png" --mode pHash --flip-v --flip-h --recurse | { tr '\n' ';' ; echo; } | grep "./tests/datas/imageWhiteCircle1fv.png;./tests/datas/imageWhiteCircle1fh.png;./tests/datas/imageWhiteCircle1.png;./tests/datas/2/imageWhiteCircle1fvfh.png;./tests/datas/imageWhiteCircle2.png;./tests/datas/imageBlackRectangle1.png;./tests/datas/imageWhite.png;./tests/datas/imageRedBlue.png;./tests/datas/imageBlack.png;./tests/datas/imageBlackRectangle2.png;./tests/datas/imageWhiteCircle3.png;./tests/datas/imageBlackCircle1.png;"
coverage run -a -m qsimg ./tests/datas/ --rand --seed 42 --mode pHash --flip-v --flip-h --recurse --verbose | { tr '\n' ';' ; echo; } | grep "./tests/datas/imageWhiteCircle2.png;0;;./tests/datas/imageWhiteCircle1fv.png;19;;./tests/datas/imageWhiteCircle1fh.png;19;;./tests/datas/imageWhiteCircle1.png;19;;./tests/datas/2/imageWhiteCircle1fvfh.png;19;;./tests/datas/imageWhite.png;22;;./tests/datas/imageRedBlue.png;22;;./tests/datas/imageBlack.png;22;;./tests/datas/imageWhiteCircle3.png;23;;./tests/datas/imageBlackRectangle1.png;29;;./tests/datas/imageBlackCircle1.png;29;;./tests/datas/imageBlackRectangle2.png;31;;"
coverage run -a -m imgphash ./tests/datas/imageBlack.png --mode pHash | grep "0;pHash;"
coverage run -a -m imgphash ./tests/datas/imageBlackRectangle1.png --mode pHash | grep "8319147471542838937;pHash;"
coverage run -a -m imgphash ./tests/datas/imageBlackRectangle2.png --mode pHash --flip-v --verbose | grep "11067990150089382910;11053635145317129211;pHash;"
coverage run -a -m imgphash ./tests/datas/imageBlack.png --mode pHash --compare ./tests/datas/imageBlackRectangle1.png
coverage run -a -m imgphash ./tests/datas/imageBlack.png --mode pHash --compare ./tests/datas/imageBlackRectangle2.png
coverage run -a -m imgphash ./tests/datas/imageBlackRectangle1.png --mode pHash --compare ./tests/datas/imageBlackRectangle2.png --flip-v
coverage run -a -m imgphash ./tests/datas/imageBlackRectangle1.png --mode pHash --compare ./tests/datas/imageBlackRectangle2.png --flip-h
coverage run -a -m imgphash ./tests/datas/imageBlackRectangle1.png --mode pHash --compare ./tests/datas/imageBlackRectangle2.png --flip-v --flip-h --verbose | grep "45.0;31.0;30.0;20.0;32.0;44.0;19.0;31.0;30.0;18.0;43.0;31.0;19.0;29.0;30.0;44.0;"
coverage run -a -m dupimg ./tests/datas/123 2&>1 || true
coverage run -a -m dupimg ./tests/datas/ --mode pHash --flip-v --flip-h | grep "./tests/datas/imageWhiteCircle1fv.png;./tests/datas/imageWhiteCircle1fh.png;./tests/datas/imageWhiteCircle1.png;./tests/datas/2/imageWhiteCircle1fvfh.png;"
coverage run -a -m dupimg ./tests/datas/ --mode averageHash --recurse | grep "./tests/datas/imageBlackCircle1.png;./tests/datas/imageBlackRectangle2.png"

coverage report -m