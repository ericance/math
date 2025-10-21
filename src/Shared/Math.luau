local Math = {}

local function createAttachment(position: Vector3)
	local attachment = Instance.new("Attachment")
	attachment.Visible = true
	attachment.Parent = workspace
	attachment.Position = position
	return attachment
end

function Math:Line(a0: Vector3, a1: Vector3)
	local line = Instance.new("Beam")
	line.FaceCamera = true
	line.Attachment0 = a0
	line.Attachment1 = a1
	line.LightEmission = 0
	line.LightInfluence = 0
	line.Transparency = NumberSequence.new(0)
	line.Width0 = 0.25
	line.Width1 = 0.25
	line.Parent = workspace
	return line
end

function Math:Grid(size)
	-- TODO: connect the parallel lines
	for i = 1, size do
		local a0 = createAttachment(Vector3.new(i*10,0,0))
		local a1 = createAttachment(Vector3.new(i*20,0,0))
		self:Line(a0, a1)
		for j = 1, size do
			local a2 = createAttachment(Vector3.new(i*10,0,j*10))
			local a3 = createAttachment(Vector3.new(i*20,0,j*10))
			self:Line(a2, a3)

		end
	end
end

return Math
