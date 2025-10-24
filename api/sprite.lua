---@meta

---Sprite component API
---@class sprite
sprite = {}

---Play a sprite animation
---@param url string|hash|url @url of the sprite component
---@param id string|hash @animation id
---@param complete_function function|nil @optional callback when animation completes
---@param play_properties table|nil @optional playback properties
function sprite.play_flipbook(url, id, complete_function, play_properties) end

---Set the constant tint of a sprite
---@param url string|hash|url @url of the sprite component
---@param tint vector4 @tint color (RGBA)
function sprite.set_constant(url, tint) end

---Set horizontal flipping of a sprite
---@param url string|hash|url @url of the sprite component
---@param flip boolean @true to flip horizontally
function sprite.set_hflip(url, flip) end

---Set vertical flipping of a sprite
---@param url string|hash|url @url of the sprite component
---@param flip boolean @true to flip vertically
function sprite.set_vflip(url, flip) end

return sprite

