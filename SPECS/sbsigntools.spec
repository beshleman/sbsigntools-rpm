Summary: A signing utility for UEFI secure boot
Name: sbsigntools%{?_with_debug:-debug}
Version: 0.9.4
Release: 1
License: GPLv3
Group: Development/Tools
URL: https://git.kernel.org/pub/scm/linux/kernel/git/jejb/sbsigntools.git

# To generate this tar ball:
#   1) clone from URL
#   2) autogen.sh
#   3) replace symlinks with regular file (see 0001-replace-autogen-symlinks.patch)
#   4) tar cvf sbsigntools-%%{version}.tar . --transform 's,^,sbsigntools-%%{version}/,'
#   5) cat sbsigntools-%%{version}.tar | bzip2 > sbsigntools-%%{version}.tar.bz2
Source0: sbsigntools-%{version}.tar.bz2

BuildRequires: help2man
BuildRequires: binutils-devel

%description
Signing utility for UEFI secure boot.

%prep
%setup -q
%configure

%build
make

%install
make install DESTDIR=%{buildroot}

%clean
rm -rf %{buildroot}

%files
/usr/bin/sbsign
/usr/bin/sbverify
/usr/bin/sbattach
/usr/bin/sbkeysync
/usr/bin/sbsiglist
/usr/bin/sbvarsign
/usr/share/man/man1/sbsign.1.gz
/usr/share/man/man1/sbverify.1.gz
/usr/share/man/man1/sbattach.1.gz
/usr/share/man/man1/sbkeysync.1.gz
/usr/share/man/man1/sbsiglist.1.gz
/usr/share/man/man1/sbvarsign.1.gz

%changelog
* Wed Apr 28 2021 Bobby Eshleman <bobby.eshleman@gmail.com> 0.9.4-1
- Init commit
