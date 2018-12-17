extends Control

func _process(delta):
	# If weapon is unlocked hide prize
	if Global.game_data.Player.Shotgun_unlocked == true:
		$ShotgunCost.hide()
		$Coin3.hide()
	if Global.game_data.Player.Ak47_unlocked == true:
		$Ak47Cost.hide()
		$Coin2.hide()
	
	# Updates coin amount
	$CoinAmount.text = str(int(Global.game_data.Player.coins))
	# Shoe "Equip" or Equiped" if your selected check autoload script gamedata dictionary
	if Global.game_data.Player.weapon_equiped == 1:
		$EquipPistol.text = str("EQUIPPED")
	else:
		$EquipPistol.text = str("EQUIP")
		
	if Global.game_data.Player.weapon_equiped == 2:
		$EquipAk47.text = str("EQUIPPED")
	else:
		$EquipAk47.text = str("EQUIP")
		
	if Global.game_data.Player.weapon_equiped == 3:
		$EquipShotgun.text = str("EQUIPPED")
	else:
		$EquipShotgun.text = str("EQUIP")
	

func _on_EquipPistol_button_up():
	# If pistol is not equip pistol and save data
	if Global.game_data.Player.weapon_equiped != 1:
		Global.game_data.Player.weapon_equiped = 1
		Global.save_game()
		
func _on_EquipAk47_button_up():
	# If Ak47 is not equip Ak47 and not unlocked. Unlock Ak47 if player can buy and equip it and save data (Same for shotgun)
	if Global.game_data.Player.weapon_equiped != 2 and Global.game_data.Player.Ak47_unlocked == false:
		if Global.game_data.Player.coins > int($Ak47Cost.text):
			Global.game_data.Player.weapon_equiped = 2
			Global.game_data.Player.coins -= int($Ak47Cost.text)
			Global.game_data.Player.Ak47_unlocked = true
			Global.save_game()
			$Ak47Cost.hide()
			$Coin2.hide()
	# If Ak47 is not equip Ak47 and is unlocked. Equip Ak47 and save data (Same for shotgun)
	elif  Global.game_data.Player.weapon_equiped != 2 and Global.game_data.Player.Ak47_unlocked == true:
		Global.game_data.Player.weapon_equiped = 2
		Global.save_game()


func _on_EquipShotgun_button_up():
	if Global.game_data.Player.weapon_equiped != 3 and Global.game_data.Player.Shotgun_unlocked == false:
		if Global.game_data.Player.coins > int($ShotgunCost.text):
			Global.game_data.Player.weapon_equiped = 3
			Global.game_data.Player.coins -= int($ShotgunCost.text)
			Global.game_data.Player.Shotgun_unlocked = true
			Global.save_game()
			$ShotgunCost.hide()
			$Coin3.hide()
			
	elif  Global.game_data.Player.weapon_equiped != 3 and Global.game_data.Player.Shotgun_unlocked == true:
		Global.game_data.Player.weapon_equiped = 3
		Global.save_game()


