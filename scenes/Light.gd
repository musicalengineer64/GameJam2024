extends Node

@export var lightLevel: int

func setLightLevel(newLight: int):
	lightLevel = newLight
	%Deck.updateVisibility()
