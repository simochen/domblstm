require 'torch'
require 'math'
require 'nn'
require 'rnn'

local predict = require 'predict'
local create_model = require 'create_model'

-- opt{opt.trainG(1,2,3), cv, inputSize, hiddenSize, lr}
local function train(opt, trainset, cvset)
    ------------------------------------------------------------------------
    -- create model and loss/grad evaluation function
    --
    local model, criterion = create_model(opt)
    local params, grads = model:getParameters()
	
	------------------------------------------------------------------------
    -- training
    --
	args = {}
    args.lr = opt.startlr
	tloss = {}
	cvloss = {}
	args.ntrial = 0
	args.minerr = 999
    for i = 1, opt.epoch*trainset.size do
		input, target = trainset:next_sample()
		model:zeroGradParameters()

        -- forward
        local output = model:forward(input)
        local loss = criterion:forward(output, target)
        -- backward
        local gradOutput = criterion:backward(output, target)
        model:backward(input, gradOutput)
		-- update
		model:updateParameters(args.lr)
		
		
		if i% trainset.size == 0 then
			epoch = i/trainset.size
			
			if opt.decay == 'log' then
				--learning rate decay (after every epoch)
				args.lr = args.lr * torch.exp((torch.log(opt.minlr)-torch.log(opt.startlr))/opt.saturate)
			elseif opt.decay == 'linear' then
				args.lr = args.lr + (opt.minlr - opt.startlr)/opt.saturate
			end
			args.lr = math.max(args.lr, opt.minlr)
			print("learning rate = "..args.lr)
			
			-- evaluate (after every epoch), calculate training and cv loss
			terr = predict(model, criterion, trainset, opt)
			print(terr)
			cverr = predict(model, criterion, cvset, opt)
			print(cverr)
			tloss[#tloss +1] = terr
			cvloss[#cvloss +1] = cverr
			if cverr < args.minerr then
				args.minerr = cverr
				args.ntrial = 0
			else
				args.ntrial = args.ntrial + 1
				if args.ntrial >= opt.earlystop then
					print("No new minima found after "..args.ntrial.." epochs.")
					if opt.decay == 'log' or opt.decay == 'linear' then
						if opt.dropout <= 0 then
							modelfile = string.format("%s_hs%d_w%d_cv%d_ep%d.t7", opt.decay, opt.hiddenSize, opt.weight, opt.cv, epoch)
						else
							modelfile = string.format("%s_hs%d_w%d_dp%.2f_cv%d_ep%d.t7", opt.decay, opt.hiddenSize, opt.weight, opt.dropout, opt.cv, epoch)
						end
					else
						if opt.dropout <= 0 then
							modelfile = string.format("hs%d_w%d_lr.0e_cv%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.cv, epoch)
						else
							modelfile = string.format("hs%d_w%d_lr.0e_dp%.2f_cv%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.dropout, opt.cv, epoch)
						end
					end
					print(modelfile)
					torch.save(modelfile, {model = model, args = args, tloss = tloss, cvloss = cvloss})
					break
				end
			end
			
			--save model
			if args.ntrial == 0 then
				if opt.decay == 'log' or opt.decay == 'linear' then
					if opt.dropout <= 0 then
						modelfile = string.format("%s_hs%d_w%d_cv%d_ep%d.t7", opt.decay, opt.hiddenSize, opt.weight, opt.cv, epoch)
					else
						modelfile = string.format("%s_hs%d_w%d_dp%.2f_cv%d_ep%d.t7", opt.decay, opt.hiddenSize, opt.weight, opt.dropout, opt.cv, epoch)
					end
				else
					if opt.dropout <= 0 then
						modelfile = string.format("hs%d_w%d_lr.0e_cv%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.cv, epoch)
					else
						modelfile = string.format("hs%d_w%d_lr.0e_dp%.2f_cv%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.dropout, opt.cv, epoch)
					end
				end
				print(modelfile)
				torch.save(modelfile, {model = model, args = args, tloss = tloss, cvloss = cvloss})
			end
		end
		
		--print info
		if i% opt.print_every == 0 then
			if table.maxn(input) < opt.rho then
				den = table.maxn(input)
			else
				den = opt.rho
			end
			print(den)
			print(string.format("Iteration %4d ; BCE loss = %6.6f ", i, loss/den))
		end
	end
	
    return model, criterion, args
end

return train