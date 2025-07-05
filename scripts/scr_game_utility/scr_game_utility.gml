function approach(_val1, _val2, _val3)
{
	if(_val1 < _val2)
	{
	    _val1 += _val3;
	    if(_val1 > _val2) return _val2;
	}
	else
	{
	    _val1 -= _val3;
	    if(_val1 < _val2)  return _val2;
	}
	return _val1;
}

function chance(_val1)
{
	return _val1 > random(1);	
}

function wave(_val1, _val2, _val3, _val4)
{
	var _a4 = (_val2 - _val1) * 0.5;
	return _val1 + _a4 + sin((((current_time * 0.001) + _val3 * _val4) / _val3) * (pi*2)) * _a4;	
}

function wrap(_val1, _val2, _val3)
{
	if(_val1 mod 1 == 0)
	{
	    while(_val1 > _val3 or _val1 < _val2)
	    {
	        if (_val1 > _val3) _val1 += _val2 - _val3 - 1;   
	        else if (_val1 < _val2) _val1 += _val3 - _val2 + 1;
	    }
	    return(_val1);
	}
	else
	{
	    var _vold = _val1 + 1;
	    while(_val1 != _vold)
	    {
	        _vold = _val1;
	        if(_val1 < _val2) _val1 = _val3 - (_val2 - _val1);
	        else if(_val1 > _val3)  _val1 = _val2 + (_val1 - _val3);
	           
	    }
	    return(_val1);
	}	
}

function x_to_gui(_x)
{
	var _offset_x = _x - CAMERA_X;
	var _offset_x_percent = _offset_x / CAMERA_WIDTH;
	var _gui_x = _offset_x_percent * GUI_WIDTH;
	
	return _gui_x;
}

function y_to_gui(_y)
{
	var _offset_y = _y - CAMERA_Y;
	var _offset_y_percent = _offset_y / CAMERA_HEIGHT;
	var _gui_y = _offset_y_percent * GUI_HEIGHT;
	
	return _gui_y;
}