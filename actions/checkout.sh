#! /bin/sh

_checkout_meta() {
  git checkout --quiet $@
  git submodule update --checkout
}
