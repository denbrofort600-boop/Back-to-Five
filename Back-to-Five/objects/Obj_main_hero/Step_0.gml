key_right = keyboard_check(vk_right);
key_left = keyboard_check(vk_left);
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);
var move_h = key_right - key_left;
var move_v = key_down - key_up;
x += move_h * move_speed;
y += move_v * move_speed;
