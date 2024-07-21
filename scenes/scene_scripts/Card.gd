extends Node

@export var depth: int = 0 #how many cards are above this?
@export_file("*.json") var jsonPath
var locked = false # A locked card cannot be moved by player action. If discarded, cannot be returned to deck until after combat ends.
var carddata
var reaction_group # Might not get implemented. When combined, depending on the other card's group, pulls a card of a group to the top of the deck.

func tostr(val):
	return val.to_string()

func compare_effect(a,b):
	if a.delay != b.delay: return a.delay < b.delay #earlier delays are visible first on the card
	if a.order != b.order: return a.order < b.order #lower order strings tie break first
	if a.value != b.value: return a.value > b.value #biggest values tie break second
	return a.type < b.type #sort alphabetically by effect type otherwise

func is_effect_visible(effect):
	return true #TODO: Implement light and depth logic here

func updateFromJSONPath(path):
	jsonPath = path
	updateFromJSON()
	
func updateFromJSON(json : JSON = load(jsonPath)):
	updateFromRaw(json.data)

func updateFromRaw(data: Dictionary): # Optionally takes JSON data directly. Can also be used w/ carddata to refresh visibility checks.
	carddata = data
	%NameText.text = data.card_name
	if ResourceLoader.exists(data.card_art_path):
		%CardArtBorder.visible = true
		%CardArt.texture = load(data.card_art_path) # card_art_path defines a card's art source
	else:
		%CardArtBorder.visible = false # Just use a nonexistent path, like "null", to disable the card art.
	var effects = carddata.effects # it's an array of dictionaries
	effects.sort_custom(compare_effect)
	var text_template = "[img]effect_icons/effect_delay.png[/img] {delay} [img]effect_icons/effect_{type}.png[/img] {value}\n"
	var card_text = ""
	for effect in effects:
		if is_effect_visible(effect):
			if not ResourceLoader.exists("effect_icons/effect_{type}.png".format(effect)):
				effect.type = "blank" # use the placeholder for unimplemented effect icons
			card_text = card_text + text_template.format(effect)
	if card_text != "": # There's card text!
		%CardText.text = card_text
	else:
		%CardText.text = "No effect."
