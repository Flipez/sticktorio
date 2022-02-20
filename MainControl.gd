extends Control

var scroll_next_update = false
var run_started = false
var run_start_time = 0

onready var collect_sound = preload("res://Sounds/collect.wav")

func _process(_delta):
  if run_started:
    var time_now = OS.get_system_time_msecs()
    var elapsed = time_now - run_start_time
    
    var minutes = int(elapsed / 60 / 1000)
    var seconds = int(elapsed / 1000) % 60
    var miliseconds = int(elapsed) % 1000
    
    var str_elapsed = "%02d:%02d:%03d" % [minutes, seconds, miliseconds]
    
    $SpeedRunLabel.text = str_elapsed
    
    $WinningProgress/ProgressBar.value = Targets.kings_count
    if !$WinningProgress.visible && Targets.kings_count > 0:
      $WinningProgress.visible = true
      
    if Targets.kings_count == 4:
      $WinDialog/RichTextLabel/Label.text = "Run Time:\n\n" + str_elapsed
      run_started = false
      $AutoCrafterTimer.stop()
      $MainTimer.stop()
      $WinDialog.popup_centered()

func _ready():
  $GridContainer/InventoryPanel.visible = false
  $GridContainer/InventoryPanelPlaceholder.visible = true
  #$GridContainer/CraftingPanel/TabContainer/Employment.visible = false
  $GridContainer/TradePanel.visible = false
  $GridContainer/TradePanelPlaceholder.visible = true
  $GridContainer/CraftingPanel.visible = false
  $GridContainer/CraftingPanelPlaceholder.visible = true
  $WinningProgress.visible = false
  
  Inventory.inventory_list_control = $GridContainer/InventoryPanel/TabContainer
  
  var _return = Targets.connect("new_target_log_message", self, "add_log_to_list")
  
  Targets.interaction_player = $InteractionAudioPlayer
  Targets.trade_control = $GridContainer/TradePanel
  Targets.trade_control_item_list = $GridContainer/TradePanel/ScrollContainer/VBoxContainer
  Targets.main_control = self
  Targets.production_control = $GridContainer/CraftingPanel/TabContainer/Production
  Targets.employment_control = $GridContainer/CraftingPanel/TabContainer/Employment
  
  $AcceptDialog.popup_centered()

func add_log_to_list(message):
  $GridContainer/LogPanel/RichTextLabel.text = $GridContainer/LogPanel/RichTextLabel.text + "\n" + message

func refresh_view():
  ###
  # Coins
  #$GridContainer/MoneyPanel.visible = Inventory.visible("coins")
  $GridContainer/TradePanel/Label.text = Helper.format_number(Inventory.get("coins"))


  ##
  # Trading
  $GridContainer/TradePanel.visible = Targets.trading_visible
  $GridContainer/TradePanelPlaceholder.visible = !Targets.trading_visible
  
  $GridContainer/CraftingPanel.visible = Targets.stone_auto_crafter
  $GridContainer/CraftingPanelPlaceholder.visible = !Targets.stone_auto_crafter
  
  if !Targets.inventory_visible && Inventory.inventory_count() > 0:
    Targets.inventory_visible = true
    $GridContainer/InventoryPanel.visible = true
    $GridContainer/InventoryPanelPlaceholder.visible = false


func offer_reset():
  $ResetDialog.popup_centered()

func increase_timer():
  $AutoCrafterTimer.wait_time = 0.3

func _on_MainTimer_timeout():
  refresh_view()
  Targets.validate_targets()

func _on_AutoCrafterTimer_timeout():
  $GridContainer/CraftingPanel/TabContainer/Employment.tick()
  $GridContainer/CraftingPanel/TabContainer/Production.tick()
  $GridContainer/InventoryPanel.tick()
  Inventory.render_throughput()

func _on_BuyAutoCrafterButton_button_up():
  Inventory.craft_stone_auto_crafter()

func _on_CraftStoneButton_button_up():
  if !run_started:
    run_started = true
    run_start_time = OS.get_system_time_msecs()
  Targets.play_sound(collect_sound, -20)
  Inventory.increase("stones", 1)
  refresh_view()


func _on_BuyStickAutoCrafterButton_button_up():
  Inventory.craft_stick_auto_crafter()


func _on_AboutButton_pressed():
  Targets.play_ui_sound()
  $AboutDialog.popup_centered()


func _on_AboutDialog_confirmed():
  Targets.play_ui_sound()

func _on_AcceptDialog_confirmed():
  Targets.play_ui_sound()


func _on_AudioToggleButton_pressed():
  if $BackgroundMusicPlayer.playing:
   $BackgroundMusicPlayer.stop()
  else:
    $BackgroundMusicPlayer.play()


func _on_ResetDialog_confirmed():
  Targets.reset_game()
