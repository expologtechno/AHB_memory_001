//======================= TRANSACTION =====================================/
class pass_transaction extends uvm_sequence_item;

`uvm_object_utils(pass_transaction)

		bit[15:0] paddr[5];
		bit[31:0] pwdata[5];
		bit [31:0] prdata[5];
		bit pwrite;
		bit preadyout;
		bit presp;
		bit pselx ;
		bit pmastlock;
		bit pready;
	 	bit[2:0] pbrust;	
	 	bit[3:0] pport;
	 	bit[2:0] psize;
	 	bit[1:0] ptrans;

      
//--------------------------constructor--------------------------------	
function new(string name="pass_transaction");
super.new(name);
endfunction


endclass

