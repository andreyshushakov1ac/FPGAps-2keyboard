module pspop_klav
(
input wire clk,
input wire data,
output reg [7:0] led,
output reg [6:0] sev, //семисегментный индикатор
output reg [6:0] sev2, //второй семиег инд

///
output reg [7:0] scancode // только цифры от 1 до 9
///

);
reg [7:0] data_curr;
reg [7:0] data_pre;
reg [3:0] b;
reg flag;
reg lang;

initial
begin
b<=4'h1;
flag<=1'b0;
data_curr<=8'hf0;
data_pre<=8'hf0;
led<=8'hf0;

sev2<=7'b1110011; //Изначально на русском
lang<=0; //индикатор стоит на 0 если на русском
end

always @(negedge clk)
begin
case(b)
1:;
2:data_curr[0]<=data;
3:data_curr[1]<=data;
4:data_curr[2]<=data;
5:data_curr[3]<=data;
6:data_curr[4]<=data;
7:data_curr[5]<=data;
8:data_curr[6]<=data;
9:data_curr[7]<=data;
10:flag<=1'b1;
11:flag<=1'b0;
endcase
if (b<=10)
b<=b+1;
else if (b==11)
b<=1;
end

always @ (posedge flag)
begin
if (data_curr==8'hf0)
begin
led<=data_pre;
///if (lang==0)///
///begin///


///
scancode <= data_pre;
///


case(data_pre)
8'h45:sev<=7'b1000000; //0
8'h16:sev<=7'b1111001; //1
8'h1E:sev<=7'b0100100; //2
8'h26:sev<=7'b0110000; //3
8'h25:sev<=7'b0011001; //4
8'h2E:sev<=7'b0010010; //5
8'h36:sev<=7'b0000010; //6
8'h3D:sev<=7'b1111000; //7
8'h3E:sev<=7'b0000000; //8
8'h46:sev<=7'b0010000; //9
endcase
///end///

/* ЗАДАНИЕ: ЕСЛИ  РУС, ТО НА 1 МЕНЬШЕ ПОКАЗЫВАЕТ
else if (lang==1) ///
begin///
case(data_pre)
8'h45:sev<=7'b1000000; //0
8'h16:sev<=7'b1000000; //1
8'h1E:sev<=7'b1111001; //2
8'h26:sev<=7'b0100100; //3
8'h25:sev<=7'b0110000; //4
8'h2E:sev<=7'b0011001; //5
8'h36:sev<=7'b0010010; //6
8'h3D:sev<=7'b0000010; //7
8'h3E:sev<=7'b1111000; //8
8'h46:sev<=7'b0000000; //9
endcase
end///
*/

end
if (data_curr==8'h11 && data_pre==8'h12)
begin
if (lang==0)
begin
sev2<=7'b0000110; //E
lang<=1;
end
else
begin
sev2<=7'b0001100; //P
lang<=0;
end
end
else
data_pre<=data_curr;
end
endmodule