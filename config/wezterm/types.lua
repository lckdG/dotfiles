---@class (exact) TabConfig
---@field left_background? string
---@field right_background? string
---@field main_background string
---@field text_configs FormatText[]

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
