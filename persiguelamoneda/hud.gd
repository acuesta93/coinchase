extends CanvasLayer

signal inicioJuego;

func actualizaScore(value):
	$Control/NivelLabel.text =str(value)
	
func actualizaTimer(value):
	$Control/TiempoLabel2.text = str(value)
	
func mostrarMensajeInicio(text):
	$Control/InicioLabel3.text = text;
	$Control/Button.show();
	$MensajeTimer.start();
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mensaje_timer_timeout() -> void:
	$Control/InicioLabel3.hide();


func _on_button_pressed() -> void:
	$Control/Button.hide()
	$Control/InicioLabel3.hide()
	emit_signal("inicioJuego")

func mostrarGameover():
	mostrarMensajeInicio("Se acabó el tiempo")
	await $MensajeTimer.timeout
	$Control/Button.show()
	$Control/InicioLabel3.text = "PERSIGUE LA MONEDA"
	$Control/InicioLabel3.show()
