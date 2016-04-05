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
  --     lstm -> linear -> sigmoid
  lstm = nn.FastLSTM(opt.inputSize, opt.hiddenSize)
  lstm.usenngraph = true
  
  local model = nn.Sequential()
  				:add(nn.BiSequencer(lstm))
  			  	:add(nn.Sequencer(nn.Linear(2*opt.hiddenSize, 1)))
 			    :add(nn.Sequencer(nn.Sigmoid()))

  ------------------------------------------------------------------------------
  -- LOSS FUNCTION
  ------------------------------------------------------------------------------
  local criterion = nn.SequencerCriterion(nn.bceCriterion())

  return model, criterion
end

return create_model

