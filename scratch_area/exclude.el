coverage exclude -scope /tb_top/dut -togglenode HRESP -comment "HRESP has been tied to zero in design" 
coverage exclude -scope /tb_top/dut/u_ahb_ram_beh -togglenode {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]} {i[8]} {i[9]}
coverage exclude -scope /tb_top/dut/u_ahb_ram_beh -togglenode {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]} {i[18]} {i[19]}
coverage exclude -scope /tb_top/dut/u_ahb_ram_beh -togglenode {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]} {i[28]} {i[29]}
coverage exclude -scope /tb_top/dut/u_ahb_ram_beh -togglenode {i[30]} {i[31]} {nxt_word_addr[0]} {nxt_word_addr[1]} -comment "nxt_word_addr[1:0] has been tied to zero in design." 
coverage exclude -scope /tb_top/dut/u_ahb_ram_beh -togglenode {word_addr[0]} {word_addr[1]} -comment "word_addr[1:0] has been tied to zero in design." 
