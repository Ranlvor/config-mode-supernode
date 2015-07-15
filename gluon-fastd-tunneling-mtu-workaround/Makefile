include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-fastd-tunneling-mtu-workaround
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/gluon-fastd-tunneling-mtu-workaround
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:=gluon-fastd-tunneling-mtu-workaround
  DEPENDS:=+gluon-core
endef

define Package/gluon-fastd-tunneling-mtu-workaround/description
	Gluon community wifi mesh firmware framework: gluon-fastd-tunneling-mtu-workaround
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-fastd-tunneling-mtu-workaround/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,gluon-fastd-tunneling-mtu-workaround))
