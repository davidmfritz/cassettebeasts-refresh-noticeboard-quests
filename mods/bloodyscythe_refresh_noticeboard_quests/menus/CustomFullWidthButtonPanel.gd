extends Control

const confirm_dialog_message: String = "This will abort all accepted noticeboard quests and generate new ones. Are you sure?";

func _on_BackButton_pressed():
	get_parent().cancel()

func _on_CustomButton_pressed():
	if yield (MenuHelper.confirm(confirm_dialog_message), "completed") and not SaveSystem.busy and not SceneManager.transitioning:
		refresh_noticeboard_quests()

func refresh_noticeboard_quests():
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
