/// @desc Get the PGMLib Box with default parameters
/// @return {Struct}
function box_get_default_box() {
	return {
		x : 0,
		y : 0,
		length : 0,
		width : 0,
		border_width : 0,
		border_sides : { //do we draw this border ?
			up : true,
			down : true,
			left : true,
			right : true
		},
		border_color : [0, 0, 0, 0], //R, G, B, A
		fill_color : [0, 0, 0, 0], //R, G, B, A
		content : {}
	};
};

function box_get_default_text() {
	return {
		text : "",
		color : [0, 0, 0, 255],
		font : PGMLib_default_font,
		size : 12,
		padding : 0
	};
};

function box_get_default_slider() {
	return {
		length : 0,
		position : 0,
		color : [0, 0, 0, 255],
		call : None,
		slider_inst : pointer_null
	}
}

/// @desc create a new box active
/// @arg {Real} box_x the position x where the box will be placed by default (relative to the parent)
/// @arg {Real} box_y the position y where the box will be placed by default (relative to the parent)
/// @arg {Real} box_length lenght of the box
/// @arg {Real} box_width width of the box
/// @arg {Real} box_border_width width of the borders of th box
/// @arg {Array<Bool>} box_border_sides for each side decide if the border is visible (With an array of booleans), (format : [up, down, left, right])
/// @arg {Array<Real>} box_border_color color of the borders (format : [R, G, B, A])
/// @arg {Array<Real>} box_fill_color color of the inside of the box (format : [R, G, B, A])
/// @arg {Struct} box_content content of the box (like other boxes, or any variable)
/// @return {Struct} the newly created box
function box_new(
box_x=0,
box_y=0,
box_length=0,
box_width=0,
box_border_width="auto",
box_border_sides=[false, false, false, false],
box_border_color=[0, 0, 0, 0],
box_fill_color=[0, 0, 0, 0],
box_content={}
)
{
	//copy of default box
	var box = box_get_default_box();
	
	//set box position
	box.x = box_x;
	box.y = box_y;
	
	//set box size
	box.length = box_length;
	box.width = box_width;
	
	//set box border width
	if box_border_width == "auto" {
		box.border_width = box.length/(box.width*1.618+1);
	}
	else {box.border_width = box_border_width};
	
	//set box border sides
	if len(box_border_sides) > 0 {box.border_sides.up = box_border_sides[0]};
	if len(box_border_sides) > 1 {box.border_sides.down = box_border_sides[1]};
	if len(box_border_sides) > 2 {box.border_sides.left = box_border_sides[2]};
	if len(box_border_sides) > 3 {box.border_sides.right = box_border_sides[3]};
	
	//set box border color
	if len(box_border_color) >= 4 {
		box.border_color = [box_border_color[0], box_border_color[1], box_border_color[2], box_border_color[3]];
		if len(box_border_color) > 4 {show_error("box_border_color should contain 4 elements maximum", false)};
	}
	else if len(box_border_color) = 3 {
		box.border_color = [box_border_color[0], box_border_color[1], box_border_color[2], 1];
	}
	else {show_error("box_border_color must contain at least 3 elements: red, green, blue", true)};
	
	//set box fill color
	if len(box_fill_color) >= 4 {
		box.fill_color = [box_fill_color[0], box_fill_color[1], box_fill_color[2], box_fill_color[3]];
		if len(box_fill_color) > 4 {show_error("box_fill_color should contain 4 elements maximum", false)};
	}
	else if len(box_fill_color) = 3 {
		box.fill_color = [box_fill_color[0], box_fill_color[1], box_fill_color[2], 1];
	}
	else {show_error("box_fill_color must contain at least 3 elements: red, green, blue", true)};
	
	//set box content
	box.content = box_content;
	
	//return the newly created box
	return box
	
	
};

/// @desc creates a new text
/// @arg {String} text displayed text
/// @arg {Array<Real>} text_color color of the text
/// @arg {Ressource} text_font font for the text
/// @arg {Real} size scale of the text, the size of the ressource is taken in account
/// @arg {Real} padding distance between the text and the parent box
function box_new_text(
	text="",
	text_color=[0, 0, 0, 255],
	text_font=PGMLib_default_font,
	text_size=12,
	text_padding=0
)
{
	box = box_get_default_text()
	box.text = text;
	box.color = text_color;
	box.font = text_font;
	box.size = text_size;
	box.padding = text_padding;
	
	return box
}

