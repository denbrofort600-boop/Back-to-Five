draw_self()
image_speed = 1;
if(keyboard_check(vk_right)){
	image_speed = 0.75;
	sprite_index = spr_main_hero_right;
}else if(keyboard_check(vk_left)){
	image_speed = 0.75;
	sprite_index = spr_main_hero_left;
}else if(keyboard_check(vk_up)){
	sprite_index = spr_main_hero_up;
}else if(keyboard_check(vk_down)){
	sprite_index = spr_main_hero_down;
}else{
	image_speed = 0;
}
if (x == xprevious and y == yprevious) {
	 image_index = 0;
}