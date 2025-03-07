
@icon("res://icon.svg")
class_name ReactiveBody2D 
extends RigidBody2D


const run_gap: float = 0.62 # sec


var speed: float = 0.1
var final_force: Vector2 = Vector2(0.0, 0.0)
#var floor: PhysicsBody2D = null
var floor: Object = null
 
func _physics_process(delta: float) -> void:
	#apply_force(final_force)
	set_constant_force(Vector2(0.0, 0.0))
	final_force =  Vector2(0.0, 0.0) # reset

	# deferred called?
	
	 
func _unhandled_input(event: InputEvent) -> void:
	# null detection included
	if floor is PhysicsBody2D:
		if Input.is_action_pressed("move_left"):
			final_force.x -= 100000
		elif Input.is_action_pressed("move_right"):
			final_force.x += 100000
		final_force.y -= 200000
		
		add_constant_force(final_force)
		if floor is RigidBody2D:
			floor.constant_force(-final_force)
		print("got it")
		floor = null
		
# https://docs.godotengine.org/en/stable/classes/class_physicsdirectbodystate2d.html
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var i := 0
	while i < state.get_contact_count():
		var normal := state.get_contact_local_normal(i)
		if normal.dot(Vector2.UP) > 0.9: # this can be dialed in
			floor = state.get_contact_collider_object(i)
		#  1.0 would be perfectly straight up
		#  0.0 is a wall
		# -1.0 is a ceiling
		i += 1
