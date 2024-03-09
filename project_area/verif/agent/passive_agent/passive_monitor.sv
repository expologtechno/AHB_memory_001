//======================================= MONITOR ====================================/

class pass_monitor extends uvm_monitor;
	`uvm_component_utils(pass_monitor)

	virtual ahb_intf intf_h;
	pass_transaction pass_trans;	
	 page_config page_cn;

uvm_analysis_port#(pass_transaction) analysis_pass_port;

//-------------------constructor-----------------------
function new(string name="pass_monitor",uvm_component parent);
	super.new(name,parent);
	pass_trans=new();
	analysis_pass_port = new("analysis_pass_port",this);
endfunction
	
//-----------------------build_phase----------------------
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	`uvm_info("PASSIVE MONITOR",$sformatf("ENTERED PASSIVE MONITOR"),UVM_MEDIUM)
	if(!uvm_config_db#(page_config)::get(this,"*","page_config",page_cn))
	`uvm_fatal("MASTER_AGT_CONFIG","cannot get() ag_con_h from uvm_config");


endfunction

//--------------------------connect_phase----------------------
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	intf_h=page_cn.intf_h;
endfunction


//----------------------run_phase-------------------------------
task run_phase(uvm_phase phase);

	pass_trans=pass_transaction::type_id::create("pass_trans");

	forever begin
		
		@(posedge intf_h.hclk);	
		if(intf_h.hresetn)begin
			wait(intf_h.mon_cb.hselx);	
				if( !intf_h.mon_cb.hwrite )
					/*begin
						pass_trans.pwrite    =  intf_h.mon_cb.hwrite;
						pass_trans.pready    =  intf_h.mon_cb.hready;
						pass_trans.psize     =  intf_h.mon_cb.hsize;
						pass_trans.ptrans    =  intf_h.mon_cb.htrans;
						pass_trans.paddr[0]  =  intf_h.mon_cb.haddr;
						@(posedge intf_h.hclk);
						pass_trans.pwdata[0]    =  intf_h.mon_cb.hwdata;
					end
				else*/
					begin
					pass_trans.pwrite    =  intf_h.mon_cb.hwrite;
					pass_trans.pready    =  intf_h.mon_cb.hready;
					pass_trans.ptrans    =  intf_h.mon_cb.htrans;
					pass_trans.paddr[0]    =  intf_h.mon_cb.haddr;
					@(posedge intf_h.hclk);
					pass_trans.prdata[0] =  intf_h.mon_cb.hrdata;
					end

				else
					`uvm_info(get_type_name,"WRONG_DATA",UVM_LOW)
		end
			//	@(posedge intf_h.mon_cb);

				$display($time,"=================================================================== PASSIVE_MONITOR_DISPLAY_STARTED  ========================================\n" );
				//	`uvm_info("PASSIVE MONITOR",$sformatf("[%0t] pwrite=%0h ptrans=%0h intf_h.mon_cb.hselx=%0b paddr=%0h  pwdata = %0h",$time,pass_trans.pwrite, pass_trans.ptrans, intf_h.mon_cb.hselx, pass_trans.paddr[0], pass_trans.pwdata[0]),UVM_LOW)
					`uvm_info("PASSIVE MONITOR",$sformatf("[%0t] pwrite=%0h ptrans=%0h intf_h.mon_cb.hselx=%0b paddr=%0h  prdata = %0h",$time,pass_trans.pwrite, pass_trans.ptrans, intf_h.mon_cb.hselx, pass_trans.paddr[0],  pass_trans.prdata[0]),UVM_LOW)
                                                                                                                                                         
				$display($time,"===================================================================================================================================\n" );



analysis_pass_port.write(pass_trans);
end
endtask



endclass



