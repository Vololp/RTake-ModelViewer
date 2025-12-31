class_name WORLDSETTINGS_MANAGER extends Node

# This function changes the DirectionLight3D YAxis value
static func WorldLightSliderY(Value:float) -> void:
	VariantManager.WorldLight.rotation.y = Value

# This function changes the DirectionLight3D XAxis value
static func WorldLightSliderX(Value:float) -> void:
	VariantManager.WorldLight.rotation.x = Value

# This function changes the DirectionLight3D Brightness  value
static func WorldLighting(Value:float) -> void:
	VariantManager.WorldLight.light_energy = Value


static func ResetPostion() -> void:
	if Ui.find_child("ResetPosButton").disabled == false:
		match VariantManager.FlyMode:
			false:
				VariantManager.YPos = 0.4
				VariantManager.ZPos = 5
			true:
				VariantManager.CurrentCamera.global_position = Vector3(0,3,3)
				VariantManager.CurrentCamera.global_rotation = Vector3(5.3,0,0)

static func FovChange(Value:float) -> void:
	VariantManager	.CurrentCamera.fov = Value

static func FarChange(Value:float) -> void:
	VariantManager.CurrentCamera.far = Value

static func NearChange(Value:float) -> void:
	VariantManager.CurrentCamera.near = Value

static func ProjectionChange(Index:int) -> void:
	print(Index)
	if Index == 0:
		VariantManager.CurrentCamera.position.z = VariantManager.CashZPos
		Ui.find_child("FOVSlider").editable = true
		Ui.find_child("ReturnToPivitButton").disabled = false
	else:
		Ui.find_child("FOVSlider").editable = false
		Ui.find_child("ReturnToPivitButton").disabled = true
		VariantManager.CurrentCamera.position.z = 1000

	if VariantManager.CurrentCamera.projection != Index as int:
		VariantManager.CurrentCamera.projection = int(Index)

static func ModeChange() -> void:
	if Ui.find_child("ReturnToPivitButton").disabled == false:
		match VariantManager.FlyMode:
			true:
				Ui.find_child("ReturnToPivitButton").text = "FlyMode"
				VariantManager.FlyMode = false
				VariantManager.CurrentCamera.reparent(VariantManager.GetSceneNode.find_child("Pivit2"),false)
				Ui.find_child("ProjectOption").disabled = false
				Ui.find_child("ProjectOption").selected = 0

				VariantManager.CurrentCamera.global_transform = VariantManager.GetSceneNode.find_child("Pivit2").global_transform

			false:
				Ui.find_child("ReturnToPivitButton").text = "Return"
				ResetPostion()
				VariantManager.FlyMode = true
				VariantManager.CurrentCamera.reparent(VariantManager.GetSceneNode,true)
				Ui.find_child("ProjectOption").disabled = true
				Ui.find_child("ProjectOption").selected = 0
				VariantManager.CurrentCamera.projection = Ui.find_child("ProjectOption").selected
