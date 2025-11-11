class_name USR_CONTROL_MANAGER extends Node

static func CameraMovement(Delta:float) -> void:
	VariantManager.SmoothMotion = lerp(VariantManager.SmoothMotion,VariantManager.MouseMotion,15*Delta)
	VariantManager.CameraPivit1.rotate_y(deg_to_rad(-VariantManager.SmoothMotion.x * VariantManager.MouseSensitivity))
	VariantManager.CameraPivit2.rotate_x(deg_to_rad(-VariantManager.SmoothMotion.y * VariantManager.MouseSensitivity) )

	VariantManager.MouseMotion = Vector2.ZERO

static func CameraYposMotion(Delta:float) -> void:
	if VariantManager.CurrentCamera.global_position.y != VariantManager.YPos:
		VariantManager.CurrentCamera.position.y = lerpf(VariantManager.CurrentCamera.position.y,VariantManager.YPos,5*Delta)


static func CameraZposMotion(Delta:float) -> void:
	if VariantManager.CurrentCamera.global_position.z != VariantManager.ZPos:
		VariantManager.CurrentCamera.position.z = lerpf(VariantManager.CurrentCamera.position.z,VariantManager.ZPos,5*Delta)
