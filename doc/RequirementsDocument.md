# Requirements Document

## 1. User Requirements

### 1.1 System's Functionality

The **ngc_counter** implements a general purpose counter, able to be programmed to count upwards, downwards, until a certain value, etc.

### 1.2 User Interfaces

This is a SystemVerilog module. The user should copy the design library into their project, instantiate the module and include it in their design.

## 2. System Requirements

The **ngc_counter** should be able to:

* Count upwards and backwards.
* Enable or disable the count.
* Count until a certain value and raise a flag indicating that the value was reached.
* Count from a certain value.
* Loop back after the final count value was reached.
* Parametrize the count bit size.
* Load and arbitrary value from where to resume the count.
* Configurable step size.
