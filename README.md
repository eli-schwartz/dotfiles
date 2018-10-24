# Dotfiles

Powered by [dotfiles.sh](https://github.com/eli-schwartz/dotfiles.sh). I've
finally pushed my stuff to public hosting, after writing a manager to track
everything directly in `$HOME`, so everything is running live in a barebones
git clone. It's surprisingly simple.

This contains a bunch of miscellaneous junk which "may" be interesting to other
people, but the mainly interesting things are some scripts in `~/bin`.

## Scripts

- `pkg-list-linked-libraries` -- Arch Linux helper utility to extract a tarball
  and `objdump` every file inside, listing the shared libraries it links.
  Assumes the tarball is an Arch Linux package archive, so it accepts pacman
  syntax for repository packages in addition to actual files, and downloads
  then checks that. Useful for determining when "missing shared library"
  reports are invalid or misfiled.

- `getpaste` -- Shamelessly stolen from @grawity to download pastes from a
  variety of pastebins, resolving view links to raw links in the process.

- `imgurbash` -- Because imgurbash2 used to suck due to not offering logging of
  uploaded files, and honestly the current implementation still sucks, but in a
  very bikesheddy sort of way. So I forked it. Also the name should not end
  with a "2" because that's... not really important info?

- `sogrep` -- Grep the entire Arch repositories to see which packages link to a
  given soname. Basically a clone of another tool provided on
  https://pkgbuild.com, but doesn't require a shell account.

- `cleanfiles.sh` -- You know that feeling you get when your files are full of
  trailing whitespace? This can "clean" that up, recursively.

- `update-repos.sh` -- My quick hack for maintaining a local repository. Please
  use aurutils instead...
