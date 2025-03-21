module csa #(parameter WIDTH = 4) 
(
            input [WIDTH-1:0] a,
            input [WIDTH-1:0] b,
            input [WIDTH-1:0] c,
            output [WIDTH:0] c_out,
            output [WIDTH-1:0] s
);
    genvar i;
    generate
        for(i=0;i<WIDTH;i=i+1)
        begin:gen
            full_adder FA(
                        .a(a[i]),
                        .b(b[i]),
                        .c_in(c[i]),
                        .c_out(c_out[i+1]),
                        .s(s[i])
                    );
        end
    endgenerate

    assign c_out[0] = 1'b0;
endmodule