include $(TOPDIR)/rules.mk

PKG_NAME:=ffda-oob-firmware
PKG_VERSION:=1

PKG_CONFIG_DEPENDS := CONFIG_FFDA_OOB_FIRMWARE_VERSION

include $(INCLUDE_DIR)/package.mk

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/ffda-oob-firmware
  TITLE:=Base files of FFDA OOB Firmware
  DEPENDS:=+ffda-oob-state-reporter
endef

define Package/ffda-oob-firmware/config
config FFDA_OOB_FIRMWARE_VERSION
	string "Gluon version number"
	depends on PACKAGE_ffda-oob-firmware
	default ""
endef

define Package/ffda-oob-firmware/install
	$(Gluon/Build/Install)

	$(INSTALL_DIR) $(1)/lib/ffda-oob-firmware $(1)/usr/bin
	echo '$(call qstrip,$(CONFIG_FFDA_OOB_FIRMWARE_VERSION))' > $(1)/lib/ffda-oob-firmware/firmware-version

	$(INSTALL_BIN) ./files/ffda-oob-ntp.sh $(1)/usr/bin/ffda-oob-ntp
endef

$(eval $(call BuildPackage,ffda-oob-firmware))
