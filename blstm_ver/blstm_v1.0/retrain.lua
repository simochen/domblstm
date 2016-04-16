require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'bceCriterion'

-- opt{opt.trainG(1,2,3), cv, inputSize, hiddenSize, lr}
local function retrain(opt, trainset)
    ------------------------------------------------------------------------
    -- create model and loss/grad evaluation function
    --
    local criterion = nn.SequencerCriterion(nn.bceCriterion())
	mfile = string.format("hs%d_lr%.0e_w%d_tg123_ep%d.t7",opt.hiddenSize, opt.lr, opt.weight, opt.last_epoch)
	model = torch.load(mfile)
	
    local params, grads = model:getParameters()
	
	------------------------------------------------------------------------
    -- training
    --
    i = 1
    while true do
		input, target = trainset:next_sample()
		model:zeroGradParameters()

        -- forward
        local output = model:forward(input)
        local loss = criterion:forward(output, target)
        -- backward
        local gradOutput = criterion:backward(output, target)
        model:backward(input, gradOutput)
		-- update
		model:updateParameters(opt.lr)
		
		if i% opt.save_every == 0 then
			savefile = string.format("hs%d_lr%.0e_w%d_tg%d%d%d_ep%d.t7", opt.hiddenSize, opt.lr, opt.weight, opt.trainG[1], opt.trainG[2], opt.trainG[3], i/opt.save_every+opt.last_epoch)
			print(savefile)
			torch.save(savefile, model)
		end
		if i% opt.print_every == 0 then
			print(string.format("Iteration %4d ; BCE loss = %6.6f ", i, loss/table.maxn(input)))
		end
		i = i + 1
	end
	
    return model, criterion
end

return retrain