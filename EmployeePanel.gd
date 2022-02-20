extends Tabs

onready var employee_item = preload("res://Employment/EmploymentItem.tscn")

func _process(_delta):
  if get_parent().get_tab_hidden(0) != Targets.employee_tab_hidden:
    get_parent().set_tab_hidden(0, Targets.employee_tab_hidden)

func tick():
  for item in $ScrollContainer/VBoxContainer.get_children():
    item.tick()
    
func reset():
  for item in $ScrollContainer/VBoxContainer.get_children():
    item.employment_count = 0

func employment_count():
  var temp_count = 0
  for item in $ScrollContainer/VBoxContainer.get_children():
    temp_count += item.employment_count
  return temp_count

func add_item(identifier, item_name, item_image, produces, output_rate, price, currency):
  var temp_item = employee_item.instance()
  temp_item.name = identifier
  temp_item.item_name = item_name
  temp_item.item_image = load("res://Sprites/Resources/" + item_image)
  temp_item.identifier = identifier
  temp_item.produces = produces
  temp_item.output_rate = output_rate
  temp_item.price = price
  temp_item.currency = currency
  $ScrollContainer/VBoxContainer.add_child(temp_item)
  get_parent().current_tab = get_index()
