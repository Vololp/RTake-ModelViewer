class_name MAIN_SCRIPT extends Node3D

######################################
## Tha Variables
@export var Pivit1 : Node3D
@export var Pivit2 : Node3D
@export var GetCamera : Camera3D
@export var Storage : Node3D
@export var GetTimer : Timer
@export var WorldLight : DirectionalLight3D

######################################
## The Engine Functions

func _ready() -> void:
	## This set's the variables here to VariantManager so all scripts can have access.
	VariantManager.GetSceneNode = self
	VariantManager.MouseSensitivity = 0.2
	VariantManager.ZPos = 5
	VariantManager.YPos = 0.4
	VariantManager.CameraPivit1 = Pivit1
	VariantManager.CameraPivit2 = Pivit2
	VariantManager.CurrentCamera = GetCamera
	VariantManager.Storage = Storage
	VariantManager.GetTimer = GetTimer
	VariantManager.WorldLight = WorldLight
	VariantManager.CashZPos = VariantManager.ZPos

	GetCamera.projection = Ui.find_child("ProjectOption").selected
	GetCamera.far = Ui.find_child("FarSlider").value
	GetCamera.near = Ui.find_child("NearSlider").value

	## This load's signals on start.

	Ui.find_child("LoadButton").connect("pressed",UI_MANAGER.LoadButton)
	Ui.find_child("RemoveButton").connect("pressed",UI_MANAGER.RemoveButton)
	Ui.find_child("Settings_Button").connect("pressed",UI_MANAGER.ShowSettingsPanel)
	Ui.find_child("Instance_Button").connect("pressed",UI_MANAGER.ShowInstancePanel)
	Ui.find_child("XAxisSlider").connect("value_changed",WORLDSETTINGS_MANAGER.WorldLightSliderX)
	Ui.find_child("YAxisSlider").connect("value_changed",WORLDSETTINGS_MANAGER.WorldLightSliderY)
	Ui.find_child("LightSlider").connect("value_changed",WORLDSETTINGS_MANAGER.WorldLighting)
	Ui.find_child("FOVSlider").connect("value_changed",WORLDSETTINGS_MANAGER.FovChange)
	Ui.find_child("ResetPosButton").connect("pressed",WORLDSETTINGS_MANAGER.ResetPostion)
	Ui.find_child("ReturnToPivitButton").connect("pressed",WorldSettingsManager.ModeChange)
	Ui.find_child("ProjectOption").connect("item_selected",WorldSettingsManager.ProjectionChange)
	Ui.find_child("FarSlider").connect("value_changed",WorldSettingsManager.FarChange)
	Ui.find_child("NearSlider").connect("value_changed",WorldSettingsManager.NearChange)
	Ui.find_child("InstanceSize").connect("value_changed",INSTANCE_MANAGER.InstnaceResize)
	FileWindow.connect("file_selected",FILE_PATH_MANAGER.LoadModelFromFile)
	get_window().files_dropped.connect(FILE_PATH_MANAGER.LoadModelFromFile)
	GetTimer.connect("timeout",DEBUGGING_MANAGER.ClearErrorMessage)

	# Setting the slider values to the values on the DirectionalLight3D Node.
	Ui.find_child("XAxisSlider").value = WorldLight.global_rotation.x
	Ui.find_child("YAxisSlider").value = WorldLight.global_rotation.y
	Ui.find_child("LightSlider").value = WorldLight.light_energy

	Ui.find_child("FOVSlider").value = GetCamera.fov

	## This will see the usr drop a model file on the excutable to open on start.

	if !OS.get_cmdline_args().size() == 1:
		print(OS.get_cmdline_args())
		print("nothing to open, continue")
	else:
		print(OS.get_cmdline_args())
		FILE_PATH_MANAGER.LoadModelFromFile(OS.get_cmdline_args())

######################################

func _input(event: InputEvent) -> void:

	## This will pivit the camera is the usr presses the right mouse button.
	if Input.is_action_just_pressed("RightMouseButton"):
		VariantManager.CanPivit = true
		VariantManager.MousePosCash = get_viewport().get_mouse_position()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif Input.is_action_just_released("RightMouseButton"):
		VariantManager.CanPivit = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.warp_mouse(VariantManager.MousePosCash)

	match VariantManager.FlyMode :
		false:

			## This will set the mouse input relative to MouseMotion in VariantManager.
			if event is InputEventMouseMotion and VariantManager.CanPivit != false:
				VariantManager.MouseMotion = event.relative

			## This will zoom the camera if the usr scroll in or out.
			if Input.is_action_pressed("ScrollDown"):
				VariantManager.ZPos += 0.2
			elif Input.is_action_pressed("ScrollUp"):
				VariantManager.ZPos -= 0.2

			## This will move the camera on the y-axis when the usr presses the middle mouse button.
			if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
				VariantManager.YPos += event.relative.y * VariantManager.MouseSensitivity /45

	## This is the application shortcut key
	if Input.is_action_just_pressed(&"LoadAModel"):
		UI_MANAGER.LoadButton()

	if Input.is_action_just_pressed(&"ControlMod"):
		WorldSettingsManager.ModeChange()

	if Input.is_action_just_pressed(&"RemoveModel"):
		UI_MANAGER.RemoveButton()

	## This will clamp the camera from going to far (really necessary)
	VariantManager.ZPos = clampf(VariantManager.ZPos,0.2,20)
	VariantManager.YPos = clampf(VariantManager.YPos,-1000,1000)

######################################

func _process(delta: float) -> void:

	## These are functions to make the camera move.
	match VariantManager.FlyMode:
		false :
			USR_CONTROL_MANAGER.CameraMovement(delta)
			USR_CONTROL_MANAGER.CameraZposMotion(delta)
			USR_CONTROL_MANAGER.CameraYposMotion(delta)
