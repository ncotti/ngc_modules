# Design Document

## 1. Introduction

General purpose counter module.

## 2. Architecture

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

Control priority:

For all operations:
`count_hit = (count == count_to_value)`

| rst   | load  | enb   | dir   | one_shot  | count_hit | Action (next clock cycle) |
|:---:  |:----: |:---:  |:---:  |:--------: |  :----:   |:-------|
| 1     | x     | x     | x     | x         |     x     |count = count_from_value   |
| 0     | 1     | x     | x     | x         |     x     |count = load_val           |
| 0     | 0     | 0     | x     | x         |     x     |count = count              |
| 0     | 0     | 1     | 0     | x         |     0     |count = count + step_value |
| 0     | 0     | 1     | 1     | x         |     0     |count = count - step_value |
| 0     | 0     | 1     | x     | 0         |     1     |count = count_from_value   |
| 0     | 0     | x     | x     | 1         |     1     |count = count              |
