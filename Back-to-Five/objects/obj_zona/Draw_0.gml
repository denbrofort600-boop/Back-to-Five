draw_self();
if (mouse_check_button_pressed(mb_left)) {
    if (position_meeting(169, 538, inst_da)) {
		with (inst_da) {
	        visible = 1;
		}
		with (inst_no) {
	        visible = 0;
		}
    }else if (position_meeting(910, 544, inst_no)) {
		with (inst_da) {
	        visible = 0;
		}
		with (inst_no) {
	        visible = 1;
		}
    }
}