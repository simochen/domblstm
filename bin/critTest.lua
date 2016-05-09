package.path = package.path .. ';../util/?.lua'
require 'nn'
require 'rnn'
require 'bceCriterion'
local matio = require 'matio'

local crit = nn.bceCriterion(2)
input = torch.Tensor{0.01}
target = torch.Tensor{1}
a = crit:forward(input, target)
b = crit:backward(input, target)
print(a)
print(b)

c = 1.1
--print(torch.log(c))

--data = torch.load("hs20_lr1e-04_w10_tg1234_ep1.t7")
--print(data[1])

e = 'linear'

if e == 'linear' or e =='log' then
	m = string.format("%s.t7", e)
	print(m)
end

