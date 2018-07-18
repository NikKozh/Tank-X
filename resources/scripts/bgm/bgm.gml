#define bgm_Init
/* Initializes BGM. Must be called once before calling anything else besides
   bgm_SetLibDir() or bgm_SetShowErrors().
   Don't call again until after bgm_Close() is called.

   bgm_Init( device_number,
             output_frequency,
             use_8bit,
             use_mono );

******************************************************************************/

var dll;

// Get full filename of the dll
if (!variable_global_exists("_bgm_path"))
  global._bgm_path = "bgm.dll"
else
  global._bgm_path += "\bgm.dll";
  
dll = global._bgm_path;

// Set the default for displaying errors, if not already set
if (!variable_global_exists("_bgm_showErrors"))
  global._bgm_showErrors = true;

// Function import table ------------------------------------------------------

global._bgm_Init               = external_define(dll, "bgm_Init",                 dll_cdecl, ty_real,   5, ty_real, ty_real, ty_real, ty_real, ty_real);
global._bgm_Close              = external_define(dll, "bgm_Close",                dll_cdecl, ty_real,   0 );
global._bgm_Load               = external_define(dll, "bgm_Load",                 dll_cdecl, ty_real,   3, ty_string, ty_real, ty_real );
global._bgm_LoadMod            = external_define(dll, "bgm_LoadMod",              dll_cdecl, ty_real,   2, ty_string, ty_real );
global._bgm_LoadSample         = external_define(dll, "bgm_LoadSample",           dll_cdecl, ty_real,   2, ty_string, ty_real );
global._bgm_LoadStream         = external_define(dll, "bgm_LoadStream",           dll_cdecl, ty_real,   2, ty_string, ty_real );
global._bgm_LoadNetStream      = external_define(dll, "bgm_LoadNetStream",        dll_cdecl, ty_real,   2, ty_string, ty_real );
global._bgm_UnloadById         = external_define(dll, "bgm_UnloadById",           dll_cdecl, ty_real,   1, ty_real );
global._bgm_UnloadByFname      = external_define(dll, "bgm_UnloadByFname",        dll_cdecl, ty_real,   1, ty_string );
global._bgm_IsLoadedById       = external_define(dll, "bgm_IsLoadedById",         dll_cdecl, ty_real,   1, ty_real );
global._bgm_IsLoadedByFname    = external_define(dll, "bgm_IsLoadedByFname",      dll_cdecl, ty_real,   1, ty_string );
global._bgm_PlayById           = external_define(dll, "bgm_PlayById",             dll_cdecl, ty_real,   2, ty_real, ty_real );
global._bgm_PlayByFname        = external_define(dll, "bgm_PlayByFname",          dll_cdecl, ty_real,   2, ty_string, ty_real );
global._bgm_StopById           = external_define(dll, "bgm_StopById",             dll_cdecl, ty_real,   1, ty_real );
global._bgm_StopByFname        = external_define(dll, "bgm_StopByFname",          dll_cdecl, ty_real,   1, ty_string );
global._bgm_PauseById          = external_define(dll, "bgm_PauseById",            dll_cdecl, ty_real,   1, ty_real );
global._bgm_PauseByFname       = external_define(dll, "bgm_PauseByFname",         dll_cdecl, ty_real,   1, ty_string );
global._bgm_UnpauseById        = external_define(dll, "bgm_UnpauseById",          dll_cdecl, ty_real,   1, ty_real );
global._bgm_UnpauseByFname     = external_define(dll, "bgm_UnpauseByFname",       dll_cdecl, ty_real,   1, ty_string );
global._bgm_IsPlayingById      = external_define(dll, "bgm_IsPlayingById",        dll_cdecl, ty_real,   1, ty_real );
global._bgm_IsPlayingByFname   = external_define(dll, "bgm_IsPlayingByFname",     dll_cdecl, ty_real,   1, ty_string );
global._bgm_GetLenById         = external_define(dll, "bgm_GetLenById",           dll_cdecl, ty_real,   1, ty_real );
global._bgm_GetLenByFname      = external_define(dll, "bgm_GetLenByFname",        dll_cdecl, ty_real,   1, ty_string );
global._bgm_GetPosById         = external_define(dll, "bgm_GetPosById",           dll_cdecl, ty_real,   1, ty_real );
global._bgm_GetPosByFname      = external_define(dll, "bgm_GetPosByFname",        dll_cdecl, ty_real,   1, ty_string );
global._bgm_GetOrderById       = external_define(dll, "bgm_GetOrderById",         dll_cdecl, ty_real,   1, ty_real );
global._bgm_GetOrderByFname    = external_define(dll, "bgm_GetOrderByFname",      dll_cdecl, ty_real,   1, ty_string );
global._bgm_GetRowById         = external_define(dll, "bgm_GetRowById",           dll_cdecl, ty_real,   1, ty_real );
global._bgm_GetRowByFname      = external_define(dll, "bgm_GetRowByFname",        dll_cdecl, ty_real,   1, ty_string );
global._bgm_GetAttrById        = external_define(dll, "bgm_GetAttrById",          dll_cdecl, ty_string, 2, ty_real, ty_string );
global._bgm_GetAttrByFname     = external_define(dll, "bgm_GetAttrByFname",       dll_cdecl, ty_string, 2, ty_string, ty_string );
global._bgm_GetAttrTypeLast    = external_define(dll, "bgm_GetAttrTypeLast",      dll_cdecl, ty_real,   0 );
global._bgm_SetAttrById        = external_define(dll, "bgm_SetAttrById",          dll_cdecl, ty_real,   3, ty_real, ty_string, ty_string );
global._bgm_SetAttrByFname     = external_define(dll, "bgm_SetAttrByFname",       dll_cdecl, ty_real,   3, ty_string, ty_string, ty_string );
global._bgm_Error              = external_define(dll, "bgm_Error",                dll_cdecl, ty_string, 0 );
global._bgm_SetReportErrors    = external_define(dll, "bgm_SetReportErrors",      dll_cdecl, ty_real,   1, ty_real );
global._bgm_FadeVolById        = external_define(dll, "bgm_FadeVolById",          dll_cdecl, ty_real,   3, ty_real, ty_real, ty_real );
global._bgm_FadeVolByFname     = external_define(dll, "bgm_FadeVolByFname",       dll_cdecl, ty_real,   3, ty_string, ty_real, ty_real );
global._bgm_VolIsFadingById    = external_define(dll, "bgm_VolIsFadingById",      dll_cdecl, ty_real,   1, ty_real );
global._bgm_VolIsFadingByFname = external_define(dll, "bgm_VolIsFadingByFname",   dll_cdecl, ty_real,   1, ty_string );


