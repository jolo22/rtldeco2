# rtldeco2

An RTL-SDR Based ADS-B and AIS receiver based on MalcolmRobb's dump1090 (https://github.com/MalcolmRobb/dump1090) and digiarni's rtl_ais (https://github.com/dgiardini/rtl-ais) combined in one automated installation to receive Aircraft's ADS-B data and Ships AIS data, and forward it to flight and marine networks to increase their coverage.

### Requirements:
- 2 RTL-SDR Receivers
- Raspberry Pi 3, 2, Zero or Zero W

### Instruction:
1. Download latest release
2. to execute type ./rtldeco2.sh
3. Follow instructions on-screen

### How to use:
Normally the decoders are started automatically upon reboot, if not type the following..
- For dump1090
```
/usr/local/rtldeco2/dump1090/dump1090
```     
- For rtl-ais    
```
/usr/local/rtldeco2/rtl-ais/rtl_ais -d 1
```
More features will be added in future revisions.
