extends Node

class_name Recipe

export var consumes : Array
export var produces : Array
export var input_rate : int
export var output_rate : int

func use(recipe_name):
  var recipe_hash = Helper.recipes[recipe_name]
  consumes = recipe_hash["consumes"]
  produces = recipe_hash["produces"]
  input_rate = recipe_hash["input_rate"]
  output_rate = recipe_hash["output_rate"]

  return self
