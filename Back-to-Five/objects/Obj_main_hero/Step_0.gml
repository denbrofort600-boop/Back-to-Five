if (pos_history_x == undefined) {
    pos_history_x = ds_list_create();
    pos_history_y = ds_list_create();
    max_history = game_get_speed(gamespeed_fps) * 5;
    rewind_cooldown = 0;
}

ds_list_insert(pos_history_x, 0, x);
ds_list_insert(pos_history_y, 0, y);

if (ds_list_size(pos_history_x) > max_history) {
    ds_list_delete(pos_history_x, ds_list_size(pos_history_x) - 1);
    ds_list_delete(pos_history_y, ds_list_size(pos_history_y) - 1);
}

if (rewind_cooldown > 0) rewind_cooldown -= 1;

if (keyboard_check_pressed(ord("E")) && rewind_cooldown <= 0 && ds_list_size(pos_history_x) >= max_history) {
    var target_x = ds_list_find_value(pos_history_x, max_history - 1);
    var target_y = ds_list_find_value(pos_history_y, max_history - 1);
    x = target_x;
    y = target_y;
    hsp = 0;
    vsp = 0;
    ds_list_clear(pos_history_x);
    ds_list_clear(pos_history_y);
    rewind_cooldown = game_get_speed(gamespeed_fps) * 5;
	prov_e = 0;	
	
    if (prov_e == 0 && rewind_cooldown <= 0) {
        with (inst_1FFC5A07) {
            y -= 500;
        }
        prov_e++;
    } else if (prov_e == 1 && rewind_cooldown <= 0) {
        prov_e = 0;
        with (inst_1FFC5A07) {
            y += 500;
        }
    }
}
if(keyboard_check("Ctrl"))
if (!jump_controll) {
    var key_up = keyboard_check(ord("W"));
    var key_down = keyboard_check(ord("S"));
    var key_left = keyboard_check(ord("A"));
    var key_right = keyboard_check(ord("D"));
    
    if(key_right) hsp = move_speed;
    else if(key_left) hsp = -move_speed;
    else hsp = 0;
    
    if(key_down) vsp = move_speed;
    else if(key_up) vsp = -move_speed;
    else vsp = 0;
    
    var s = 0;
    if (!place_meeting(x + hsp, y, obj_collision)) {
        x += hsp;
    } else {
        while (!place_meeting(x + sign(hsp), y, obj_collision) && s < 10) {
            x += sign(hsp);
            s++;
        }
    }

    s = 0;
    if (!place_meeting(x, y + vsp, obj_collision)) {
        y += vsp;
    } else {
        while (!place_meeting(x, y + sign(vsp), obj_collision) && s < 10) {
            y += sign(vsp);
            s++;
        }
    }

} else {
    var key_left = keyboard_check(ord("A"));
    var key_right = keyboard_check(ord("D"));
    hsp = (key_right - key_left) * move_speed;

    if (keyboard_check_pressed(vk_space) && onground) {
        vsp = jump_strength;
        onground = false;
    }
    
    vsp += grav;
    
    if (!place_meeting(x + hsp, y, obj_collision)) {
        x += hsp;
    } else {
        while (!place_meeting(x + sign(hsp), y, obj_collision)) {
            x += sign(hsp);
        }
    }
    
    if (!place_meeting(x, y + vsp, obj_collision)) {
        y += vsp;
    } else {
        while (!place_meeting(x, y + sign(vsp), obj_collision)) {
            y += sign(vsp);
        }
        if (vsp > 0) {
            onground = true;
            vsp = 0;
        }
    }
    
}