extends ReactiveBody2D

enum States {GROUNDED, JUMPING}

const run_gap: float = 0.62 # sec
var speed: float = 0.1
var touch_floor: PhysicsBody2D = null
var is_slow: bool = false 

	 
func _unhandled_input(event: InputEvent) -> void:
	#is_slow = false
	#if event.is_pressed():
		#is_slow = true
		
	# null detection included
	var force: Vector2 = Vector2(0.0, 0.0);
	if touch_floor is PhysicsBody2D:
		if event.is_action("move_left"):
			force.x += 200000 * 2 
		elif event.is_action("move_right"):
			force.x -= 200000 * 2
		force.y += 200000
		if event.is_action_pressed("jump"):
			force.y += 2000000
			
		apply_reactive_force(touch_floor, force);
		touch_floor = null
	
	#get_viewport().set_input_as_handled()
		
# allow get_contact_count
func _ready() -> void:	
	contact_monitor = true
	max_contacts_reported = 4

			
# Slow time, without messing with physic
func _physics_process(delta: float) -> void:
	super(delta)
	if Input.is_anything_pressed():
		Engine.time_scale = 0.05
	else:
		Engine.time_scale = 1
	pass
			
			
# https://docs.godotengine.org/en/stable/classes/class_physicsdirectbodystate2d.html
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# call ReactiveBody2D's _integrate_forces
	super(state)
	
	
	var i := 0
	while i < state.get_contact_count():
		var normal := state.get_contact_local_normal(i)
		if normal.dot(Vector2.UP) > 0.9: # this can be dialed in
			touch_floor = state.get_contact_collider_object(i)
		#  1.0 would be perfectly straight up
		#  0.0 is a wall
		# -1.0 is a ceiling
		i += 1
