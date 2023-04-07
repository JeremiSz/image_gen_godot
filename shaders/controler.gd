extends Node

var VIEWPORT : Viewport;
var images :Array[Image]=[];
var areas : Array[float]=[];
var index = 0;

@export
var shader_sqr : Shader;
@export
var shader_circ : Shader;
@export
var rounds : int=100;
const COUNT :int = 128*128;
var RANDOM = RandomNumberGenerator.new();

var squares :Array[Node];
var circles :Array[Node];

func _ready():
	print(rounds)
	VIEWPORT = self.get_viewport();
	var tree = self.get_tree();
	squares  = tree.get_nodes_in_group("square");
	circles = tree.get_nodes_in_group("circle");
	
	for square in squares:
		square.material = ShaderMaterial.new();
		(square.material as ShaderMaterial).shader = shader_sqr;
	for circle in circles:
		circle.material = ShaderMaterial.new();
		(circle.material as ShaderMaterial).shader = shader_circ;
	return;
	
func _process(_delta):
	_new_values();
	if index > rounds:
		exit();
	images.append(VIEWPORT.get_texture().get_image());
	index += 1;
	return
	
func exit():
	var index :int = 0;
	for img in images:
		img.save_png("images/" + str(index) + "test.png");
		
		index +=1;
	var text = "";
	for area in areas:
		text += str(area) + ",";
	var file = FileAccess.open("areas.csv",FileAccess.WRITE);
	file.store_string(text);
	file.close();
	self.get_tree().quit();
	
func _new_values():
	for square in squares:
		var x = RANDOM.randf();
		var y = RANDOM.randf();
		var lenght = RANDOM.randf()/2;
		square.material.set_shader_parameter("edges", Vector4(x - lenght,y - lenght,x + lenght,y+lenght));
		areas.append(lenght * lenght);
	for circle in circles:
		var radius = RANDOM.randf();
		var x = RANDOM.randf();
		var y = RANDOM.randf();
		circle.material.set_shader_parameter("data",Vector4(x,y,radius,0.0));
		areas.append(PI * radius * radius);
	return;
		
