---@class (exact) TabConfig
---@field description ComponentDescription
---@field text_configs FormatText[]

---@class (exact) ComponentDescription
---@field backgrounds ComponentBackground
---@field border_side BorderSide

---@class (exact) ComponentBackground
---@field main string
---@field sub? string
---@field left string
---@field right string

---@enum (keys) BorderSide
BorderSide = {
    Left = "Left",
    Right = "Right",
    Center = "Center",
}

---@class (exact) FormatText
---@field foreground string
---@field icon? string
---@field text? string
---@field attributes? FormatTextAttributes

---@class (exact) FormatTextAttributes
---@field underline? Underline
---@field intensity? Intensity
---@field italic? Italic

---@class (exact) PredefinedComponent
---@field description ComponentDescription
---@field text_color PredefinedTextColor

---@class (exact) PredefinedTextColor
---@field icon string
---@field main string
---@field sub? string

---@enum (keys) Underline
Underline = {
    None = "None",
    Single = "Single",
    Double = "Double",
    Curly = "Curly",
    Dotted = "Dotted",
    Dashed = "Dashed",
}

---@enum (keys) Intensity
Intensity = {
    Normal = "Normal",
    Bold = "Bold",
    Half = "Half",
}

---@enum Italic
Italic = {
    On = true,
    Off = false,
}

