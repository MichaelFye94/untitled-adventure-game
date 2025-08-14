# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node


signal transitioned(state_name: String)


@export var initial_state := NodePath()


@onready var state := get_node(initial_state)


func _ready():
	await owner.ready
	
	for child in get_children():
		child.state_machine = self
		
	state.enter()
	
	
func _unhandled_input(event):
	state.handle_input(event)
	
	
func _process(delta: float):
	state.update(delta)
	
	
func _physics_process(delta: float):
	state.physics_update(delta)
	
	
func transition_to(target_state_name: String, msg := {}):
	if not has_node(target_state_name):
		return
		
	state.exit()
	state = get_node(target_state_name)
	print("Entering state: " + target_state_name)
	state.enter(msg)
	
	transitioned.emit(state.name)
