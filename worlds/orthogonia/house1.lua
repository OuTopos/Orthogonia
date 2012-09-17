return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 10,
  height = 8,
  tilewidth = 32,
  tileheight = 32,
  properties = {
    ["name"] = "Tat's Hut"
  },
  tilesets = {
    {
      name = "inside01",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../../images/tilesets/lorestrome/inside01.png",
      imagewidth = 256,
      imageheight = 3507,
      properties = {},
      tiles = {}
    },
    {
      name = "inside2",
      firstgid = 873,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../../images/tilesets/lorestrome/inside2.png",
      imagewidth = 256,
      imageheight = 3507,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "0",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "0"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 1018, 1018, 1018, 1018, 1017, 1018, 1018, 1018, 0,
        0, 1018, 1017, 1018, 1017, 1018, 1017, 1018, 1018, 0,
        0, 1018, 1018, 1018, 1018, 1017, 1018, 1018, 1018, 0,
        0, 1018, 1018, 1018, 1018, 1018, 1018, 1017, 1017, 0,
        0, 0, 0, 0, 0, 1018, 1018, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "0 - Detail A",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "0"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 1005, 1006, 0, 0, 950, 951, 952, 0, 0,
        0, 1013, 1014, 0, 82, 1350, 1351, 970, 0, 0,
        0, 0, 0, 0, 0, 1358, 1359, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "1",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "1"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 900, 902, 902, 901, 942, 943, 944, 1032, 0,
        0, 0, 0, 1016, 74, 0, 0, 133, 134, 0,
        0, 0, 0, 0, 83, 0, 0, 0, 997, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 963, 989, 0, 0, 0, 0, 995, 996, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "1 - Detail A",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "1"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 985, 977, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 79, 0, 0, 962, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 973, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "2",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "2"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 892, 1071, 894, 893, 934, 935, 936, 1024, 0,
        0, 0, 0, 1008, 0, 0, 0, 0, 126, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 987, 988, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "2 - Detail A",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "2"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 1078, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "3",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "3"
      },
      encoding = "lua",
      data = {
        907, 908, 908, 908, 908, 908, 908, 908, 908, 909,
        915, 0, 0, 0, 0, 0, 0, 0, 0, 917,
        915, 0, 0, 0, 0, 0, 0, 0, 0, 917,
        915, 0, 0, 0, 0, 0, 0, 0, 0, 917,
        915, 0, 0, 0, 0, 0, 0, 0, 0, 917,
        915, 0, 0, 0, 0, 0, 0, 0, 0, 917,
        915, 0, 0, 0, 0, 0, 0, 0, 0, 917,
        923, 924, 924, 924, 911, 0, 0, 910, 924, 925
      }
    },
    {
      type = "tilelayer",
      name = "3 - Detail A",
      x = 0,
      y = 0,
      width = 10,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["z"] = "3"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 959, 960, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "portals",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "door_portal",
          type = "",
          x = 160,
          y = 272,
          width = 64,
          height = 16,
          properties = {
            ["map"] = "test",
            ["world"] = "orthogonia",
            ["x"] = "17",
            ["y"] = "5",
            ["z"] = "1"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "block",
      visible = true,
      opacity = 1,
      properties = {
        ["behavior"] = "block"
      },
      objects = {
        {
          name = "",
          type = "",
          x = 0,
          y = 0,
          width = 32,
          height = 256,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 32,
          y = 0,
          width = 256,
          height = 96,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 288,
          y = 0,
          width = 32,
          height = 256,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 224,
          y = 224,
          width = 64,
          height = 32,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 32,
          y = 224,
          width = 128,
          height = 32,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 224,
          y = 192,
          width = 64,
          height = 32,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 256,
          y = 136,
          width = 32,
          height = 24,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 32,
          y = 192,
          width = 64,
          height = 32,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 96,
          y = 112,
          width = 32,
          height = 16,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 128,
          y = 112,
          width = 32,
          height = 48,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 224,
          y = 96,
          width = 64,
          height = 40,
          properties = {}
        },
        {
          name = "",
          type = "",
          x = 208,
          y = 96,
          width = 16,
          height = 16,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "spawn",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "door",
          type = "",
          x = 176,
          y = 224,
          width = 32,
          height = 32,
          properties = {}
        }
      }
    }
  }
}
