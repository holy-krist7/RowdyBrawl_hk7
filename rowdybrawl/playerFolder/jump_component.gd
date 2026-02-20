class_name JumpComponent
extends Node


signal landed()

@export var nodes_to_move: Array[Node2D]

@export_group("jump settings")
@export var jump_velocity: float
@export var vertical_acceleration: float
var vertical_velocity: float
var vertical_position: float

var is_grounded: bool:
    get: return vertical_position == 0



var _original_y_positions: Dictionary[Node2D, float]


func _ready() -> void:
    for node in nodes_to_move:
        _original_y_positions[node] = node.position.y


func _physics_process(delta: float) -> void:
    if vertical_position <= 0 and vertical_velocity <= 0:
        vertical_position = 0
        vertical_velocity = 0
        landed.emit()
    else:
        vertical_velocity += vertical_acceleration * delta
        vertical_position += vertical_velocity * delta
    
    for node in nodes_to_move:
        node.position.y = _original_y_positions[node] - vertical_position


func jump():
    vertical_velocity = jump_velocity        
