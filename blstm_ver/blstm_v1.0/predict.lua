local function predict(model, criterion, data)
	losses = 0;
    
    for i = 1, data.size do
		input, target = data:next_sample()
		model:zeroGradParameters()

        -- forward
        local output = model:forward(input)
        local loss = criterion:forward(output, target)
		
		losses = losses+ loss/table.maxn(input);
	end
	
    return losses
end

return predict