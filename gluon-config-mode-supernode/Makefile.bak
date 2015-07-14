include $(TOPDIR)/rules.mk

PKG_NAME:=config-mode-supernode
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(GLUONDIR)/include/package.mk

PKG_CONFIG_DEPENDS += $(GLUON_I18N_CONFIG)


define Package/config-mode-supernode
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=Set some settings affecting behavior of supernodes
  DEPENDS:=gluon-config-mode-core-virtual +gluon-node-info
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(call GluonBuildI18N,config-mode-supernode,i18n)
endef

define Package/config-mode-supernode/install
	$(CP) ./files/* $(1)/
	$(call GluonInstallI18N,config-mode-supernode,$(1))
endef

$(eval $(call BuildPackage,config-mode-supernode))
