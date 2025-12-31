class_name CameraFlyer extends Camera3D

var MouseMotion : Vector2 = Vector2(0,0)
var MousePosCash : Vector2
var Direction : Vector3
var SmoothDirection : Vector3

var Value1 : float = 0.11

var ForwardRightVector : Vector2
var UpDownVector : Vector2

var Forward : bool
var Backward : bool
var Left : bool
var Right : bool
var Up : bool
var Down : bool
var ScrollWheelButton : bool
var SuperSpeed : bool

## This function sets the *MouseMotion* variable to the mouses position.
func SetMouseRelative(GetEvent:InputEvent) -> void:
	if GetEvent is InputEventMouseMotion:
		MouseMotion = GetEvent.relative * VariantManager.MouseSensitivity

## This funtion is used to capture the mouse when the right mouse button is pressed.
func SetPivit(GetEvent:InputEvent) -> void:
	if GetEvent is InputEventMouseButton:
		if VariantManager.FlyMode != true:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
				MousePosCash = get_viewport().get_mouse_position()
			elif !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
					Input.warp_mouse(MousePosCash)

## This funtion is used to rotate the camera when the right mouse button is pressed.
func SetCameraRotation() -> void:

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-MouseMotion.x))
		rotate_object_local(Vector3(1,0,0),deg_to_rad(-MouseMotion.y))

	if ScrollWheelButton == true and VariantManager.FlyMode != true:
		translate(Vector3(-MouseMotion.x * Value1,MouseMotion.y * Value1,0))

	MouseMotion = Vector2.ZERO

## This function is used user inputs.
func SetMovementInputs(GetEvent:InputEvent) -> void:

	if GetEvent is InputEventKey:
		match GetEvent.keycode:
			KEY_W:
				Forward = GetEvent.pressed
			KEY_S:
				Backward = GetEvent.pressed
			KEY_A:
				Left = GetEvent.pressed
			KEY_D:
				Right = GetEvent.pressed
			KEY_E:
				Up = GetEvent.pressed
			KEY_Q:
				Down = GetEvent.pressed
		if Input.is_key_pressed(KEY_SHIFT):
			if SuperSpeed != true:
				SuperSpeed = true
				VariantManager.CameraSpeedHold = VariantManager.CameraSpeed
				VariantManager.CameraSpeed = VariantManager.CameraSpeedMax
		else:
			if SuperSpeed != false:
				SuperSpeed = false
				VariantManager.CameraSpeed = VariantManager.CameraSpeedHold

	if GetEvent	 is InputEventMouseButton:
		match GetEvent.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
					VariantManager.CameraSpeed += 0.2
				else:
					translate(Vector3(0,0,-0.3))
			MOUSE_BUTTON_WHEEL_DOWN:
				if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
					VariantManager.CameraSpeed -= 0.2
				else:
					translate(Vector3(0,0,0.3))
			MOUSE_BUTTON_MIDDLE:
				ScrollWheelButton = GetEvent.pressed

	VariantManager.CameraSpeed = clampf(VariantManager.CameraSpeed,0.4,VariantManager.CameraSpeedMax)
	ForwardRightVector = Vector2((Backward as int) - (Forward as int),(Right as int) - (Left as int))

## This Function is used to set the movement direction for the camera.
func SetDirection(Delta:float) -> void:
	Direction = Vector3(ForwardRightVector.y * VariantManager.CameraSpeed,(Up as float)* VariantManager.CameraSpeed - (Down as float)* VariantManager.CameraSpeed ,ForwardRightVector.x * VariantManager.CameraSpeed)

	SmoothDirection = lerp(SmoothDirection,Direction,Delta*14)

	translate(SmoothDirection * Delta)

#---------------------------------------------------------#

func _input(event: InputEvent) -> void:
	match VariantManager.FlyMode :
		true :
			SetMouseRelative(event)
			SetPivit(event)
			SetCameraRotation()
			SetMovementInputs(event)

func _process(delta: float) -> void:
	match VariantManager.FlyMode :
		true :
			SetDirection(delta)
