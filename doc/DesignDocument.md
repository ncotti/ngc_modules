# Design Document

## 1. Introduction

*Brief description of the design.*

### 1.1 Dependencies

*In this section describe any assumptions, background, or dependencies of the software, its use, the operational environment, or significant project issues.*

### 1.2 Constraints

*In this section describe any constraints on the system that have a significant impact on the design of the system.*

*Maximum clock. Area. Power.*

### 1.3 System Environment

*In this section describe the system environment on which the software will be executing. Include any specific reasons why this system was chosen and if there are any plans to include new sections to the list of current ones.*

## 2. Architecture

### 2.1 Overview

*Provide here a descriptive overview of the software/system/application architecture.*

### Ports

| Port | Width | Direction | Description |
|:----:|:---:|:---:|---|
| clk | 1 | Input | Design clock. |
| rst | 1 | Input | Synchronous, active high reset. |
| load | 1 | Input | 0: Does nothing.<br>1: Sets the value of `counter` to `load_val`. |
| load_val | N | Input | When `load` is high, the value of `count` is set to this value. |
| enb | 1 | Input | Enable signal:<br>0: Pause the counter.<br>1: Resume the counter. |
| dir | 1 | Input | Sets the direction of the counter:<br>0: Goes from `count_from_value` to `count_to_value`, in steps of `step_value`. <br>1: Goes from `count_from_value` to `count_to_value`, in steps of `-step_value`. |
| one_shot | 1 | Input | Halts the counter when the `count` reaches the `count_to_value`. One shot has priority over the enable `enb` signal.<br>0: Loopback after reaching the `count_to_value`, (i.e. set counter to `count_from_value` in hte next clock cycle and continue counting).<br>1: Halt after reaching the `count_to_value` (i.e. `counter` value will be equal to `count_to_value` and `count_hit` will be kept high until this signal is lowered). |
| count_to_value | N | Input | End value of the counting loop. When `count` equals this value, the `count_hit` output is asserted. On the next enabled clock cycle, when not in one shot mode, the count goes back to the `count_from_value`. |
| count_from_value | N | Input | Initial value of the counting loop. |
| step_value | N/2 | Input | The `count` value will be advanced by `step_value` each clock cycle. If the current value of the counter, plus or minus the `step_value`, depending of the direction `dir` is greater or lower than the `count_to_value`, the counter will continue counting beyond the latter . |
| count | N | Output | Current value of the counter. |
| count_hit | 1 | Output | 0: count is not equal to `count_to_value`.<br>1: count is equal to `count_to_value`. |

Priority of control

For all operations:
count_hit = (count == count_to_value)

| rst   | load  | enb   | dir   | one_shot  | count_hit | Action (next clock cycle) |
|:---:  |:----: |:---:  |:---:  |:--------: |  :----:   |:-------|
| 1     | x     | x     | x     | x         |     x     |count = count_from_value   |
| 0     | 1     | x     | x     | x         |     x     |count = load_val           |
| 0     | 0     | 0     | x     | x         |     x     |count = count              |
| 0     | 0     | 1     | 0     | x         |     0     |count = count + step_value |
| 0     | 0     | 1     | 1     | x         |     0     |count = count - step_value |
| 0     | 0     | 1     | x     | 0         |     1     |count = count_from_value   |
| 0     | 0     | x     | x     | 1         |     1     |count = count              |

### 2.2 Component Diagrams

*Provide here the diagram and a detailed description of its most valuable parts. There may be multiple diagrams. Include a description for each diagram. Subsections can be used to list components and their descriptions.*

### 2.4 Sequence Diagrams

*Provide here any sequence diagrams. If possible list the use case they contribute to or solve. Provide descriptions if possible.*

### 2.5 Deployment Diagrams

*Provide here the deployment diagram for the system including any information needed to describe it. Also, include any information needed to describe future scaling of the system.*

### 2.6 Other Diagrams

*Provide here any additional diagrams and their descriptions in subsections.*

## 3 Appendices and References

### 3.1 Definitions and Abbreviations

*List here any definitions or abbreviations that could be used to help a new team member understand any jargon that is frequently referenced in the design document.*

#### 3.2 References

*List here any references that can be used to give extra information on a topic found in the design document. These references can be referred to using superscript in the rest of the document.*
