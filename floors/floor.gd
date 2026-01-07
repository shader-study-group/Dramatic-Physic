extends StaticBody2D


@export var sprite: Sprite2D;			# Sprite2D reference
var now_disco: float = 0.0;
var now_disco_way: float = 1.0;
@export_range(0, 1) var disco_range: float = 1.0:
	set(value):
		now_disco = 0;
		disco_range = value; # setter overwrites default `disco_range = value`, add it back
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: 
	sprite.material.set_shader_parameter("tint_blue", now_disco)  # var name must be exact same
	
	now_disco += delta * now_disco_way
	if now_disco >= disco_range or now_disco <= 0:
		now_disco_way *= -1
