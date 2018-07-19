#!/usr/bin/env bash

# =============================================================================
#
# rtldeco2 Installation Script
#
# An RTL-SDR based ADS-B and AIS Decoder bundled with dump1090 and rtl_ais
# to be able to demodulate interactive 1090 MHz ADS-B and Class A and B AIS Signals.
#
# =============================================================================

set -e
set -o pipefail

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

echo "Beginning installation of dump1090 and rtl_ais"

while true; do
    read -p "Do you wish to install dump1090 and rtl_ais?" yn
    case $yn in
        [Yy]* ) apt-get update && apt-get upgrade && apt-get install -y librtlsdr0 librtlsdr-dev wget git dpkg gcc make pkg-config && cd /usr/local && mkdir rtldeco2 && cd rtldeco2 && git clone https://github.com/MalcolmRobb/dump1090.git && cd dump1090 && make && cd .. && git clone https://github.com/dgiardini/rtl-ais && cd rtl-ais && make; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Starting both dump1090 and rtl_ais... make sure you have 2 RTL-SDR Plugged in"

cd .. && nohup ./dump1090/dump1090 --interactive --net </dev/null &>/dev/null &
cd .. && nohup ./rtl-ais/rtl_ais -d 1 </dev/null &>/dev/null &

echo "Setting up dump1090 and rtl_ais to work after reboot"

sed -i -e '$i \nohup /usr/local/rtldeco2/dump1090/dump1090 --interactive --net </dev/null &>/dev/null &' /etc/rc.local;
sed -i -e '$i \nohup /usr/local/rtldeco2/rtl-ais/rtl_ais -d 1 </dev/null &>/dev/null &' /etc/rc.local;

echo "Successfully installed and started dump1090 and rtl_ais, all files can be found in /usr/local/rtldeco2 folder"
echo "If RTL_AIS doesn't start after installation, just execute it by typing /usr/local/rtldeco2/rtl-ais/rtl_ais -d 1"
