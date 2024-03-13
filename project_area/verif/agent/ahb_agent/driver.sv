//================================= DRIVER ==========================================/

class ahb_driver extends uvm_driver#(ahb_transaction);
	`uvm_component_utils(ahb_driver)
	 
	 virtual ahb_intf intf_h;
	 ahb_transaction trans;
	 age_config age_cn;

//--------------------------------------constructor-------------------------------	 
function new(string name="ahb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

//--------------------------------------build_phase-------------------------------
function void build_phase(uvm_phase phase);
	super.build_phase(phase);

`uvm_info("DRIVER",$sformatf("ENTERED DRIVER"),UVM_MEDIUM)
	 
	trans=ahb_transaction::type_id::create("trans",this);

	if(!uvm_config_db#(age_config)::get(this,"*","age_config",age_cn))
		`uvm_fatal("MASTER_AGT_CONFIG","cannot get() ag_con_h from uvm_config");
	
endfunction

//----------------------------connect_phase--------------------------------------
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	intf_h=age_cn.intf_h;
`uvm_info("DRIVER",$sformatf("ENTERED CONNECT DRIVER"),UVM_MEDIUM)

endfunction



//------------------------------run_phase ----------------------------------------
task run_phase(uvm_phase phase);
		`uvm_info("DRIVER",$sformatf("ENTERED RUN DRIVER"),UVM_MEDIUM)

forever begin

		@(posedge intf_h.hclk);
		if(!intf_h.hresetn)begin
			intf_h.hwrite <=0; 
   			intf_h.haddr  <=0; 
  			intf_h.hwdata <=0; 
  			intf_h.hsize  <=0; 
  			intf_h.htrans <=0; 
  			intf_h.hready <=0; 
			end	
		else begin
				seq_item_port.get_next_item(trans);
				for(int i=0; i<trans.datalen; i++) begin
				//	wait(intf_h.hreadyout);
					if(trans.write)begin
							intf_h.cb_tb.hready <= trans.ready;
							intf_h.cb_tb.hsize  <= trans.size;
							intf_h.cb_tb.hwrite <= trans.write;
						//	intf_h.cb_tb.hresetn  <= trans.resetn;
							intf_h.cb_tb.htrans <= trans.trans;
							intf_h.cb_tb.hselx  <= 1;
							intf_h.cb_tb.haddr  <= trans.addr[i];
							@(posedge intf_h.hclk);
					        	intf_h.cb_tb.hwdata <= trans.wdata[i];
							@(posedge intf_h.hclk);
							intf_h.cb_tb.hselx  <= 0;

					end

					else begin
							intf_h.cb_tb.hwrite <= trans.write;
							intf_h.cb_tb.hready <= trans.ready;
							intf_h.cb_tb.hsize  <= trans.size;
						//	intf_h.cb_tb.hresetn  <= trans.resetn;
							intf_h.cb_tb.htrans <= trans.trans;
							intf_h.cb_tb.hselx  <= 1;
							intf_h.cb_tb.haddr  <= trans.addr[i];
							@(posedge intf_h.hclk);
							@(negedge intf_h.hclk);
					//todo		@(posedge intf_h.cb_tb);
						       // @(negedge intf_h.cb_tb);
							trans.rdata[i]= intf_h.hrdata;
							@(posedge intf_h.hclk);
							intf_h.cb_tb.hselx  <= 0;
						end
						
						$display($time,"=================================================================== DRIVER_DISPLAY_STARTED  ========================================\n" );
						`uvm_info("DRIVER ",$sformatf("[%0t] write=%0h intf_h.hselx =%0h trans=%0h addr=%0h  wdata = %0h resetn=%0b",$time,trans.write, intf_h.hselx, trans.trans, trans.addr[i], trans.wdata[i],trans.resetn),UVM_LOW)
						`uvm_info("DRIVER ",$sformatf("[%0t] write=%0h intf_h.hselx= %0h trans=%0h addr=%0h  rdata = %0h resetn=%0b ",$time,trans.write, intf_h.hselx, trans.trans, trans.addr[i],  trans.rdata[i],trans.resetn),UVM_LOW)

						$display($time,"====================================================================================================================================\n" );
					rsp=trans;
					rsp.set_id_info(trans);
					//seq_item_port.item_done(trans);
					end
				seq_item_port.item_done(rsp);
			end

end
endtask
	 
endclass

