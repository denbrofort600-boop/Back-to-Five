key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
var move_h = key_right - key_left;
if (room != tutorial){
	y += move_v * move_speed;
	var move_v = key_down - key_up;
}
var hsp = 0, vsp = 0;
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