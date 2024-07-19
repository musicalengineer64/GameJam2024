extends Node2D

@export var depth: int = 0 #how many cards are above this?
@export_file("*.json") var jsonPath
var effects
var reaction_group

func tostr(val):
	return val.to_string()

func compare_effect(a,b):
	if a.delay != b.delay: return a.delay < b.delay #earlier delays are visible first on the card
	if a.value != b.value: return a.value > b.value #if delays are equal, favor biggest value first
	return a.type < b.type #sort alphabetically by effect type otherwise

func is_effect_visible(effect):
	return true #TODO: Implement light and depth logic here

func setJSONPath(path):
	jsonPath = path
	updateFromJSON()

func updateFromJSON(json : JSON = load(jsonPath)): # Optionally takes JSON data directly. 
	var data = json.data
	# Each of these nodes can only occur once in a card.
	var cardArtBorder = get_node("%Card Art Border")
	var cardArt = get_node("%Card Art")
	var cardText = get_node("%Card Text")
	if ResourceLoader.exists(data.card_art_path):
		cardArtBorder.visible = true
		cardArt.texture = load(data.card_art_path) # card_art_path defines a card's art source
	else:
		cardArtBorder.visible = false # Just use a nonexistent path, like "null", to disable the card art.
	effects = data.effects # it's an array of dictionaries
	effects.sort_custom(compare_effect)
	var text_template = "[img]effect_icons/effect_delay.png[/img] {delay} [img]effect_icons/effect_{type}.png[/img] {value}\n"
	var card_text = ""
	for effect in effects:
		if is_effect_visible(effect):
			if not ResourceLoader.exists("effect_icons/effect_{type}.png".format(effect)):
				effect.type = "blank" # use the placeholder for unimplemented effect icons
			card_text = card_text + text_template.format(effect)
	if card_text != "": # There's card text!
		cardText.text = card_text
	else:
		cardText.text = "No effect."
	
func _ready():
	updateFromJSON()
