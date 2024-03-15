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
							trans.datalen == 16'h5;  
		       					trans.addr[0] == 16'h00; 
		       					trans.addr[1] == 16'h3A98;//15000 
		       					trans.addr[2] == 16'h6D60; //28000
		       					trans.addr[3] == 16'hAFC8;//45000 
		       					trans.addr[4] == 16'hF618; //63000
		       					trans.wdata[0] == 32'h00; 
		       					trans.wdata[1] == 32'h00; 
		       					trans.wdata[2] == 32'h00; 
		       					trans.wdata[3] == 32'h00; 
		       					trans.wdata[4] == 32'h00; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);


		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 16'h5;
							//trans.addr[0] == 16'h00;
		       					trans.addr[0] == 16'h00; 
		       					trans.addr[1] == 16'h3A98;//15000 
		       					trans.addr[2] == 16'h6D60; //28000
		       					trans.addr[3] == 16'hAFC8;//45000 
		       					trans.addr[4] == 16'hF618; //63000
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h5;  
		       				//	trans.addr[0] == 16'h00; 
		       				//	trans.addr[1] == 16'h3E80;//16000
		       				//	trans.addr[2] == 16'h6D60;//28000
		       				//	trans.addr[3] == 16'hB3B0;//33000
		       				//	trans.addr[4] == 16'hFDE8;
		       					trans.addr[0] == 16'h00; 
		       					trans.addr[1] == 16'h3A98;//15000 
		       					trans.addr[2] == 16'h6D60; //28000
		       					trans.addr[3] == 16'hAFC8;//45000 
		       					trans.addr[4] == 16'hF618; //63000
		       					trans.wdata[0] == 32'hFFFFFFFF; 
		       					trans.wdata[1] == 32'hFFFFFFFF; 
		       					trans.wdata[2] == 32'hFFFFFFFF; 
		       					trans.wdata[3] == 32'hFFFFFFFF; 
		       					trans.wdata[4] == 32'hFFFFFFFF; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);


		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 16'h5;
		       				//	trans.addr[0] == 16'h00; 
		       				//	trans.addr[1] == 16'h3E80;
		       				//	trans.addr[2] == 16'h8CA0;
		       				//	trans.addr[3] == 16'hDEA8;
		       				//	trans.addr[4] == 16'hFDE8;
		       					trans.addr[0] == 16'h00; 
		       					trans.addr[1] == 16'h3A98;//15000 
		       					trans.addr[2] == 16'h6D60; //28000
		       					trans.addr[3] == 16'hAFC8;//45000 
		       					trans.addr[4] == 16'hF618; //63000
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
	
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h5;  
		       					trans.addr[4] == 16'h13000; 
		       					//trans.wdata[0] == 32'hFFFFFFFF; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

			`uvm_info("W_R_SEQ",$sformatf("[%0t]  %p  ",$time,rsp),UVM_LOW )

			`uvm_info("---------------------------------------W_R_SEQ-----------------------------------------",$sformatf("[%0t]  addr[0]=%0h addr[1]=%0h addr[2]=%0h addr[4]=%0h  ",$time,rsp.addr[0], rsp.addr[1],rsp.addr[2],rsp.addr[4]),UVM_LOW )
		
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
		//foreach(trans.addr[i])begin
			`uvm_info("---------------------------------------W_R_SEQ_ADDR -----------------------------------------",$sformatf("[%0t] addr[0]=%0h  addr[1]=%0h  addr[2]=%0h addr[0]=%0h",$time, trans.addr[0],  trans.addr[1],  trans.addr[2]  ,trans.addr[4]          ),UVM_LOW )
	
		//end
		




		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h5;  
		       					trans.addr[0] == 16'h36B0; //h14000
		       					trans.addr[1] == 16'h6978; //h27000
		       					trans.addr[2] == 16'hA028; //h41000
		       					trans.addr[3] == 16'hDAC0; //h56000
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

			`uvm_info("W_R_SEQ",$sformatf("[%0t]  %p  ",$time,rsp),UVM_LOW )

			`uvm_info("---------------------------------------W_R_SEQ-----------------------------------------",$sformatf("[%0t]  addr[0]=%0h addr[1]=%0h addr[2]=%0h addr[4]=%0h  ",$time,rsp.addr[0], rsp.addr[1],rsp.addr[2],rsp.addr[4]),UVM_LOW )
		
		foreach(rsp.addr[i]) begin
			temp[i] = rsp.addr[i];
		end			

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 16'h5;
							trans.addr[0] == temp[0]; 
							trans.addr[1] == temp[1]; 
							trans.addr[2] == temp[2]; 
							trans.addr[3] == temp[3]; 
							trans.addr[4] == temp[4]; 
		       					//trans.addr[4] == 16'h13000; 
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
			`uvm_info("W_R_SEQ",$sformatf("[%0t]  %p  ",$time,rsp),UVM_LOW )
		//foreach(trans.addr[i])begin
			`uvm_info("---------------------------------------W_R_SEQ_ADDR -----------------------------------------",$sformatf("[%0t] addr[0]=%0h  addr[1]=%0h  addr[2]=%0h addr[0]=%0h",$time, trans.addr[0],  trans.addr[1],  trans.addr[2]  ,trans.addr[4]          ),UVM_LOW )
end	
endtask


