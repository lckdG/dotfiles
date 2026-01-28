---@class (exact) TabConfig
---@field description ComponentDescription
---@field text_configs FormatText[]

---@class ComponentDescription
---@field backgrounds ComponentBackground
---@field border_side BorderSide

---@class ComponentBackground
---@field main string
---@field sub? string
---@field left string
---@field right string
---@enum BorderSide

BorderSide = {
    Left = "Left",
    Right = "Right"
}

---@class (exact) FormatText
---@field foreground string
---@field icon? string
---@field text string
---@field attributes? FormatTextAttributes

---@class (exact) FormatTextAttributes
---@field underline? Underline
---@field intensity? Intensity
---@field italic? Italic

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