/// @desc creates a new slider
/// @arg {Real} slider_length length of the slider
/// @arg {Real} slider_position position of the cursor within the slider
/// @arg {Array<Real>} slider_color color of the slider
/// @arg {Ref}slider_call method called each frame wich's arg is the slider position
/// @arg {Real} offset_x offset of the slider on the x axis
/// @arg {Real} offset_y offset of the slider on the y axis
function box_new_slider(
	slider_length=0,
	slider_position=0,
	slider_color=[0, 0, 0, 255],
	slider_call=None,
)
{
	slider = box_get_default_slider()
	slider.length = slider_length
	slider.position = slider_position
	slider.color=slider_color
	slider.call=slider_call
	
	slider.slider_inst = instance_create_layer(
		0,
		0,
		layer,
		PGMLib_object,
		{role:"obj_slider", box: slider})
		
	return slider
}

/// @desc check if an object is a PGMLib Box (consumes a lot of ressources, 18 conditions at max)
/// @arg {Any} variable The object to check
/// @return {Bool}
function is_box(variable) {
	var var_names = ["x", "y", "border_sides","border_color","fill_color","content","length","width","border_width" ];
	if typeof(variable) != "struct" {
		//print("PGMLib.is_box : variable is not a struct");
		return false
	}
	else if variable_struct_get_names(variable) != var_names {
		for (var _i=0; _i<9; _i++) {
			if not array_contains(variable_struct_get_names(variable), var_names[_i]) {
				//print("PGMLib.is_box : \"" + var_names[_i] + "\" doesn't exists in variable");
				return false
			};
		};
	}
	else if typeof(variable_struct_get(variable, "x")) != "number" {
		//print("PGMLib.is_box : \"x\" must be of type \"number\" but is \"" + typeof(variable.x) + "\"");
		return false
	}
	else if typeof(variable_struct_get(variable, "y")) != "number" {
		//print("PGMLib.is_box : \"y\" must be of type \"number\" but is \"" + typeof(variable.y) + "\"");
		return false
	}
	else if typeof(variable_struct_get(variable, "length")) != "number" {
		//print("PGMLib.is_box : \"length\" must be of type \"number\" but is \"" + typeof(variable.length) + "\"");
		return false
	}
	else if typeof(variable_struct_get(variable, "width")) != "number" {
		//print("PGMLib.is_box : \"width\" must be of type \"number\" but is \"" + typeof(variable.width) + "\"");
		return false
	}
	else if typeof(variable_struct_get(variable, "border_width")) != "number" {
		//print("PGMLib.is_box : \"border_width\" must be of type \"number\" but is \"" + typeof(variable.border_width) + "\"");
		return false
	}
	else if array_contains(["array", "struct"], typeof(variable.border_sides)) {
		var border_sides_error = ("PGMLib.is_box : \"border_sides\" must be on model {up: bool, down: bool, left: bool, right: bool} or [bool, bool, bool, bool] but is " + string(variable.border_sides));
		if typeof(variable.border_sides) == "array" {
			for (var _i=0; _i<4; _i++) {
				if typeof(variable.border_sides[_i]) != "bool" {
					print(border_sides_error);
					return false
				};
			};
		}
		else if variable_struct_get_names(variable.border_sides) == ["up", "down", "left", "right"] {
			if typeof(variable.border_sides.up) != "bool" {
				print(border_sides_error);
				return false
			}
			else if typeof(variable.border_sides.down) != "bool" {
				print(border_sides_error);
				return false
			}
			else if typeof(variable.border_sides.left) != "bool" {
				print(border_sides_error);
				return false
			}
			else if typeof(variable.border_sides.right) != "bool" {
				print(border_sides_error);
				return false
			};
		}
		else {
			print(border_sides_error);
			return false
		}
	}
	else if color_format(variable.border_color) == "NaC" {
		//print("PGMLib.is_box : \"border_color\" must be a color but is \"" + typeof(variable.border_color) + "\"");
		return false
	}
	else if color_format(variable.fill_color) == "NaC" {
		//print("PGMLib.is_box : \"fill_color\" must be a color but is \"" + typeof(variable.fill_color) + "\"");
		return false
	}
	else if typeof(variable.content) != "struct" {
		//print("PGMLib.is_box : \"content\" must be of type \"struct\" but is \"" + typeof(variable.content) + "\"");
		return false
	};
	return true
};

