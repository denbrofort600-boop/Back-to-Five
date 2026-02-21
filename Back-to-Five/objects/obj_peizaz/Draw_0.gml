
var w = 1152;
var h = 1152;
image_index = 0;
draw_sprite(sprite_index, image_index, bg_x0, 0);
image_index += 1;
draw_sprite(sprite_index, image_index, bg_x1, 0);
image_index += 1;
draw_sprite(sprite_index, image_index, bg_x2, 0);
image_index += 1;
draw_sprite(sprite_index, image_index, bg_x3, 0);
image_index += 1;
draw_sprite(sprite_index, image_index, bg_x4, 0);

if (bg_x0 < -1152) {
	bg_x0 += 1152*3;
}
if (bg_x1 < -1152) {
	bg_x1 += 1152*3
}
if (bg_x2 < -1152) {
	bg_x2 += 1152*3
}
if (bg_x3 < -1152) {
	bg_x3 += 1152*3
}
if (bg_x4 < -1152) {
	bg_x4 += 1152*3
}


/*
if(room == room_start){
	image_index = 1;
	draw_sprite(sprite_index, image_index, bg_x - 1152*i, 0);
	image_index += 1;
	i++;
	draw_sprite(sprite_index, image_index, bg_x - 1152*i, 0);
	image_index += 1;
	i++;
	draw_sprite(sprite_index, image_index, bg_x - 1152*i, 0);
}*/