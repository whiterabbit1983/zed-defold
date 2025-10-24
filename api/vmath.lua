---@meta

---Vector math library
---@class vmath
vmath = {}

---Create a vector3
---@param x number|nil @x component, defaults to 0
---@param y number|nil @y component, defaults to 0
---@param z number|nil @z component, defaults to 0
---@return vector3
function vmath.vector3(x, y, z) end

---Create a vector4
---@param x number|nil @x component, defaults to 0
---@param y number|nil @y component, defaults to 0
---@param z number|nil @z component, defaults to 0
---@param w number|nil @w component, defaults to 0
---@return vector4
function vmath.vector4(x, y, z, w) end

---Create a quaternion
---@param x number|nil @x component, defaults to 0
---@param y number|nil @y component, defaults to 0
---@param z number|nil @z component, defaults to 0
---@param w number|nil @w component, defaults to 1
---@return quaternion
function vmath.quat(x, y, z, w) end

---Create a quaternion from axis and angle
---@param axis vector3 @rotation axis
---@param angle number @rotation angle in radians
---@return quaternion
function vmath.quat_axis_angle(axis, angle) end

---Create a quaternion from Euler angles
---@param x number @rotation around x axis in radians
---@param y number @rotation around y axis in radians
---@param z number @rotation around z axis in radians
---@return quaternion
function vmath.quat_from_euler(x, y, z) end

---Create a quaternion representing a rotation around the x-axis
---@param angle number @angle in radians
---@return quaternion
function vmath.quat_rotation_x(angle) end

---Create a quaternion representing a rotation around the y-axis
---@param angle number @angle in radians
---@return quaternion
function vmath.quat_rotation_y(angle) end

---Create a quaternion representing a rotation around the z-axis
---@param angle number @angle in radians
---@return quaternion
function vmath.quat_rotation_z(angle) end

---Conjugate a quaternion
---@param q quaternion @quaternion to conjugate
---@return quaternion @conjugated quaternion
function vmath.conj(q) end

---Rotate a vector by a quaternion
---@param q quaternion @quaternion
---@param v vector3 @vector to rotate
---@return vector3 @rotated vector
function vmath.rotate(q, v) end

---Calculate the length of a vector
---@param v vector3|vector4 @vector
---@return number @length
function vmath.length(v) end

---Calculate the squared length of a vector
---@param v vector3|vector4 @vector
---@return number @squared length
function vmath.length_sqr(v) end

---Normalize a vector
---@param v vector3|vector4 @vector to normalize
---@return vector3|vector4 @normalized vector
function vmath.normalize(v) end

---Calculate the dot product
---@param v1 vector3|vector4|quaternion
---@param v2 vector3|vector4|quaternion
---@return number @dot product
function vmath.dot(v1, v2) end

---Calculate the cross product
---@param v1 vector3
---@param v2 vector3
---@return vector3 @cross product
function vmath.cross(v1, v2) end

---Linear interpolation between two values
---@param t number @interpolation parameter (0-1)
---@param n1 number|vector3|vector4|quaternion @start value
---@param n2 number|vector3|vector4|quaternion @end value
---@return number|vector3|vector4|quaternion @interpolated value
function vmath.lerp(t, n1, n2) end

---Spherical linear interpolation
---@param t number @interpolation parameter (0-1)
---@param q1 quaternion @start rotation
---@param q2 quaternion @end rotation
---@return quaternion @interpolated rotation
function vmath.slerp(t, q1, q2) end

---@class vector3
---@field x number
---@field y number
---@field z number

---@class vector4
---@field x number
---@field y number
---@field z number
---@field w number

---@class quaternion
---@field x number
---@field y number
---@field z number
---@field w number

return vmath

