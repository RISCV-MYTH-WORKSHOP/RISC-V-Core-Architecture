\m4_TLV_version 1d: tl-x.org
\SV
//RISC-V labs solutions here

//Next pc
$reset = *reset;

   $pc[31:0] = >>1$reset ? 0 :                  
                 (>>1$pc + 32'd4);
