---@meta

---GUI API for user interfaces
---@class gui
gui = {}

---Get a node by id
---@param id string|hash @node id
---@return node @the node
function gui.get_node(id) end

---Get the position of a node
---@param node node @the node
---@return vector3 @position of the node
function gui.get_position(node) end

---Set the position of a node
---@param node node @the node
---@param position vector3 @new position
function gui.set_position(node, position) end

---Get the size of a node
---@param node node @the node
---@return vector3 @size of the node
function gui.get_size(node) end

---Set the size of a node
---@param node node @the node
---@param size vector3 @new size
function gui.set_size(node, size) end

---Get the scale of a node
---@param node node @the node
---@return vector3 @scale of the node
function gui.get_scale(node) end

---Set the scale of a node
---@param node node @the node
---@param scale vector3 @new scale
function gui.set_scale(node, scale) end

---Get the color of a node
---@param node node @the node
---@return vector4 @color of the node (RGBA)
function gui.get_color(node) end

---Set the color of a node
---@param node node @the node
---@param color vector4 @new color (RGBA)
function gui.set_color(node, color) end

---Animate a node property
---@param node node @the node to animate
---@param property constant|string|hash @property to animate
---@param to vector3|vector4|number @target value
---@param easing constant|vector @easing function
---@param duration number @animation duration in seconds
---@param delay number|nil @optional delay before animation starts
---@param complete_function function|nil @optional callback when animation completes
---@param playback constant|nil @optional playback mode
function gui.animate(node, property, to, easing, duration, delay, complete_function, playback) end

---Cancel animation on a node
---@param node node @the node
---@param property string|hash|nil @optional property to cancel, nil cancels all
function gui.cancel_animation(node, property) end

---Get the text of a text node
---@param node node @the node
---@return string @the text
function gui.get_text(node) end

---Set the text of a text node
---@param node node @the node
---@param text string @new text
function gui.set_text(node, text) end

---Set a node to be enabled or disabled
---@param node node @the node
---@param enabled boolean @true to enable, false to disable
function gui.set_enabled(node, enabled) end

---Check if a node is enabled
---@param node node @the node
---@return boolean @true if enabled
function gui.is_enabled(node) end

---Pick a node at screen position
---@param x number @x screen coordinate
---@param y number @y screen coordinate
---@return node|nil @the node at the position, or nil
function gui.pick_node(x, y) end

---@class node

return gui

