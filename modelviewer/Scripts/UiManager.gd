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
		VariantManager.InstanceModel = null
		DisableButton(true)

## This function will show the settings panel for the usr.
static func ShowPanel(name:String) -> void:
	var GetAnimation = Ui.find_child("AnimationPlayer") as AnimationPlayer
	var GetSettingsPanel = Ui.find_child("WorldSettingsContainer") as Control
	var GetInstancePanel = Ui.find_child("InstanceSettingsContainer") as Control

	match name:


		"Settings":
			match VariantManager.SettingsPanel:
				true:
					VariantManager.SettingsPanel = false
				false:
					VariantManager.InstancePanel = false
					VariantManager.SettingsPanel = true
					GetInstancePanel.visible = VariantManager.InstancePanel
					GetSettingsPanel.visible = VariantManager.SettingsPanel

		"Instance":
			match VariantManager.InstancePanel:
				true:
					VariantManager.InstancePanel = false
				false:
					VariantManager.InstancePanel = true
					VariantManager.SettingsPanel = false
					GetInstancePanel.visible = VariantManager.InstancePanel
					GetSettingsPanel.visible = VariantManager.SettingsPanel

	if VariantManager.PanelShow != true:
		GetAnimation.play("Open_SettingsPanel")
		VariantManager.PanelShow = true
	elif VariantManager.SettingsPanel == false and VariantManager.InstancePanel == false:
		GetAnimation.play_backwards("Open_SettingsPanel")
		VariantManager.PanelShow = false



static func ShowSettingsPanel() -> void:
	ShowPanel("Settings")

static func ShowInstancePanel() -> void:
	ShowPanel("Instance")
