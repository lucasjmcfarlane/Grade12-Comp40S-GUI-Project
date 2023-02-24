extends Control
onready var guessInput = $Game/HBoxContainer/guessInput
onready var tooHigh = $Game/Control/VBoxContainer/HBoxContainer/tooHigh
onready var tooLow = $Game/Control/VBoxContainer/HBoxContainer/tooLow
onready var correct = $Game/Control/VBoxContainer/HBoxContainer/correct
onready var outOfRange = $Game/Control/VBoxContainer/HBoxContainer/outOfRange
onready var rand_generate = RandomNumberGenerator.new()

onready var rand
onready var maxValue = 0
onready var validInput = "1234567890"
onready var guesses = 0


func _input(_ev):
	if Input.is_action_just_pressed("ui_cancel"):
		if $DifficultySelect.is_visible():
			get_tree().change_scene("res://Scenes/MainMenu.tscn")
		else:
			$DifficultySelect.show()
			$Game.hide()
			guessInput.set_editable(true)

#get difficulty
func _on_easyDifficulty_pressed():
	rand_generate.randomize()
	rand = rand_generate.randi_range(1,100)
	maxValue = 100
	difficultyChosen()
func _on_mediumDifficulty_pressed():
	rand_generate.randomize()
	rand = rand_generate.randi_range(1,300)
	maxValue = 300
	difficultyChosen()
func _on_hardDifficulty_pressed():
	rand_generate.randomize()
	rand = rand_generate.randi_range(1,1000)
	maxValue = 1000
	difficultyChosen()

#once difficulty chosen, set up guessing portion
func difficultyChosen():
	tooLow.hide()
	tooHigh.hide()
	correct.hide()
	outOfRange.hide()
	guesses = 0
	$DifficultySelect.hide()
	$Game.show()
	$Game/Label.text = str("\nChoose A Number from 1-" + str(maxValue))
	guessInput.grab_focus()

#ensure all entered text is valid
func _on_guessInput_text_changed(new_text):
	if !new_text.empty():
		if !(new_text[-1] in validInput):
			new_text.erase(new_text.length()-1,1)
			guessInput.set_text(new_text)
			guessInput.set_cursor_position(new_text.length())

#once enter is pressed, check guess
func _on_guessInput_text_entered(new_text):
	guessInput.clear()
	guesses += 1
	tooLow.hide()
	tooHigh.hide()
	correct.hide()
	outOfRange.hide()
	
	if int(new_text) < 1 or int(new_text) > maxValue:
		outOfRange.show()
	elif int(new_text) > rand:
		tooHigh.show()
	elif int(new_text) < rand:
		tooLow.show()
	elif int(new_text) == rand:
		correct.set_text("You Got It In " + str(guesses) + " Guesses!")
		guessInput.set_editable(false)
		correct.show()
