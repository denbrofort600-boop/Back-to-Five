// Инициализация истории позиций, если она ещё не создана
if (pos_history_x == undefined) {
    pos_history_x = ds_list_create();  // Создаём список для хранения истории координат X
    pos_history_y = ds_list_create();  // Создаём список для хранения истории координат Y
    max_history = game_get_speed(gamespeed_fps) * 5;  // Устанавливаем максимальный размер истории: 5 секунд при текущей частоте кадров
    rewind_cooldown = 0;  // Сбрасываем таймер перезарядки функции отката
}

// Добавляем текущие координаты объекта в начало списков истории
ds_list_insert(pos_history_x, 0, x);
ds_list_insert(pos_history_y, 0, y);

// Если размер истории превышает лимит, удаляем самую старую запись (последнюю в списке)
if (ds_list_size(pos_history_x) > max_history) {
    ds_list_delete(pos_history_x, ds_list_size(pos_history_x) - 1);
    ds_list_delete(pos_history_y, ds_list_size(pos_history_y) - 1);
}

// Уменьшаем таймер перезарядки отката на 1 кадр, если он активен
if (rewind_cooldown > 0) rewind_cooldown -= 1;

// Обработка функции «отката» позиции (при нажатии E)
if (keyboard_check_pressed(ord("E")) && rewind_cooldown <= 0 && ds_list_size(pos_history_x) >= max_history) {
    var target_x = ds_list_find_value(pos_history_x, max_history - 1);  // Получаем координату X из истории (самую старую запись)
    var target_y = ds_list_find_value(pos_history_y, max_history - 1);  // Получаем координату Y из истории
    x = target_x;  // Перемещаем объект на старую позицию
    y = target_y;
    hsp = 0;  // Обнуляем горизонтальную скорость
    vsp = 0;  // Обнуляем вертикальную скорость
    ds_list_clear(pos_history_x);  // Очищаем историю координат X
    ds_list_clear(pos_history_y);  // Очищаем историю координат Y
    rewind_cooldown = game_get_speed(gamespeed_fps) * 5;  // Устанавливаем перезарядку на 5 секунд
}

// Специальный режим при prov_e == 1 (возможно, отладка или особый режим)
if (keyboard_check_pressed(ord("E")) && prov_e == 1){
    with (inst_1FFC5A07) {  // Применяем действие к объекту с указанным ID
        y += 1000;  // Смещаем объект вниз на 1000 пикселей
    }
    prov_e = 0;  // Отключаем флаг специального режима
}

move_speed = 4;  // Базовая скорость движения

// Ускорение при зажатом Ctrl (максимум до 20)
if (keyboard_check(vk_control)) {
    move_speed = min(move_speed + 4, 20);
}

// Режим без прыжков (jump_controll = false)
if (!jump_controll) {
    var key_up = keyboard_check(ord("W"));    // Проверка нажатия W
    var key_down = keyboard_check(ord("S"));  // Проверка нажатия S
    var key_left = keyboard_check(ord("A"));  // Проверка нажатия A
    var key_right = keyboard_check(ord("D")); // Проверка нажатия D
    
    // Устанавливаем горизонтальную скорость в зависимости от нажатых клавиш
    if(key_right) hsp = move_speed;
    else if(key_left) hsp = -move_speed;
    else hsp = 0;
    
    // Устанавливаем вертикальную скорость в зависимости от нажатых клавиш
    if(key_down) vsp = move_speed;
    else if(key_up) vsp = -move_speed;
    else vsp = 0;
    
    var s = 0;
    // Движение по горизонтали с проверкой столкновений
    if (!place_meeting(x + hsp, y, obj_collision)) {
        x += hsp;  // Если нет столкновения — двигаемся
    } else {
        // Если есть столкновение — пытаемся сдвинуться попиксельно (до 10 попыток)
        while (!place_meeting(x + sign(hsp), y, obj_collision) && s < 10) {
            x += sign(hsp);
            s++;
        }
    }

    s = 0;
    // Движение по вертикали с проверкой столкновений
    if (!place_meeting(x, y + vsp, obj_collision)) {
        y += vsp;  // Если нет столкновения — двигаемся
    } else {
        // Если есть столкновение — пытаемся сдвинуться попиксельно (до 10 попыток)
        while (!place_meeting(x, y + sign(vsp), obj_collision) && s < 10) {
            y += sign(vsp);
            s++;
        }
    }
} else {  // Режим с прыжками (jump_controll = true)
    var key_left = keyboard_check(ord("A"));
    var key_right = keyboard_check(ord("D"));
    hsp = (key_right - key_left) * move_speed;  // Расчёт горизонтальной скорости (1, 0 или -1)
    hsp_slow = hsp * 0.3;  // Замедленная горизонтальная скорость для особых зон
    vsp_slow = vsp * 0.3;  // Замедленная вертикальная скорость для особых зон

    // Прыжок при нажатии пробела и на земле
    if (keyboard_check_pressed(vk_space) && onground) {
        vsp = jump_strength;  // Придаём вертикальную скорость для прыжка
        onground = false;  // Объект больше не на земле
    }
    
    vsp += grav;  // Учитываем гравитацию (увеличиваем вертикальную скорость вниз)
    
    // Движение по горизонтали с проверкой столкновений
    if (!place_meeting(x + hsp, y, obj_collision)) {
        x += hsp;
    } else {
        while (!place_meeting(x + sign(hsp), y, obj_collision)) {
            x += sign(hsp);
        }
    }
    
    // Движение по вертикали с проверкой столкновений и определением приземления
    if (!place_meeting(x, y + vsp, obj_collision)) {
        y += vsp;
    } else {
        while (!place_meeting(x, y + sign(vsp), obj_collision)) {
            y += sign(vsp);
        }
        if (vsp > 0) {  // Если падали вниз и столкнулись — значит, приземлились
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
        if (vsp_slow > 0) {  // Если двигались вниз и в зоне замедления — считаем, что на земле
            onground = true;
            vsp = 0; 
        }
    } else {
        while (place_meeting(x, y + sign(vsp_slow), obj_unspeed)) {
            y += sign(vsp_slow);
        }
    }
}
