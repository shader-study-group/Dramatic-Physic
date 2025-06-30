@icon("res://icon.svg")
class_name ReactiveBody2D 
extends RigidBody2D

# _ means private variables
var _final_force: Vector2 = Vector2(0.0, 0.0)
var _physic_state: PhysicsDirectBodyState2D = null 
 
func apply_reactive_force(target: PhysicsBody2D, force: Vector2) -> void:
	_final_force -= force
	var react_target: ReactiveBody2D = target as ReactiveBody2D
	if react_target != null:
		react_target._final_force += force

func _physics_process(delta: float) -> void:
	apply_force(_final_force)
	_final_force = Vector2(0.0, 0.0) # reset
	_physic_state = null 
	
# https://docs.godotengine.org/en/stable/classes/class_physicsdirectbodystate2d.html
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	_physic_state = state
