## Simulador de distribución normal en Godot

![Captura de pantalla 2021-12-14 134958](https://user-images.githubusercontent.com/57385138/146069511-ff79e6a0-6775-4aa6-8bbb-42cdee32f413.png)

- El botón _nuevo_ añade una nueva linea a la simulación
- El botón _Limpiar_ limpia la pantalla eliminando las lineas dibujadas
- En _Cantidad de números_ se puede seleccionar la cantidad de números generados para la simulación
- El eje X representa los numeros del 0 al 500
- El eje Y representa la cantidad de veces que aparece un número

Simulación corriendo: 

![2021-12-14 13-59-42](https://user-images.githubusercontent.com/57385138/146071790-d4f38d71-429e-448c-b53c-5ad5a893c039.gif)

O puedes probarla online [aqui](https://raymoef.github.io/Distribucion/)

## Funcionamiento

```gdscript
var lineNode = preload("res://line.tscn")
var rng = RandomNumberGenerator.new()
var clr = RandomNumberGenerator.new()
var current_scene = null
```

Precarga de una escena con la linea que se usara despues, se generan dos numeros aleatoreos, uno para el rango y otro para los colores

```gdscript
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
```

Función para invocar una nueva linea al simulador

- Se obtiene un color al azar obteniendo 3 numeros aleatoreos entre 0 y 255
- Si se corre en un entorno web _if OS.has_feature('JavaScript')_ ejecuta un scpript para generar los números aleatoreos con distribución normal, de lo contrario ejecuta _numeros.push_back(int(rng.randfn(media,desviacion)))_ para obtener los números
- Finalmente dibuja un punto de la linea cada 0.01 ticks 
