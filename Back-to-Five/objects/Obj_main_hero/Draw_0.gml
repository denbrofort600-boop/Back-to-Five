draw_self()
image_speed = 1;
if(keyboard_check(ord("D"))){
	image_speed = 0.75;
	sprite_index = spr_main_hero_right;
}else if(keyboard_check(ord("A"))){
	image_speed = 0.75;
	sprite_index = spr_main_hero_left;
}else if(keyboard_check(ord("W"))){
	sprite_index = spr_main_hero_up;
}else if(keyboard_check(ord("S"))){
	sprite_index = spr_main_hero_down;
}else{
	image_speed = 0;
}
if (x == xprevious and y == yprevious) {
	 image_index = 0;
}