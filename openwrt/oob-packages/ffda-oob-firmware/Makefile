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

define Package/ffda-oob-firmware/conffiles
/lib/ffda-oob-firmware/userdata
/lib/ffda-oob-firmware/configured
endef

define Package/ffda-oob-firmware/config
config FFDA_OOB_FIRMWARE_VERSION
	string "Gluon version number"
	depends on PACKAGE_ffda-oob-firmware
	default ""
endef

define Package/ffda-oob-firmware/install
	$(Gluon/Build/Install)

	$(INSTALL_DIR) $(1)/lib/ffda-oob-firmware $(1)/lib/ffda-oob-firmware/userdata $(1)/lib/ffda-oob-firmware/conffiles/config $(1)/usr/bin $(1)/etc/uci-defaults
	
	echo '$(call qstrip,$(CONFIG_FFDA_OOB_FIRMWARE_VERSION))' > $(1)/lib/ffda-oob-firmware/firmware-version
	touch $(1)/lib/ffda-oob-firmware/userdata/.keep

	$(INSTALL_BIN) ./files/ffda-oob-ntp.sh $(1)/usr/bin/ffda-oob-ntp
	$(INSTALL_BIN) ./files/uci-defaults.sh $(1)/etc/uci-defaults/99_ffda-oob-firmware
	$(INSTALL_BIN) ./files/label-mac.sh $(1)/lib/ffda-oob-firmware/
	$(INSTALL_BIN) ./files/ffda-notes.sh $(1)/usr/bin/ffda-notes

	$(CP) ./files/authorized_keys $(1)/lib/ffda-oob-firmware/conffiles/authorized_keys
	$(CP) ./files/config/* $(1)/lib/ffda-oob-firmware/conffiles/config/
	$(INSTALL_BIN) ./files/banner.txt $(1)/lib/ffda-oob-firmware/
endef

$(eval $(call BuildPackage,ffda-oob-firmware))
