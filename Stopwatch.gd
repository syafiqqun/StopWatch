extends Node2D

var play_button := false

var milisecond := 0
var second := 0
var minute := 0

var time_str := ""
var flag_count := 1


func _physics_process(delta):
	
	if play_button == true:
		
		milisecond += 1
		if milisecond > 90:
			second += 1
			milisecond = 0
		if second > 60:
			minute += 1
			second = 0
		if minute > 60:
			play_button = false
	
		set_timer()


func set_timer():
	
	if milisecond < 10:
		time_str = "0" + str(minute) + ":0" + str(second) + ":0" + str(milisecond)
	else:
		time_str = "0" + str(minute) + ":0" + str(second) + ":" + str(milisecond)
	if second < 10:
		if milisecond < 10:
			time_str = "0" + str(minute) + ":0" + str(second) + ":0" + str(milisecond)
		else:
			time_str = "0" + str(minute) + ":0" + str(second) + ":" + str(milisecond)
	else:
		if minute < 10:
			time_str = "0" + str(minute) + ":" + str(second) + ":" + str(milisecond)
		else:
			time_str = str(minute) + ":" + str(second) + ":" + str(milisecond)
	
	set_time_label(time_str)


func get_time_label():
	return time_str


func set_time_label(val):
	$TimeLabel.text = val


func _on_PlayButton_pressed():
	play_button = !play_button
	
	if play_button == true:
		$PlayButton.text = "Pause"
		$FlagButton.text = "Flag"
	if play_button == false:
		$PlayButton.text = "Play"
		$FlagButton.text = "Reset"


func _on_FlagButton_pressed():
	if play_button == true:
		print(get_time_label())
		var new_label = Label.new()
		new_label.text = str(flag_count) + ") " + time_str
		get_node("ScrollContainer/VBoxContainer").add_child(new_label)
		flag_count += 1
	else:
		milisecond = 0
		second = 0
		minute = 0
		flag_count = 1
		set_time_label("00:00:00")
		var label_list = get_node("ScrollContainer/VBoxContainer").get_children()
		for child in label_list:
			child.queue_free()
