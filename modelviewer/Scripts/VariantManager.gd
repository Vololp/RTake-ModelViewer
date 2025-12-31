class_name VARIANT_MANAGER extends Node

## this is to store variables...

var GetSceneNode : Node3D
var InstanceModel : Node3D
var CameraPivit1: Node3D
var CameraPivit2 : Node3D
var Storage : Node3D
var CurrentCamera : Camera3D
var GetTimer : Timer
var WorldLight : DirectionalLight3D

var MouseMotion : Vector2
var SmoothMotion : Vector2
var MousePosCash : Vector2

var CanPivit : bool
var PanelShow : bool
var SettingsPanel : bool
var InstancePanel : bool
var FlyMode : bool

var MouseSensitivity : float
var ZPos : float
var YPos : float
var CashZPos : float

var CameraSpeedMax : float = 40
var CameraSpeed : float = 7
var CameraSpeedHold : float
