class_name FILE_PATH_MANAGER extends Node

## This function will load a FBX file to the scene.
static func LoadFBX(Path:String) -> void:
	var FBX_State = FBXState.new()
	var FBX_Doc = FBXDocument.new()
	var Model = FBX_Doc.append_from_file(Path,FBX_State)

	if Model == OK:
		var Instance = FBX_Doc.generate_scene(FBX_State)

		UI_MANAGER.RemoveButton()
		VARIANT_MANAGER.Storage.add_child.call_deferred(Instance)
		UI_MANAGER.DisableButton(false)
		VARIANT_MANAGER.InstanceModel = Instance
		Ui.find_child("InstanceSize").value = 1
		print("fbx model")
	else :

		DEBUGGING_MANAGER.ErrorMessage(str("Importing Failed! | ",Path))

## This function will load a GLB file to the scene.
static func LoadGLB(Path:String) -> void:
	var GLTF_State = GLTFState.new()
	var GLTF_Doc = GLTFDocument.new()
	var Model = GLTF_Doc.append_from_file(Path,GLTF_State)

	if Model == OK :
		var Instance = GLTF_Doc.generate_scene(GLTF_State)

		UI_MANAGER.RemoveButton()
		VARIANT_MANAGER.Storage.add_child.call_deferred(Instance)
		UI_MANAGER.DisableButton(false)
		VARIANT_MANAGER.InstanceModel = Instance
		Ui.find_child("InstanceSize").value = 1
		print("glb model")
	else:

		DEBUGGING_MANAGER.ErrorMessage(str("Importing Failed! | ",Path))

## This function is for loading models also seeing if it's a model file and support's the formate
static func LoadModelFromFile(Path) -> void:
	var FilePath : String

	#########################

	if Path is PackedStringArray:
		FilePath = str(Path.get(0))
	else:
		FilePath = Path

	#########################

	if FilePath.split(".") :
		DEBUGGING_MANAGER.ErrorMessage(str("Loading | ",FilePath))

		if FilePath.ends_with(".glb") :
			LoadGLB(FilePath)
		elif FilePath.ends_with(".fbx") :
			LoadFBX(FilePath)
		else :
			DEBUGGING_MANAGER.ErrorMessage(str("I don't support that format | ",FilePath))
	else:
		DEBUGGING_MANAGER.ErrorMessage(str("Not a format! | ",FilePath))

	print(FilePath)
