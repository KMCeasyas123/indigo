extends StaticBody2D

class_name Card

onready var sprite : Sprite = $Sprite

export(NodePath) onready var _cardgame
export(Texture) var _backface : Texture
var _card_texture : Texture

var _delayed_flip_active : bool
var _delayed_flip_timer : float

var _is_flipped : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(_cardgame).allCards.append(self)
	sprite.texture = _backface


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _delayed_flip_active:
		_delayed_flip_timer -= delta
		if _delayed_flip_timer <= 0:
			_delayed_flip_active = false
			flip()

func _interact(_player):
	if !_is_flipped:
		flip()

func start_delayed_flip(time : float):
	_delayed_flip_timer = time
	_delayed_flip_active = true

func assign_texture(texture:Texture):
	_card_texture = texture

func flip():
	if _is_flipped:
		_is_flipped = false
		sprite.texture = _backface
	else:
		_is_flipped = true
		sprite.texture = _card_texture
		get_node(_cardgame).on_card_flip(self)
