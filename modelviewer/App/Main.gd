extends Node3D

@export var Pivit1 : Node3D
@export var Pivit2 : Node3D
@export var GetCamera : Camera3D
@export var Storage : Node3D
@export var GetTimer : Timer


var MouseMotion : Vector2
var SmoothMotion : Vector2
var MousePosCash : Vector2
var PivitMove : bool

var MouseSens : float = 0.2
var ZPos : float = 5
var YPos : float = 0.4

func CameraMovement(Delta:float) -> void:
	SmoothMotion = lerp(SmoothMotion,MouseMotion,15*Delta)
	Pivit1.rotate_y(deg_to_rad(-SmoothMotion.x * MouseSens))
	Pivit2.rotate_x(deg_to_rad(-SmoothMotion.y * MouseSens) )

	MouseMotion = Vector2.ZERO

func CameraZposMotion(Delta:float) -> void:
	if GetCamera.global_position.z != ZPos:
		GetCamera.position.z = lerpf(GetCamera.position.z,ZPos,5*Delta)

func CameraYposMotion(Delta:float) -> void:
	Pivit1.global_position.y = lerpf(Pivit1.global_position.y,YPos,10*Delta)

func LoadButton() -> void:
	FileWindow.visible = true

func RemoveButton() -> void:
	if Storage.get_child_count() == 1:
		Storage.get_child(0).queue_free()
		DisableButton(true)
	pass

func ClearMessage() -> void:
	var ErrorBox = Ui.find_child("ErrorBox") as LineEdit
	ErrorBox.text = ""

func ErrorMessage(Text:String) -> void:
	var ErrorBox = Ui.find_child("ErrorBox") as LineEdit
	ErrorBox.text = Text
	GetTimer.start(0)

func LoadModelFromFile(Path:String) -> void:
	if Path.split(".") :
		ErrorMessage(str("Loading | ",Path))
		if Path.ends_with(".glb") :
			var GLTF_State = GLTFState.new()
			var GLTF_Doc = GLTFDocument.new()
			var Model = GLTF_Doc.append_from_file(Path,GLTF_State)
			if Model == OK :
				var Instance = GLTF_Doc.generate_scene(GLTF_State)
				RemoveButton()
				Storage.add_child.call_deferred(Instance)
				DisableButton(false)
				print("glb model")
			else:
				ErrorMessage(str("Importing Failed! | ",Path))
		elif Path.ends_with(".fbx") :
			var FBX_State = FBXState.new()
			var FBX_Doc = FBXDocument.new()
			var Model = FBX_Doc.append_from_file(Path,FBX_State)
			if Model == OK:
				var Instance = FBX_Doc.generate_scene(FBX_State)
				RemoveButton()
				Storage.add_child.call_deferred(Instance)
				DisableButton(false)
				print("fbx model")
			else :
				ErrorMessage(str("Importing Failed! | ",Path))
		elif Path.ends_with(".obj") :
			ErrorMessage("OBJ is not supported yet")
			print("obj model")
		else :
			ErrorMessage(str("I don't support that format | ",Path))
	else:
		ErrorMessage(str("Not a format! | ",Path))

	print(Path)

func DisableButton(Disable:bool) -> void:
	var GetRemoveButton = Ui.find_child("RemoveButton") as Button

	GetRemoveButton.disabled = Disable

func _ready() -> void:
	var GetLoadButton = Ui.find_child("LoadButton") as Button
	var GetRemoveButton = Ui.find_child("RemoveButton") as Button

	GetLoadButton.connect("pressed",LoadButton)
	GetRemoveButton.connect("pressed",RemoveButton)
	FileWindow.connect("file_selected",LoadModelFromFile)

	if Storage.get_child_count() != 1:
		FileWindow.visible = true


func _input(event: InputEvent) -> void:

	if event is InputEventMouseMotion and PivitMove != false:
		MouseMotion = event.relative

	if Input.is_action_just_pressed("RightMouseButton"):
		PivitMove = true
		MousePosCash = get_viewport().get_mouse_position()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif Input.is_action_just_released("RightMouseButton"):
		PivitMove = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.warp_mouse(MousePosCash)

	if Input.is_action_pressed("ScrollDown"):
		ZPos += 0.2
	elif Input.is_action_pressed("ScrollUp"):
		ZPos -= 0.2

	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		YPos += event.relative.y * MouseSens /45

	ZPos = clampf(ZPos,0.2,20)
	YPos = clampf(YPos,0.0,1000)

func _process(delta: float) -> void:
	CameraMovement(delta)
	CameraZposMotion(delta)
	CameraYposMotion(delta)
