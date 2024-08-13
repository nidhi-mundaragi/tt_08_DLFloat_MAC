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
    dut.ui_in.value = 00
    dut.uio_in.value = 62

    # Wait for one clock cycle
    await ClockCycles(dut.clk, 1)

    # Set the input values b1=3
    dut.ui_in.value = 00
    dut.uio_in.value = 65

    # Wait for four clock cycle to see the output values
    await ClockCycles(dut.clk, 4)
    
    assert dut.uo_out.value == 00

    await ClockCycles(dut.clk, 1)
    
    assert dut.uo_out.value == 00


    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
