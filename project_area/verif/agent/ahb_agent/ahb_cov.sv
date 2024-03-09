class ahb_cov extends uvm_subscriber#(ahb_transaction);

  `uvm_component_utils(ahb_cov)

  uvm_analysis_imp#(ahb_transaction, ahb_cov)       ahb_cov_port;

  ahb_transaction   trans;

// functional coverage

  covergroup ahb_cg;
   option.per_instance=1;

 // ADDR:coverpoint trans.addr
 // {
 //   	bins b1={0};  
 //   	bins b1={1};  
 //   	bins b1={2};  
 //   	bins b1={4};  
 // }

  WRITE:coverpoint trans.write
  {
   	bins low={0};
	bins high={1};
    }

  READYOUT:coverpoint trans.readyout
  {
	bins high={1};
   	bins low={0};
  }

  RESP:coverpoint trans.resp
  {
   	bins low={0};
	bins high={1};
  }

  SELX:coverpoint trans.selx
  {
   	bins low={0};
	bins high={1};
  }

  SIZE:coverpoint trans.size
  {
    	bins b1={0};
    	bins b2={1};
    	bins b3={2};
    	bins b4={3};
  }

  TRANS:coverpoint trans.trans
  {
    	bins b1={0};
    	bins b2={1};
    	bins b3={2};
    	bins b4={3};
  }
  READY:coverpoint trans.ready
  {
   	bins low={0};
	bins high={1};
  }


  
  //AWADDR_WDATA:cross AWADDR,WRITE_DATA;
  //ARADDR_RDATA:cross ARADDR,READ_DATA;

endgroup : ahb_cg
  

function new(string name="ahb_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   ahb_cov_port = new("ahb_cov_port", this);
    trans = ahb_transaction::type_id::create("trans", this);
  endfunction:build_phase

  function void write(ahb_transaction   t);

    `uvm_info("AHB_AGENT_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("AHB_AGENT_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:ahb_cov
