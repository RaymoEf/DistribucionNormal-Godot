extends Node2D

var lineNode = preload("res://line.tscn")
var rng = RandomNumberGenerator.new()
var clr = RandomNumberGenerator.new()
var current_scene = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func spawnLine(num, media, desviacion):
	var numeros = []
	var colores = []
	
	var line = lineNode.instance()
	line.set_position(Vector2(12,555))
	add_child(line)	
	
	for i in 3:
		clr.randomize()
		colores.push_back(clr.randi_range(0,255))
	
	line.set_default_color(Color8(colores[0],colores[1],colores[2],255))
	
	for i in num:
		if OS.has_feature('JavaScript'):
			numeros.push_back(int(JavaScript.eval("""randn_bm(0, 500, 1);
			function randn_bm(min, max, skew) {
	var u = 0, v = 0;
	while(u === 0) u = Math.random();
	while(v === 0) v = Math.random();
	let num = Math.sqrt( -2.0 * Math.log( u ) ) * Math.cos( 2.0 * Math.PI * v );

	num = num / 10.0 + 0.5; 
	if (num > 1 || num < 0) num = randn_bm(min, max, skew); 
	num = Math.pow(num, skew); 
	num *= max - min; 
	num += min; 
	return num;
}			""")))
		else:
			rng.randomize()
			numeros.push_back(int(rng.randfn(media,desviacion)))
	for j in 500:
		var c = numeros.count(j)
		#$Label.text=str(c)
		line.add_point(Vector2(j*2,-c*20))
		#line.set_point_position(j,Vector2(j*2,-c*20))
		yield(get_tree().create_timer(0.01), "timeout")
	


# Called when the node enters the scene tree for the first time.
func _ready():
	var line=lineNode.instance()
	line.set_position(Vector2(12,555))
	add_child(line)	
	line.set_default_color(Color(0.07,0.17,0.41,1))
	line.add_point(Vector2(0,0))
	line.add_point(Vector2(0,-460))
	
	var line2=lineNode.instance()
	line2.set_position(Vector2(12,560))
	add_child(line2)	
	line2.set_default_color(Color(0.90,0.82,0,1))
	line2.add_point(Vector2(0,0))
	line2.add_point(Vector2(1000,0))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var n=$n.text.to_int()
	var m=$m.text.to_int()
	var d=$d.text.to_int()
	spawnLine(n,m,d)# Replace with function body.


func _on_Button2_pressed():
	var n=$n.text.to_int()
	if n == 1000:
		$n.text="100"
	else:
		n=n+100
		$n.text=str(n)
		
	#pass # Replace with function body.


func _on_Button3_pressed():
	var n=$n.text.to_int()
	if n == 100:
		$n.text="1000"
	else:
		n=n-100
		$n.text=str(n)
	


func _on_Button5_pressed():
	var n=$m.text.to_int()
	if n == 0:
		$m.text="500"
	else:
		n=n-50
		$m.text=str(n)
	


func _on_Button4_pressed():
	var n=$m.text.to_int()
	if n == 500:
		$m.text="0"
	else:
		n=n+50
		$m.text=str(n)


func _on_Button7_pressed():
	var n=$d.text.to_int()
	if n == 10:
		$d.text="100"
	else:
		n=n-10
		$d.text=str(n)
	


func _on_Button6_pressed():
	var n=$d.text.to_int()
	if n == 100:
		$d.text="10"
	else:
		n=n+10
		$d.text=str(n)


func _on_Button8_pressed():
	var root = get_tree().get_root().get_child_count()
	var r = get_tree().get_root()
	for i in root:
		current_scene = r.get_child(i)
		current_scene.queue_free()
	var s = ResourceLoader.load("res://main.tscn")
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
