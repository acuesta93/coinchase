extends Node
@onready var Coin = preload("res://moneda/moneda.tscn")
@export var tiempoJuego : int

var nivel := 1
var score
var time_left
@onready var screensize = Vector2(450,680)
var playing = false
@onready var player = $player
@onready var hud = $HUD
@onready var Powerup = preload("res://powerup/powerup.tscn")
@onready var Cactus = preload("res://cactus/cactus.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	player.ventanaTm = screensize
	player.hide()
	
func nuevoJuego():
	$SpawnPowerupTimer.start()
	$InicioAudioStreamPlayer.play()
	playing = true
	nivel = 1
	score = 0
	time_left = 10
	player.inicio($InicioMarker2D.position) 
	player.show()
	$juegoTimer.start()
	agregarMonedas()
	hud.actualizaScore(score)
	hud.actualizaTimer(time_left)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playing and $contenedor_monedas.get_child_count() == 0:
		nivel += 1;
		time_left += 5;
		agregarMonedas();

func agregarMonedas():
	crearCactus();
	for i in range(4+nivel):
		var coin = Coin.instantiate()
		$contenedor_monedas.add_child(coin)
		coin.position = Vector2(randf_range(0, screensize.x), randf_range(0, screensize.y))
		


func _on_juego_timer_timeout() -> void:
	time_left -= 1
	hud.actualizaTimer(time_left)
	if time_left <= 0:
		game_over();
		
func game_over():
	$MorirAudioStreamPlayer.play()
	playing = false;
	$juegoTimer.stop();
	for moneda in $contenedor_monedas.get_children():
		moneda.queue_free()
	hud.mostrarGameover()
	player.morirse()
		


func _on_player_recolectar(areaRecolectada) -> void:
	match areaRecolectada:
		"moneda":
			$MonedaAudioStreamPlayer.play()
			score += 1
			hud.actualizaScore(score)
		"powerup":
			$PowerupAudioStreamPlayer.play()
			time_left += 3;


func _on_player_herirse() -> void:
	game_over()


func new_game() -> void:
	nuevoJuego()


func _on_spawn_powerup_timer_timeout() -> void:
	if playing:
		$SpawnPowerupTimer.wait_time = randi_range(3,10)
		var powerup = Powerup.instantiate()
		add_child(powerup)
		powerup.position = Vector2(randf_range(0, screensize.x), randf_range(0, screensize.y))
		
func crearCactus():
	var cactus = Cactus.instantiate()
	add_child(cactus)
	randomize()
	cactus.position = Vector2(randf_range(0, screensize.x), randf_range(0, screensize.y))
	
	
