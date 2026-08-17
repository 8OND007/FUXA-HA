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
          (/api/project|/api/projectData|/api/screen|/api/refresh|/api/settings|/api/screen|/api/resources|/api/heartbeat|/api/scheduler|/home|/home/:viewName|/lab|/editor|/device|/plugins|/rodevice|/users|/view|/_images|/_widgets|/snapshots|/hmi|/graph|/chart|/alarm|/notification|/language|/report|/maps|/client-access|/ar|/_helpers/utils)
        replace: >-
          $http_x_ingress_path\1
      # 3. Rewrite Socket.IO requests
      - mode: body
        match: >-
          /socket\.io
        replace: >-
          $http_x_ingress_path/socket\.io
```
# Source
https://github.com/8OND007/FUXA-HA
