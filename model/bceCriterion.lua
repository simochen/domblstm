require 'nn'
local bceCriterion = torch.class('nn.bceCriterion', 'nn.Criterion')

local eps = 1e-12
w = 20

function bceCriterion:updateOutput(input, target)
    -- - log(input) * target - log(1 - input) * (1 - target)
	
    self.buffer = self.buffer or input.new()

    local buffer = self.buffer
    local output
	
    buffer:resizeAs(input)
	
    -- w * log(input) * target
    buffer:add(input, eps):log():mul(w)

    output = torch.dot(target, buffer)

    -- log(1 - input) * (1 - target)
    buffer:mul(input, -1):add(1):add(eps):log()

    output = output + torch.sum(buffer)
    output = output - torch.dot(target, buffer)
	output = output / (w+1)

    
    self.output = - output

    return self.output
end

function bceCriterion:updateGradInput(input, target)
    -- - (target - input) / ( input (1 - input) )
    -- The gradient is slightly incorrect:
    -- It should have be divided by (input + eps) (1 - input + eps)
    -- but it is divided by input (1 - input + eps) + eps
    -- This modification requires less memory to be computed.

    self.buffer = self.buffer or input.new()

    local buffer = self.buffer
    local gradInput = self.gradInput

    buffer:resizeAs(input)
    -- - x ( 1 + eps -x ) + eps
    buffer:add(input, -1):add(-eps):cmul(input):add(-eps)

    gradInput:resizeAs(input)
    -- **(y - x)**--  w * y - x - (w - 1) * x * y
	local p = torch.mul(target, w)
    gradInput:mul(input, 1-w):cmul(target):add(-input):add(p)
    -- - (y - x) / ( x ( 1 + eps -x ) + eps )
    gradInput:cdiv(buffer):div(w+1)

    return gradInput
end