// ----------------------------------------------------------------------------

// Call bgm_Init()
if (!external_call(global._bgm_Init, argument0, argument1, argument2,
    argument3, window_handle()))
{
  // Error occured - At this point BGM.DLL will have already cleared it's own
  // memory. Therefore, the only thing to do is to unload the dll.
  
  // Output the error message
  if (global._bgm_showErrors != 0)
    show_error(external_call(global._bgm_Error),false);
  
  // Free all functions
  external_free(global._bgm_path);
  
  // Failure...
  return false;
}

// Success!
return true;
#define bgm_Close
/* Frees all memory used by BGM and unloads the DLLs.
   This must be called right before the game ends so that the DLLs may be
   properly deleted.
   
   bgm_Close();

******************************************************************************/

var ret;

ret = external_call(global._bgm_Close);
if (!ret) {
  if (global._bgm_showErrors != 0)
    show_error(external_call(global._bgm_Error),false);
  return false;
}
external_free(global._bgm_path);
return true;
#define bgm_Load
/* Loads a song of any kind and returns a handle (id) for it.
   + Sampled audio on the local computer may be either loaded/uncompressed all
     at once or streamed from the filesystem.
   + Sampled audio may be streamed from the internet by providing an http:// or
     ftp:// URL. "stream" is ignored in this case since the data must be
     streamed no matter what.
   + Modules can only be loaded from the local computer and may not be
     streamed.
     
   bgm_Load( Filename or URL,
             stream )
   Examples:
   
   song1 = bgm_Load("YourSong.xm");
   song2 = bgm_Load("YourSong.mp3", true);
   song3 = bgm_Load("http://www.yoursite.com/YourSong.ogg", true);

******************************************************************************/

var ret;
ret = external_call(global._bgm_Load, argument0, argument1, false);
if (ret==false && global._bgm_showErrors != false)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_LoadMod
/* Loads a traked format song and returns a handle (id) for it.
   Unlike bgm_Load(), this can only load songs of the types MOD, XM, S3M, IT,
   MTM and UMX. The upside is that it's usually faster.
   
   <songID> bgm_LoadMod( filename )
   
   Examples:
   
   song1 = bgm_LoadMod("YourSong.xm");
   song2 = bgm_LoadMod("YourSong.mo3");

******************************************************************************/

var ret;
ret = external_call(global._bgm_LoadMod, argument0, false);
if (ret==false && global._bgm_showErrors != false)
  show_error(external_call(global._bgm_Error), false);
return ret;

