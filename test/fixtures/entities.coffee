fixturesEntities = JSON.parse('''
[
  {
    "id": "1111-1111-1111-1111",
    "components":
    {
      "resources": ["resId01"],
      "position":
      {
        "x": 100,
        "y": 100
      },
      "size":
      {
        "width": 20,
        "height": 20
      }
    }
  },
  {
    "id": "2222-2222-2222-2222",
    "components":
    {
      "resources": ["resId02"],
      "position":
      {
        "x": 200,
        "y": 100
      },
      "size":
      {
        "width": 20,
        "height": 20
      }
    }
  },
  {
    "id": "3333-3333-3333-3333",
    "components":
    {
      "connection":
      {
        "from": "1111-1111-1111-1111",
        "to": "2222-2222-2222-2222"
      },
      "resources": [
          "ws1Id",
          "ws2Id",
          "ws3Id"
      ]
    }
  }
]
''')
