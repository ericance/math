local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Math = require(ReplicatedStorage.Shared.Math)

local a0 = Instance.new("Attachment")
local a1 = Instance.new("Attachment")
a0.Visible = true
a1.Visible = true
a0.Parent = workspace
a1.Parent = workspace

a0.Position = Vector3.new(0, 0, -20)
a1.Position = Vector3.new(10, 0, -20)

-- needs two points
Math:Line(a0, a1)

-- needs a size
local size = 5
Math:Grid(size)


