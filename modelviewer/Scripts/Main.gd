class_name MAIN_SCRIPT extends Node3D

######################################
## The Engine Functions

func _ready() -> void:
	## This set's the variables here to VariantManager so all scripts can have access.
	VARIANT_MANAGER.GetSceneNode = self
	VARIANT_MANAGER.MouseSensitivity = 0.2
	VARIANT_MANAGER.ZPos = 5
	VARIANT_MANAGER.YPos = 0.4
	VARIANT_MANAGER.CameraPivit1 = find_child("Pivot")
	VARIANT_MANAGER.CameraPivit2 = find_child("Pivot2")
	VARIANT_MANAGER.CurrentCamera = find_child("Camera3D")
	VARIANT_MANAGER.Storage = find_child("Storage")
	VARIANT_MANAGER.GetTimer = find_child("Timer")
	VARIANT_MANAGER.GetTimer2 = find_child("Timer2")
	VARIANT_MANAGER.WorldLight = find_child("DirectionalLight3D")
	VARIANT_MANAGER.CashZPos = VARIANT_MANAGER.ZPos

	VARIANT_MANAGER.CurrentCamera.projection = Ui.find_child("ProjectOption").selected
	VARIANT_MANAGER.CurrentCamera.far = Ui.find_child("FarSlider").value
	VARIANT_MANAGER.CurrentCamera.near = Ui.find_child("NearSlider").value

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
	Ui.find_child("ReturnToPivitButton").connect("pressed",WORLDSETTINGS_MANAGER.ModeChange)
	Ui.find_child("HelpButton").connect("pressed",UI_MANAGER.ShowHelpPanel)
	Ui.find_child("CloseHelpButton").connect("pressed",UI_MANAGER.ShowHelpPanel)
	Ui.find_child("SSAOToggle").connect("toggled",WORLDSETTINGS_MANAGER.SSAO_Toggle)
	Ui.find_child("VOLUMEFOGToggle").connect("toggled",WORLDSETTINGS_MANAGER.VOLUMEFOG_Toggle)
	Ui.find_child("ProjectOption").connect("item_selected",WORLDSETTINGS_MANAGER.ProjectionChange)
	Ui.find_child("FarSlider").connect("value_changed",WORLDSETTINGS_MANAGER.FarChange)
	Ui.find_child("NearSlider").connect("value_changed",WORLDSETTINGS_MANAGER.NearChange)
	Ui.find_child("InstanceSize").connect("value_changed",INSTANCE_MANAGER.InstnaceResize)
	Ui.find_child("Tree2").connect("item_selected",UI_MANAGER.TreeSelected)
	Ui.find_child("Tree2").connect("item_edited",UI_MANAGER.BlendShapeEnditEnded)

	Ui.find_child("SpeedLabel").text = str(VARIANT_MANAGER.CameraSpeed)

	FileWindow.connect("file_selected",FILE_PATH_MANAGER.LoadModelFromFile)
	get_window().files_dropped.connect(FILE_PATH_MANAGER.LoadModelFromFile)
	VARIANT_MANAGER.GetTimer.connect("timeout",DEBUGGING_MANAGER.ClearErrorMessage)
	VARIANT_MANAGER.GetTimer2.connect("timeout",UI_MANAGER.SpeedLabelOff)

	VARIANT_MANAGER.Storage.connect("child_entered_tree",InstanceManager.GetBlendShapes)

	# Setting the slider values to the values on the DirectionalLight3D Node.
	Ui.find_child("XAxisSlider").value = VARIANT_MANAGER.WorldLight.global_rotation.x
	Ui.find_child("YAxisSlider").value = VARIANT_MANAGER.WorldLight.global_rotation.y
	Ui.find_child("LightSlider").value = VARIANT_MANAGER.WorldLight.light_energy

	Ui.find_child("FOVSlider").value = VARIANT_MANAGER.CurrentCamera.fov

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
		VARIANT_MANAGER.CanPivit = true
		VARIANT_MANAGER.MousePosCash = get_viewport().get_mouse_position()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	elif Input.is_action_just_released("RightMouseButton"):
		VARIANT_MANAGER.CanPivit = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.warp_mouse(VARIANT_MANAGER.MousePosCash)

	match VARIANT_MANAGER.FlyMode :
		false:

			## This will set the mouse input relative to MouseMotion in VariantManager.
			if event is InputEventMouseMotion and VARIANT_MANAGER.CanPivit != false:
				VARIANT_MANAGER.MouseMotion = event.relative

			## This will zoom the camera if the usr scroll in or out.
			if Input.is_action_pressed("ScrollDown"):
				VARIANT_MANAGER.ZPos += 0.2
			elif Input.is_action_pressed("ScrollUp"):
				VARIANT_MANAGER.ZPos -= 0.2

			## This will move the camera on the y-axis when the usr presses the middle mouse button.
			if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
				VARIANT_MANAGER.YPos += event.relative.y * VARIANT_MANAGER.MouseSensitivity /45

	## This is the application shortcut key
	if Input.is_action_just_pressed(&"LoadAModel"):
		UI_MANAGER.LoadButton()

	if Input.is_action_just_pressed(&"ControlMod"):
		WORLDSETTINGS_MANAGER.ModeChange()

	if Input.is_action_just_pressed(&"RemoveModel"):
		UI_MANAGER.RemoveButton()

	## This will clamp the camera from going to far (really necessary)
	VARIANT_MANAGER.ZPos = clampf(VARIANT_MANAGER.ZPos,0.2,20)
	VARIANT_MANAGER.YPos = clampf(VARIANT_MANAGER.YPos,-1000,1000)

######################################

func _process(delta: float) -> void:

	## These are functions to make the camera move.
	match VARIANT_MANAGER.FlyMode:
		false :
			USR_CONTROL_MANAGER.CameraMovement(delta)
			USR_CONTROL_MANAGER.CameraZposMotion(delta)
			USR_CONTROL_MANAGER.CameraYposMotion(delta)
