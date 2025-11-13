extends Node
var _start_ms: int = 0
func start() -> void: _start_ms = Time.get_ticks_msec()
func elapsed_ms() -> int: return max(0, Time.get_ticks_msec() - _start_ms)
