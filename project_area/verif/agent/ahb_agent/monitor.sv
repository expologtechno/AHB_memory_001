//======================================= MONITOR ====================================/

/*class ahb_monitor extends uvm_monitor;
	`uvm_component_utils(ahb_monitor)
	
	//int i;
	ahb_transaction trans;
	virtual ahb_intf intf_h;
	age_config age_cn;

uvm_analysis_port#(ahb_transaction) analysis_port;

//-------------------constructor-----------------------
function new(string name="ahb_monitor",uvm_component parent);
	super.new(name,parent);
	trans=new();
	analysis_port = new("analysis_port",this);
endfunction
	
//-----------------------build_phase----------------------
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	`uvm_info("MONITOR",$sformatf("ENTERED MONITOR"),UVM_MEDIUM)
	if(!uvm_config_db#(age_config)::get(this,"*","age_config",age_cn))
	`uvm_fatal("MASTER_AGT_CONFIG","cannot get() ag_con_h from uvm_config");

endfunction

//--------------------------connect_phase----------------------
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	intf_h= age_cn.intf_h;
endfunction


//----------------------run_phase-------------------------------
task run_phase(uvm_phase phase);

	trans=ahb_transaction::type_id::create("trans");
	`uvm_info("ahb_mon","monitor run phase", UVM_LOW)

	forever begin
		
		@(negedge intf_h.hclk);
		if(intf_h.hresetn)begin
			if(intf_h.mon_cb.hselx)begin	
				if( intf_h.mon_cb.hwrite )begin
						trans.write    =  intf_h.mon_cb.hwrite;
						trans.ready    =  intf_h.mon_cb.hready;
						trans.size     =  intf_h.mon_cb.hsize;
						trans.trans    =  intf_h.mon_cb.htrans;
						trans.addr[0]    =  intf_h.mon_cb.haddr;
						@(negedge intf_h.hclk);
						trans.wdata[0]    =  intf_h.mon_cb.hwdata;
					end
				else
					begin
					trans.write    =  intf_h.mon_cb.hwrite;
					trans.ready    =  intf_h.mon_cb.hready;
					trans.size     =  intf_h.mon_cb.hsize;
					trans.trans    =  intf_h.mon_cb.htrans;
					trans.addr[0]    =  intf_h.mon_cb.haddr;
					@(negedge intf_h.hclk);
					trans.rdata[0] =  intf_h.mon_cb.hrdata;
					end
			analysis_port.write(trans);
				$display($time,"=================================================================== MONITOR_DISPLAY_STARTED  ========================================\n" );
					`uvm_info("MONITOR",$sformatf("[%0t] write=%0h trans=%0h intf_h.mon_cb.hselx=%0b addr=%0h  wdata = %0h",$time,trans.write, trans.trans, intf_h.mon_cb.hselx, trans.addr[0], trans.wdata[0]),UVM_LOW)
					`uvm_info("MONITOR",$sformatf("[%0t] write=%0h trans=%0h intf_h.mon_cb.hselx=%0b addr=%0h  rdata = %0h",$time,trans.write, trans.trans, intf_h.mon_cb.hselx, trans.addr[0],  trans.rdata[0]),UVM_LOW)

				$display($time,"=====================================================================================================================================\n" );
		   end
	     end


	end
endtask



endclass*/

//======================================= MONITOR ====================================/

