global.game_settings = {};

with(global.game_settings)
{
	view = 0;
	view_cam = noone;
	view_width = 640;
	view_height = 360;
	
	gui_width = view_width;
	gui_height = view_height;
	gui_vsync = true;
	
	resolutions = [[640, 360], [1280, 720], [1920, 1080]];
	resolutions_length = array_length(resolutions) - 1;
	resolution_ind = 1;
	
	window_caption = "Rope Physics";
	window_width = resolutions[resolution_ind][0];
	window_height = resolutions[resolution_ind][1];
	window_start_fullscreen = false;
	window_borderless_fullscreen = false;
	window_cursor_visible = true;
	window_toggle_fullscreen = true;
	
	starting_room = rm_main;
	game_fps = 60;
	debug = false;
}

function game_init()
{
	randomize();
	instance_create_depth(0, 0, 0, obj_window_manager);
	room_goto(global.game_settings.starting_room);	
}

function game_set_window()
{
	global.game_settings.window_width = global.game_settings.resolutions[global.game_settings.resolution_ind][0];
	global.game_settings.window_height = global.game_settings.resolutions[global.game_settings.resolution_ind][1];
	
	var _gui_width = global.game_settings.gui_width;
	var _gui_height = global.game_settings.gui_height;
	
	window_set_caption(global.game_settings.window_caption);
	
	if(!global.game_settings.window_cursor_visible) window_set_cursor(cr_none);
	
	window_set_size(global.game_settings.window_width, global.game_settings.window_height);
	
	window_enable_borderless_fullscreen(global.game_settings.window_borderless_fullscreen);
		
	call_later(1, time_source_units_frames, function()
	{
		window_center();
		window_set_fullscreen(global.game_settings.window_start_fullscreen);
		global.game_settings.window_start_fullscreen = false;
	}, false);
	
	surface_resize(application_surface, global.game_settings.view_width, global.game_settings.view_height);
	display_set_gui_size(_gui_width, _gui_height);
	display_reset(0, global.game_settings.gui_vsync);
}

function game_next_resolution()
{
	if(window_get_fullscreen()) return;
	
	global.game_settings.resolution_ind++;
	global.game_settings.resolution_ind = wrap(global.game_settings.resolution_ind, 0, global.game_settings.resolutions_length);
	game_set_window();
}

function game_previous_resolution()
{
	if(window_get_fullscreen()) return;
	
	global.game_settings.resolution_ind--;
	global.game_settings.resolution_ind = wrap(global.game_settings.resolution_ind, 0, global.game_settings.resolutions_length);
	game_set_window();
}

function game_enable_view_port()
{
	global.game_settings.view_cam = view_camera[global.game_settings.view];
	view_enabled = true;
	view_visible[global.game_settings.view] = true;
	camera_set_view_size(global.game_settings.view_cam, global.game_settings.view_width, global.game_settings.view_height);
}

function game_toggle_fullscreen()
{
	if(!global.game_settings.window_toggle_fullscreen) return;
	
	global.game_settings.window_toggle_fullscreen = false;
	
	call_later(10, time_source_units_frames, function() 
	{
		global.game_settings.window_toggle_fullscreen = true;
	});
	
	window_set_fullscreen(!window_get_fullscreen());
	
	if(!WINDOW_FULLSCREEN)
	{
		call_later(10, time_source_units_frames, function()
		{
			if(WINDOW_WIDTH != global.game_settings.window_width or WINDOW_HEIGHT != global.game_settings.window_height)
			{
				global.game_settings.window_toggle_fullscreen = false;
				window_set_size(global.game_settings.window_width, global.game_settings.window_height);
				call_later(1, time_source_units_frames, window_center);
				call_later(10, time_source_units_frames, function() 
				{
					global.game_settings.window_toggle_fullscreen = true;
				});
			}
		});	
	}
}