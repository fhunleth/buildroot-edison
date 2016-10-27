################################################################################
#
# erlang-jiffy
#
################################################################################

ERLANG_JIFFY_VERSION = 0.14.8
ERLANG_JIFFY_SITE = $(call github,davisp,jiffy,$(ERLANG_JIFFY_VERSION))
ERLANG_JIFFY_LICENSE = Apache-2.0
ERLANG_JIFFY_LICENSE_FILES = LICENSE.txt
ERLANG_JIFFY_INSTALL_STAGING = YES

$(eval $(rebar-package))