class ahb_monitor extends uvm_monitor;
	`uvm_component_utils(ahb_monitor)
	
	//int i;
	ahb_transaction trans;
	virtual ahb_intf intf_h;
	age_config age_cn;

uvm_analysis_port#(ahb_transaction) analysis_port;
// functional coverage

  covergroup ahb_cg;
   option.per_instance=1;

  MEM_ADDR: coverpoint trans.addr[0]
  {
	bins addr_bin1[5] = {[0:65535]};
  }
  WRITE:coverpoint trans.write
  {
   	bins low={0};
	bins high={1};
    }


  SIZE:coverpoint trans.size
  {
    	bins c1={0};
    	bins c2={1};
    	bins c3={2};
    	//bins c4={3}; //DB not supported
  }

  TYPE_TRANS:coverpoint trans.trans
  {
    	bins d1={0};
    	bins d2={1};
    	bins d3={2};
    	bins d4={3};
  }
 
MEM_DATA:coverpoint trans.wdata[0]
{
	bins data_bin[5] = {[1:32'hFFFFFFFE]};
	bins bin_0 = {32'h00000000};
	bins bin_f = {32'hFFFFFFFF};
}

MEM_READ_DATA:coverpoint trans.rdata[0]
{
	bins rdata_bin[5] = {[1:32'hFFFFFFFE]};
	bins rbin_0 = {32'h00000000};
	bins rbin_f_ = {32'hFFFFFFFF};
}
  
  AWADDR_WDATA:cross MEM_ADDR,MEM_DATA;
  ARADDR_RDATA:cross MEM_ADDR,MEM_READ_DATA;

endgroup : ahb_cg
  

//-------------------constructor-----------------------
function new(string name="ahb_monitor",uvm_component parent);
	super.new(name,parent);
	trans=new();
	analysis_port = new("analysis_port",this);
	ahb_cg=new();
endfunction
	
//-----------------------build_phase----------------------
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	`uvm_info("MONITOR",$sformatf("ENTERED MONITOR"),UVM_MEDIUM)
	if(!uvm_config_db#(age_config)::get(this,"*","age_config",age_cn))
	`uvm_fatal("MASTER_AGT_CONFIG","cannot get() ag_con_h from uvm_config");

endfunction

//--------------------------connect_phase----------------------
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	intf_h= age_cn.intf_h;
endfunction


//----------------------run_phase-------------------------------
task run_phase(uvm_phase phase);

	trans=ahb_transaction::type_id::create("trans");
	trans.addr = new[1];
	trans.wdata = new[1];
	trans.rdata = new[1];

	`uvm_info("ahb_mon","monitor run phase", UVM_LOW)

	forever begin
		
		@(negedge intf_h.hclk);
		if(intf_h.hresetn)begin
			if(intf_h.mon_cb.hselx)begin	
				if( intf_h.mon_cb.hwrite )begin
						trans.write    =  intf_h.mon_cb.hwrite;
						trans.ready    =  intf_h.mon_cb.hready;
						trans.size     =  intf_h.mon_cb.hsize;
						trans.trans    =  intf_h.mon_cb.htrans;
						trans.addr[0]    =  intf_h.mon_cb.haddr;
						@(negedge intf_h.hclk);
						trans.wdata[0]    =  intf_h.mon_cb.hwdata;
					end
				else
					begin
					trans.write    =  intf_h.mon_cb.hwrite;
					trans.ready    =  intf_h.mon_cb.hready;
					trans.size     =  intf_h.mon_cb.hsize;
					trans.trans    =  intf_h.mon_cb.htrans;
					trans.addr[0]   =  intf_h.mon_cb.haddr;
					@(negedge intf_h.hclk);
					trans.rdata[0] =  intf_h.mon_cb.hrdata;
					end
			analysis_port.write(trans);
				$display($time,"=================================================================== MONITOR_DISPLAY_STARTED  ========================================\n" );
					`uvm_info("MONITOR",$sformatf("[%0t] write=%0h trans=%0h intf_h.mon_cb.hselx=%0b addr=%0h  wdata = %0h",$time,trans.write, trans.trans, intf_h.mon_cb.hselx, trans.addr[0], trans.wdata[0]),UVM_LOW)
					`uvm_info("MONITOR",$sformatf("[%0t] write=%0h trans=%0h intf_h.mon_cb.hselx=%0b addr=%0h  rdata = %0h",$time,trans.write, trans.trans, intf_h.mon_cb.hselx, trans.addr[0],  trans.rdata[0]),UVM_LOW)

				$display($time,"=====================================================================================================================================\n" );
		   end
	     end
ahb_cg.sample();

	end
endtask



endclass
