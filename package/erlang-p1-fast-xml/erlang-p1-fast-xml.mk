################################################################################
#
# erlang-p1-fast-xml
#
################################################################################

ERLANG_P1_FAST_XML_VERSION = 1.1.15
ERLANG_P1_FAST_XML_SITE = $(call github,processone,fast_xml,$(ERLANG_P1_FAST_XML_VERSION))
ERLANG_P1_FAST_XML_LICENSE = Apache-2.0
ERLANG_P1_FAST_XML_LICENSE_FILES = LICENSE.txt
ERLANG_P1_FAST_XML_DEPENDENCIES = expat erlang-p1-utils
ERLANG_P1_FAST_XML_INSTALL_STAGING = YES

ERLANG_P1_FAST_XML_USE_AUTOCONF = YES

$(eval $(rebar-package))
