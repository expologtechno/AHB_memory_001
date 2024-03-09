//---------------------------------------------------------------------------------------//
/*------------------------------reset_sequence-------------------------------------------*/
//---------------------------------------------------------------------------------------//
class reset_seq extends ahb_sequence;

	`uvm_object_utils(reset_seq)
extern function new(string name ="reset_seq");
extern task body();
int i;
endclass
//--------------constructor--------------------------
function reset_seq:: new(string name="reset_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task reset_seq::body();

	begin
		trans=ahb_transaction::type_id::create("trans");



		start_item(trans);
		 	assert(trans.randomize() with {  
							trans.resetn  == 1'b0;
							trans.datalen == 16'h1;  
						trans.size    == 3'h0; 
						trans.trans   == 2'b0; 
						trans.ready   == 1'b0;
						trans.write   == 1'b0;
		       				trans.addr[0] == 16'h00; 
						trans.wdata[0] == 32'h0;
					});	

		finish_item(trans);
		get_response(rsp);

		start_item(trans);
		 	assert(trans.randomize() with {  
							trans.resetn  == 1'b1; 
							trans.datalen == 16'h1;  
							trans.size    == 3'h0; 
							trans.trans   == 2'b0; 
							trans.ready   == 1'b0;
							trans.write   == 1'b0;
		       					trans.addr[0] == 16'h00; 
							trans.wdata[0] == 32'h0;
							});	

		finish_item(trans);
		get_response(rsp);


		end
	
endtask

