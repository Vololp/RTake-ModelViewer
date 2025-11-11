class_name DEBUGGING_MANAGER extends Node

static func ErrorMessage(Text:String) -> void:
	var ErrorBox = Ui.find_child("ErrorBox") as LineEdit
	ErrorBox.text = Text
	VariantManager.GetTimer.start(0)

static func ClearErrorMessage() -> void:
	var ErrorBox = Ui.find_child("ErrorBox") as LineEdit
	ErrorBox.text = ""