/// @desc checks if given object is a text for a PGMLib box
/// @arg {Struct} text Text to check
/// @return {Bool} true if the argument is a valid text for PGMLib box, else false
function box_is_text(variable) {
	var var_names = ["text", "color", "font", "size", "padding"];
	if typeof(variable) != "struct" {
		//print("PGMLib.box_is_text : variable is not a struct");
		return false
	}
	else if variable_struct_get_names(variable) != var_names {
		for (var _i=0; _i<5; _i++) {
			if not array_contains(variable_struct_get_names(variable), var_names[_i]) {
				//print("PGMLib.box_is_text : \"" + var_names[_i] + "\" doesn't exists in variable");
				return false
			};
		};
	}
	else if typeof(variable.text) != "string" {
		//print("PGMLib.box_is_text : \"text\" must be of type \"string\" but is \"" + typeof(variable.text) + "\"");
		return false
		}
	else if color_format(variable.color) == "NaC" {
		//print("PGMLib.box_is_text : \"color\" must be a color but is \"" + typeof(variable.color) + "\"");
		return false
	}
	else if typeof(variable.font) != "string" {
		//print("PGMLib.box_is_text : \"font\" must be of type \"string\" but is \"" + typeof(variable.font) + "\"");
		return false
	}
	else if typeof(variable.size) != "number" {
		//print("PGMLib.box_is_text : \"size\" must be of type \"number\" but is \"" + typeof(variable.size) + "\"");
		return false
	}
	else if typeof(variable.padding) != "number" {
		//print("PGMLib.box_is_text : \"padding\" must be of type \"number\" but is \"" + typeof(variable.padding) + "\"");
		return false
	};
	return true
};

/// @desc checks if given object is a slider for a PGMLib box
/// @arg {Struct} variable object to check
/// @return {Bool} true if the argument is a valid slider for PGMLib box, else false
function box_is_slider(variable) {
	var var_names = ["length", "position", "color", "call", "slider_inst"];
	if typeof(variable) != "struct" {
		//print("PGMLib.is_box : variable is not a struct");
		return false
	}
	else if variable_struct_get_names(variable) != var_names {
		for (var _i=0; _i<5; _i++) {
			if not array_contains(variable_struct_get_names(variable), var_names[_i]) {
				//print("PGMLib.is_box : \"" + var_names[_i] + "\" doesn't exists in variable");
				return false
			};
		};
	}
	else if typeof(variable.length) != "number" {
		return false
	}
	else if typeof(variable.position) != "number" {
		return false
	}
	else if color_format(variable.color) == "NaC" {
		return false
	}
	else if typeof(variable.call) != "ref" {
		return false
	}
	else if typeof(variable.slider_inst) != "ref" {
		return false
	}
	return true
}

/// @desc add something to a box content (like other boxes, or any variable)
/// @arg {Struct} box The box to add an element to
/// @arg {String} variable_name The name of the variable to put the value in (and so, the one to use to get it later)
/// @arg {Any} value The value to put in this new variable (by default the Real 0)
/// @return {Struct}
function box_content_add(box, variable_name, value=0) {
	if is_box(box) {
		var c = variable_struct_get(box, "content");
		if variable_struct_exists(c, variable_name) {show_error(variable_name + " already exists in this box, can't create it", false)}
		else {
			variable_struct_set(c, variable_name, value)
		};
		box.content = c;
		return box
	}
	else {show_error("box must be a PGMLib Box", true)}
};

/// @desc remove something from a box content
/// @arg {Struct} box The box to remove an element from
/// @arg {String} variable_name The name of the variable to remove
function box_content_remove(box, variable_name) {
	var c = variable_struct_get(box, "content");
	if variable_struct_exists(c, variable_name) {
		struct_remove(c, variable_name)
	};
	box.content = c;
	return box
};

/// @desc returns the data type of any color variable
/// @arg {Any} color The variable to get the data type of
/// @return {String}
function color_format(color) {
	var hex_digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"];
	if (typeof(color) == "number") and (color == int64(color)) and (color >= 0 and color <= 4294967295) {
		return "gm_color"
	}
	else if typeof(color) == "array" {
		for (var _i=0; _i < len(color); _i++) {
			if not ((typeof(color[_i]) == "number") and (color[_i] == int64(color[_i])) and (color[_i] >= 0 and color[_i] <= 255)) {
				return "NaC"
			}
		}
		if len(color) == 4 {return "rgba_rray"}
		else if len(color) == 3 {return "rgb_array"}
		else {return "NaC"}
	}
	else if typeof(color) == "string" {
		color = string_lower(color);
		var _arr = string_explode(color);
		if not (len(_arr) == 9 or len(_arr) == 7) {return "NaC"};
		if _arr[0] == "#" {array_delete(_arr, 0, 1)};
		for (var _i=0; _i < len(_arr); _i++) {
			if not (array_contains(hex_digits, _arr[_i])) {
				return "NaC"
			}
		}
		if len(_arr) == 6 {return "rgb"}
		else {return "rgba"}
	}
	return "NaC"
};


