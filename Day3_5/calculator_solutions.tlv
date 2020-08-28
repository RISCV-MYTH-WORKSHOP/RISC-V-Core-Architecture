\m4_TLV_version 1d: tl-x.org
\SV
//Calculator labs solutions here

//LAB1: TASK 2: 
$reset = *reset;
   // MUX 2:1
   $out = $sel ? $in1 : $in2;
   
   //Combinational calculator
   $val1[31:0] = $rand1[3:0];
   $val2[31:0] = $rand2[3:0];
   $sum[31:0] = $val1[3:0] + $val2[3:0];
   $sub[31:0] = $val1[3:0] - $val2[3:0];
   $mul[31:0] = $val1[3:0] * $val2[3:0];
   $div[31:0] = $val1[3:0] / $val2[3:0];
   
   $out =  $sel[0] ? $sum[31:0] :
           $sel[1] ? $sub[31:0] : 
           $sel[2] ? $mul[31:0] :
           //default :
           $div[31:0];  

