### WPA3 Virtual Interface Setup on Linux (mac80211_hwsim)

DO POPRAWIENIA !!!
- narazie naljepiej po prostu postawic dwa interfacy modprobem i potem odrazu hostapd i supplicant, custom parametry interfacow psuja rzeczy
#### 1. Clean up previous instances

```bash
sudo pkill -f wpa_supplicant
sudo pkill -f hostapd
sudo rm -f /var/run/wpa_supplicant/wlan1
sudo ip link set wlan0 down 2>/dev/null
sudo ip link set wlan1 down 2>/dev/null
sudo modprobe -r mac80211_hwsim
```

---

#### 2. Load mac80211_hwsim with 2 radios

```bash
sudo modprobe mac80211_hwsim radios=2
```

* `wlan0` will be AP
* `wlan1` will be station

---

#### 3. Assign unique MAC addresses **before bringing interfaces up**

```bash
sudo ip link set dev wlan0 address 02:11:22:33:44:55
sudo ip link set dev wlan1 address 02:66:77:88:99:AA
```

---

#### 4. Bring interfaces up

```bash
sudo ip link set wlan0 up
sudo ip link set wlan1 up
```

---

#### 5. Assign IP addresses

```bash
sudo ip addr add 192.168.50.1/24 dev wlan0
sudo ip addr add 192.168.50.2/24 dev wlan1
```

---

#### 6. Create configuration files

`hostapd-wpa3-personal.conf`

```ini
ctrl_interface=/var/run/hostapd
driver=nl80211
ssid=testnetwork
channel=1
hw_mode=g
ieee80211n=1
ieee80211w=2
auth_algs=1
wpa=2
wpa_key_mgmt=SAE
rsn_pairwise=CCMP
wpa_passphrase=passphrase
```

`supplicant-wpa3-personal.conf`

```ini
ctrl_interface=/var/run/wpa_supplicant
network={
    ssid="testnetwork"
    proto=RSN
    key_mgmt=SAE
    pairwise=CCMP
    group=CCMP
    psk="passphrase"
    ieee80211w=2
    freq=2412
}
```

---

#### 7. Run hostapd

In terminal 1:

```bash
sudo hostapd hostapd-wpa3-personal.conf -dd
```

---

#### 8. Run wpa_supplicant

In terminal 2:

```bash
sudo wpa_supplicant -i wlan1 -c supplicant-wpa3-personal.conf -dd
```

---

#### 9. Test connectivity

```bash
ping -I wlan1 192.168.50.1
```

---

#### 10. Clean up

```bash
sudo pkill hostapd
sudo pkill wpa_supplicant
sudo ip link set wlan0 down
sudo ip link set wlan1 down
sudo modprobe -r mac80211_hwsim
sudo rm -f /var/run/wpa_supplicant/wlan1
```

---

#### Summary

| Interface | Role         | IP           | Config                        |
| --------- | ------------ | ------------ | ----------------------------- |
| wlan0     | Access Point | 192.168.50.1 | hostapd-wpa3-personal.conf    |
| wlan1     | Station      | 192.168.50.2 | supplicant-wpa3-personal.conf |

---
