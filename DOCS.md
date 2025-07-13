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
    index: /
    icon: mdi:monitor-dashboard
    disable_stream: True
    rewrite:
      # 1. Rewrite the <base> tag in the body section
      - mode: body
        match: >-
          <base href="\/">
        replace: >-
          <base href="$http_x_ingress_path/">
      # 2. Rewrite for API calls (e.g., /api/project)
      - mode: body
        match: >-
          (/api/projectData|/api/project|/api/screen|/api/settings|/api/screen|/api/resources|/api/heartbeat)
        replace: >-
          $http_x_ingress_path\1
      # 3. Rewrite for socket.io requests
      - mode: body
        match: >-
          /socket\.io
        replace: >-
          $http_x_ingress_path/socket\.io
```
# Source
https://github.com/8OND007/FUXA-HA
