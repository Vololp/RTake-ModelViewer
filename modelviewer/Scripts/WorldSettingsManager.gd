class_name WORLDSETTINGS_MANAGER extends Node

# This function changes the DirectionLight3D YAxis value
static func WorldLightSliderY(Value:float) -> void:
	VariantManager.WorldLight.rotation.y = Value

# This function changes the DirectionLight3D XAxis value
static func WorldLightSliderX(Value:float) -> void:
	VariantManager.WorldLight.rotation.x = Value

# This function changes the DirectionLight3D Brightnes value
static func WorldLighting(Value:float) -> void:
	VariantManager.WorldLight.light_energy = Value
