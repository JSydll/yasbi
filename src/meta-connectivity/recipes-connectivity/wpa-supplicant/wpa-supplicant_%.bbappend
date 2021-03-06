# -------------------
# Configures the WPA client for wifi connections
# -------------------

# Depends on the following custom env vars exported to the yocto build:
# - WIFI_ENABLED
# - WIFI_SSID
# - WIFI_PWD

# Configures wifi (with nl-802.11 standard)
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://wpa_supplicant-nl80211-wlan0.conf"

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE_${PN}_append = " wpa_supplicant-nl80211@wlan0.service  "

# Use the preplace class to patch template source files
inherit preplace
require generate_config.inc

TEMPLATE_FILE = "${WORKDIR}/wpa_supplicant-nl80211-wlan0.conf"

python do_patch_append() {
    params = generate_config(d)
    preplace_execute(d.getVar('TEMPLATE_FILE', True), params)
}

do_install_append () {
    install -d ${D}${sysconfdir}/wpa_supplicant/
    install -D -m 600 ${WORKDIR}/wpa_supplicant-nl80211-wlan0.conf ${D}${sysconfdir}/wpa_supplicant/

    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
    ln -s ${systemd_unitdir}/system/wpa_supplicant@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant-nl80211@wlan0.service
}