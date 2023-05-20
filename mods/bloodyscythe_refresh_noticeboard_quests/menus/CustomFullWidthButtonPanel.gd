extends Control

func _on_BackButton_pressed():
	get_parent().cancel()

func _on_CustomButton_pressed():
	# TODO: confirmation prompt "do you really want to do this?"
	
	# remove all noticeboard quests from the quest log
	for record in SaveState.noticeboard.quests:
		var quest = SaveState.quests.get_quest(record.quest)
		if quest != null:
			# TODO: set tracked marker if the quest was the tracked one
			SaveState.quests.fail_quest(quest)
	
	# remove all noticeboard quests
	SaveState.noticeboard.clear()
	
	# trigger animations for newly generated quests
	get_parent().run_animations()
