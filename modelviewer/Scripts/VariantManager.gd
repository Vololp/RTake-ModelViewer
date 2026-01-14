class_name VARIANT_MANAGER extends Node

## this is to store variables...

static var GetSceneNode : Node3D
static var InstanceModel : Node3D
static var CameraPivit1: Node3D
static var CameraPivit2 : Node3D
static var Storage : Node3D
static var CurrentCamera : Camera3D
static var GetTimer : Timer
static var GetTimer2 : Timer
static var WorldLight : DirectionalLight3D
static var GetBlendShapeItem : TreeItem
static var GetMeshWithSelBlend : String

static var SelectedBlendShape : int = -1

static var HierarchyTree : Array = []

static var MouseMotion : Vector2
static var SmoothMotion : Vector2
static var MousePosCash : Vector2

static var CanPivit : bool
static var PanelShow : bool
static var HelpPanelShow : bool
static var SettingsPanel : bool
static var InstancePanel : bool
static var FlyMode : bool

static var MouseSensitivity : float
static var ZPos : float
static var YPos : float
static var CashZPos : float

static var CameraSpeedMax : float = 40
static var CameraSpeed : float = int(5)
static var CameraSpeedHold : float
