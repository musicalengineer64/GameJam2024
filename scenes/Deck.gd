extends Node

@export var deck: Array[Node2D]
@export var discard: Array[Node2D] # Cards temporarily removed from the deck go here
@export var depthGroupSize: int
var cardTemplate = preload("res://scenes/card_2d.tscn")

# Used for adding a card from a file.
func addCardToDeckFromJSONPath(filepath: String):
	var card = cardTemplate.instantiate()
	%CardContainer.add_child(card)
	deck.push_back(card)
	card.depth = deck.size()-1
	card.setJSONPath(filepath)
	return card

# Used for adding a card from imported JSON data. 
func addCardToDeckFromJSON(cardjson: JSON):
	var card = cardTemplate.instantiate()
	%CardContainer.add_child(card)
	deck.push_back(card)
	card.depth = deck.size()-1 #index in deck, makes implementing concealed info easier
	card.updateFromJSON(cardjson)
	return card

# Used for adding a card from raw Dictionary data.
func addCardToDeckFromRaw(data: Dictionary):
	var card = cardTemplate.instantiate()
	%CardContainer.add_child(card)
	deck.push_back(card)
	card.depth = deck.size()-1 #index in deck, makes implementing concealed info easier
	card.updateFromRaw(data)
	return card

#Shuffles all cards in the deck. Does not retrieve the discard pile.
func shuffle(): 
	var newdeck: Array[Node2D] = []
	for i in range(deck.size()):
		newdeck.push_back(deck.pop_at(floor(randf()*deck.size())))
	deck = newdeck

#Shuffles count cards in the deck closest to targetIndex.
#Attempts to grab half of count from targetIndex and the cards immediately above it, and half from cards immediately below it.
#shuffleTargeted(2, 5) attempts to shuffle cards from [0 -> 4], for example. shuffleTargeted(2,4) attempts to shuffle cards from [0 -> 3].
func shuffleTargeted(targetIndex: int, count: int):
	var toShuffle: Array[Node2D] = []
	for i in range(count):
		toShuffle.push_back(deck.pop_at(clamp(targetIndex - floor(i / (count / 2)), 0, deck.size()-1))) #prevent out of bounds indexing
	for card in toShuffle:
		deck.insert(floor(randf()*(deck.size()+1)), card) #shove the retrieved cards at random positions within the deck, including at either end

func updateVisibility():
	return
