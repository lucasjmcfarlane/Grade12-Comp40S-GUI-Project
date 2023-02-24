extends Control
onready var binaryInput = get_node("VBoxContainer/HBoxContainer/BinaryInput")
onready var baseTenInput = get_node("VBoxContainer/HBoxContainer2/BaseTenInput")
onready var hexInput = get_node("VBoxContainer/HBoxContainer3/HexInput")
var binaryArray = ['0000','0001','0010','0011','0100','0101','0110','0111', 
				   '1000','1001','1010','1011','1100','1101','1110','1111']
var hexCharacters = "0123456789ABCDEF"
var baseTenCharacters = "1234567890"

func _input(_ev):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_BinaryInput_text_changed(new_text):
	#only allow 1 and 0 to be entered into the textbox
	if !new_text.empty():
		if new_text[-1] !='1' and new_text[-1] !='0':
			new_text.erase(new_text.length()-1,1)
			binaryInput.set_text(new_text)
			binaryInput.set_cursor_position(new_text.length())
	
	if new_text.length() == 0:
		baseTenInput.set_text('')
		hexInput.set_text('')
	else:
		var baseTen = binary_to_baseten(new_text)
		baseTenInput.set_text(baseTen)
		hexInput.set_text(baseten_to_hex(baseTen))


func _on_BaseTenInput_text_changed(new_text):
	if !new_text.empty():
		if !(new_text[-1] in baseTenCharacters):
			new_text.erase(new_text.length()-1,1)
			baseTenInput.set_text(new_text)
			baseTenInput.set_cursor_position(new_text.length())
	
	if new_text.length() == 0:
		binaryInput.set_text('')
		hexInput.set_text('')
	else:
		var hex = baseten_to_hex(new_text)
		hexInput.set_text(hex)
		binaryInput.set_text(hex_to_binary(hex))


func _on_HexInput_text_changed(new_text):
	new_text = new_text.to_upper()
	
	if !new_text.empty():
		if !(new_text[-1] in hexCharacters):
			new_text.erase(new_text.length()-1,1)
	
	hexInput.set_text(new_text)	
	hexInput.set_cursor_position(new_text.length())
	
	if new_text.length() == 0:
		baseTenInput.set_text('')
		binaryInput.set_text('')
	else:
		var binary = hex_to_binary(new_text)
		binaryInput.set_text(binary)
		baseTenInput.set_text(binary_to_baseten(binary))


func hex_to_binary(hex):
	var binary = ''
	for character in hex:
		binary += binaryArray[hexCharacters.find(character)]
	return str(binary)


func binary_to_baseten(new_text):
	#convert binary to base ten and update textbox
	new_text = str(new_text)
	var baseTen = 0
	for digit in new_text: baseTen = baseTen*2 + int(digit)
	return str(baseTen)


func baseten_to_hex(number):
	var hex = []
	var newHex = ''
	number = int(number)
	
	#conversion from decimal to hex
	while number>= 16:
		hex.push_front(number % 16)
		number /= 16
	hex.push_front(number)

	for i in range(0, hex.size()):
		if hex[i] == 10: hex[i] = 'A'
		elif hex[i] == 11: hex[i] = 'B'
		elif hex[i] == 12: hex[i] = 'C'
		elif hex[i] == 13: hex[i] = 'D'
		elif hex[i] == 14: hex[i] = 'E'
		elif hex[i] == 15: hex[i] = 'F'
		newHex = newHex + str(hex[i])
	return str(newHex)
