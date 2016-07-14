################################################################################
#
# rust-bootstrap
#
################################################################################

RUST_BOOTSTRAP_VERSION = 1.9.0
RUST_BOOTSTRAP_DATE = 2016-05-24

ifeq ($(HOSTARCH),x86_64)
RUST_BOOTSTRAP_ARCH = x86_64
else ifeq ($(HOSTARCH),x86)
RUST_BOOTSTRAP_ARCH = i686
else
$(error Unsupported host architecture)
endif

RUST_BOOTSTRAP_SITE = https://static.rust-lang.org/dist/$(RUST_BOOTSTRAP_DATE)

RUST_BOOTSTRAP_SOURCE = rustc-$(RUST_BOOTSTRAP_VERSION)-$(RUST_BOOTSTRAP_ARCH)-unknown-linux-gnu.tar.gz
RUST_BOOTSTRAP_LICENSE = Apache-2.0, MIT
RUST_BOOTSTRAP_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

$(eval $(host-generic-package))
