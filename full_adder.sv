module full_adder (
                    input a,
                    input b,
                    input c_in,
                    output c_out,
                    output s
);
    assign s = a^b^c_in;
    assign c_out= (a&b) | (a&c_in) | (b&c_in);
endmodule