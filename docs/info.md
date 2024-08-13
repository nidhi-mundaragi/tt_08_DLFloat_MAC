<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works
The digital design consists of three blocks : Reg_wrapper, Multiplier and Adder, in which adder and multiplier are clubbed together to form the MAC operation. The Reg_wrapper block finds it’s use in concatenating two 8 bit inputs to 16 bit registers as input operands for the MAC operation. This block efficiently handles having limited number of input pins aligning with the tiny tapeout specifications to getting the 16 bit operands ready. Here the addition and multiplication follows the IEEE754 algorithm and the Mac operation incorporates handling the special cases like inf, NaN and zero and full 16 bit precision range.

## How to test

Testing can be done using linear testbench with dut being driven with 16 bit input stimulus every clock cycle

## External hardware

All output pins must be connected to LEDs
