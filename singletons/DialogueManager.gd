extends Node


@onready var text_box_scene = preload("res://dialogue/textbox.tscn")

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var is_dialogue_active = false
var can_advance_line = false
var canvasNode
var _sig

func start_dialogue(position: Vector2, lines: Array[String], canvas: Control, sig):
	if is_dialogue_active:
		return
	canvasNode = canvas
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	_sig = sig
	
	is_dialogue_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	canvasNode.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false
	
func _on_text_box_finished_displaying():
	can_advance_line = true
	
func _unhandled_input(event):
	if event.is_action_pressed("DialogueAdvance") && is_dialogue_active && can_advance_line:
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			if _sig != null:
				SignalManager.emit(_sig)
			return
		_show_text_box()
