// === ВСПОМОГАТЕЛЬНАЯ ФУНКЦИЯ: толкание ящика ===
function push_box(dx, dy) {
        // Проверяем, свободно ли место ЗА ящиком
    if (!place_meeting(x + dx, y + dy, obj_collision)){
        return true; // Можно толкнуть
    }
	else {
	    return false; // Нельзя толкнуть
	}
}