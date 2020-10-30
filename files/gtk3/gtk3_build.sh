#! /bin/bash

#----------------------------------------------------------------------
# Description: a script to build GTK3 libraries (as for 2014.06.26
# into /opt/gtk3
# Author: Artem S. Tashkinov
# Created at: Thu Jun 26 16:54:40 YEKT 2014
# Computer: localhost.localdomain
# System: Linux 3.15.0-ic on i686
#
# Copyright (c) 2014 Artem S. Tashkinov.  All rights reserved.
# Licensed under: LGPL 2.1 or later
#----------------------------------------------------------------------

test -f "/.nolvm" && exit 1 # Don't run on my real PC ;-)

export LD_LIBRARY_PATH=/opt/gtk3/lib
export PATH="/opt/gtk3/bin:$PATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/gtk3/lib/pkgconfig"
export CFLAGS="-O2 -march=pentium2 -pipe"
export CXXFLAGS="$CFLAGS"

die()
{
	echo "$*"
	exit 1
}

prepare()
{
	rpmbuild --rebuild http://dl.fedoraproject.org/pub/fedora/linux/releases/19/Fedora/source/SRPMS/f/fontconfig-2.10.93-1.fc19.src.rpm
	cd /root/rpmbuild/RPMS/i386 && rpm -Uvh fontconfig*
	rpm -Uvh http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/15/Fedora/i386/os/Packages/autoconf-2.68-2.fc15.noarch.rpm \
		 http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/15/Fedora/i386/os/Packages/m4-1.4.16-1.fc15.i686.rpm
}

patchme()
{
	if [ "$1" == "libIDL-0.8.14" ]; then
		echo "Patching $1 ..."
		wget -q http://pkgs.fedoraproject.org/cgit/libIDL.git/plain/libIDL-0.8.6-multilib.patch
		cat *patch | patch -p1
	fi

	if [ "$1" == "ORBit2-2.14.19" ]; then
		echo "Patching $1 ..."
		wget -q http://pkgs.fedoraproject.org/cgit/ORBit2.git/plain/ORBit2-2.14.3-multilib.patch
		wget -q http://pkgs.fedoraproject.org/cgit/ORBit2.git/plain/ORBit2-allow-deprecated.patch
		cat *patch | patch -p1
	fi

	if [ "$1" == "libbonobo-2.32.1" ]; then
		echo "Patching $1 ..."
		wget -q http://pkgs.fedoraproject.org/cgit/libbonobo.git/plain/0001-Remove-use-of-G_DISABLE_DEPRECATED.patch
		cat *patch | patch -p1
	fi

}

test -z "`rpm -qa | grep m4-1.4.16`" && prepare

echo "http://www.complang.org/ragel/ragel-6.8.tar.gz
http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.29.tar.bz2
ftp://sourceware.org/pub/libffi/libffi-3.1.tar.gz
http://ftp.gnome.org/pub/gnome/sources/glib/2.40/glib-2.40.0.tar.xz
http://ftp.gnome.org/pub/gnome/sources/atk/2.12/atk-2.12.0.tar.xz
http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.29.tar.bz2
http://ftp.gnome.org/pub/gnome/sources/pango/1.36/pango-1.36.3.tar.xz
http://cairographics.org/releases/pixman-0.32.2.tar.gz
http://cairographics.org/releases/cairo-1.12.16.tar.xz
http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.30/gdk-pixbuf-2.30.8.tar.xz
http://ftp.gnome.org/pub/gnome/sources/pango/1.36/pango-1.36.3.tar.xz
http://ftp.gnome.org/pub/GNOME/sources/intltool/0.40/intltool-0.40.0.tar.bz2
http://ftp.gnome.org/pub/gnome/sources/libIDL/0.8/libIDL-0.8.14.tar.bz2
http://ftp.gnome.org/pub/gnome/sources/ORBit2/2.14/ORBit2-2.14.19.tar.bz2
http://ftp.gnome.org/pub/gnome/sources/libbonobo/2.32/libbonobo-2.32.1.tar.bz2
http://ftp.gnome.org/pub/GNOME/sources/at-spi2-core/2.12/at-spi2-core-2.12.0.tar.xz
http://ftp.gnome.org/pub/GNOME/sources/at-spi2-atk/2.12/at-spi2-atk-2.12.1.tar.xz
http://ftp.gnome.org/pub/gnome/sources/gtk+/3.12/gtk+-3.12.2.tar.xz" | \

while read package; do
	basesrc=`echo $package | awk -F '/' '{print $NF}'`
	basedir=`echo $basesrc | sed 's/\(.*\)\.tar.*/\1/'`
	rm -rf "$basedir"
	logconf="/tmp/$basedir.conf.log"
	logmake="/tmp/$basedir.make.log"
	echo "Building : $basedir ..."
	wget -nc -q "$package" || die "Wget fail for $package"
	tar -xf "$basesrc"
	cd $basedir || exit 1
	patchme "$basedir"
	./configure --prefix=/opt/gtk3 &> $logconf || die "Conf failed for $basedir"
	make -j4 &> $logmake || die "Make failed for $basedir"
	make install  &> /dev/null || die "Make install failed for $basedir"
	cd ..
	rm -rf "$basedir" "$logconf" "$logmake"
done
