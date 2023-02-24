extends Control

onready var firstSprite = $HBoxContainer/FirstSprite
onready var secondSprite = $HBoxContainer/SecondSprite
onready var thirdSprite = $HBoxContainer/ThirdSprite
onready var rerollOrExit = $RerollOrExit
onready var moneyCountNeutral = $MoneyCountNeutral
onready var moneyCountNegative = $MoneyCountNegative
onready var moneyCountPositive = $MoneyCountPositive
onready var money = 0
onready var rollChecked

func _ready():
	updateMoney(300)

func _input(_ev):
	if Input.is_action_just_pressed("ui_cancel"):
		if !firstSprite.is_playing() and !secondSprite.is_playing() and !thirdSprite.is_playing():
			rollChecked = false
			if money <= 0:
				updateMoney(300)
			reroll()
		else:
			get_tree().change_scene("res://Scenes/MainMenu.tscn")

func reroll():
	rerollOrExit.set_text("Press Esc to Exit")
	moneyCountNegative.set_visible(false)
	moneyCountPositive.set_visible(false)
	
	if money <= 0:
		moneyCountNegative.set_text("You are out of money!")
		moneyCountNegative.set_visible(true)
		moneyCountNeutral.set_visible(false)
	else:
		firstSprite.play()
		secondSprite.play()
		thirdSprite.play()
	
func updateMoney(amount):
	money = money + amount
	moneyCountNeutral.set_text("You have $" + str(money) + "!")
	if amount == 300:
		moneyCountNeutral.set_text("You spent $300")
	elif amount <= 0:
		moneyCountNeutral.set_text(moneyCountNeutral.get_text() + " (-$" + str(-amount) + ")")
	elif amount >= 0:
		moneyCountNeutral.set_text(moneyCountNeutral.get_text() + " (+$" + str(amount) + ")")
	moneyCountPositive.set_text(moneyCountNeutral.get_text())
	moneyCountNegative.set_text(moneyCountNeutral.get_text())
	if amount > 0:
		moneyCountPositive.set_visible(true)
	else:
		moneyCountNegative.set_visible(true)

func checkRoll():
		#Player has stopped all three
		if !( firstSprite.is_playing() or secondSprite.is_playing() or thirdSprite.is_playing() ) and !rollChecked:
			rerollOrExit.set_text("Press Esc to Reroll")
			var first = firstSprite.get_frame()
			var second = secondSprite.get_frame()
			var third = thirdSprite.get_frame()
			rollChecked = true
			
			if first == second and second == third:
				updateMoney(450)
			elif (first == second) or (second == third):
				updateMoney(50)
			else:
				updateMoney(-50)


func _on_FirstButton_pressed():
	firstSprite.stop()
	checkRoll()
func _on_SecondButton_pressed():
	secondSprite.stop()
	checkRoll()
func _on_ThirdButton_pressed():
	thirdSprite.stop()
	checkRoll()
