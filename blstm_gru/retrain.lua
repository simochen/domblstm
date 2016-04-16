require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'bceCriterion'


local predict = require 'predict'

-- opt{opt.trainG(1,2,3), cv, inputSize, hiddenSize, lr}
local function retrain(opt, trainset, cvset)
    ------------------------------------------------------------------------
    -- create model and loss/grad evaluation function
    --
    local criterion = nn.SequencerCriterion(nn.bceCriterion())
	
	if opt.decay then
		if opt.dropout <= 0 then
			mfile = string.format("hs%d_w%d_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], opt.last_epoch)
		else
			mfile = string.format("hs%d_w%d_dp%.2f_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.dropout, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], opt.last_epoch)
		end
	else
		if opt.dropout <= 0 then
			mfile = string.format("hs%d_w%d_lr.0e_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.startlr, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], opt.last_epoch)
		else
			mfile = string.format("hs%d_w%d_lr.0e_dp%.2f_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.startlr, opt.dropout, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], opt.last_epoch)
		end
	end
	data = torch.load(mfile)
	model = data.model
	args = data.args
	tloss = data.tloss
	cvloss = data.cvloss
	
    local params, grads = model:getParameters()
	
	------------------------------------------------------------------------
    -- training
    --
    i = opt.last_epoch* trainset.size +1
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
		model:updateParameters(args.lr)
		
		if i% trainset.size == 0 then
			epoch = i/trainset.size
			
			if opt.decay then
				--learning rate decay (after every epoch)
				args.lr = args.lr * torch.exp((torch.log(opt.minlr)-torch.log(opt.startlr))/opt.saturate)
				--args.lr = args.lr + (opt.minlr - opt.startlr)/opt.saturate
				args.lr = math.max(args.lr, opt.minlr)
				print("learning rate = "..args.lr)
			end
			
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
					if opt.decay then
						if opt.dropout <= 0 then
							modelfile = string.format("hs%d_w%d_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
						else
							modelfile = string.format("hs%d_w%d_dp%.2f_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.dropout, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
						end
					else
						if opt.dropout <= 0 then
							modelfile = string.format("hs%d_w%d_lr.0e_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
						else
							modelfile = string.format("hs%d_w%d_lr.0e_dp%.2f_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.dropout, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
						end
					end
					print(modelfile)
					torch.save(modelfile, {model = model, args = args, tloss = tloss, cvloss = cvloss})
					break
				end
			end
			
			--save model
			if args.ntrial == 0 then
				if opt.decay then
					if opt.dropout <= 0 then
						modelfile = string.format("hs%d_w%d_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
					else
						modelfile = string.format("hs%d_w%d_dp%.2f_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, opt.dropout, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
					end
				else
					if opt.dropout <= 0 then
						modelfile = string.format("hs%d_w%d_lr.0e_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
					else
						modelfile = string.format("hs%d_w%d_lr.0e_dp%.2f_tg%d%d%d%d_ep%d.t7", opt.hiddenSize, opt.weight, args.lr, opt.dropout, opt.trainG[1], opt.trainG[2], opt.trainG[3], opt.trainG[4], epoch)
					end
				end
				print(modelfile)
				torch.save(modelfile, {model = model, args = args, tloss = tloss, cvloss = cvloss})
			end
		end
		
		if i% opt.print_every == 0 then
			if table.maxn(input) < opt.rho then
				den = table.maxn(input)
			else
				den = opt.rho
			end
			print(string.format("Iteration %4d ; BCE loss = %6.6f ", i, loss/den))
		end
		i = i + 1
	end
	
    return model, criterion, args
end

return retrain