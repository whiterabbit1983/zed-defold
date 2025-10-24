---@meta

---Game object API
---@class go
go = {}

---Define a script property
---@param name string @property name
---@param value any @default value
---@return any @property accessor
function go.property(name, value) end

---Get the position of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return vector3 @the position
function go.get_position(id) end

---Set the position of a game object
---@param position vector3 @position to set
---@param id string|hash|url|nil @optional id of the game object
function go.set_position(position, id) end

---Get the rotation of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return quaternion @the rotation
function go.get_rotation(id) end

---Set the rotation of a game object
---@param rotation quaternion @rotation to set
---@param id string|hash|url|nil @optional id of the game object
function go.set_rotation(rotation, id) end

---Get the scale of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return vector3 @the scale
function go.get_scale(id) end

---Set the scale of a game object
---@param scale number|vector3 @scale to set
---@param id string|hash|url|nil @optional id of the game object
function go.set_scale(scale, id) end

---Animate a property of a game object
---@param url string|hash|url @url of the game object or component
---@param property string|hash @property to animate
---@param playback constant @playback mode
---@param to number|vector3|vector4|quaternion @target value
---@param easing constant|vector @easing function
---@param duration number @animation duration in seconds
---@param delay number|nil @optional delay before animation starts
---@param complete_function function|nil @optional callback when animation completes
function go.animate(url, property, playback, to, easing, duration, delay, complete_function) end

---Cancel all animations on the specified property
---@param url string|hash|url @url of the game object or component
---@param property string|hash|nil @optional property to cancel, nil cancels all
function go.cancel_animations(url, property) end

---Delete a game object
---@param id string|hash|url|nil @optional id of the game object to delete
---@param recursive boolean|nil @optional if children should be deleted as well
function go.delete(id, recursive) end

---Gets a named property of the specified game object or component
---@param url string|hash|url @url of the game object or component
---@param property string|hash @property to get
---@return any @the property value
function go.get(url, property) end

---Sets a named property of the specified game object or component
---@param url string|hash|url @url of the game object or component
---@param property string|hash @property to set
---@param value any @value to set
function go.set(url, property, value) end

---Get the parent of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return hash @id of the parent, or nil if no parent
function go.get_parent(id) end

---Get the world transform of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return matrix4 @world transform matrix
function go.get_world_transform(id) end

---Get the world position of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return vector3 @world position
function go.get_world_position(id) end

---Get the world rotation of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return quaternion @world rotation
function go.get_world_rotation(id) end

---Get the world scale of a game object
---@param id string|hash|url|nil @optional id of the game object
---@return vector3 @world scale
function go.get_world_scale(id) end

---Check if a game object exists
---@param id string|hash|url|nil @optional id of the game object
---@return boolean @true if exists
function go.exists(id) end

---Get the id of a game object
---@param path string|nil @optional path to game object
---@return hash @id of the game object
function go.get_id(path) end

return go

