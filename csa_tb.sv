module tb();
  reg [5:0] a;
  reg [5:0] b;
  reg [5:0] c;
  wire [6:0] c_out;
  wire [5:0] s;
  
  csa dut(
    .a(a),
    .b(b),
    .c(c),
    .c_out(c_out),
    .s(s)
  );
  
  initial begin
  	a = 0;
    b=0;
    c=0;
    
    #5
    a=40;
    b=25;
    c=20;
    
    #5
    a=$random;
    b=$random;
    c=$random;
    
    #5
    a=$random;
    b=$random;
    c=$random;
  end
  
  initial begin
    $monitor("a: %0d, b: %0d, c: %0d, c_out: %0d, s: %0d, sum: %0d", a, b, c, c_out, s, c_out+s);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end
  
endmodule