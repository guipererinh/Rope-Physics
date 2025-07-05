#macro GRAVITY 0.5

function Rope(_ax, _ay, _segments, _seg_len, _iterations, _max_vel)
{
    var rope = 
	{
        anchor_x  : _ax,
        anchor_y  : _ay,
        segments  : _segments,
        seg_len   : _seg_len,
        iterations: _iterations,
        max_vel   : is_undefined(_max_vel) ? 20 : _max_vel,
        node_ct   : _segments + 1,

        x  : array_create(_segments + 1, 0),
        y  : array_create(_segments + 1, 0),
        px : array_create(_segments + 1, 0),
        py : array_create(_segments + 1, 0),

        init : function () 
		{
            for (var _i = 0; _i < node_ct; ++_i) 
			{
                x[_i]  = anchor_x;
                y[_i]  = anchor_y + _i * seg_len;
                px[_i] = x[_i];
                py[_i] = y[_i];
            }
        },

        step : function () 
		{
            for (var _i = 1; _i < node_ct; ++_i) 
			{
                var _vx = x[_i] - px[_i];
                var _vy = y[_i] - py[_i];

                px[_i] = x[_i];
                py[_i] = y[_i];

                x[_i] += _vx;
                y[_i] += _vy + GRAVITY;

                _vx = x[_i] - px[_i];
                _vy = y[_i] - py[_i];
				
                var _vlen = sqrt(_vx * _vx + _vy * _vy);
                if (_vlen > max_vel) 
				{
                    var _f = max_vel / _vlen;
                    x[_i] = px[_i] + _vx * _f;
                    y[_i] = py[_i] + _vy * _f;
                }
            }

            for (var _it = 0; _it < iterations; ++_it) 
			{
                x[0] = anchor_x;
                y[0] = anchor_y;

                for (var _n = 0; _n < segments; ++_n) 
				{
                    var _dx   = x[_n + 1] - x[_n];
                    var _dy   = y[_n + 1] - y[_n];
                    var _dist = sqrt(_dx * _dx + _dy * _dy);
                    if (_dist == 0) _dist = 16;

                    var _diff = (seg_len - _dist) / _dist;
                    var _ox   = _dx * _diff;
                    var _oy   = _dy * _diff;

                    var _wA = (_n == 0) ? 0.0 : 0.5;
                    var _wB = (_n == 0) ? 1.0 : 0.5;

                    x[_n]     -= _ox * _wA;
                    y[_n]     -= _oy * _wA;
                    x[_n + 1] += _ox * _wB;
                    y[_n + 1] += _oy * _wB;
                }
            }
        },

        draw : function (_col) 
		{
            draw_set_colour(argument_count > 0 ? _col : c_white);
            for (var _i = 0; _i < segments; ++_i) 
			{
                draw_line(x[_i], y[_i], x[_i + 1], y[_i + 1]);
            }
            draw_set_colour(c_white);
        }
    };

    rope.init();
    return rope;
}