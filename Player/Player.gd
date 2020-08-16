extends KinematicBody2D

const MAX_SPEED = 200
const DECEL = 500

var velocity = Vector2.ZERO
var curr_speed = MAX_SPEED
var is_jumping = false
var is_falling = false
var has_double_jumped = false
var has_jumped = false
var is_tumbling = false

var max_height = 64
var added_height = 0
var ground_elevation = 32

onready var player_shadow = $Shadow
onready var player_sprite = $PlayerSprite
onready var collision_shape = $CollisionShape2D
onready var player_area = $PlayerArea2D
onready var hurtbox = $HurtboxArea2D/CollisionShape2D

func _physics_process(delta):
	if is_tumbling and added_height <= 0:
		velocity.y += 25
		move_and_slide(velocity)
		if player_area.get_overlapping_areas().size() > 0:
			print("OVERLAPPING WALL")
			collision_shape.disabled = true
			is_tumbling = true
		else:
			is_tumbling = false
			collision_shape.disabled = false
		return
		
	# Get input vector, do something as long as it is pressed/held, tap inputs go to _input func
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		# set velocity
		velocity = input_vector * curr_speed
	else:
		velocity = Vector2.ZERO
		
	# Move and slide using current velocity, set velocity to maintain velocity after collision
	velocity = move_and_slide(velocity)
		
	# Move sprite for jumping and falling
	if is_jumping:
		hurtbox.disabled = true
		if added_height < max_height:
			added_height += 4
			player_sprite.position.y -= 4
		else:
			is_falling = true
			is_jumping = false
			
	elif is_falling:
		if added_height > 0:
			added_height -= 4
			player_sprite.position.y += 4
		elif added_height <= ground_elevation:
			is_falling = false
			max_height = 48
			added_height = 0
			has_jumped = false
			has_double_jumped = false
			hurtbox.disabled = false
			
	else:	
		# get if player area is overlapping a wall, if it is, tumble down
		# isTumbling will disable player input
		if player_area.get_overlapping_bodies().size() > 0:
			print("OVERLAPPING WALL")
			collision_shape.disabled = true
			is_tumbling = true
		else:
			is_tumbling = false
			collision_shape.disabled = false
	
	# boundary mask layer of elevation 1
	set_collision_mask_bit(3, ground_elevation + added_height < 32)
	
	# wall mask layer of elevation 1
	set_collision_mask_bit(4, get_collision_mask_bit(3))
	
	# Maintain sprite positions when grounded
	if (added_height <= 0):
		player_sprite.position.y = -6
		player_shadow.position.y = 2
	
	# PLAYER DEATH CHECK (ELEVATION 0 and not in air)
	if ground_elevation == 0 and added_height <= 0:
		position = Vector2.ZERO
		print("DEAD")
		ground_elevation = 32
	
		
# input func for tap input events
func _input(event):
	if Input.is_action_just_pressed("jump") and !has_jumped:
		has_jumped = true
		is_jumping = true
		is_falling = false
	elif Input.is_action_just_pressed("jump") and has_jumped and !has_double_jumped:
		has_double_jumped = true
		max_height = added_height + 48
		is_jumping = true
		is_falling = false
		

# entry should include the wall, wall and boundary collisions should be slightly larger than area2d for entry/elev area
# ENTRY AREA FOR ENTERING ELEVATION SHOULD BE ABOUT 32 PX EMPTY ON TOP
# HAVE ANOTHER LAYERED TILE ABOVE ON TOP THAT WILL BE VISIBLE/INVISIBLE DEPENDING ON PLAYER'S ELEVATION

# Detect elevation entry
func _on_DetectElevEntry_area_entered(area):
	var area_elev = area.get_owner().elevation	# Get elevation of entered area
	# check for players height before allowing entry into new elevation
	if (ground_elevation != area_elev and ground_elevation + added_height >= area_elev):
		ground_elevation = area_elev
		added_height -= ground_elevation
		player_sprite.position.y += ground_elevation
		position.y -= ground_elevation

# Detect elevation area exit
func _on_DetectElevArea_area_exited(area):
	var area_elev = area.get_owner().elevation	# Get elevation of exited area
	if (ground_elevation == area_elev):
		added_height += ground_elevation
		player_sprite.position.y -= ground_elevation
		position.y += ground_elevation
		ground_elevation = 0
		is_falling = true
		set_collision_mask_bit(3, true)
