class_name UI_MANAGER extends Node

static func DisableButton(Disable:bool) -> void:
	var GetRemoveButton = Ui.find_child("RemoveButton") as Button

	GetRemoveButton.disabled = Disable

static func LoadButton() -> void:
	FileWindow.visible = true

static func RemoveButton() -> void:
	if VariantManager.Storage.get_child_count() == 1:
		VariantManager.Storage.get_child(0).queue_free()
		DisableButton(true)
