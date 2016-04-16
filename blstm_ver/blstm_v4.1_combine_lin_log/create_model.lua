require 'nn'
require 'nngraph'
require 'rnn'
require 'bceCriterion'

function create_model(opt)
	--opt{opt.inputSize,hiddenSize}
  ------------------------------------------------------------------------------
  -- MODEL
  ------------------------------------------------------------------------------
    -- OUR MODEL:
  --     rnn(lstm/gru) -> (dropout) -> linear -> sigmoid
  if opt.rnn == 'gru' then
	  rnn = nn.GRU(opt.inputSize, opt.hiddenSize, opt.rho, opt.dropout/2)
  elseif opt.rnn == 'lstm' then
	  nn.FastLSTM.usenngraph = true
      rnn = nn.FastLSTM(opt.inputSize, opt.hiddenSize, opt.rho)
  else
	  rnn = nn.Recurrent(opt.hiddenSize, nn.Linear(opt.inputSize, opt.hiddenSize),
	  					 nn.Linear(opt.hiddenSize, opt.hiddenSize), 
						 nn.Sigmoid(), opt.rho)
  end
  
  local model = nn.Sequential()
  				:add(nn.BiSequencer(rnn))
				
  if opt.dropout > 0 then
  	  model:add(nn.Sequencer(nn.Dropout(opt.dropout)))
  end
  
  model:add(nn.Sequencer(nn.Linear(2*opt.hiddenSize, 1)))
 	   :add(nn.Sequencer(nn.Sigmoid()))

  ------------------------------------------------------------------------------
  -- LOSS FUNCTION
  ------------------------------------------------------------------------------
  local criterion = nn.SequencerCriterion(nn.bceCriterion())

  return model, criterion
end

return create_model

