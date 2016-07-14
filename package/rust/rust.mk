################################################################################
#
# rust
#
################################################################################

RUST_VERSION = 1.10.0
RUST_SOURCE = rustc-$(RUST_VERSION)-src.tar.gz
RUST_SITE = https://static.rust-lang.org/dist
RUST_LICENSE = Apache-2.0, MIT
RUST_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

HOST_RUST_DEPENDENCIES = host-rust-bootstrap host-python toolchain host-jemalloc

define HOST_RUST_GEN_CONF
	package/rust/rust-target-gen \
		--mode conf \
		--prefix=$(notdir $(TARGET_CROSS)) \
		--input $(@D) \
		--output $(@D)/mk/cfg/$(GNU_TARGET_NAME).mk \
		$(GNU_TARGET_NAME)
endef

define HOST_RUST_GEN_SPEC
	package/rust/rust-target-gen \
		--mode spec \
		--input $(@D) \
		--output $(HOST_DIR)/etc/rustc/$(GNU_TARGET_NAME).json \
		$(GNU_TARGET_NAME)
endef

HOST_RUST_PRE_CONFIGURE_HOOKS += \
	HOST_RUST_GEN_CONF \
	HOST_RUST_GEN_SPEC

HOST_RUST_MAKE_ENV = RUST_TARGET_PATH=$(HOST_DIR)/etc/rustc
HOST_RUST_MAKE_OPTS = $(if $(VERBOSE),VERBOSE=1)

# Though not using autotools, Rust follows the ./configure convention, in its
# own way...
define HOST_RUST_CONFIGURE_CMDS
	(cd $(@D); $(HOST_CONFIGURE_OPTS) \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--prefix="$(HOST_DIR)/usr" \
		--jemalloc-root="$(HOST_DIR)/usr/lib" \
		--enable-local-rust \
		--local-rust-root="$(HOST_RUST_BOOTSTRAP_DIR)/rustc" \
		--disable-docs \
		--disable-manage-submodules \
		--sysconfdir="$(HOST_DIR)/etc" \
		--localstatedir="$(HOST_DIR)/var/lib" \
		--datadir="$(HOST_DIR)/usr/share" \
		--infodir="$(HOST_DIR)/usr/share/info")
endef

define HOST_RUST_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_RUST_MAKE_ENV) $(MAKE) \
		$(HOST_RUST_MAKE_OPTS) -C $(@D)
endef

define HOST_RUST_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(HOST_RUST_MAKE_ENV) $(MAKE) \
		$(HOST_RUST_MAKE_OPTS) -C $(@D) install
endef

$(eval $(host-generic-package))
