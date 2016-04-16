local function predict(model, criterion, data, opt)
	losses = 0;
    
    for i = 1, data.size do
		input, target = data:next_sample()
		model:zeroGradParameters()

        -- forward
        local output = model:forward(input)
        local loss = criterion:forward(output, target)
		
		if table.maxn(input) < opt.rho then
			den = table.maxn(input)
		else
			den = opt.rho
		end
		losses = losses+ loss/den;
	end
	
    return losses
end

return predict