---@meta

---Message passing API
---@class msg
msg = {}

---Post a message to a receiving URL
---@param receiver string|hash|url @the receiver
---@param message_id string|hash @the message id
---@param message table|nil @optional message parameters
function msg.post(receiver, message_id, message) end

---Get the URL of the current script
---@return url @the URL of the current script
function msg.url() end

---Get the URL from individual components
---@param socket string|hash|nil @optional socket
---@param path string|hash|nil @optional path
---@param fragment string|hash|nil @optional fragment
---@return url @constructed URL
function msg.url(socket, path, fragment) end

return msg

