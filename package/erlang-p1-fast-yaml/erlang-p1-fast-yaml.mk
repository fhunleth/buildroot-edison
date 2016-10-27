################################################################################
#
# erlang-p1-fast-yaml
#
################################################################################

ERLANG_P1_FAST_YAML_VERSION = 1.0.6
ERLANG_P1_FAST_YAML_SITE = $(call github,processone,fast_yaml,$(ERLANG_P1_FAST_YAML_VERSION))
ERLANG_P1_FAST_YAML_LICENSE = Apache-2.0
ERLANG_P1_FAST_YAML_LICENSE_FILES = LICENSE.txt
ERLANG_P1_FAST_YAML_DEPENDENCIES = erlang-p1-utils libyaml
ERLANG_P1_FAST_YAML_INSTALL_STAGING = YES

ERLANG_P1_FAST_YAML_USE_AUTOCONF = YES

$(eval $(rebar-package))
