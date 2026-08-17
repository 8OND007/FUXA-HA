# Use
Use FUXA SCADA inside Home Assistant.

# Configuration
* Port 1881 may be exposed externally.
All other configuration is performed within the Web UI. 

# Instructions
see https://frangoteam.org/

# Implement it into Home Assistant Dashboard using iframe (website card)
You can use the https://www.home-assistant.io/dashboards/iframe/ Lovelace card, this is only possible locally on a HTTP HA instance. HTTPS does not allow iframes to HTTP content.

# Implement it into Home Assistant Dashboard using HACS hass_ingress app (sidebar button)
You can use the https://github.com/lovelylain/hass_ingress HACS integration, this allows full access to FUXA from anywhere (HTTP or HTTPS), in & externally.
it's still experimental, and some elements don't seem to work remotely (some missing widgets, icons, controls, save function 
sometimes fails and have to resave a second time,...), if someone has Ingress fully working without any problem, please share your ingress config.

add to config.yaml:

```
ingress:
  fuxa:
    title: FUXA
    work_mode: ingress
    url: http://localhost:1881
    index: /fuxa/
    icon: mdi:monitor-dashboard
    require_admin: true
    rewrite:

      # =========================================================
      # FUXA HTML / frontend absolute paths
      #
      # FUXA generates URLs such as:
      #   /fuxa/assets/...
      #   /fuxa/main....js
      #   /fuxa/styles....css
      #
      # Convert them to:
      #   /api/ingress/fuxa/fuxa/...
      #
      # IMPORTANT:
      # This only operates on the initial FUXA HTML response.
      # ==========================================================
      - mode: body
        path: '^/fuxa/?$'
        match: '(["''(=])(/fuxa/)'
        replace: '\1$http_x_ingress_path/fuxa/'

      # =========================================================
      # FUXA REST API
      #
      # FUXA generates absolute API paths such as:
      #
      #   /api/project
      #   /api/projectData
      #   /api/settings
      #   /api/screen
      #   /api/refresh
      #   /api/resources
      #   /api/heartbeat
      #   /api/scheduler
      #   /api/report
      #   /api/maps
      #   ...
      #
      # Convert:
      #   /api/project
      #
      # to:
      #   /api/ingress/fuxa/api/project
      #
      # NOTE:
      # Do NOT add /fuxa here because these API URLs are native
      # FUXA /api URLs.
      # =========================================================
      - mode: body
        path: '^/fuxa/?$'
        match: '(["''(=])(/api/(projectData|project|screen|refresh|settings|resources|heartbeat|scheduler|home|lab|editor|device|plugins|rodevice|users|view|_images|_widgets|snapshots|hmi|graph|chart|alarm|notification|language|report|maps|client-access|ar|_helpers/utils)(?:[/"''?])?)'
        replace: '\1$http_x_ingress_path\2'

      # =========================================================
      # FUXA API
      #
      # Native FUXA:
      #   /fuxa/api/project
      #
      # Through HA:
      #   /api/ingress/fuxa/fuxa/api/project
      # =========================================================
      - mode: body
        path: '^/fuxa/?$'
        match: '(["''(=])(/fuxa/api/)'
        replace: '\1$http_x_ingress_path/fuxa/api/'

      # =========================================================
      # Socket.IO
      #
      # FUXA uses Socket.IO for the live connection.
      # =========================================================
      - mode: body
        path: '^/fuxa/?$'
        match: '(["''(=])(/fuxa/socket\.io)'
        replace: '\1$http_x_ingress_path/fuxa/socket.io'

      # =========================================================
      # Redirects
      # =========================================================

      - mode: header
        name: '^Location$'
        match: '^/fuxa/(?!api/ingress/)'
        replace: '$http_x_ingress_path/fuxa/'
```
# Source
https://github.com/8OND007/FUXA-HA
