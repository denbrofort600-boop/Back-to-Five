key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
var move_h = key_right - key_left;
if (room != tutorial){
	y += move_v * move_speed;
	var move_v = key_down - key_up;
}
var hsp = 0;
if (keyboard_check(ord("A"))){
	hsp = -move_speed;
}
if (keyboard_check(ord("D"))){
	hsp = move_speed;
}
if (!place_meeting(x + hsp, y, obj_platform_for_tutor || obj_box_for_tutor)) {
    x += hsp;
} else {
    while (!place_meeting(x + sign(hsp), y, obj_platform_for_tutor || obj_box_for_tutor)) {
        x += sign(hsp);
    }
}