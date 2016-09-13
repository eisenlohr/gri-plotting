# Prerequisites:

* install the plotting engine `gri` (needs `autoconf` and `automake` packages)

```bash
  git clone git@github.com:dankelley/gri.git
  cd gri
  aclocal
  autoconf
  automake --add-missing
  ./configure
  make
  make install
```

# Installation

* clone the `gri-plotting` repository

```bash
git clone git@gitlab.msu.edu:metal/gri-plotting.git
```

* add the location of `gri-plotting` to your `$PATH`

# Useful configurations:

* define an environment variable `$GRI` pointing to the location of the repository clone
