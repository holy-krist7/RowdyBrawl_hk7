class_name Player
extends CharacterBody2D


@onready var player_sprite: AnimatedSprite2D = $hitBox/playerSprite
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var shadow: Sprite2D = $shadow
@onready var hit_box: Node2D = $hitBox

# Sounds #

@onready var jump_sound: AudioStreamPlayer2D = %JumpSound
@onready var land_sound: AudioStreamPlayer2D = %LandSound

# Controllers #

@onready var player_action_animator: AnimationPlayer = $playerActionAnimator
@onready var music_manager: musicManager = $musicManager
@onready var camera_controller: cameraController = $cameraController
@onready var movement_component: MovementComponent = %MovementComponent
@onready var jump_component: JumpComponent = $JumpComponent


# Timers #

@onready var attack_busy_timer: Timer = %AttackBusyTimer
@onready var combo_timer: Timer = %ComboTimer
@onready var stun_timer: Timer = %StunTimer
@onready var parry_timer: Timer = %ParryTimer
@onready var parry_cooldown_timer: Timer = %ParryCooldownTimer


var health: float
var special_meter: float

var direction_facing: int = 1:
	set = flip_to_direction


func _ready():
	player_sprite.show()
	player_action_animator.play("spawnIn")



func _physics_process(delta: float) -> void:

	rich_text_label.text =  "Health:" + str(health) + "\nMeter: " + str(special_meter)# temporary 

	#TODO: create an attack controller
	
	# Walk logic #

	var x_walk_axis := Input.get_axis("left", "right")
	var y_walk_axis := Input.get_axis("up", "down")
	var walk_direction := Vector2(x_walk_axis, y_walk_axis).normalized()

	movement_component.walk_direction = walk_direction

	player_sprite.speed_scale = velocity.length() / movement_component.max_speed + 0.5
	if not walk_direction.is_zero_approx():
		flip_to_direction(sign(x_walk_axis))
		player_sprite.play("walk")
	elif velocity.is_zero_approx(): 
		player_sprite.play("idle")


	# Jump and Parry logic #

	if Input.is_action_just_pressed("jump") and stun_timer.is_stopped() and jump_component.is_grounded:
		jump_sound.pitch_scale = .5 * randf() + .75 # between .75 and 1.25
		jump_sound.play()

		collision_layer = 2
		collision_mask = 2

		jump_component.jump()
		jump_component.landed.connect(_on_jump_landed, CONNECT_ONE_SHOT)
		
	if Input.is_action_just_pressed("parry") and stun_timer.is_stopped():
		player_action_animator.play("parry")
		# TODO: add parry logic


	if global_position.y >= RenderingServer.CANVAS_ITEM_Z_MIN and global_position.y < RenderingServer.CANVAS_ITEM_Z_MAX:
		z_index = int(global_position.y)



func flip_to_direction(dir: int):
	if sign(dir) != dir: # (if 'dir' isn't 1, 0, or -1)
		push_error("dir should be 1, 0, or -1")


	if dir == 0: return

	player_sprite.flip_h = dir == -1

	direction_facing = dir


func _on_jump_landed():
	land_sound.play()

	collision_layer = 1
	collision_mask = 1
