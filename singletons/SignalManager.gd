extends Node

signal intro_done

func emit(sig):
	match sig:
		"intro_done":
			emit_signal("intro_done")
