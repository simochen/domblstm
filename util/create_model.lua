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
  local stepmodule = nn.Sequential()
  
  local inputSize = opt.inputSize
  for i, hiddenSize in ipairs(opt.hiddenSize) do
      if opt.rnn == 'gru' then
          rnn = nn.GRU(inputSize, hiddenSize, opt.rho, opt.dropout/2)
      elseif opt.rnn == 'lstm' then
          nn.FastLSTM.usenngraph = true
          rnn = nn.FastLSTM(inputSize, hiddenSize, opt.rho)
      else
          rnn = nn.Recurrent(hiddenSize, nn.Linear(inputSize, hiddenSize),
                             nn.Linear(hiddenSize, hiddenSize), 
                             nn.Sigmoid(), opt.rho)
      end
    stepmodule:add(rnn)
    
    if opt.dropout > 0 then
        stepmodule:add(nn.Dropout(opt.dropout))
    end
    
    inputSize = hiddenSize
  end
  
  local bwd = stepmodule:clone()
  bwd:reset()
  local brnn = nn.BiSequencer(stepmodule, bwd)
  
  local model = nn.Sequential()
  model:add(brnn)
       :add(nn.Sequencer(nn.Linear(2*inputSize, 1)))
       :add(nn.Sequencer(nn.Sigmoid()))
     
  -- local memory = (opt.rnn == 'lstm' or opt.rnn == 'gru')
  -- model:remember(memory and 'both' or 'eval')

  ------------------------------------------------------------------------------
  -- LOSS FUNCTION
  ------------------------------------------------------------------------------
  local criterion = nn.SequencerCriterion(nn.bceCriterion())
  
  ------------------------------------------------------------------------------
  -- CUDA
  ------------------------------------------------------------------------------
  if opt.cuda == 1 then
      require 'cutorch'
      require 'cunn'
      cutorch.setDevice(opt.device)
      model:cuda()
      criterion:cuda()
  end

  return model, criterion
end

return create_model
