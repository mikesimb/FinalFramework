local TestMsgHandler = require "Handler/TestMsgHandler"

local HandlerManager = class("HandlerManager")

function HandlerManager:Initialize()
    self.handlers = {}
	self:AddHandler(HandlerNames.Test, TestMsgHandler)
	
	local netMgr = MgrCenter:GetManager(ManagerNames.Network)
	for _, handler in pairs(self.handlers) do
		netMgr:RegMsgHandler(handler)
	end
end

function HandlerManager:AddHandler(name, handler)
	if name == nil or handler == nil then
		logError('HandlerManager:AddHandler Error!! was nil.')
		return
	end
	self.handlers[name] = handler
end

function HandlerManager:GetHandler(name)
	return self.handlers[name]
end

function HandlerManager:RemoveHandler(name)
	table.removeKey(self.handlers, name)
end

return HandlerManager