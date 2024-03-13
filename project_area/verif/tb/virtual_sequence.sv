class virtual_sequence extends uvm_sequence#(ahb_transaction);
  `uvm_object_utils(virtual_sequence)
 virtual ahb_intf intf_h; 
  env_config env_cn;
  virtual_sequencer v_seqr;
  ahb_sequencer sequencer;

  function new(string name="virtual_sequence");
    super.new(name);
  endfunction 
  
  virtual task pre_body();
    if(starting_phase != null) starting_phase.raise_objection(this);
  endtask

  virtual task body();
    env_cn=env_config::type_id::create("env_cn");
    $display("virt sequence body");
    if (!uvm_config_db#(env_config)::get(null,get_full_name(),"env_config",env_cn))
      `uvm_fatal("virt_sequence","getting env config unsuccessful")
  
    assert($cast(v_seqr,m_sequencer))
    else begin
      `uvm_fatal("virt sequence","casting failed")
    end  
    sequencer = v_seqr.sequencer;	
    $display(" after virt sequence body");	
  endtask	
  
  virtual task post_body();
    if(starting_phase != null) starting_phase.drop_objection(this);
  endtask

endclass  

//---------------------------------------------------------------------------------------//
/************************* wr_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_wr_sequence extends virtual_sequence; 
  `uvm_object_utils(virt_wr_sequence)
  
 // virtual_sequencer v_seqr;
  w_r_seq wr_seq;



/************** constructor*******************/
function new(string name="virt_wr_sequence");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" sequence task body");	
  wr_seq=w_r_seq::type_id::create("wr_seq");
  wr_seq.start(sequencer);
  $display(" sequence task1 body");	
endtask  
endclass

////---------------------------------------------------------------------------------------//
///************************* reset_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_reset_seq extends virtual_sequence; 
  `uvm_object_utils(virt_reset_seq)
  
 // virtual_sequencer v_seqr;
  reset_seq reset_seq_h;



/************** constructor*******************/
function new(string name="virt_reset_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" reset sequence task body");	
  reset_seq_h=reset_seq::type_id::create("reset_seq_h");
  reset_seq_h.start(sequencer);
  $display(" reset sequence task1 body");	
endtask  
endclass

////---------------------------------------------------------------------------------------//
///************************* sanity_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_sanity_seq extends virtual_sequence; 
  `uvm_object_utils(virt_sanity_seq)
  
 // virtual_sequencer v_seqr;
sanity_seq sanity_seq_h;


