extends Node2D

var file_path = "res://enemy_sample.json"
var json_as_text = FileAccess.get_file_as_string(file_path)
var json_as_dict = JSON.parse_string(json_as_text)

var base_health = json_as_dict["enemy_base_health"]
var base_priority = json_as_dict["enemy_priorities"]["full_health"]

var priority = null
var health = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print(json_as_dict)
	print(base_health)
	
	priority = get_node("EnemyPriority")
	health = get_node("EnemyHealthLabel")
	
	health.text = str(base_health)
	priority.text = str(base_priority)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(self.get_child(1).text) < 50:
		priority.text = json_as_dict["enemy_priorities"]["medium_health"]
		#self.get_child(2).text = str(priority)
	if int(self.get_child(1).text) < 20:
		priority.text = json_as_dict["enemy_priorities"]["low_health"]
		#self.get_child(2).text = str(priority)
	if int(self.get_child(1).text) == 0:
		get_node("EnemySprite").texture = preload("res://Textures/PlaceholderEnemy2.png")
