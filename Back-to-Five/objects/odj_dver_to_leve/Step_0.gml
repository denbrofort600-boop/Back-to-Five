if(instance_place(x,y,obj_main_hero)){
	if global.level == level {
		room_goto(levels_room[level])
		global.level++;
	}
}

show_debug_message(global.level)
show_debug_message(level)