
# Logic Gate & Flip-Flop Simulator


## Overview
This project is a simple simulator for **Logic Gates** and **Flip-Flops** implemented in **Tcl**. It allows users to evaluate common logic gates (AND, OR, NAND, etc.) and flip-flop operations (SR, JK, D, T) by providing binary inputs.
 
## Installation
1. Install **Tcl** and **Tk** on your system if they are not already installed.
   - Download and install Tcl and Tk from [here](https://www.tcl.tk/software/tcltk/download.html).
2. Download the project files and navigate to the folder containing `LogicGate_FF_Simulator.tcl`.
3. Run `LogicGate_FF_Simulator.tcl` using the Tcl interpreter.

## Features
- Simulates various **Logic Gates**: AND, OR, NAND, NOR, XOR, XNOR, NOT.
- Simulates **Flip-Flops**: SR, JK, D, T.
- Provides error handling for invalid inputs.
- User-friendly **GUI** built using **Tk**.

## How to Use
1. Choose the mode: **Logic Gate** or **Flip-Flop**.
2. Enter the appropriate input for the selected operation (e.g., `AND 1 0` for Logic Gates or `SR 1 0 0` for Flip-Flops).
3. Click **Evaluate** to see the result.

## Example Inputs
### Logic Gate:
- `AND 1 0`
- `OR 0 1`
- `NAND (OR 0 1) (AND 1 1)`

### Flip-Flop:
- `SR 0 1 1`
- `D 1`
