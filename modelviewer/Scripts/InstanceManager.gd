class_name INSTANCE_MANAGER extends Node


static func InstnaceResize(Size:float) -> void:
	if VariantManager.InstanceModel != null:
		VariantManager.InstanceModel.scale = Vector3(Size,Size,Size)
