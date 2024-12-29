# FUXA HomeAssistant Addon
Add FUXA to your Home Assistant. It is an easy web-based Process Visualization (SCADA/HMI/Dashboard) software

>This Addon is based on https://github.com/frangoteam/FUXA. All credits go to the team of frangoteam.

## FUXA
FUXA is a web-based Process Visualization (SCADA/HMI/Dashboard) software. With FUXA you can create modern process visualizations with individual designs for your machines and real-time data display.

![fuxa editor](https://raw.githubusercontent.com/8OND007/FUXA-HA/main/screenshot/fuxa-editor.png) 

![fuxa ani](https://raw.githubusercontent.com/8OND007/FUXA-HA/main/screenshot/fuxa-ani.gif)

![fuxa action](https://raw.githubusercontent.com/8OND007/FUXA-HA/main/screenshot/feature-action-move.gif)

## Features
- Devices connectivity with Modbus RTU/TCP, Siemens S7 Protocol, OPC-UA, BACnet IP, MQTT, Ethernet/IP (Allen Bradley)
- SCADA/HMI Web-Editor - Engineering and Design completely web-based
- Cross-Platform Full-Stack - Backend with NodeJs and Frontend with Web technologies (HTML5, CSS, Javascript, Angular, SVG)

## Live Demo
Here is a [live demo](https://frangoteam.github.io) example of FUXA editor.

## Add custom Repository to Home Assistant
Add this Repository `https://github.com/8OND007/FUXA-HA/` manually or click here to add it via `my Home Assistant`:

[![Open your Home Assistant instance and show the dashboard of an add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=9aa46cf0_fuxa-slr&repository_url=https%3A%2F%2Fgithub.com%2F8OND007%2FFUXA-HA%2F)

### Here is how you do it
- Go to Add-ons
- Click on ADD-ON-STORE in the lower right corner (Blue Button)
- Click on the three dots in the upper right corner
- Select `Repositories`
- Paste the url `https://github.com/8OND007/FUXA-HA/`
- Hit Add and then close
- Refresh the page
- The new Add-on `FUXA-HA` is now visible
- Click on it
- Install the Add-on

## Start the Add-on and use FUXA
- Press `Start`
- Check the `Logs`
- Now FUXA is started and you can use it on port `1881`
- You can use `homeasssitant.local:1881` (just replace the `:8123` with `:1881`)
- Have fun! 

## Implement it into Home Assistant Dashboard using iframe (website card)
You can use the https://www.home-assistant.io/dashboards/iframe/ Lovelace card, this is only possible locally on a HTTP HA instance. HTTPS does not allow iframes to HTTP content.

## Implement it into Home Assistant Dashboard using HACS hass_ingress addon (sidebar button)
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
