require 'nn'
require 'bceCriterion'

local crit = nn.bceCriterion()
input = torch.Tensor{0.01}
target = torch.Tensor{1}
a = crit:forward(input, target,20)
b = crit:backward(input, target,20)
print(a)
print(b)
