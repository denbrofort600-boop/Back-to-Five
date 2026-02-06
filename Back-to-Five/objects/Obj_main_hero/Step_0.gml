var hsp = 0, vsp = 0;
if (room != tutorial){
	key_up = keyboard_check(ord("W"));
	key_down = keyboard_check(ord("S"));
	key_left = keyboard_check(ord("A"));
	key_right = keyboard_check(ord("D"));
	y += move_v * move_speed;
	var move_v = key_down - key_up;
	if(key_right){
		hsp = move_speed;
	}else if(key_left){
		hsp = -move_speed;
	}
	if(key_down){
		vsp = move_speed;
	}else if(key_up){
		vsp = move_speed;
	}
	var s = 0;
	if (!place_meeting(x + hsp, y, obj_collision)) {
	    x += hsp;
	} else {
	    while (!place_meeting(x + sign(hsp), y, obj_collision) && s < 10) {
	        x += sign(hsp);
			s++;
	    }
	}

	if (!place_meeting(x, y + vsp, obj_collision)) {
	    y += vsp;
	} else {
	    while (!place_meeting(x, y + sign(vsp), obj_collision) && s < 10) {
	        y += sign(vsp);
			s++;
	    }
	}

}else{
	key_left = keyboard_check(ord("A"));
	key_right = keyboard_check(ord("D"));

	hsp = (key_right - key_left) * move_speed;

	vsp += grav;
	if (keyboard_check_pressed(vk_space) && onground) {
	    vsp = jump_strength;
	    onground = false;
	}
	if (!place_meeting(x + hsp, y, obj_collision)) {
	    x += hsp;
	} else {
	    while (!place_meeting(x + sign(hsp), y, obj_collision)) {
	        x += sign(hsp);
	    }
	    hsp = 0;
	}
	if (!place_meeting(x, y + vsp, obj_collision)) {
	    y += vsp;
	} else {
	    while (!place_meeting(x, y + sign(vsp), obj_collision)) {
	        y += sign(vsp);
	    }
	    if (vsp > 0) onground = true;
	    vsp = 0;
	}
	
}