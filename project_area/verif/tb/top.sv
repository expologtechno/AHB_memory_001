//`include "cmsdk_ahb_memory_models_defs.v"
//`include "cmsdk_ahb_ram.v"
//`include "cmsdk_ahb_ram_beh.v"
//`include "pack.sv"
//`include "interface.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "pack.svh"

module tb_top;

  bit hclk = 0;
  bit hresetn;

  //-------------------- clock_generation --------------------
  always #5 hclk = ~hclk;
	
 initial begin
    intf_h.hresetn=0;
    #50;
    intf_h.hresetn=1;
 end

  ahb_intf    intf_h( hclk );

  //-------------------- dut_instantiation --------------------
  cmsdk_ahb_ram  dut ( .HCLK(intf_h.hclk),
                       .HRESETn(intf_h.hresetn),
                       .HSEL(intf_h.hselx),
                       .HADDR(intf_h.haddr),
                       .HTRANS(intf_h.htrans),
                       .HSIZE(intf_h.hsize),
                       .HWRITE(intf_h.hwrite),
                       .HWDATA(intf_h.hwdata),
                       .HREADY(intf_h.hready),
                       .HREADYOUT(intf_h.hreadyout),
                       .HRDATA(intf_h.hrdata),
                       .HRESP(intf_h.hresp)
                     );

initial begin

	uvm_config_db #(virtual ahb_intf)::set(null,"*","ahb_intf",intf_h);
	`uvm_info("TOP",$sformatf("ENTERED TOP"),UVM_MEDIUM)

run_test();
end

/*initial begin
	#10000;
	$finish;
end*/

endmodule
