local Math = {}

local lines = Instance.new("Folder")
lines.Name = "Lines"
lines.Parent = workspace

local function createAttachment(position: Vector3)
	local attachment = Instance.new("Attachment")
	attachment.Visible = true
	attachment.Position = position
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

function Math:Grid(gridSize)
	-- TODO: connect the parallel lines
	local grid = Instance.new("Folder")
	grid.Name = "Grid"
	grid.Parent = workspace

	--[[ 
		The goal is to have a structure where the folder in workspace is labeled 1, 2, 3...
		and inside the folder is 1, 2, 3 ... which is why there is + 1, 
		since the iteration in the for loops start at 0.

		Grid [Folder]
			1 [Folder]
				1 [Attachment] 
				2 [Attachment]
				3 [Attachment]
			2 [Folder]
	]]

	-- Create attachments
	local attachments = {}
	for x = 1, gridSize do
		local row = Instance.new("Folder")
		row.Name = x
		row.Parent = grid
		attachments[x] = {}

		for z = 1, gridSize do
			local a = createAttachment(Vector3.new(x * 5, 0, z * 5))
			table.insert(attachments[x], a)
			a.Parent = row
			a.Name = z
		end
	end

	--[[{
		[1] = {
			1,2,3,4
		},
		[2] = {
			1,2,3,4
		},
	}]]
	-- Create beams
	for x = 1, gridSize do
		-- if x > gridSize then
		-- 	continue
		-- end
		for z = 1, gridSize do
			if attachments[x][z+1] then
				-- horizontal
				self:Line(attachments[x][z], attachments[x][z + 1])
			end

			if attachments[x + 1] then
				-- vertical 
				self:Line(attachments[x][z], attachments[x + 1][z])
			end
			-- if z > gridSize then
			-- 	continue
			-- end

			print(x)
			print(attachments[x][z])
		end
	end

end

return Math
