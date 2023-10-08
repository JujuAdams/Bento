#macro BENTO_DEFAULT_BUTTON_NAME  "action"

#macro BENTO_LOCAL_POSITION_STRETCH  true

#macro BENTO_MOBILE_CLICK_ON_PRESS  true

#macro BENTO_LONG_CLICK_DELAY  600

// Default font to use for text-based boxes
#macro BENTO_DEFAULT_FONT  __bentoDefaultFont

#macro BENTO_MAX_CACHED_STRINGS  100

// Hot reload mode
//  0 = No hot reload
//  1 = Hot reload allowed when running from IDE
//  2 = Hot reload allowed always
//
//Hot reload will trigger in two situations:
// a. Incremental scan through each loaded file every x-milliseconds (see below)
// b. Full refresh every time the window is refocused (Windows OS only)
#macro BENTO_HOT_RELOAD_MODE  1

// These two macros control How often the hot reloader will scan a new file in different
// application states. Only one file is scanned at a time. If the game is in focus (as determined by
// window_has_focus()) then ..._IN_FOCUS variant is used, otherwise ..._OUT_OF_FOCUS is used.
// 
// If you have a lot of files, file scanning might take a while due to one file being scanned at a
// time. Set scan periods to lower values if you want to see faster updates. Lower values may cause
// hitching or slowdown though so don't set it too low. Set either macro to <infinity> to never
// scan for file changes
// 
// You generally will want BENTO_HOT_RELOAD_SCAN_PERIOD_OUT_OF_FOCUS to be a very low number to ensure
// that any changes to source files is reflected quickly in-game.
#macro BENTO_HOT_RELOAD_SCAN_PERIOD_IN_FOCUS      500 //In milliseconds
#macro BENTO_HOT_RELOAD_SCAN_PERIOD_OUT_OF_FOCUS   16 //In milliseconds

// Controls how many debug messages are spit out into the log
//  0 = Only absolutely essential messages
//  1 = Informative messages
//  2 = Extended debug information
#macro BENTO_REPORT_LEVEL  0

// Function to use to show debug messages
// The default is <BentoTrace>, a simple function that adds a timestamp and calls show_debug_message()
// The function specified here is handed a single argument which is a string containing the message
#macro BENTO_TRACE  BentoTraceDefault