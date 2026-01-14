class_name USR_CONTROL_MANAGER extends Node

## This function will smoothly move the camera.
static func CameraMovement(Delta:float) -> void:
	VARIANT_MANAGER.SmoothMotion = lerp(VARIANT_MANAGER.SmoothMotion,VARIANT_MANAGER.MouseMotion,15*Delta)
	VARIANT_MANAGER.CameraPivit1.rotate_y(deg_to_rad(-VARIANT_MANAGER.SmoothMotion.x * VARIANT_MANAGER.MouseSensitivity))
	VARIANT_MANAGER.CameraPivit2.rotate_x(deg_to_rad(-VARIANT_MANAGER.SmoothMotion.y * VARIANT_MANAGER.MouseSensitivity) )

	VARIANT_MANAGER.MouseMotion = Vector2.ZERO

## This function will smoothly move the camera on the y-axis.
static func CameraYposMotion(Delta:float) -> void:
	if VARIANT_MANAGER.CameraPivit1.global_position.y != VARIANT_MANAGER.YPos:
		VARIANT_MANAGER.CameraPivit1.global_position.y = lerpf(VARIANT_MANAGER.CameraPivit1.global_position.y,VARIANT_MANAGER.YPos,12*Delta)

## This function will smoothly zoom the camera on the x-axis.
static func CameraZposMotion(Delta:float) -> void:
	if VARIANT_MANAGER.CurrentCamera.global_position.z != VARIANT_MANAGER.ZPos:
		match VARIANT_MANAGER.CurrentCamera.projection:
			0:
				VARIANT_MANAGER.CurrentCamera.position.z = lerpf(VARIANT_MANAGER.CurrentCamera.position.z,VARIANT_MANAGER.ZPos,9*Delta)
			1:
				VARIANT_MANAGER.CurrentCamera.size = lerpf(VARIANT_MANAGER.CurrentCamera.size,VARIANT_MANAGER.ZPos,5*Delta)
