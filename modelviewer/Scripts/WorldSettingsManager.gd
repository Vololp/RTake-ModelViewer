class_name WORLDSETTINGS_MANAGER extends Node

# This function changes the DirectionLight3D YAxis value
static func WorldLightSliderY(Value:float) -> void:
	VARIANT_MANAGER.WorldLight.rotation.y = Value

# This function changes the DirectionLight3D XAxis value
static func WorldLightSliderX(Value:float) -> void:
	VARIANT_MANAGER.WorldLight.rotation.x = Value

# This function changes the DirectionLight3D Brightness  value
static func WorldLighting(Value:float) -> void:
	VARIANT_MANAGER.WorldLight.light_energy = Value

# This function will reset the position to the camera controller.
static func ResetPostion() -> void:
	if Ui.find_child("ResetPosButton").disabled == false:
		match VARIANT_MANAGER.FlyMode:
			false:
				VARIANT_MANAGER.YPos = 0.4
				VARIANT_MANAGER.ZPos = 5
			true:
				VARIANT_MANAGER.CurrentCamera.global_position = Vector3(0,3,3)
				VARIANT_MANAGER.CurrentCamera.global_rotation = Vector3(5.3,0,0)

# This function will set the fov for the users camera.
static func FovChange(Value:float) -> void:
	VARIANT_MANAGER.CurrentCamera.fov = Value

# This function will set the far distance for the users camera.
static func FarChange(Value:float) -> void:
	VARIANT_MANAGER.CurrentCamera.far = Value

# This function will set the near distance for the users camera.
static func NearChange(Value:float) -> void:
	VARIANT_MANAGER.CurrentCamera.near = Value

# This function will set the camera projection.
static func ProjectionChange(Index:int) -> void:

	print(Index)
	if Index == 0:
		VARIANT_MANAGER.CurrentCamera.position.z = VARIANT_MANAGER.CashZPos
		Ui.find_child("FOVSlider").editable = true
		Ui.find_child("ReturnToPivitButton").disabled = false
	else:
		Ui.find_child("FOVSlider").editable = false
		Ui.find_child("ReturnToPivitButton").disabled = true
		VARIANT_MANAGER.CurrentCamera.position.z = 1000

	if VARIANT_MANAGER.CurrentCamera.projection != Index:
		VARIANT_MANAGER.CurrentCamera.projection = Index as Camera3D.ProjectionType

# This function will change the camera controller mode.
static func ModeChange() -> void:

	if Ui.find_child("ReturnToPivitButton").disabled == false:
		match VARIANT_MANAGER.FlyMode:
			true:
				Ui.find_child("ReturnToPivitButton").text = "FlyMode"
				VARIANT_MANAGER.FlyMode = false
				VARIANT_MANAGER.CurrentCamera.reparent(VARIANT_MANAGER.CameraPivit2,false)
				Ui.find_child("ProjectOption").disabled = false
				Ui.find_child("ProjectOption").selected = 0

				VARIANT_MANAGER.CurrentCamera.global_transform = VARIANT_MANAGER.CameraPivit2.global_transform

			false:
				Ui.find_child("ReturnToPivitButton").text = "Return"
				ResetPostion()
				UI_MANAGER.ChangeSpeedLabel()
				VARIANT_MANAGER.FlyMode = true
				VARIANT_MANAGER.CurrentCamera.reparent(VARIANT_MANAGER.GetSceneNode,true)
				Ui.find_child("ProjectOption").disabled = true
				Ui.find_child("ProjectOption").selected = 0
				VARIANT_MANAGER.CurrentCamera.projection = Ui.find_child("ProjectOption").selected

# This function will toggle the ssao in the scene.
static func SSAO_Toggle(BoolValue:bool) -> void:
	VARIANT_MANAGER.CurrentCamera.environment.ssao_enabled = BoolValue

# This function will toggle the volumetric-fog in the scene.
static func VOLUMEFOG_Toggle(BoolValue:bool) -> void:
	VARIANT_MANAGER.CurrentCamera.environment.volumetric_fog_enabled = BoolValue
