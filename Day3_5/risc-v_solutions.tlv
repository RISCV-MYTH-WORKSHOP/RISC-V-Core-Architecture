\m4_TLV_version 1d: tl-x.org
\SV
//RISC-V labs solutions here

//Next pc
$reset = *reset;

   $pc[31:0] = >>1$reset ? 0 :                  
                 (>>1$pc + 32'd4);
                 
                 
// fetch and decode along with next pc
|cpu
      @0
         $reset = *reset;

         $pc[31:0] = >>1$reset ? 0                   
                       : (>>1$pc + 32'd4);

         $imem_rd_en[1:0] = !$reset;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_CNT+1:2];

      @1
         $instr[31:0] = $imem_rd_data[31:0];
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001;
         $is_r_instr = $instr[6:2] ==? 5'b01x1x ||
                       $instr[6:2] ==? 5'bxx100;
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
    //decoding immediate fields
         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}},$instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:7]} :
                      $is_b_instr ? {{20{$instr[31]}},$instr[7], $instr[30:8]} :
                      $is_u_instr ? {$instr[31], $instr[30:12]} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21]};
      
      
      