/************** constructor*******************/
function new(string name="virt_sanity_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" sanity sequence task body");
  sanity_seq_h=sanity_seq::type_id::create("sanity_seq_h");  
  sanity_seq_h.start(sequencer);
  $display(" sanity sequence task1 body");	
endtask  
endclass


//---------------------------------------------------------------------------------------//
/************************* incr4_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_idle_seq extends virtual_sequence; 
  `uvm_object_utils(virt_idle_seq)
  
idle_seq idle_seq_h;


/************** constructor*******************/
function new(string name="virt_idle_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" idle sequence task body");	
  idle_seq_h=idle_seq::type_id::create("idle_seq_h");
  idle_seq_h.start(sequencer);
  $display(" idle sequence task1 body");	
endtask  
endclass


//---------------------------------------------------------------------------------------//
/************************* wait_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_wait_seq extends virtual_sequence; 
  `uvm_object_utils(virt_wait_seq)
  
wait_seq wait_seq_h;


/************** constructor*******************/
function new(string name="virt_wait_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" wait sequence task body");	
  wait_seq_h=wait_seq::type_id::create("wait_seq_h");
  wait_seq_h.start(sequencer);
  $display(" wait sequence task1 body");	
endtask  
endclass



//---------------------------------------------------------------------------------------//
/************************* mul_write_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_mul_w_seq extends virtual_sequence; 
  `uvm_object_utils(virt_mul_w_seq)
  
mul_w_seq mul_w_seq_h;


/************** constructor*******************/
function new(string name="virt_mul_w_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" multiple write sequence task body");	
  mul_w_seq_h=mul_w_seq::type_id::create("mul_w_seq_h");
  mul_w_seq_h.start(sequencer);
  $display(" multiple write sequence task1 body");	
endtask  
endclass



////---------------------------------------------------------------------------------------//
///************************* size_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_size_seq extends virtual_sequence; 
  `uvm_object_utils(virt_size_seq)
  
 // virtual_sequencer v_seqr;
size_seq size_seq_h;


/************** constructor*******************/
function new(string name="virt_size_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" size sequence task body");
size_seq_h=size_seq::type_id::create("size_seq_h");  
  size_seq_h.start(sequencer);
  $display(" size sequence task1 body");	
endtask  
endclass


////---------------------------------------------------------------------------------------//
///************************* size0_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_size0_seq extends virtual_sequence; 
  `uvm_object_utils(virt_size0_seq)
  
 // virtual_sequencer v_seqr;
size0_seq size0_seq_h;


/************** constructor*******************/
function new(string name="virt_size0_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" size sequence task body");
size0_seq_h=size0_seq::type_id::create("size0_seq_h");  
  size0_seq_h.start(sequencer);
  $display(" size sequence task1 body");	
endtask  
endclass



////---------------------------------------------------------------------------------------//
///************************* size1_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_size1_seq extends virtual_sequence; 
  `uvm_object_utils(virt_size1_seq)
  
 // virtual_sequencer v_seqr;
size1_seq size1_seq_h;


/************** constructor*******************/
function new(string name="virt_size1_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" size sequence task body");
  size1_seq_h=size1_seq::type_id::create("size1_seq_h");  
  size1_seq_h.start(sequencer);
  $display(" size sequence task1 body");	
endtask  
endclass



////---------------------------------------------------------------------------------------//
///************************* full_memory_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_mem_full_seq extends virtual_sequence; 
  `uvm_object_utils(virt_mem_full_seq)
  
  mem_full_seq    mem_full_seq_h;

/************** constructor*******************/
function new(string name="virt_mem_full_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" size sequence task body");
  mem_full_seq_h = mem_full_seq::type_id::create("mem_full_seq_h");  
  mem_full_seq_h.start(sequencer);
  $display(" size sequence task1 body");	
endtask  
endclass


////---------------------------------------------------------------------------------------//
///************************* trans_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_trans_seq extends virtual_sequence; 
  `uvm_object_utils(virt_trans_seq)
  
 // virtual_sequencer v_seqr;
trans_seq trans_seq_h;


/************** constructor*******************/
function new(string name="virt_trans_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" trans sequence task body");
  trans_seq_h=trans_seq::type_id::create("trans_seq_h");  
  trans_seq_h.start(sequencer);
  $display(" trans sequence task1 body");	
endtask  
endclass




////---------------------------------------------------------------------------------------//
///************************* error_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_error_seq extends virtual_sequence; 
  `uvm_object_utils(virt_error_seq)
  
 // virtual_sequencer v_seqr;
error_seq error_seq_h;


/************** constructor*******************/
function new(string name="virt_error_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" error sequence task body");
  error_seq_h=error_seq::type_id::create("error_seq_h");  
  error_seq_h.start(sequencer);
  $display(" error sequence task1 body");	
endtask  
endclass


////---------------------------------------------------------------------------------------//
///************************* dummy_sequence************************************************/
//---------------------------------------------------------------------------------------//
class virt_dummy_seq extends virtual_sequence; 
  `uvm_object_utils(virt_dummy_seq)
  
 // virtual_sequencer v_seqr;
dummy_seq dummy_seq_h;


/************** constructor*******************/
function new(string name="virt_dummy_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task  body();
  super.body();
  $display(" dummy sequence task body");
  dummy_seq_h=dummy_seq::type_id::create("dummy_seq_h");  
  dummy_seq_h.start(sequencer);
  $display(" dummy sequence task1 body");	
endtask  
endclass
