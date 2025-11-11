class_name MAIN_SCRIPT extends Node3D

@export var Pivit1 : Node3D
@export var Pivit2 : Node3D
@export var GetCamera : Camera3D
@export var Storage : Node3D
@export var GetTimer : Timer

func _ready() -> void:
	VariantManager.MouseSensitivity = 0.2
	VariantManager.ZPos = 5
	VariantManager.YPos = 0.4
	VariantManager.CameraPivit1 = Pivit1
	VariantManager.CameraPivit2 = Pivit2
	VariantManager.CurrentCamera = GetCamera
	VariantManager.Storage = Storage
	VariantManager.GetTimer = GetTimer

	Ui.find_child("LoadButton").connect("pressed",UI_MANAGER.LoadButton)
	Ui.find_child("RemoveButton").connect("pressed",UI_MANAGER.RemoveButton)
	FileWindow.connect("file_selected",FILE_PATH_MANAGER.LoadModelFromFile)
	get_window().files_dropped.connect(FILE_PATH_MANAGER.LoadModelFromFile)
	GetTimer.connect("timeout",DEBUGGING_MANAGER.ClearErrorMessage)

func _input(event: InputEvent) -> void:

	if event is InputEventMouseMotion and VariantManager.CanPivit != false:
		VariantManager.MouseMotion = event.relative

	if Input.is_action_just_pressed("RightMouseButton"):
		VariantManager.CanPivit = true
		VariantManager.MousePosCash = get_viewport().get_mouse_position()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif Input.is_action_just_released("RightMouseButton"):
		VariantManager.CanPivit = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.warp_mouse(VariantManager.MousePosCash)

	if Input.is_action_pressed("ScrollDown"):
		VariantManager.ZPos += 0.2
	elif Input.is_action_pressed("ScrollUp"):
		VariantManager.ZPos -= 0.2

	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		VariantManager.YPos += event.relative.y * VariantManager.MouseSensitivity /45

	VariantManager.ZPos = clampf(VariantManager.ZPos,0.2,20)
	VariantManager.YPos = clampf(VariantManager.YPos,0.0,1000)

func _process(delta: float) -> void:
	USR_CONTROL_MANAGER.CameraMovement(delta)
	USR_CONTROL_MANAGER.CameraZposMotion(delta)
	USR_CONTROL_MANAGER.CameraYposMotion(delta)
