extends Item

func _physics_process(delta: float) -> void:
		# attacks and stuff
	if Input.is_action_just_pressed("lightAttack") and player.canAttack():
		player.changeAnimation("lightAttack")
		if player.grounded:
			player.doAttackCheckCombos("L")
			
		else:
			player.doAttackCheckCombos("A")
		#print(comboString)
		
	elif Input.is_action_just_pressed("heavyAttack") and player.canAttack():
		player.changeAnimation("lightAttack")
		if player.grounded:
			player.doAttackCheckCombos("H")
			player.changeAnimation("lightAttack")
		else:
			player.doAttackCheckCombos("S")
			player.changeAnimation("lightAttack")
		#print(comboString)
	
