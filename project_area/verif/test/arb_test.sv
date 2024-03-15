class arb_test extends base_test;
  `uvm_component_utils(arb_test)
    
  function new(string name = "arb_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task cfg_arb_mode;
    env.age.sequencer.set_arbitration(SEQ_ARB_STRICT_FIFO);
  endtask
endclass





