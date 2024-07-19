extends Button

#Example of creating a button and assigning an action when pressed by code:
func _ready():
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	var enemy_health = get_node("/root/presenter/EnemySample/EnemyHealthLabel")
	enemy_health.text = str(int(enemy_health.text) - 10)
	if int(enemy_health.text) <= 0:
		enemy_health.text = str(0)
	print("Hello world!")
