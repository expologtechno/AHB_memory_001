//---------------------------------------------------------------------------------------//
//---------------------------------- write_read_test--------------------------------------/
//---------------------------------------------------------------------------------------//
	
class w_r_seq extends ahb_sequence;
	`uvm_object_utils(w_r_seq)
	
reg [31:0] temp[7];
int i;

extern function new(string name ="w_r_seq");
extern task body();

endclass

//---------------------------------------------constructor-----------------------------------
function w_r_seq:: new(string name="w_r_seq");
	super.new(name);
endfunction



//-----------------------------------------------task body------------------------------------
task w_r_seq::body();
begin
		trans=ahb_transaction::type_id::create("trans");
	
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 3'h4;  
		       					trans.addr[0] == 16'h01; 
							trans.addr[1] == 16'h12; 
							trans.addr[2] == 16'h24;
							trans.addr[3] == 16'h18; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		foreach(trans.wdata[i])begin
		temp[i] = trans.wdata[i];
			`uvm_info("---------------------------------------STORING WDATA IN TEMP -----------------------------------------",$sformatf("[%0t] temp[i] =%0h wdata=%0h",$time, temp[i],trans.wdata[i]),UVM_HIGH )
		end

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 3'h4;
							trans.addr[0] == 16'h01;
							trans.addr[1] == 16'h12; 
							trans.addr[2] == 16'h24;
							trans.addr[3] == 16'h18; 
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		
		foreach(rsp.rdata[i])begin
	if(rsp.rdata[i] == temp[i])
		begin
		`uvm_info(get_type_name()," =============================================================SEQUENCE DATA MATCH========================================",UVM_LOW )
		`uvm_info("-------------------- DATA_MATCH---------------------------",$sformatf("[%0t] temp[i] =%0h rdata=%0h",$time, temp[i],rsp.rdata[i]),UVM_LOW )
		end
	else
		begin
		`uvm_info(get_type_name(),"==========================================================SEQUENCE DATA MISMATCH ==========================================",UVM_LOW )
		`uvm_info("-------------------- DATA_MISMATCH---------------------------",$sformatf("[%0t] temp[i] =%0h rdata=%0h",$time, temp[i],rsp.rdata[i]),UVM_LOW )
		end
	end

end	
endtask