#define bgm_LoadSample
/* Loads and decompresses a sampled format song and returns a handle (id) for
   it.
   Unlike bgm_Load(), this can only load songs of the types WAV, AIFF, MP3 and
   OGG. The upside is that it's usually faster.
   
   <songID> bgm_LoadSample( filename )
   
   Examples:
   
   song1 = bgm_LoadSample("YourSong.wav");
   song2 = bgm_LoadSample("YourSong.mp3");

******************************************************************************/

var ret;
ret = external_call(global._bgm_LoadSample, argument0, false);
if (ret==false && global._bgm_showErrors != false)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_LoadStream
/* Loads a sample format song as a stream. This means that it is loaded and
   decompressed while it plays instead of all at once.
   Modules cannot be streamed.
   
   <songID> bgm_LoadStream( filename )
   
   Example:
   
   song1 = bgm_LoadStream("YourSong.wav");

******************************************************************************/

var ret;
ret = external_call(global._bgm_LoadStream, argument0, false);
if (ret==false && global._bgm_showErrors != false)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_LoadNetStream
/* Loads a sample format song as a stream from the internet. This means that it
   is downloaded and decompressed while it plays instead of all at once.
   The URL must begin with either "http://" or "ftp://".
   Modules cannot be loaded or streamed.
   
   <songID> bgm_LoadNetStream( URL )
   
   Example:
   
   song1 = bgm_LoadStream("http://YourSong.mp3");

******************************************************************************/

var ret;
ret = external_call(global._bgm_LoadNetStream, argument0, false);
if (ret==false && global._bgm_showErrors != false)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_Unload
/*  Unloads the given song from memory regardless of type.

    bgm_Unload( song )
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_UnloadById, argument0)
else
  ret = external_call(global._bgm_UnloadByFname, argument0);
if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_IsLoaded
/*  Returns whether or not a song with the given filename or ID number is
    currently loaded. Can be used to validate a number as being an ID.

    Example:
    
    if (bgm_IsLoaded(12)) {
      bgm_Play(12);
    }
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_IsLoadedById, argument0)
else
  ret = external_call(global._bgm_IsLoadedByFname, argument0);
return ret;

#define bgm_Play
/*  Plays the given song. If a filename that does not match any loaded song is
    given it is loaded and played as the Quick Play song.
    Is "loop" is true the song will loop until it is stopped.

    bgm_Play( song, loop <optional> )
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_PlayById, argument0, argument1)
else
  ret = external_call(global._bgm_PlayByFname, argument0, argument1);
if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_Stop
/*  Stops the given song. If no song is given the Quick Play song will be
    stopped and unloaded.

    bgm_Stop( song <optional> )
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_StopById, argument0)
else
  ret = external_call(global._bgm_StopByFname, argument0);
if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_Pause
/*  Pauses the given song. If no song is given the Quick Play song will be
    paused.

    bgm_Pause( song <optional> )
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_PauseById, argument0)
else
  ret = external_call(global._bgm_PauseByFname, argument0);
if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_Unpause
/*  Unpauses the given song. If no song is given the Quick Play song will be
    unpaused.

    bgm_Unpause( song <optional> )
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_UnpauseById, argument0)
else
  ret = external_call(global._bgm_UnpauseByFname, argument0);
if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_IsPlaying
/*  Returns whether the given song is playing (1), stopped (0), or paused (2).
    If no song is passed it returns the status of the QP song.
    Returns -1 on error.

    bgm_IsPlaying( song <optional> )
    
    Example:
    
    if (bgm_IsPlaying(song1)==2) {
      show_message("The song is paused.");
    }
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_IsPlayingById, argument0)
else
  ret = external_call(global._bgm_IsPlayingByFname, argument0);
if (ret==-1 && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_GetLen
/*  Gets the length of a song, in seconds, or returns -1 on error.

    Ex:
    seconds = bgm_GetLen(mySong);
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_GetLenById, argument0)
else
  ret = external_call(global._bgm_GetLenByFname, argument0);
if (ret==-1 && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_GetPos
/*  Gets the playing position of a song, in seconds, or returns -1 on error.

    Ex:
    seconds = bgm_GetLen(mySong);
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_GetPosById, argument0)
else
  ret = external_call(global._bgm_GetPosByFname, argument0);
if (ret==-1 && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_GetOrder
/*  Returns the current order of the given mod.

    Ex:
      order = bgm_GetOrder(mySong);
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_GetOrderById, argument0)
else
  ret = external_call(global._bgm_GetOrderByFname, argument0);
if (ret==-1 && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_GetRow
/*  Returns the current row of the given mod.

    Ex:
      row = bgm_GetRow(mySong);
    
******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_GetRowById, argument0)
else
  ret = external_call(global._bgm_GetRowByFname, argument0);
if (ret==-1 && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
return ret;
#define bgm_GetAttr
/*  Returns the value of a song's attribute or -1000000 on error.

    bgm_GetAttr( song,
                 attribute )
                 
    Example:
    
    // Get the panning seperation of a module
    sep = bgm_GetAttr(song1, "penSep");

******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_GetAttrById, argument0, argument1)
else
  ret = external_call(global._bgm_GetAttrByFname, argument0, argument1);

if (ret=="-1000000" && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
  
if (external_call(global._bgm_GetAttrTypeLast)==1)
  return real(ret);
  
return ret;
#define bgm_SetAttr
/*  Sets the value of a song's attribute.

    bgm_SetAttr( song,
                 attribute,
                 value )
                 
    Example:
    
    // Set the panning seperation of a module
    bgm_SetAttr(song1, "panSep", 35);

******************************************************************************/

