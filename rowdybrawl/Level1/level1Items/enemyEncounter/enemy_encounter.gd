extends Node2D
class_name enemyEncounter

@onready var enemies_to_spawn: Node2D = $enemiesToSpawn

var spawned := false
var enemyArray = []
var playerRef : Player = null

func spawnEnemies():
	for enemySpawn : enemySpawnPoint in enemies_to_spawn.get_children():
		var spawnedEnemy = enemySpawn.spawnEnemy()
		enemyArray.append(spawnedEnemy)
		spawnedEnemy.playerRef = playerRef
		spawnedEnemy.ai = spawnedEnemy.aiStates.CHASE
		call_deferred("addMyEnemyChild",spawnedEnemy, enemySpawn.global_position)
		
func addMyEnemyChild(spawnedEnemy : Enemy, location : Vector2):
	add_child(spawnedEnemy)
	spawnedEnemy.global_position = location

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		pass


func _on_player_trigger_body_entered(body: Node2D) -> void:
	if body is Player and !spawned:
		playerRef = body
		# TODO: refactor music manager
		# playerRef.enterCombat()
		spawnEnemies()
		spawned = true
