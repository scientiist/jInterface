--[[
	TextLabel class - TextLabel()

		table<GUIObject> getChildren()
		void setSize(Vector2D offset, Vector2D scale)
		void setPosition(Vector2D offset, Vector2D scale)
		Vector2D, Vector2D getSize()
		Vector2D, Vector2D getPosition()
]]--

local RGBColor = require("datatypes/RGBColor")
local Vector2D = require("datatypes/Vector2D")
local Frame = require("Frame")

local TextLabel = {}

TextLabel.__index = TextLabel

setmetatable(TextLabel, {
	__index = Frame, -- this is what makes the inheritance work
	__call = function (cls, ...)
		local self = setmetatable({}, cls)
		self:_init(...)
		return self
	end,
})

function TextLabel:_init()
	
	Frame._init(self) -- call the base class constructor
	table.insert(self.__inheritance, "TextLabel")
	self.children = {}

	-- public variables
	self.parent = nil
	self.backgroundColor = RGBColor.new(255,255,255)
	self.border = 2
	self.borderColor = RGBColor.new(0,0,0)
	self.sizeOffset = Vector2D.new(300,150)
	self.sizeScale = Vector2D.new(0,0)
	self.positionOffset = Vector2D.new(50,50)
	self.positionScale = Vector2D.new(0,0)
	self.absoluteSize = Vector2D.new(0,0)
	self.absolutePosition = Vector2D.new(0,0)

	self.text = "TextLabel"
	self.textColor = RGBColor.new(128, 128, 128)
end

function TextLabel:render()

	self.absoluteSize = Vector2D.new(self.sizeOffset.x + self.parent.absoluteSize.x * self.sizeScale.x, self.sizeOffset.y + self.parent.absoluteSize.y * self.sizeScale.y)
	self.absolutePosition = Vector2D.new(self.parent.absolutePosition.x + self.positionOffset.x + self.parent.absoluteSize.x  * self.positionScale.x,  self.parent.absolutePosition.y + self.positionOffset.y + self.parent.absoluteSize.y  * self.positionScale.y)

	-- border
	
	love.graphics.setColor(self.borderColor:toTable())
	love.graphics.rectangle("fill", self.absolutePosition.x-self.border, self.absolutePosition.y-self.border, self.absoluteSize.x+self.border*2, self.absoluteSize.y+self.border*2)

	-- background
	love.graphics.setColor(self.backgroundColor:toTable())
	love.graphics.rectangle("fill", self.absolutePosition.x, self.absolutePosition.y, self.absoluteSize.x, self.absoluteSize.y)
	
	love.graphics.setColor(self.textColor:toTable())
	love.graphics.printf(self.text, self.absolutePosition.x, self.absolutePosition.y, self.absoluteSize.x, "center")
	self:renderchildren()
end

return TextLabel