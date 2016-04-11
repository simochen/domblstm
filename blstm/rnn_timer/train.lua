require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'gnuplot'

local create_model = require 'create_model'

-- opt{opt.trainG(1,2,3), cv, inputSize, hiddenSize, lr}
local function train(opt, trainset)
    ------------------------------------------------------------------------
    -- create model and loss/grad evaluation function
    --
    local model, criterion = create_model(opt)
    local params, grads = model:getParameters()
	
	------------------------------------------------------------------------
    -- training
    --
    
    for i = 1, opt.epoch do
		input, target = trainset:next_batch()
		model:zeroGradParameters()

        -- forward
        local output = model:forward(input)
        local loss = criterion:forward(output, target)
        -- backward
        local gradOutput = criterion:backward(output, target)
        model:backward(input, gradOutput)
		-- update
		model:updateParameters(opt.lr)
		model:forget()
		
		if i% opt.save_every == 0 then
			savefile = string.format("hs%d_lr%.0e_w%d_tg%d%d%d_ep%d.t7", opt.hiddenSize, opt.lr,opt.weight, opt.trainG[1], opt.trainG[2], opt.trainG[3], i/opt.save_every)
			print(savefile)
			--torch.save(savefile, model)
		end
		if i% opt.print_every == 0 then
			print(string.format("Iteration %4d ; BCE loss = %6.6f ", i, loss/table.maxn(input)))
		end
	end
	
    return model, criterion
end

return train