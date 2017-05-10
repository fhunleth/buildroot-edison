import unittest
import os
import datetime

from infra.builder import Builder
from infra.emulator import Emulator

BASIC_TOOLCHAIN_CONFIG = \
"""
BR2_arm=y
BR2_TOOLCHAIN_EXTERNAL=y
BR2_TOOLCHAIN_EXTERNAL_CUSTOM=y
BR2_TOOLCHAIN_EXTERNAL_DOWNLOAD=y
BR2_TOOLCHAIN_EXTERNAL_URL="http://autobuild.buildroot.org/toolchains/tarballs/br-arm-full-2015.05-1190-g4a48479.tar.bz2"
BR2_TOOLCHAIN_EXTERNAL_GCC_4_7=y
BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_10=y
BR2_TOOLCHAIN_EXTERNAL_LOCALE=y
# BR2_TOOLCHAIN_EXTERNAL_HAS_THREADS_DEBUG is not set
BR2_TOOLCHAIN_EXTERNAL_INET_RPC=y
BR2_TOOLCHAIN_EXTERNAL_CXX=y
"""

MINIMAL_CONFIG = \
"""
BR2_INIT_NONE=y
BR2_SYSTEM_BIN_SH_NONE=y
# BR2_PACKAGE_BUSYBOX is not set
# BR2_TARGET_ROOTFS_TAR is not set
"""

class BRTest(unittest.TestCase):
    config = None
    downloaddir = None
    outputdir = None
    logtofile = True
    keepbuilds = False

    def show_msg(self, msg):
        print "[%s/%s/%s] %s" % (os.path.basename(self.__class__.outputdir),
                                 self.testname,
                                 datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                                 msg)
    def setUp(self):
        self.testname = self.__class__.__name__
        self.builddir = os.path.join(self.__class__.outputdir, self.testname)
        self.runlog = self.builddir + "-run.log"
        self.emulator = None
        self.show_msg("Starting")
        self.b = Builder(self.__class__.config, self.builddir, self.logtofile)

        if not self.keepbuilds:
            self.b.delete()

        if not self.b.is_finished():
            self.show_msg("Building")
            self.b.build()
            self.show_msg("Building done")

        self.emulator = Emulator(self.builddir, self.downloaddir, self.logtofile)

    def tearDown(self):
        self.show_msg("Cleaning up")
        if self.emulator:
            self.emulator.stop()
        if self.b and not self.keepbuilds:
            self.b.delete()