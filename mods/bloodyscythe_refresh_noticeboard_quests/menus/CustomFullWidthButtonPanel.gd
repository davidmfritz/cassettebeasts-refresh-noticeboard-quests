extends Control

const confirm_dialog_message: String = "This will abort all accepted noticeboard quests and generate new ones. Are you sure?";

var noticeboard = SaveState.noticeboard;
var quests = SaveState.quests;

func _on_BackButton_pressed():
	get_parent().cancel()

func _on_CustomButton_pressed():
	if yield (MenuHelper.confirm(confirm_dialog_message), "completed") and not SaveSystem.busy and not SceneManager.transitioning:
		refresh_noticeboard_quests()

func refresh_noticeboard_quests():
	# remove all noticeboard quests from the quest log
	var was_tracked = false
	for record in noticeboard.quests:
		var quest = quests.get_quest(record.quest)
		if quest != null:
			was_tracked = quests.is_tracked(quest)
			quests.fail_quest(quest)
			quests.garbage.push_back(weakref(quest))
	
	# track a new quest if the previously tracked quest was a noticeboard quest
	if was_tracked:
		for child in quests.get_children():
			if child.get_quest_kind() != Quest.QuestKind.PASSIVE and quests._has_chunks_on_current_map(child):
				quests.set_tracked(child, true)
	
	# remove all noticeboard quests
	SaveState.noticeboard.clear()
	
	# trigger animations for newly generated quests
	get_parent().run_animations()
