################################################################################
#
# erlang-p1-fast-tls
#
################################################################################

ERLANG_P1_FAST_TLS_VERSION = 1.0.7
ERLANG_P1_FAST_TLS_SITE = $(call github,processone,fast_tls,$(ERLANG_P1_FAST_TLS_VERSION))
ERLANG_P1_FAST_TLS_LICENSE = Apache2.0
ERLANG_P1_FAST_TLS_LICENSE_FILES = LICENSE.txt
ERLANG_P1_FAST_TLS_INSTALL_STAGING = YES
ERLANG_P1_FAST_TLS_DEPENDENCIES = openssl erlang-p1-utils

$(eval $(rebar-package))
