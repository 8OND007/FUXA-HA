# Use
Use FUXA SCADA inside Home Assistant.

# Configuration
* Port 1881 may be exposed externally.
All other configuration is performed within the Web UI. 

# Instructions
see https://frangoteam.org/

# Implement it into Home Assistant Dashboard using iframe (website card)
You can use the https://www.home-assistant.io/dashboards/iframe/ Lovelace card, this is only possible locally on a HTTP HA instance. HTTPS does not allow iframes to HTTP content.

# Implement it into Home Assistant Dashboard using HACS hass_ingress addon (sidebar button)
You can use the https://github.com/lovelylain/hass_ingress HACS integration, this allows full access to FUXA from anywhere (HTTP or HTTPS), in & externally.

add to config.yaml:

```
ingress:
  fuxa:
    title: FUXA
    work_mode: ingress
    url: http://localhost:1881
    index: /fuxa
    icon: mdi:monitor-dashboard
    require_admin: true
    rewrite:
      # 1. Rewrite FUXA <base> path
      - mode: body
        match: >-
          <base href="\/fuxa\/" />
        replace: >-
          <base href="$http_x_ingress_path/fuxa/" />
      # 2. Rewrite FUXA API cal (/script does not work)
      - mode: body
        match: >-
```
# Source
https://github.com/8OND007/FUXA-HA
