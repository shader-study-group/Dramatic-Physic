extends ReactiveBody2D

var floor: PhysicsBody2D = null


func _physics_process(delta: float) -> void:
	# call ReactiveBody2D's _physics_process
	super(delta)
	
	if floor is PhysicsBody2D:
		apply_reactive_force(floor, Vector2(0.0, 8000.0));
	floor = null

# allow get_contact_count
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4

# https://docs.godotengine.org/en/stable/classes/class_physicsdirectbodystate2d.html
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# call ReactiveBody2D's _integrate_forces
	super(state)
	
	var i := 0
	while i < state.get_contact_count():
		
		var normal := state.get_contact_local_normal(i)
		if normal.dot(Vector2.UP) > 0.9: # this can be dialed in
			floor = state.get_contact_collider_object(i)
		#  1.0 would be perfectly straight up
		#  0.0 is a wall
		# -1.0 is a ceiling
		i += 1
