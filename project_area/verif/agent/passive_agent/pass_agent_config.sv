/*********************PASSIVE_AGENT_CONFIG********************/
class page_config extends uvm_object;
	`uvm_object_utils(page_config)
	virtual ahb_intf intf_h;

//----------CONSTRUCTOR----------------------	
 function new(string name="page_config");
	super.new(name);
endfunction

endclass	
