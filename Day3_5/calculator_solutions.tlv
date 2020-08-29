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

//Fibonacci
$reset = *reset;

   $num[31:0] = $reset ? 1 :                  
                 (>>1$num + >>2$num); 
//Counter
$reset = *reset;
   $num[31:0] = $reset ? 0 :                  
                 (>>1$num + 1); 
                 
 //Sequential Calculator

 //Counter + Calculator
   |calc
      @1
         $reset = *reset;
         $val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];
         $val1[31:0] = >>1$out[31:0];
         $sum[31:0] = $val1[3:0] + $val2[3:0];
         $diff[31:0] = $val1[3:0] - $val2[3:0];
         $prod[31:0] = $val1[3:0] * $val2[3:0];
         $quot[31:0] = $val1[3:0] / $val2[3:0];
   
         $out[31:0] =  $reset ? 32'b0 :
              ($op[1:0] == 00) 
                ? $sum[31:0] :
              ($op[1:0] == 01)
                ? $diff[31:0] :
              ($op[1:0] == 2'b10) 
                ? $prod[31:0] :
              ($op[1:0] == 2'b11)
                ? $quot[31:0] :
             //default
                 32'b00;
             
         $reset = *reset;    
         $cnt[31:0] = $reset ? 0 :                  
                     (>>1$cnt + 1);


   //2 cycle calc
   |calc
      @0
         $reset = *reset;
         
      @1
         $valid = $cnt;
         $op[1:0] = $rand1[1:0];
         $val2[31:0] = $rand2[3:0];
         $val1[31:0] = >>2$out[31:0];
         $sum[31:0] = $val1[3:0] + $val2[3:0];
         $diff[31:0] = $val1[3:0] - $val2[3:0];
         $prod[31:0] = $val1[3:0] * $val2[3:0];
         $quot[31:0] = $val1[3:0] / $val2[3:0];
         
             
         $cnt[1:0] = $reset ? 0 :                  
                     (>>1$cnt[1:0] + 1);
                     
      @2
            
         $out[31:0] =  $reset ? 32'b0 :
           ($op[1:0] == 00) 
             ? $sum[31:0] :
           ($op[1:0] == 01)
             ? $diff[31:0] :
           ($op[1:0] == 2'b10) 
             ? $prod[31:0] :
           ($op[1:0] == 2'b11)
             ? $quot[31:0] :
           //default
               32'b00;
              
            
             
         
