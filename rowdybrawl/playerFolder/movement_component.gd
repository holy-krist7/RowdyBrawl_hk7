class_name MovementComponent
extends Node


@onready var player: Node2D = get_parent()

var walk_direction: Vector2

var max_speed: float:
    get: return max(walk_acceleration, _y_walk_speed)

@export var walk_acceleration: float
var current_walk_velocity: Vector2

@export var _x_walk_speed: float
@export var _y_walk_speed: float


func _physics_process(delta: float) -> void:

    var target_speed := walk_direction * Vector2(_x_walk_speed, _y_walk_speed)
    var target_accel := walk_acceleration * (2.5 if target_speed.is_zero_approx() else 1.0)
        
    current_walk_velocity = current_walk_velocity.move_toward(target_speed, target_accel * delta)
    

    if player is CharacterBody2D:
        player.velocity = current_walk_velocity
        player.move_and_slide()

    elif player is PhysicsBody2D:
        player.move_and_collide(current_walk_velocity * delta)

    else:
        player.position += current_walk_velocity * delta

    

    
    