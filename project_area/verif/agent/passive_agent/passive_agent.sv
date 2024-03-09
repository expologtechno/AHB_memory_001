/************  AGENT ********************/

class pass_agent extends uvm_agent;

	`uvm_component_utils(pass_agent)
       	
	page_config page_cn;
	pass_monitor monitor;

//---------constructor------------------
function new(string name = "pass_agent",uvm_component parent);
	super.new(name,parent);
endfunction

//---------------------build_phase----------------------
function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	`uvm_info("PASSIVE AGENT",$sformatf("ENTERED PASSIVE AGENT"),UVM_MEDIUM)

	if(!uvm_config_db#(page_config)::get(this,"*","page_config",page_cn))
	`uvm_fatal("MASTER_AGT_CONFIG","cannot get() ag_con_h from uvm_config");


	monitor = pass_monitor::type_id::create("monitor",this);
	page_cn=page_config::type_id::create("page_cn",this);


endfunction

endclass
