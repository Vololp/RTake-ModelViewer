class_name UI_MANAGER extends Node

## This Function disables the remove button in the usr interface.
static func DisableButton(Disable:bool) -> void:
	var GetRemoveButton = Ui.find_child("RemoveButton") as Button

	GetRemoveButton.disabled = Disable

## This function will open the files window.
static func LoadButton() -> void:
	FileWindow.visible = true

## This function will remove the model from the scene.
static func RemoveButton() -> void:
	if VariantManager.Storage.get_child_count() == 1:
		VariantManager.Storage.get_child(0).queue_free()
		DisableButton(true)

## This function will show the settings panel for the usr.
static func ShowSettingsPanel() -> void:
	var GetAnimation = Ui.find_child("AnimationPlayer") as AnimationPlayer

	match VariantManager.SettingsPanel :
		false :
			GetAnimation.play("Open_SettingsPanel")
			VariantManager.SettingsPanel = true
		true :
			GetAnimation.play_backwards("Open_SettingsPanel")
			VariantManager.SettingsPanel = false
