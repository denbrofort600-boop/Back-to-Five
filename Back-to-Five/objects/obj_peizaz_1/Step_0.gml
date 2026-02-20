if (!is_transitioning) {
    peizaz_x += peizaz_speed;
    if (peizaz_x >= screen_width) {
        peizaz_x = 0;
    }
    switch_timer -= 1;
    if (switch_timer <= 0) {
        is_transitioning = true;
    }
} else {
    current_alpha -= transition_speed;
    next_alpha += transition_speed;
    current_alpha = max(0, min(1, current_alpha));
    next_alpha = max(0, min(1, next_alpha));
    if (next_alpha >= 1) {
        current_peizaz = next_peizaz;
        next_peizaz = (current_peizaz + 1) % 2;
        current_alpha = 1;
        next_alpha = 0;
        is_transitioning = false;
        switch_timer = 600;
        peizaz_x = 0;
    }
}