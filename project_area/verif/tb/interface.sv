/************** INTERFACE ***************/

interface ahb_intf(input bit hclk);

	
	logic hresetn;
	logic [15:0] haddr;
	logic [31:0] hwdata;
	logic [31:0] hrdata;
	logic hwrite;
	logic hreadyout;
	logic hresp;
	logic hselx;
	logic hmastlock;
	logic hready;
	logic [2:0] hbrust;	
	logic [3:0] hport;
	logic [2:0] hsize;
	logic [1:0] htrans;
	//--------CLOCKING BLOCK-----------------
	
clocking cb_tb @(posedge hclk);
	default input #0 output #0;
	input hrdata;
	input hreadyout;
	input hresp;
	
	output hready;
	output hresetn;
	output hwdata;
	output haddr;
	output hwrite;
	output hselx;
	output hmastlock;
	output hbrust;
	output hport;
	output hsize;
	output htrans;
	
endclocking


//monitor clocking block
clocking mon_cb@(posedge hclk);
	default input #1 output #1;
	input hclk;
	input hresetn;
	input hrdata;
	input hreadyout;
	input hresp;
	input hready;
	input hwdata;
	input haddr;
	input hwrite;
	input hselx;
	input hmastlock;
	input hbrust;
	input hport;
	input hsize;
	input htrans;
endclocking
//----------------MODPORT------------

modport mon_mp(clocking mon_cb);
modport dri_mp(clocking cb_tb);
	
	

endinterface



