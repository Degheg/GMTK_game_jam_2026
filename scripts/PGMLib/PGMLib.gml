PGMLib_version = "0.3.0"
Credits = "C Degheg, struct_copy inspired by 31Nf4ChZ4H73N"

/// @desc If you want to do nothing, call this function
function None() {};


/// @desc	Returns the given array with two values exchanged
/// @arg	{Real}	      index_1               The index of the first value
/// @arg	{Real}	      index_2               The index of the second value
/// @arg	{Array}	      string                The array to exchange values in
/// @return {Array}
function array_exchange_values(_index1, _index2, _arr) {
	_a = _arr[_index1];
	_arr[_index1] = _arr[_index2];
	_arr[_index2] = _a;
	return _arr
};


/// @desc	Creates a custom debug message shown in the compiler window at the runtime (and returns the message as a string)
/// @arg	{Any}	string_or_format	The message
/// @return {String}
function print(string_or_format) {
	show_debug_message(string_or_format);
	return string(string_or_format)
	};


/// @desc	Get the number of elements in an array, string or struct
/// @arg	{Any}	value	The thing to check
/// @return {Real}
function len(_arr) {
	if typeof(_arr) == "array" {return array_length(_arr)}
	else if typeof(_arr) == "string" {return string_length(_arr)}
	else if typeof(_arr) == "struct" {return array_length(variable_struct_get_names(_arr))}
	else {show_error("len() argument must be an Array, String or Struct but is a" + typeof(_arr), true)}
}


/// @desc Get the index of a value in an array. For the occurence parameter, use one of theses OCCURENCE.FIRST, OCCURENCE.LAST, OCCURENCE.ALL to get an array with all occurences, OCCURENCE.NUBER to get the number of occurences
/// @arg  {array}	array	the array to search in
/// @arg  {Any}		value	the value to search for
/// @arg  {Real}	occurence	Optional ; the occurence to search for in case the value appears more than one time.
/// @return {Any}
function get_index(array, value, occurence=OCCURENCE.FIRST) {
	enum OCCURENCE
	{
	FIRST,
	LAST,
	ALL,
	COUNT
	};
	indexes = []
	for (var i=0; i < len(array); i++) {
		if value == array[i] {
			array_push(indexes, i)
		};
	};
	switch(occurence) {
		case OCCURENCE.FIRST:
			if len(indexes) > 0 {
				return indexes[0]
			}
			else {return None()}
		case OCCURENCE.LAST:
			if len(indexes) > 0 {
				return indexes[len(indexes)-1]
			}
			else {return None()}
		case OCCURENCE.ALL:
			return indexes
		case OCCURENCE.COUNT:
			return len(indexes)
	}
};


/// @desc Convert decimal value to hexadecimal
/// @arg {Real} value the decimal value
/// @return {String}
function hexadecimal(n) {
	digits_hex = ["0", "1", "2", "3" ,"4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
	if n == 0 {
		return "0"
	};
	result = ""
	while n > 0 {
		reste = n mod 16
		result = digits_hex[reste] + result
		n = n div 16
	}
  return result
};


/// @desc Extract a value from a multi-dimentional array
/// @arg {Array} array The array to search in
/// @arg {Array} path Path of the value
/// @return {Any}
function array_extract(_arr, key) {
	extract = _arr
	if len(key) > 0 {
		n = 0
		while n < len(key) {
			next = key[n];
			if len(extract) > next {
				extract = extract[next];
			}
			else {show_error(("key index [" + string(key[n]) + "] out of range [" + string(len(extract)) + "]"), true)}
			n++;
		}
		return extract
	}
	else {return extract}
};


/// @desc Extract a value from a multi-dimentional struct
/// @arg {Struct} struct The struct to search in
/// @arg {Array} path Path of the value
/// @return {Any}
function struct_extract(_struct, key) {
	extract = _struct
	if len(key) > 0 {
		n = 0
		while n < len(key) {
			next = key[n];
			if variable_struct_exists(extract, next) {
				extract = variable_struct_get(extract, next);
			}
			else {show_error(string(next) + " does not exists in " + string(len(extract)), true)}
			n++;
		}
		return extract
	}
	else {return extract}
};

/// @desc Detect if mouse cursor touches the collision mask of an instance
/// @arg {Id.Instance} inst the instance to detect for
/// @return {Boolean}
function mouse_on(_inst) {
	if collision_point(mouse_x, mouse_y, _inst, true, false) == _inst {
		return true
	}
	else {return false}
}


/// @desc Create an array with every character from a string separated
/// @arg {String} string The string to explode
/// @return {Array<String>}
function string_explode(_str) {
	var _arr = []
	if typeof(_str) != "string" {show_error("argument must be a value of type string", true)}
	for (var _i=1; _i<=string_length(_str); _i++) {
		_arr = array_concat(_arr, [string_char_at(_str, _i)])
	}
	return _arr
}


/// @desc   Returns a real converted from an hexadecimal string (only natural numbers)
/// @arg  {String}    hex         hexadecimal digits
/// @return {real}      positive integer
/// GMLscripts.com/license
 
function hex_to_dec(hex) 
{
    var final = 0;
    var digits = "0123456789abcdef";
	hex = string_lower(hex)
    for (var pos=1; pos <= string_length(hex); pos++) {
        final = final << 4 | (string_pos(string_char_at(hex, pos), digits) - 1);
    }
 
    return final;
}

/// @desc Regroup array elements into a string (every value will be converted to string)
/// @arg {Array} array The array to join
/// @arg {String} delimiter Something to put between every array value, for example spaces in an array of words
function array_join(array, delimiter="") {
	return method_call(string_join, array_concat([delimiter], array))
}

/// @desc Recursively copies the content of a struct and returns the copy
/// @arg {struct}	struct	The struct to copy
/// @return {struct} copy of the given struct
/// Inspired by 31Nf4ChZ4H73N's copyStruct
function struct_copy(struct){
    var key, value;
    var newCopy = {};
    var keys = variable_struct_get_names(struct);
    for (var i = array_length(keys)-1; i >= 0; --i) {
            key = keys[i];
            value = struct[$ key];
            variable_struct_get(struct, key);
			if typeof(variable_struct_get(struct, key)) == "struct" {variable_struct_set(newCopy, key, struct_copy(value))}
            else {variable_struct_set(newCopy, key, value)}
    }
    return newCopy;
}