require 'nn'
require 'rnn'
require 'bceCriterion'

local crit = nn.bceCriterion()
input = torch.Tensor{0.01}
target = torch.Tensor{1}
a = crit:forward(input, target,20)
b = crit:backward(input, target,20)
print(a)
print(b)

c = 1.1
d = 1.3
print(torch.log(c))

--data = torch.load("hs20_lr1e-04_w10_tg1234_ep1.t7")
--print(data[1])

e = 'linear'

if e == 'linear' or e =='log' then
	m = string.format("%s.t7", e)
	print(m)
end