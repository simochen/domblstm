require 'torch'
require 'math'
require 'nn'
require 'rnn'
require 'nngraph'
require 'bceCriterion'

local predict = require 'predict'

-- opt{opt.trainG(1,2,3), cv, inputSize, hiddenSize, lr}
local function retrain(opt, trainset, cvset)
	------------------------------------------------------------------------
    -- model file base name
    --
	if opt.decay == 'log' or opt.decay == 'linear' then
		if opt.dropout <= 0 then
			base = string.format("%s_hs%d_w%d_cv%d", opt.decay, opt.hiddenSize[1], opt.weight, opt.cv)
		else
			base = string.format("%s_hs%d_w%d_dp%.2f_cv%d", opt.decay, opt.hiddenSize[1], opt.weight, opt.dropout, opt.cv)
		end
	else
		if opt.dropout <= 0 then
			base = string.format("hs%d_w%d_lr.0e_cv%d", opt.hiddenSize[1], opt.weight, args.lr, opt.cv)
		else
			base = string.format("hs%d_w%d_lr.0e_dp%.2f_cv%d", opt.hiddenSize[1], opt.weight, args.lr, opt.dropout, opt.cv)
		end
	end
    ------------------------------------------------------------------------
    -- create model and loss/grad evaluation function
    --
    local criterion = nn.SequencerCriterion(nn.bceCriterion())
	
	mfile = string.format("%s_ep%d.t7", base, opt.last_epoch)
	mfile = paths.concat('../output', opt.savepath, mfile)
	
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
					
					mfile = string.format("%s_ep%d.t7", base, epoch)
					print(mfile)
					mfile = paths.concat('../output', opt.savepath, mfile)
					
					torch.save(modelfile, {model = model, args = args, tloss = tloss, cvloss = cvloss})
					break
				end
			end
			
			--save model
			if args.ntrial == 0 then
				if epoch% opt.save_every == 0 then
					mark = epoch
				else
					mark = 0
				end
			
				mfile = string.format("%s_ep%d.t7", base, mark)
				print(mfile)
				mfile = paths.concat('../output', opt.savepath, mfile)
				
				torch.save(modelfile, {model = model, args = args, tloss = tloss, cvloss = cvloss})
			end
		end

		i = i + 1
	end
	
    return model, criterion, args
end

return retrain