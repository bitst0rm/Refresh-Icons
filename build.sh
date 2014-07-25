#!/bin/sh

# Script to build deb packages.
# https://github.com/bitst0rm
# Copyright (c) 2014 bitst0rm <bitst0rm@users.noreply.github.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMP_DIR=${TOP_DIR}/tmp

mkdir $TMP_DIR
cd $TMP_DIR

# get dpkg-deb for Mac OS X
echo "Checking for dpkg-deb..."
if [ -z "$(type -P dpkg-deb)" ]; then
	echo "Downloading dpkg-deb..."
	curl -O http://test.saurik.com/francis/dpkg-deb-fat
	chmod a+x dpkg-deb-fat
	echo ""
	echo "Installing dpkg-deb..."
	sudo mkdir -p /usr/local/bin
	sudo mv dpkg-deb-fat /usr/local/bin/dpkg-deb
	if [ -z "$(type -P dpkg-deb)" ]; then
		echo "Fatal: Could not install dpkg-deb."
		exit 1;
	fi
fi

cd $TOP_DIR
find . -name ".DS_Store" -delete
find . -name "._*" -delete

# build deb
echo ""
echo "Building package..."
dpkg-deb -b ./build com.bitst0rm.refreshicons_1.0_iphoneos-arm.deb
rm -rf $TMP_DIR
echo "Done."
