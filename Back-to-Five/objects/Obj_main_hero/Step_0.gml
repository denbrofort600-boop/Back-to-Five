// Инициализация истории позиций, если она ещё не создана
if (pos_history_x == undefined) {
    pos_history_x = ds_list_create();
    pos_history_y = ds_list_create();
    max_history = game_get_speed(gamespeed_fps) * 5;
    rewind_cooldown = 0;
}

// Добавляем текущие координаты объекта в начало списков истории
ds_list_insert(pos_history_x, 0, x);
ds_list_insert(pos_history_y, 0, y);

// Если размер истории превышает лимит, удаляем самую старую запись
if (ds_list_size(pos_history_x) > max_history) {
    ds_list_delete(pos_history_x, ds_list_size(pos_history_x) - 1);
    ds_list_delete(pos_history_y, ds_list_size(pos_history_y) - 1);
}

// Уменьшаем таймер перезарядки отката на 1 кадр, если он активен
if (rewind_cooldown > 0) rewind_cooldown -= 1;

// Обработка функции «отката» позиции (при нажатии E)
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
}

// Специальный режим при prov_e == 1
if (keyboard_check_pressed(ord("E")) && prov_e == 1){
    with (inst_1FFC5A07) {
        y += 1000;
    }
    prov_e = 0;
}

move_speed = 4;

// Ускорение при зажатом Ctrl (максимум до 20)
if (keyboard_check(vk_control)) {
    move_speed = min(move_speed + 4, 20);
}

// === ВСПОМОГАТЕЛЬНАЯ ФУНКЦИЯ: толкание ящика ===
function push_box(dx, dy) {
    var box = instance_place(x + dx, y + dy, obj_move_collision);
	show_debug_message(box)
    if (box != noone) {
        // Проверяем, свободно ли место ЗА ящиком
        if (!place_meeting(box.x + dx, box.y + dy, obj_collision)){
            return true; // Можно толкнуть
        }
    }
    return false; // Нельзя толкнуть
}

// Режим без прыжков (jump_controll = false)
if (!jump_controll) {
    var key_up = keyboard_check(ord("W"));
    var key_down = keyboard_check(ord("S"));
    var key_left = keyboard_check(ord("A"));
    var key_right = keyboard_check(ord("D"));
    
    // Устанавливаем горизонтальную скорость
    if(key_right) hsp = move_speed;
    else if(key_left) hsp = -move_speed;
    else hsp = 0;
    
    // Устанавливаем вертикальную скорость
    if(key_down) vsp = move_speed;
    else if(key_up) vsp = -move_speed;
    else vsp = 0;
    
    var s = 0;
    // Движение по горизонтали с проверкой столкновений и толканием ящика
    if (!place_meeting(x + hsp, y, obj_collision)) {
        x += hsp;
    } else {
        // Пробуем толкнуть ящик
        if (hsp != 0 && push_box(hsp, 0)) {
            var box = instance_place(x + hsp, y, obj_move_collision);
            box.x += hsp; // Двигаем ящик
            x += hsp;     // Двигаем игрока
        } else {
            // Попиксельное движение до столкновения
            while (!place_meeting(x + sign(hsp), y, obj_collision) && s < 10) {
                x += sign(hsp);
                s++;
            }
        }
    }

    s = 0;
    // Движение по вертикали с проверкой столкновений и толканием ящика
    if (!place_meeting(x, y + vsp, obj_collision)) {
        y += vsp;
    } else {
        // Пробуем толкнуть ящик
        if (vsp != 0 && push_box(0, vsp)) {
            var box = instance_place(x, y + vsp, obj_move_collision);
            box.y += vsp; // Двигаем ящик
            y += vsp;     // Двигаем игрока
        } else {
            // Попиксельное движение до столкновения
            while (!place_meeting(x, y + sign(vsp), obj_collision) && s < 10) {
                y += sign(vsp);
                s++;
            }
        }
    }

// Режим с прыжками (jump_controll = true)
} else {
    var key_left = keyboard_check(ord("A"));
    var key_right = keyboard_check(ord("D"));
    hsp = (key_right - key_left) * move_speed;
    hsp_slow = hsp * 0.3;
    vsp_slow = vsp * 0.3;

    // Прыжок при нажатии пробела и на земле
    if (keyboard_check_pressed(vk_space) && onground) {
        vsp = jump_strength;
        onground = false;
    }
    
    vsp += grav;
    if (push_box(hsp, 0)) {
            var box = instance_place(x + hsp, y, obj_move_collision);
            box.x += hsp;
        }
    // Движение по горизонтали с толканием ящика
    if (!place_meeting(x + hsp, y, obj_collision) and !place_meeting(x + hsp, y, obj_move_collision)) {
        x += hsp;
    } else {

        while (!place_meeting(x + sign(hsp), y, obj_collision) and !place_meeting(x + sign(hsp), y, obj_move_collision)) {
            x += sign(hsp);
        }
    }
    // Движение по вертикали с толканием ящика
    if (!place_meeting(x, y + vsp, obj_collision) and !place_meeting(x, y + vsp, obj_move_collision)) {
        y += vsp;
    } else
	{
        while (!place_meeting(x, y + sign(vsp), obj_collision) and !place_meeting(x, y + sign(vsp), obj_move_collision)) {
            y += sign(vsp);
        }
        if (vsp > 0) {
            onground = true;
            vsp = 0;
        }
    }
    
    // Движение в зонах замедления (obj_unspeed) по горизонтали
    if (place_meeting(x + hsp_slow, y, obj_unspeed)) {
        x += hsp_slow;
    } else {
        while (place_meeting(x + sign(hsp_slow), y, obj_unspeed)) {
            x += sign(hsp_slow);
        }
    }

    // Движение в зонах замедления (obj_unspeed) по вертикали
    if (place_meeting(x, y + vsp_slow, obj_unspeed)) {
        y += vsp_slow;
        if (vsp_slow > 0) {
            onground = true;
            vsp = 0; 
        }
    } else {
        while (place_meeting(x, y + sign(vsp_slow), obj_unspeed)) {
            y += sign(vsp_slow);
        }
    }
}