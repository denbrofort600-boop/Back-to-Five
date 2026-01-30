image_speed = 10;
if(keyboard_check(vk_right)){
	sprite_index = spr_main_hero_right;
}else if(keyboard_check(vk_left)){
	sprite_index = spr_main_hero_left;
}else if(keyboard_check(vk_up)){
	sprite_index = spr_main_hero_up;
}else{
	sprite_index = spr_main_hero_down;
}