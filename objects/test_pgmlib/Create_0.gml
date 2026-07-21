// exemple use of PGMLib Boxes
settings = box_new(20, 20, 1330, 720, 3, [true, true, true, true], [255, 255, 255, 255], [0, 0, 0, 255], {
	gain_text: box_new_text("Master volume", #ffffff, PGMLib_default_font, 12, 20),
	gain_slider_box: box_new(20, 60, 300, 20, 0, [false, false, false, false], [0, 0, 0, 0], [0, 0, 0, 0], {
		gain_slider: box_new_slider(300, 150, c_red, print)
	})
})
