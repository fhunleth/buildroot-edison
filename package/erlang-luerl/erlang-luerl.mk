################################################################################
#
# erlang-luerl
#
################################################################################

ERLANG_LUERL_VERSION = v0.3
ERLANG_LUERL_SITE = $(call github,rvirding,luerl,$(ERLANG_LUERL_VERSION))
ERLANG_LUERL_LICENSE = Apache-2.0
ERLANG_LUERL_LICENSE_FILES = LICENSE
ERLANG_LUERL_INSTALL_STAGING = YES

$(eval $(rebar-package))
