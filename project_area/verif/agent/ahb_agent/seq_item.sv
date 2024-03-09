//======================= TRANSACTION =====================================/
class ahb_transaction extends uvm_sequence_item;

`uvm_object_utils(ahb_transaction)
	rand	bit resetn;
       rand	bit[15:0] addr[];
	rand 	bit[31:0] wdata[];
		bit[31:0] rdata[];
    //  rand	bit[15:0] addr[65536]; //16x4096
    //  rand 	bit[31:0] wdata[65536];
     // 	bit[31:0] rdata[65536];
		rand	bit write;
		bit readyout;
		bit resp;
		bit selx ;
		bit mastlock;
	rand	bit ready;
	rand 	bit[2:0] brust;	
	rand 	bit[3:0] port;
	rand 	bit[2:0] size;
	rand 	bit[1:0] trans;

       rand bit[15:0] datalen;

      constraint addr_con {  addr.size() == datalen;}
      constraint wdata_con { wdata.size() == datalen;}

//--------------------------constructor--------------------------------	
function new(string name="ahb_transaction");
super.new(name);
endfunction

function void pre_randomize();
	rdata = new[datalen];
endfunction
	
endclass

