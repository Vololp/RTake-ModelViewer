class_name INSTANCE_MANAGER extends Node

# This function will set the scale of the model.
static func InstnaceResize(Size:float) -> void:

	if VARIANT_MANAGER.InstanceModel != null:

		VARIANT_MANAGER.InstanceModel.scale = Vector3(Size,Size,Size)

static func GetBlendShapesFromSkeleton3D(Value:int) -> void:
	var GetInstance = VARIANT_MANAGER.InstanceModel
	var GetTree : Tree = Ui.find_child("Tree2")
	var Root = GetTree.create_item()

	for GetPlaceChild in GetInstance.get_child(Value).get_child(0).get_child_count():

		if GetInstance.get_child(Value).get_child(0).get_child(0) is MeshInstance3D:

			if GetInstance.get_child(Value).get_child(0).get_child(0).get_blend_shape_count() != null:

				for GetBlend in GetInstance.get_child(Value).get_child(0).get_child(GetPlaceChild).get_blend_shape_count():
					var TheNode : Node3D = GetInstance.get_child(Value).get_child(0).get_child(GetPlaceChild)

					UI_MANAGER.AddBlendShapeItem(GetTree,Root,TheNode.name,GetBlend)

static func GetBlendShapes(Instance:Node3D) -> void:
	var GetTree : Tree = Ui.find_child("Tree2")
	var Root = GetTree.create_item()

	UI_MANAGER.ClearTrees()

	GetSurfaceMaterials(Instance)

	for GetPlace:int in Instance.get_child_count():

		if Instance.get_child(GetPlace) is Node3D and Instance.get_child(GetPlace).name == "Armature":

			GetBlendShapesFromSkeleton3D(GetPlace)

		elif Instance.get_child(GetPlace) is MeshInstance3D:

			if Instance.get_child(GetPlace).get_blend_shape_count() != null:

				for GetBlend in Instance.get_child(GetPlace).get_blend_shape_count():
					var TheNode : Node3D = Instance.get_child(GetPlace)

					UI_MANAGER.AddBlendShapeItem(GetTree,Root,TheNode.name,GetBlend)

static func GetSurfaceMaterials(GetInstance:Node3D) -> void:
	var GetTree : Tree = Ui.find_child("Tree")
	var Root = GetTree.create_item()

	for GetPlace:int in GetInstance.get_child_count():

		if GetInstance.get_child(GetPlace) is Node3D and GetInstance.get_child(GetPlace).name == "Armature":

			for Get in GetInstance.get_child(GetPlace).get_child(0).get_child_count():

				if GetInstance.get_child(GetPlace).get_child(0).get_child(Get) is MeshInstance3D:
					var TheNode : Node3D = GetInstance.get_child(GetPlace).get_child(0).get_child(Get)

					UI_MANAGER.AddSurfaceMaterialItem(GetTree,Root,TheNode.name,TheNode.get_surface_override_material_count())

		elif GetInstance.get_child(GetPlace) is MeshInstance3D:
			var TheNode : Node3D = GetInstance.get_child(GetPlace)

			UI_MANAGER.AddSurfaceMaterialItem(GetTree,Root,TheNode.name,TheNode.get_surface_override_material_count())
