#  Notify people

Let people know of a pending release, e.g. mailto://libcdio-devel@gnu.org; no
major changes before release, please


# Change version in VERSION.py

    $ emacs VERSION.py
	source VERSION.py
	git commit -m'Get ready for release $VERSION" .

# test on lots of platforms (Solaris, cygwin, Darwin GNU/Linux)

# Look for/fix/apply patches and outstanding bugs on Savannah.

# Update ChangeLog:

    rm ChangeLog ; make ChangeLog

#  Update NEWS.md from ChangeLog.

# Make sure sources are current and checked in:

    git status
    git pull
    git commit .
    git push

#  Test it:

    make clean
    make build
    make check

Test all python versions:

	./admin-tools/check-versions.sh

#  Tag release in git:

look in __pkginfo__.py for version =
(also look at .git/refs/tags to see existing release numbers)

    VERSION='2.0.0'
    echo git tag release-$VERSION
     git tag release-$VERSION
     git push
     git push --tags

- "make check" one more time

# Upload single package and look at Rst Formating

    $ twine upload dist/pycdio-${VERSION}-py3.3.egg

# Upload rest of versions

    $ twine upload dist/pycdio-${VERSION}*


# Get onto ftp.gnu.org. I use my perl program

    gnupload from the automake distribution.
    locate gnupload
    /src/external-vcs/coreutils/build-aux/gnupload --to ftp.gnu.org:libcdio pycdio-${VERSION}.tar.*  # (Use "is" password)

#  Bump version in __pkginfo__.py.

# Check on a VM

    $ cd /virtual/vagrant/virtual/vagrant/ubuntu-zesty
	$ vagrant up
	$ vagrant ssh
	$ pyenv local 3.5.2
	$ pip install --upgrade xdis
	$ exit
	$ vagrant halt
