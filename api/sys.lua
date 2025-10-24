---@meta

---System functions
---@class sys
sys = {}

---Get system information
---@param info_name constant @what information to retrieve
---@return string|table @the information
function sys.get_sys_info(info_name) end

---Get current engine info
---@return table @engine info table
function sys.get_engine_info() end

---Get application information
---@return table @application info table
function sys.get_application_info() end

---Load a resource
---@param path string @path to the resource
---@return buffer @the resource data
function sys.load_resource(path) end

---Save a resource
---@param path string @path where to save
---@param data buffer|string @data to save
function sys.save_resource(path, data) end

---Get configuration value
---@param key string @configuration key
---@param default_value string|nil @optional default value
---@return string|nil @configuration value
function sys.get_config(key, default_value) end

---Get number configuration value  
---@param key string @configuration key
---@param default_value number|nil @optional default value
---@return number|nil @configuration value as number
function sys.get_config_number(key, default_value) end

---Get integer configuration value
---@param key string @configuration key
---@param default_value integer|nil @optional default value
---@return integer|nil @configuration value as integer
function sys.get_config_int(key, default_value) end

---Exit the application
---@param code number @exit code
function sys.exit(code) end

---Reboot the engine
function sys.reboot() end

return sys

