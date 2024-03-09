coverage exclude -scope /top/dut -togglenode HRESP -comment "hresp is tied to zero in design." 
coverage exclude -scope /top/dut/u_ahb_ram_beh -togglenode {word_addr[0]} -comment "word alligned address which is not falls with in this address" 
