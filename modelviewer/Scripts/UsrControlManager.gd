class_name USR_CONTROL_MANAGER extends Node

## This function will smoothly move the camera.
static func CameraMovement(Delta:float) -> void:
	VariantManager.SmoothMotion = lerp(VariantManager.SmoothMotion,VariantManager.MouseMotion,15*Delta)
	VariantManager.CameraPivit1.rotate_y(deg_to_rad(-VariantManager.SmoothMotion.x * VariantManager.MouseSensitivity))
	VariantManager.CameraPivit2.rotate_x(deg_to_rad(-VariantManager.SmoothMotion.y * VariantManager.MouseSensitivity) )

	VariantManager.MouseMotion = Vector2.ZERO

## This function will smoothly move the camera on the y-axis.
static func CameraYposMotion(Delta:float) -> void:
	if VariantManager.CameraPivit1.global_position.y != VariantManager.YPos:
		VariantManager.CameraPivit1.global_position.y = lerpf(VariantManager.CameraPivit1.global_position.y,VariantManager.YPos,12*Delta)

## This function will smoothly zoom the camera on the x-axis.
static func CameraZposMotion(Delta:float) -> void:
	if VariantManager.CurrentCamera.global_position.z != VariantManager.ZPos:
		match VariantManager.CurrentCamera.projection:
			0:
				VariantManager.CurrentCamera.position.z = lerpf(VariantManager.CurrentCamera.position.z,VariantManager.ZPos,9*Delta)
			1:
				VariantManager.CurrentCamera.size = lerpf(VariantManager.CurrentCamera.size,VariantManager.ZPos,5*Delta)
