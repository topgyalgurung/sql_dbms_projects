{
    "version": "v1",
    "config": {
      "visState": {
        "filters": [],
        "layers": [
          {
            "id": "25gdmnq",
            "type": "point",
            "config": {
              "dataId": "main",
              "label": "target",
              "color": [
                18,
                147,
                154,
                255
              ],
              "columns": {
                "lat": "target_lat",
                "lng": "target_lon",
                "altitude": null
              },
              "isVisible": true,
              "visConfig": {
                "radius": 10,
                "fixedRadius": false,
                "opacity": 0.8,
                "outline": false,
                "thickness": 2,
                "colorRange": {
                  "name": "Global Warming",
                  "type": "sequential",
                  "category": "Uber",
                  "colors": [
                    "#5A1846",
                    "#900C3F",
                    "#C70039",
                    "#E3611C",
                    "#F1920E",
                    "#FFC300"
                  ]
                },
                "radiusRange": [
                  0,
                  50
                ],
                "hi-precision": false
              },
              "textLabel": {
                "field": null,
                "color": [
                  255,
                  255,
                  255
                ],
                "size": 50,
                "offset": [
                  0,
                  0
                ],
                "anchor": "middle"
              }
            },
            "visualChannels": {
              "colorField": null,
              "colorScale": "quantile",
              "sizeField": null,
              "sizeScale": "linear"
            }
          }
        ],
        "interactionConfig": {
          "tooltip": {
            "fieldsToShow": {
              "main": [
                "target_name",
                "cluster"
              ]
            },
            "enabled": true
          },
          "brush": {
            "size": 0.5,
            "enabled": false
          }
        },
        "layerBlending": "normal",
        "splitMaps": []
      },
      "mapState": {
        "bearing": 0,
        "dragRotate": false,
        "latitude": 47.46678040629504,
        "longitude": -122.31926316280968,
        "pitch": 0,
        "zoom": 7.480654760073648,
        "isSplit": false
      },
      "mapStyle": {
        "styleType": "dark",
        "topLayerGroups": {},
        "visibleLayerGroups": {
          "label": true,
          "road": true,
          "border": false,
          "building": true,
          "water": true,
          "land": true
        },
        "mapStyles": {}
      }
    }
  }