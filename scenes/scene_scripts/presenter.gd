extends Node2D

var damage_button = Button.new()
var summon_button = Button.new()
var clear_button = Button.new()

var enemy_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a button in presenter to demonstrate damaging an enemy
	damage_button.text = "Damage Enemy"
	damage_button.position = Vector2(100,100)
	damage_button.pressed.connect(self._damage_button_pressed)
	add_child(damage_button)
	
	# Create a button in presenter to demonstrate summoning an enemy
	summon_button.text = "Summon Enemy"
	summon_button.position = Vector2(100,200)
	summon_button.pressed.connect(self._summon_button_pressed)
	add_child(summon_button)
	
	clear_button.text = "Clear Enemy"
	clear_button.position = Vector2(100,300)
	clear_button.pressed.connect(self._clear_button_pressed)
	add_child(clear_button)

# damage an enemy
func _damage_button_pressed():
	for enemy in enemy_list:
		enemy._take_damage()

# place enemies on the board
func _summon_button_pressed():
	if enemy_list.size() == 0:
		enemy_list.push_back(load("res://scenes/enemy_sample.tscn").instantiate())
		enemy_list[0].position = Vector2(700,300)
		add_child(enemy_list[0])
	elif enemy_list.size() == 1:
		enemy_list.push_back(load("res://scenes/enemy_sample.tscn").instantiate())
		enemy_list[0].position = Vector2(600,200)
		enemy_list[1].position = Vector2(800,400)
		add_child(enemy_list[1])
	elif enemy_list.size() == 2:
		enemy_list.push_back(load("res://scenes/enemy_sample.tscn").instantiate())
		enemy_list[0].position = Vector2(750,200)
		enemy_list[1].position = Vector2(900,400)
		enemy_list[2].position = Vector2(600,400)
		add_child(enemy_list[2])
	elif enemy_list.size() == 3:
		print("Board is Full!")

func _clear_button_pressed():
	if enemy_list.size() == 0:
		print("I have no enemies.")
	elif enemy_list.size() == 1:
		enemy_list[-1].free()
		enemy_list.pop_back()
	elif enemy_list.size() == 2:
		enemy_list[-1].free()
		enemy_list.pop_back()
		enemy_list[0].position = Vector2(700,300)
	elif enemy_list.size() == 3:
		enemy_list[-1].free()
		enemy_list.pop_back()
		enemy_list[0].position = Vector2(600,200)
		enemy_list[1].position = Vector2(800,400)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
