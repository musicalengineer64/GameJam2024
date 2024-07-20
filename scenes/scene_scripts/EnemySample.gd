extends Node2D

#@export var enemy_sample: PackedScene

var file_path = "res://enemies/enemy_sample.json"
var json_as_text = FileAccess.get_file_as_string(file_path)
var json_as_dict = JSON.parse_string(json_as_text)

var base_health = json_as_dict["enemy_base_health"]
var base_priority = json_as_dict["enemy_priorities"]["full_health"]

var priority_label = null
var health_label = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print(json_as_dict)
	print(base_health)
	
	priority_label = get_node("EnemyPriorityLabel")
	health_label = get_node("EnemyHealthLabel")
	
	priority_label.text = str(base_priority)
	health_label.text = str(base_health)

# Modify the health value of the enemy
func _take_damage(amount=10):
	var health_val = int(health_label.text)
	var priority_val = str(priority_label.text)
	
	if health_val < amount:
		health_val = 0
	else:
		health_val -= amount
	
	# change the enemy behavior based on their new health
	if health_val < 50:
		priority_val = json_as_dict["enemy_priorities"]["medium_health"]
	if health_val < 20:
		priority_val = json_as_dict["enemy_priorities"]["low_health"]
	if health_val == 0:
		get_node("EnemySprite").texture = preload("res://textures/enemy/PlaceholderEnemy2.png")
		
	# update labels
	health_label.text = str(health_val)
	priority_label.text = str(priority_val)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
