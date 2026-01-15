class_name UI_MANAGER extends Node

## This Function disables the remove button in the usr interface.
static func DisableButton(Disable:bool) -> void:
	var GetRemoveButton = Ui.find_child("RemoveButton") as Button

	GetRemoveButton.disabled = Disable

## This function will open the files window.
static func LoadButton() -> void:
	FileWindow.visible = true

## This function will remove the model from the scene.
static func RemoveButton() -> void:

	if VARIANT_MANAGER.Storage.get_child_count() == 1:

		ClearTrees()
		VARIANT_MANAGER.Storage.get_child(0).queue_free()
		VARIANT_MANAGER.InstanceModel = null

		VARIANT_MANAGER.GetBlendShapeItem = null
		VARIANT_MANAGER.GetMeshWithSelBlend = ""

		DisableButton(true)

# This function will clear the trees in the user-interface.
static func ClearTrees() -> void:
	Ui.find_child("Tree").clear()
	Ui.find_child("Tree2").clear()

# This function will check what tree-item is selected.
static func TreeSelected() -> void:
	var GetItem : TreeItem = Ui.find_child("Tree2").get_selected()

	print(GetItem.get_suffix(0))
	VARIANT_MANAGER.GetBlendShapeItem = GetItem
	VARIANT_MANAGER.GetMeshWithSelBlend = GetItem.get_suffix(0).get_slice(" ",1)
	VARIANT_MANAGER.SelectedBlendShape = GetItem.get_index()

# This function will change the blendshape value of the mesh when the user deselects a tree-item.
static func BlendShapeEnditEnded() -> void:
	var _GetMesh : MeshInstance3D = VARIANT_MANAGER.InstanceModel.find_child(VARIANT_MANAGER.GetMeshWithSelBlend)
	var _GetTreeItems = Ui.find_child("Tree2").get_root().get_children()

	print(_GetTreeItems[VARIANT_MANAGER.SelectedBlendShape].get_range(0))

	_GetMesh.set_blend_shape_value(VARIANT_MANAGER.SelectedBlendShape,_GetTreeItems[VARIANT_MANAGER.SelectedBlendShape].get_range(0))
	VARIANT_MANAGER.GetBlendShapeItem = null

# This function will add a tree-item to the tree-node that shows the number of materials a mesh has.
static func AddSurfaceMaterialItem(ToWhere:Tree,IntoWhat:TreeItem,MeshName:String,Value:int) -> void:
	var NewItem = ToWhere.create_item(IntoWhat)

	NewItem.set_description(0,str(MeshName," ",Value))
	NewItem.set_text(0,str(MeshName," | ",Value))

# This function will add a tree-item to the tree-node that shows the number of blendshapes a mesh has.
static func AddBlendShapeItem(ToWhere:Tree,IntoWhat:TreeItem,MeshName:String,Value:int) -> void:
	var NewItem = ToWhere.create_item(IntoWhat)

	NewItem.set_suffix(0,str("| ",MeshName," ",Value))
	NewItem.set_description(0,str(MeshName," ",Value))
	NewItem.set_cell_mode(0,2 as TreeItem.TreeCellMode)
	NewItem.set_editable(0,true)
	NewItem.set_range_config(0,0,1,0,false)

# This function will update the Label[-SpeedLabel-] to show the max-speed for the camera-controller.
static func ChangeSpeedLabel() -> void:

	match Ui.find_child("SpeedLabel").visible:

		true:
			VARIANT_MANAGER.GetTimer2.start(0)
			Ui.find_child("SpeedLabel").text = str(VARIANT_MANAGER.CameraSpeed)
		false:
			Ui.find_child("SpeedLabel").visible = true
			Ui.find_child("SpeedLabel").text = str(VARIANT_MANAGER.CameraSpeed)
			VARIANT_MANAGER.GetTimer2.start()

# This function will set the visible to false on Label[-SpeedLabel-].
static func SpeedLabelOff() -> void:
	Ui.find_child("SpeedLabel").visible = false

## This function will show the settings panel for the usr.
static func ShowPanel(PanelName:String) -> void:
	var GetAnimation = Ui.find_child("AnimationPlayer") as AnimationPlayer
	var GetSettingsPanel = Ui.find_child("WorldSettingsContainer") as Control
	var GetInstancePanel = Ui.find_child("InstanceSettingsContainer") as Control

	match PanelName:

		"Settings":

			match VARIANT_MANAGER.SettingsPanel:
				true:
					VARIANT_MANAGER.SettingsPanel = false
				false:
					VARIANT_MANAGER.InstancePanel = false
					VARIANT_MANAGER.SettingsPanel = true
					GetInstancePanel.visible = VARIANT_MANAGER.InstancePanel
					GetSettingsPanel.visible = VARIANT_MANAGER.SettingsPanel

		"Instance":

			match VARIANT_MANAGER.InstancePanel:
				true:
					VARIANT_MANAGER.InstancePanel = false
				false:
					VARIANT_MANAGER.InstancePanel = true
					VARIANT_MANAGER.SettingsPanel = false
					GetInstancePanel.visible = VARIANT_MANAGER.InstancePanel
					GetSettingsPanel.visible = VARIANT_MANAGER.SettingsPanel

	if VARIANT_MANAGER.PanelShow != true:

		GetAnimation.play("Open_SettingsPanel")
		VARIANT_MANAGER.PanelShow = true

	elif VARIANT_MANAGER.SettingsPanel == false and VARIANT_MANAGER.InstancePanel == false:

		GetAnimation.play_backwards("Open_SettingsPanel")
		VARIANT_MANAGER.PanelShow = false

# This function will open the help-panel and also closing the panel.
static func ShowHelpPanel() -> void:
	var GetAnimation = Ui.find_child("AnimationPlayer") as AnimationPlayer

	match VARIANT_MANAGER.HelpPanelShow:
		true:
			VARIANT_MANAGER.HelpPanelShow = false
			GetAnimation.play_backwards("Open_HelpPanel")

		false:
			VARIANT_MANAGER.HelpPanelShow = true
			GetAnimation.play("Open_HelpPanel")

# This function will show the settings-panel.
static func ShowSettingsPanel() -> void:
	ShowPanel("Settings")

# This function will show the instance-panel.
static func ShowInstancePanel() -> void:
	ShowPanel("Instance")
