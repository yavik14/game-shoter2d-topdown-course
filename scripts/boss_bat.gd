extends CharacterBody2D

@export var max_health = 100
var health = max_health

@onready var anims = $AnimationPlayer
@onready var player = get_node("/root/Level/Player")
@onready var sprite = $Sprite2D

@export var bullet_scene: PackedScene
@export var bullets_per_wave = 12
@export var fire_rate = 0.15
@export var wave_interval = 2.0
@export var shots_per_wave = 3
var firing = false

@onready var timer = $Timer

@export var speed=65
var start_position: Vector2

var phase = 1

@export var laser_fire_rate = 0.05
@export var laser_rotation_speed=180.0
@export var laser_lines=4
@export var laser_angle_gap=90.0

var laser_active=false
var laser_angle=0.0
var laser_timer=0.0

func _ready():
	start_position=global_position
	anims.play("fly")
	anims.connect("animation_finished", self._on_animation_finished)
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = wave_interval
	timer.start()

func _physics_process(delta):
	update_health_bar()
	update_facing()
	match phase:
		2:
			move_towards(player.global_position)
		3:
			move_towards(start_position)
		4:
			if laser_active:
				update_laser_attack(delta)
			
func move_towards(target: Vector2):
	velocity=global_position.direction_to(target)*speed
	move_and_slide()
	if global_position.distance_to(target) < 5:
		global_position = target
		velocity=Vector2.ZERO
		
func take_damage(amount):
	anims.stop()
	anims.play("hurt")
	health -= amount
	if (health <= 0):
		queue_free()
		return
	check_phase()
	
func check_phase():
	var new_phase=1
	if health <= max_health*0.3:
		new_phase=4
	elif health <= max_health*0.5:
		new_phase=3
	elif health <= max_health*0.7:
		new_phase=2
	if new_phase != phase:
		phase = new_phase
		on_phase_changed()

func on_phase_changed():
	match phase:
		2:
			print("Fase 2: Persecución + Ráfagas")
			set_fire_params(0.2, 10, 2.5, 4)
		3:
			print("Fase 3: Furioso + Centro")
			set_fire_params(0.09, 18, 1.2, 5)
		4:
			print("Fase 4: Láser Rotativo")
			timer.stop()
			start_laser_attack()

			

func set_fire_params(rate, bullets, interval, shots):
	fire_rate = rate
	bullets_per_wave = bullets
	wave_interval = interval
	shots_per_wave = shots
	timer.wait_time=interval
	timer.start()

func update_health_bar():
	$CanvasLayer/Control/ProgressBar.value=health
	
func update_facing():
	sprite.flip_h=player.global_position.x < global_position.x

func _on_animation_finished(anim_name):
	if anim_name == "hurt":
		anims.play("fly")

func _on_timer_timeout():
	if not firing:
		fire_bullet_wave()
		
func fire_bullet_wave():
	firing = true
	await start_fire_wave()
	firing = false
	
func start_fire_wave():
	for i in range(shots_per_wave):
		spawn_circular_bullets()
		await get_tree().create_timer(fire_rate).timeout
		
func spawn_circular_bullets():
	var offset = randf() * TAU
	var step = TAU / bullets_per_wave
	for i in range(bullets_per_wave):
		var bullet = bullet_scene.instantiate()
		bullet.position=global_position
		bullet.direction=Vector2.RIGHT.rotated(i*step+offset)
		get_parent().add_child(bullet)

func start_laser_attack():
	laser_active = true
	laser_timer = 0.0
	laser_angle = 0.0
	
func update_laser_attack(delta):
	if not laser_active:
		return
	laser_angle = fposmod(laser_angle+deg_to_rad(laser_rotation_speed)*delta, TAU)
	laser_timer -= delta
	if laser_timer <=0 :
		fire_laser_barrage()
		laser_timer=laser_fire_rate
	
func fire_laser_barrage():
	for i in range(laser_lines):
		var angle = laser_angle-deg_to_rad(i*laser_angle_gap)
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.direction = Vector2.RIGHT.rotated(angle)
		bullet.rotation = angle
		get_parent().add_child(bullet)
