draw_set_alpha(next_alpha);
draw_sprite(peizaz_sprites[next_peizaz], 0, peizaz_x, 0);
draw_sprite(peizaz_sprites[next_peizaz], 0, peizaz_x - screen_width, 0);
draw_set_alpha(current_alpha);
draw_sprite(peizaz_sprites[current_peizaz], 0, peizaz_x, 0);
draw_sprite(peizaz_sprites[current_peizaz], 0, peizaz_x - screen_width, 0);
draw_set_alpha(1);