function convert_gm_color(color) {
	if color_format(color) == "gm_color" {return color}
	else if color_format(color) == "rgb_array" or color_format(color) == "rgba_rray" {
		var red = color[0];
		var green = color[1];
		var blue = color[2];
		if color_format == "rgba_rray" {
			var alpha = color[3]
		}
		else {alpha = 255};
		return (red + 256*blue + 65536*green + 16777216*alpha)
	}
	else if color_format(color) == "rgb" {
		var c = string_explode(color);
		if string_char_at(color, 0) == "#" {
			array_delete(c, 0, 1)
		}
		var f = ["00"];
		for (var _i=5; _i>0; _i-=2) {
			f = array_concat(f, [array_join([c[_i-1], c[_i]], "")])
		}
		return hex_to_dec(array_join(f))
	}
	else if color_format(color) == "rgba" {
		var c = string_explode(color);
		if string_char_at(color, 0) == "#" {
			array_delete(c, 0, 1)
		};
		var f = [];
		for (var _i=7; _i>0; _i-=2) {
			f = array_concat(f, [array_join([c[_i-1], c[_i]], "")])
		};
		return hex_to_dec(array_join(f))
	}
	else if color_format(color) == "NaC" {show_error("convert_gm_color() expected a color as argument", true)}
};




function draw_box(box, offset_x=0, offset_y=0) {
	if not is_box(box) {show_error("draw_box expected a PGMLib Box as argument", true)};
	var col = convert_gm_color(box.fill_color);
	draw_rectangle_color(
		offset_x+box.x,
		offset_y+box.y,
		offset_x+box.x+box.length,
		offset_y+box.y+box.width,
		col, col, col, col,
		false);
	col = convert_gm_color(box.border_color);
	
	if box.border_sides.up {
		draw_line_width_colour(
		offset_x+box.x-(box.border_sides.left*(box.border_width div 2)),
		offset_y+box.y,
		offset_x+box.x+box.length+(box.border_sides.right*(box.border_width div 2)),
		offset_y+box.y,
		box.border_width,
		col, col)
	};
	if box.border_sides.down {
		draw_line_width_colour(
		offset_x+box.x-(box.border_sides.left*(box.border_width div 2)),
		offset_y+box.y+box.width,
		offset_x+box.x+box.length+(box.border_sides.right*(box.border_width div 2)),
		offset_y+box.y+box.width,
		box.border_width,
		col, col)
	};
	if box.border_sides.left {
		draw_line_width_colour(
		offset_x+box.x,
		offset_y+box.y,
		offset_x+box.x,
		offset_y+box.y+box.width,
		box.border_width,
		col, col)
	};
	if box.border_sides.right {
		draw_line_width_colour(
		offset_x+box.x+box.length,
		offset_y+box.y,
		offset_x+box.x+box.length,
		offset_y+box.y+box.width,
		box.border_width,
		col, col)
	}
	
	var names = variable_struct_get_names(box.content)
	for (var i=0; i < len(names); i++) {
		name = names[i]
		sub_box = variable_struct_get(box.content, name)
		if is_box(sub_box) {
			draw_box(sub_box, offset_x+box.x, offset_y+box.y)
		}
		else if box_is_text(sub_box) or typeof(sub_box) == "string" {
			box_draw_text(sub_box, offset_x+box.x, offset_y+box.y, box.length)
		}
		else if box_is_slider(sub_box) {
			box_draw_slider(sub_box, offset_x+box.x, offset_y+box.y)
		}
	}
}

/// @desc draws given text
/// @arg text text to draw, must be a PGMLib Boxes compatible text or a string
function box_draw_text(text, offset_x, offset_y, parent_length) {
	if box_is_text(text) {
			var col = convert_gm_color(text.color);
		if col < 16777216 {alpha = 1}
		else {alpha = $ff000000 & col}
		
		draw_text_ext_transformed_colour(
		offset_x + text.padding,
		offset_y + text.padding,
		text.text,
		10,
		parent_length - text.padding*2,
		text.size/12,
		text.size/12,
		0, col, col, col, col, alpha)
	}
	else if typeof(text) == "string" {
		draw_text_ext_transformed_colour(
		offset_x,
		offset_y,
		text,
		10,
		parent_lenght,
		1,
		1,
		0, 0, 0, 0, 0, 1)
	}
	else {
		show_error("text must be a PGMLib Boxes compatible text or a string", true)
	}
}

function box_draw_slider(slider, offset_x=0, offset_y=0) {
	if not box_is_slider(slider) {show_error("slider must be a PGMLib slider struct", true)}
	else {
		if not slider.slider_inst.slider_setup {
			slider.slider_inst.x = offset_x+slider.position;
			slider.slider_inst.y = offset_y;
			slider.slider_inst.sx = offset_x;
			slider.slider_inst.slider_setup = true
		};
		
		draw_line_width_colour(
		offset_x,
		offset_y,
		offset_x+slider.length,
		offset_y,
		5,
		convert_gm_color(slider.color)-50,
		convert_gm_color(slider.color)-50
		);
	
		draw_circle_colour(
		offset_x+slider.position,
		offset_y,
		10,
		convert_gm_color(slider.color),
		convert_gm_color(slider.color),
		false
		)
	}
}