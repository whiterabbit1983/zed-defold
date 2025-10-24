---@meta

---Physics API for 2D physics simulation
---@class physics
physics = {}

---Raycast in the physics world
---@param from vector3 @start position
---@param to vector3 @end position
---@param groups table @collision groups to test against
---@param options table|nil @optional raycast options
---@return table @raycast result
function physics.raycast(from, to, groups, options) end

---Get the gravity in the physics world
---@param url string|hash|url|nil @optional url of a collision world
---@return vector3 @gravity vector
function physics.get_gravity(url) end

---Set the gravity in the physics world
---@param gravity vector3 @gravity vector
---@param url string|hash|url|nil @optional url of a collision world
function physics.set_gravity(gravity, url) end

---Create a physics joint
---@param joint_type constant @type of joint
---@param collisionobject_a string|hash|url @first collision object
---@param joint_id string|hash @id of the joint
---@param position_a vector3 @position on first object
---@param collisionobject_b string|hash|url @second collision object
---@param position_b vector3 @position on second object
---@param properties table|nil @optional joint properties
function physics.create_joint(joint_type, collisionobject_a, joint_id, position_a, collisionobject_b, position_b, properties) end

---Destroy a physics joint
---@param collisionobject string|hash|url @collision object with the joint
---@param joint_id string|hash @id of the joint to destroy
function physics.destroy_joint(collisionobject, joint_id) end

---Get joint properties
---@param collisionobject string|hash|url @collision object with the joint
---@param joint_id string|hash @id of the joint
---@return table @joint properties
function physics.get_joint_properties(collisionobject, joint_id) end

---Set joint properties
---@param collisionobject string|hash|url @collision object with the joint
---@param joint_id string|hash @id of the joint
---@param properties table @new joint properties
function physics.set_joint_properties(collisionobject, joint_id, properties) end

return physics

