module adder8(cout, sum, a, b, cin);
  
  output cout;
  output[7:0] sum;
  input[7:0] a, b;
  input cin;

  assign {cout, sum} = {1'b0, a} + {1'b0, b} + {{8{1'b0}}, cin};

endmodule