var ret;

if (is_real(argument2))
  argument2 = string(argument2);

if (is_real(argument0))
  ret = external_call(global._bgm_SetAttrById, argument0, argument1, argument2)
else
  ret = external_call(global._bgm_SetAttrByFname, argument0, argument1, argument2);

if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
  
return ret;
#define bgm_GetGlobalAttr
/*  Returns the value of a global attribute or -1000000 on error.

    bgm_GetGlobalAttr( attribute )
                 
    Example:
    
    // Get the global output frequency
    freq = bgm_GetGlobalAttr("freq");

******************************************************************************/

var ret;

ret = external_call(global._bgm_GetAttrById, 0, argument0);

if (ret=="-1000000" && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
  
if (external_call(global._bgm_GetAttrTypeLast)==1)
  return real(ret);
  
return ret;
#define bgm_SetGlobalAttr
/*  Sets the value of a global attribute.

    bgm_SetGlobalAttr( song,
                       attribute,
                       value )
                 
    Example:
    
    // Set the global output frequency
    bgm_SetGlobalAttr("freq", 32000);

******************************************************************************/

var ret;

if (is_real(argument1))
  argument1 = string(argument1);

ret = external_call(global._bgm_SetAttrById, 0, argument0, argument1);

if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
  
return ret;
#define bgm_FadeVol
/*  Fades the volume of a song to the given level over a certain period of
    time, given in milliseconds.
    
    Ex:
    
    // Fade out a song over 5 seconds
    bgm_FadeVol(song, 0, 5000);

******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_FadeVolById, argument0, argument1, argument2)
else
  ret = external_call(global._bgm_FadeVolByFname, argument0, argument1, argument2);

if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
  
return ret;

#define bgm_VolIsFading
/*  Returns whether or not a song's volume is sliding
    
    bgm_VolIsFading(song)

******************************************************************************/

var ret;

if (is_real(argument0))
  ret = external_call(global._bgm_VolIsFadingById, argument0)
else
  ret = external_call(global._bgm_VolIsFadingByFname, argument0);

if (!ret && global._bgm_showErrors)
  show_error(external_call(global._bgm_Error), false);
  
return ret;

#define bgm_Error
/*  Returns a description of the last error that occured in BGM.
    After this is called the error cache is cleared.
    
    Example:
    
    if (!bgm_Load("MySong.ogg"))
      str = bgm_Error();
      
    show_message(str); // This would display a message explaining why the
                       // song couldn't be loaded.
                       
******************************************************************************/

return external_call(global._bgm_Error);
#define bgm_SetShowErrors
/*  Sets whether or not BGM should display errors that occur automatically.
    By default BGM shows errors. This function may be called before bgm_Init().
    
    bgm_SetShowErrors( true (show) or false (hide) )

******************************************************************************/

global._bgm_showErrors = argument0;
#define bgm_SetReportErrors
external_call(global._bgm_SetReportErrors, argument0);
#define bgm_init
return bgm_Init();
#define bgm_close
return bgm_Close();
#define bgm_play
return bgm_Play(argument0);
#define bgm_stop
return bgm_Stop();
#define bgm_pause
return bgm_Pause();
#define bgm_unpause
return bgm_Unpause();
#define bgm_vol
if (argument0<=-1)
  return bgm_GetAttr(0,"cvolume")
else
  return bgm_SetAttr(0,"cvolume", argument0);
#define bgm_isplaying
var ret;
ret = bgm_IsPlaying();
if (ret==2)
  return 3;
if (ret==3)
  return 2;
return ret;

#define bgm_SetLibDir
// This script has been depricated because it doesn't work correctly.

/*  Changes the directory in which BGM will look for the DLLs.

  bgm_SetLibDir( new directory without final backslash );
*/

global._bgm_path = argument0;
