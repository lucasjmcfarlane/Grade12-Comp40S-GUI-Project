extends Control

func _input(_ev):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/BaseConverter.tscn")
func _on_Button2_pressed():
	get_tree().change_scene("res://Scenes/GuessingGame.tscn")
func _on_Button3_pressed():
	get_tree().change_scene("res://Scenes/SlotMachine.tscn")
