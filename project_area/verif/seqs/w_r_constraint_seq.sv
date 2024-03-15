//---------------------------------------------------------------------------------------//
//---------------------------------- write_read_constraint_seq--------------------------------------/
//---------------------------------------------------------------------------------------//
	
class w_r_constraint_seq extends ahb_sequence;
	`uvm_object_utils(w_r_constraint_seq)
	
reg [31:0] temp[7];
int i;

extern function new(string name ="w_r_constraint_seq");
extern task body();

endclass

//---------------------------------------------constructor-----------------------------------
function w_r_constraint_seq:: new(string name="w_r_constraint_seq");
	super.new(name);
endfunction



//-----------------------------------------------task body------------------------------------
task w_r_constraint_seq::body();
begin
		trans=ahb_transaction::type_id::create("trans");
	
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h1;  
		       					trans.addr[0] == 16'h00; 
		       					trans.wdata[0] == 32'h00; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);


		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 16'h1;
		       					trans.addr[0] == 16'h00; 
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h1;  
		       					trans.addr[0] == 16'h00; 
		       					trans.wdata[0] == 32'hFFFFFFFF; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);


		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 16'h1;
		       					trans.addr[0] == 16'h00; 
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);





		for(int i=0; i<5; i++)begin

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h5;  
		       					//trans.addr[4] == 16'h13000; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

			`uvm_info("W_R_SEQ",$sformatf("[%0t]  %p  ",$time,rsp),UVM_LOW )

		
		foreach(rsp.addr[i]) begin
			temp[i] = rsp.addr[i];
		end			

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 16'h5;
							trans.addr[0] == temp[0]; //rsp.addr[0];
							trans.addr[1] == temp[1]; //rsp.addr[1];
							trans.addr[2] == temp[2]; //rsp.addr[2];
							trans.addr[3] == temp[3]; //rsp.addr[3];
							trans.addr[4] == temp[4]; //rsp.addr[4];
		       					//trans.addr[4] == 16'h13000; 
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
			`uvm_info("W_R_SEQ",$sformatf("[%0t]  %p  ",$time,rsp),UVM_LOW )
	
		end



end	
endtask
