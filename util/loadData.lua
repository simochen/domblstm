require 'torch'
local matio = require 'matio'
local loader = {}

function loader.load_data(type, r)
	if type == 'single' then
		Xkey = 'sg_X'
		ykey = 'sg_y0'
	elseif type == 'multi' then
		Xkey = 'mg_X'
		ykey = 'mg_y0'
	elseif type == 'disc' then
		Xkey = 'dg_X'
		ykey = 'dg_y0'
	else 
		error('undefined domain type' .. tostring(type))
	end

	matfile = string.format('../data/group5_r%d.mat', r)
	g_X = matio.load(matfile, Xkey) --table[key:1-720]
	g_y = matio.load(matfile, ykey) --table[key:1-720]
 
	local data = {}
	data.gsize = #g_y/5;
	
	data.gX = {}	--table[key:5*144]
	data.gy = {}	--table[key:5*144]
	
	sub_gX = {}
	sub_gy = {}
	for i = 1, #g_y do
		j = i - torch.floor((i-1)/data.gsize)*data.gsize;
		table.insert(sub_gX, j, g_X[i])
		table.insert(sub_gy, j, g_y[i])
		if i%data.gsize==0 then
			table.insert(data.gX, i/data.gsize, sub_gX)
			table.insert(data.gy, i/data.gsize, sub_gy)
			sub_gX = {}
			sub_gy = {}
		end
	end
	return data
end

function loader.Trainset(opt, data)
	local trainset = {}
	trainset.inputs = {}
	trainset.targets = {}

	trainset.idx = 1;
	trainset.size = 4*data.gsize;
	
	for i = 1, 4*data.gsize do
		k = torch.floor((i-1)/data.gsize)+1;
		j = i - (k-1)*data.gsize;
		table.insert(trainset.inputs, i, data.gX[opt.trainG[k]][j]);
		table.insert(trainset.targets, i, data.gy[opt.trainG[k]][j]);
	end
	
	function trainset:next_sample()
		X = trainset.inputs[trainset.idx];
		y = trainset.targets[trainset.idx];

	    trainset.idx = trainset.idx + 1

	    if(trainset.idx > trainset.size) then
	        trainset.idx = 1
	    end

	    table_X = {}
	    table_y = {}

	    for i = 1,X:size(1) do
	      table.insert(table_X, X[{{i},{}}])
	      table.insert(table_y, y[{{i},{}}])
	    end

	    return table_X, table_y
	end
	
	return trainset
end

function loader.CVset(cvNum, data)
	local cvset = {}

	cvset.idx = 1;
	cvset.size = data.gsize;
	
	cvset.inputs = data.gX[cvNum];
	cvset.targets = data.gy[cvNum];	
	
	function cvset:next_sample()
		X = cvset.inputs[cvset.idx];
		y = cvset.targets[cvset.idx];

	    cvset.idx = cvset.idx + 1

	    if(cvset.idx > cvset.size) then
	        cvset.idx = 1
	    end

	    table_X = {}
	    table_y = {}

	    for i = 1,X:size(1) do
	      table.insert(table_X, X[{{i},{}}])
	      table.insert(table_y, y[{{i},{}}])
	    end

	    return table_X, table_y
	end
	
	return cvset
end

return loader