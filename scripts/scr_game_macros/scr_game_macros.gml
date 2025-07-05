#macro CAMERA view_camera[0]
#macro CAMERA_WIDTH camera_get_view_width(CAMERA)
#macro CAMERA_HEIGHT camera_get_view_height(CAMERA)
#macro CAMERA_X camera_get_view_x(CAMERA)
#macro CAMERA_Y camera_get_view_y(CAMERA)

#macro GUI_WIDTH display_get_gui_width()
#macro GUI_HEIGHT display_get_gui_height()

#macro WINDOW_CAPTION window_get_caption()
#macro WINDOW_WIDTH window_get_width()
#macro WINDOW_HEIGHT window_get_height()
#macro WINDOW_X window_get_x()
#macro WINDOW_Y window_get_y()
#macro WINDOW_FULLSCREEN window_get_fullscreen()
#macro WINDOW_HAS_FOCUS window_has_focus()

#macro TIME_DELTA_TIME (delta_time / 1000000) * 60