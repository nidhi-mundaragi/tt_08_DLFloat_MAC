# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")
    
    # Set the input values a1=1
    dut.ui_in.value = 0
    dut.uio_in.value = 62
    await ClockCycles(dut.clk, 1)
    # Set the input values b1=3
    dut.ui_in.value = 0
    dut.uio_in.value = 65
    await ClockCycles(dut.clk, 1)
    # Set the input values a2=1
    dut.ui_in.value = 0
    dut.uio_in.value = 62
    await ClockCycles(dut.clk, 1)
    # Set the input values b2=2
    dut.ui_in.value = 0
    dut.uio_in.value = 64
    await ClockCycles(dut.clk, 1)
     # Set the input values a3=1
    dut.ui_in.value = 0
    dut.uio_in.value = 62
    await ClockCycles(dut.clk, 1)
    # Set the input values b3=4
    dut.ui_in.value = 0
    dut.uio_in.value = 66
    
   
   
    # Wait for five clock cycle to see the output values
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 65
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 128
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 66
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 64
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 68
    
   
    


   
