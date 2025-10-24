local Math = {}

local lines = Instance.new("Folder")
lines.Name = "Lines"
lines.Parent = workspace

local function createAttachment(position: Vector3?)
	local attachment = Instance.new("Attachment")
	if position then
		attachment.Position = position
	end

	attachment.Visible = true
	attachment.Parent = workspace
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
	line.Width0 = 0.1
	line.Width1 = 0.1
	line.Parent = lines
	return line
end

function Math:Grid(gridSize: number, cellSize: number, origin: Vector3)
	-- TODO: connect the parallel lines
	local grid = Instance.new("Folder")
	grid.Name = "Grid"
	grid.Parent = workspace

	if not cellSize then
		cellSize = 4
	end
	
	if not origin then
		origin = Vector3.zero
	end

	-- Create attachments
	local attachments = {}
	for x = 1, gridSize do
		local row = Instance.new("Folder")
		row.Name = x
		row.Parent = grid
		attachments[x] = {}

		for z = 1, gridSize do
			local a = createAttachment()
			-- (x-1) and (z-1) is to support if the origin is 0, because the for loops start at 1
			a.Position = origin + Vector3.new((x-1) * cellSize, 0, (z-1) * cellSize)
			table.insert(attachments[x], a)
			a.Parent = row
			a.Name = z
		end
	end

	-- Create beams
	for x = 1, gridSize do
		for z = 1, gridSize do
			if attachments[x][z + 1] then
				-- horizontal
				self:Line(attachments[x][z], attachments[x][z + 1])
			end

			if attachments[x + 1] then
				-- vertical 
				self:Line(attachments[x][z], attachments[x + 1][z])
			end
		end
	end
end

return Math
