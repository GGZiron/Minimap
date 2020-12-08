($imported ||= {})[:GGZiron_Minimap] = '1.2.1'

module Minimap

=begin
  Script Name: GGZiron's Minimap
  Author: GGZiron
  Engine: RPG Maker VX Ace
  Terms(updated): Free for non commercial and commercial projects. 
  Sending me a copy of your game would be very appreciated, 
  but is not mandatory. With terms update, that so even for commercial
  projects. You have to credit me as GGZiron.
  Not allowed to repost, only allowed to post link to this script tread in
  RPG maker forum.
  Allowed to edit, and allowed to post your edit, but together with link to this
  script tread in RPG Maker forums. Not the case if the very post is within
  the tread of this script in RPG Maker forums, then link not needed.
  Version: 1.2.1
  
  Script Purpose: Adds Minimap on the Scene Map, to be used for navigation.
  Compitability: Check it yourself, for your project :).
  
  How easy to install?: From medium to hard, dependings how much of the settings
  you plan to change. Even if none, you gotta place comment tags for events,
  if you want them drawn on minimap, and check the toggle option with button, 
  as the probability to like the default is not too high, especially if you
  love to dash in debug through during playtest.
  
  Known flaws: Works kinda slow for very big maps. Also, it consumes a lot of
  memory. With the default TILE_SIZE (given in settings bellow) in 500 x 500 
  map, a default project would eat nearly 80 mb operative memory, when without 
  my script on same map it takes only 41 mb. That is so because it draws one 
  large bitmap. To prevent that, I should write some sorta tile map, but so far 
  I couldn't figure how to make one, and cannot use the engine's Tilemap for the 
  minimap. With not too big maps I believe this flaw won't be a deal breaker.
  Other know issue is with the looping maps. While minimap itself will
  loop properly, the event characters will not. They would appear suddenly on
  their spots, when the player is relocated at the oposite end.
  
Entry bellow comes with my initial version:
  Warning!! As that is my initial version, you might want me to patch it a 
  little before including that into your project. Currently, recommended only
  for preview purpose. Still, you can include it in your project, if you see
  no issues. Just be sure to check for updates :).
  
  Version History:
   Version 1.0.0 Realeased on: 29/08/2019
   That is the initial version.
   Version 1.0.1 Released on 29/08/2019
    Fixed an issue with small looping maps.
   Version 1.1.0 Released on 31/08/2019
    Butchered a lot of code. Hope for better :)
    *New Feature: Map List. See more about it on general options.
    *Option to change in game the variable, that determines if map
    *should update even when disabled.
    *When disabled map is set to not update, it will now draw too, 
     preventing short game freeze for no apparent reason when
     going to new map.
    *Minimap characters are now their own Sprites (one colored tile sprites)
     That makes their movement smoother.
    *Added additional support for vehicles.
    *Loopable map smaller than set minimap dimension will reduce the minimap 
     size too. They wouldn't in the previous version. Did so because when the
     real area could be populated with characters, the repeat areas would be 
     empty, and that will break the illusion. In previous verion characters
     were part of minimap bitmap, so there was not a problem.
    *Needs more save data. 
    *New script calls.
    Once again, Mithran's debug script was of great service to me.
    Little trivia, my crashes was not random at all, but with 100 % certancy,
    before I added the dispose code for the minimap character sprites.
   Version 1.1.1 Released on 01.09.2019
    *Fixed an issue, which would cause game to crash on map without events.
    *Added additional bitmap disposes, that I forgot to do in previous version.
    *Minimap adjust ox and oy only when player moving, increasing performance.
     Was idea to do so in previous versions too, but I goofed the conditional
     checks there.
   Version 1.2.0 Released on 06/09/2019
    *Now it use better method to scan the entire map passability at once, which
     improves the performance.
    *Add passability data into cache, to make map drawing faster(needed
     for map revisit or for vehicle change). More about caches in settings. 
    *Fixed some script calls.
    *Fixed some bugs.
   Version 1.2.1 Released on 08/12/2021
    *Upon pressing f12(and maybe under other circumstances too), my minimap
     window would would stay blank. Connected with not initializing everything
     upon starting new game. Now that should be fixed.
    
    
  Please, do report me bugs, if you see some. Especially the deal breakers.
  All bug reports are more than welcome, just be polite, please.
  Not compitable with other script? While I do not promise to fix that, feel 
  welcome to report in my script tread. Even if I do not do a fix, someone else 
  could help. There is something very specific you want to be done? Like, 
  new feature? If I feel everyone would benefit from that new feature, might 
  add it. If not, could add it as addon, but that only if have extra time, and 
  feel like doing it.
  
  How my minimap works: It use processor heavy opertions to draw a full minimap,
  but is drawn only once per awhile. Then, it updates characters acording their 
  movement. If sometimething doesn't update properly, then there is either
  bug in my script, or there is other script that not so compatible with mine.
  It adds bit to the save data. In initial version, that is used only to keep
  track if minimap is currently enabled, or disabled. 
  It checks only for events that have minimap color. When not visible, Minimap 
  is still updated. There is option bellow that changes this, but doing that 
  have its downside too.
  With version 1.1.0: Forbiden maps would not update, as is assumed that
  the map lists won't be altered too often, but only once per awhile, if at all.
 
  There are script calls that would completely redraw entire map,
  or selected rectangle from it. They would be useful only if you know what
  actions my minimap doesn't respond to, and if that doesn't happen too often.
  The script draws bitmap with the whole map, but the part that fit within
  the window viewport will have the size you set in settings.
  That bitmap is redrawn when player changes vehicle, or visit new map, or
  on script calls, which I provide bellow.
  
  With version 1.2.0, minimap doesn't use the player's passability anymore,
  but the map's passage flags. Thus, any script that alters the player
  passability would not be reflected on minimap.
  
  Features:
    *Kinda simplified minimap, but not simple on features.
    *Draws passable area. 
    *Draws impassable area.
    *Option to set or unset buttons for toggling minimap visibility.
    *Draws partly passable as passable, but then draw impassable line on the 
     edge of the tile. You will see what I mean if you test ladders, walls
     with walkable upper floor, ladders, bridges and so on.
    *Draws events, but not by default. You need to put comments with certain
     formation, similar like in the notetags. Also, while there is default color
     for the events characters, you can set to use different one, to make
     characters standing out of the crowd(quest NPC, point of special interest).
    *Player input options.
    *Option to draw regions and terrain tags too.
    *Draws damage floor.
    *Updates player and event movement on straight move, diagonal move, jump,
     set position.
    *Redraws passage map on changing vehicle, according the new passability.
     For example, riding boat will turn all water tiles as passable, and all
     ground as no passable. Region and terrain tag, same as damage floor, 
     remain unchanged.
     When using airship, will draw the land ok tiles, instead passable tiles.
     Otherwise riding airship would mean to have one color minimap, with no tiles
     within, as airship can pass through everything.
    *Option to change the character object priority. Priority is used so if
     two objects are within same tile, it will draw the color of the one with
     higher priority. Objects are: player, events, damage floor, region,
     terrain_tag, vehicle. When two events share a tile, it will draw the one
     with higher id number.
     With version 1.1.0, objects are on two groups.
    *Configurable minimap size; transparency; x, y and z coordinates.
    *Reacts on loop maps, as then the minimap loops too.
    *Option to determine how deep to look in event commands for the needed
     comment tags.
    *With version 1.1.0: Maps List. See in general options about it.
     
  Does not feature followers display (for now)!!  
=end

# ============================================================================
#                        General Options
# ============================================================================
  
  ENABLED_AT_BEGINNING = true
  #Map will be visible with game start. There is script call to change
  #that at anytime.  
  
  MAPS_LIST = [] #Used to forbid or allow maps, depending MAPS_LIST_FORBID 
  #value.
  #Put all the maps ID's you want in the list at the beggining of the game.
  #EXAMPLE MAPS_LIST
  #MAPS_LIST = [1, 2, 3, 7] #Would affect maps with id 1, 2, 3 and 7
  MAPS_LIST_FORBID = true
  #set to true or false. 
  #When false, the map in the maps list will be displayed
  #if all the other display condisions are on. If map display is disabled
  #then they still won't display.
  #Set to true, if you want to forbid the maps. When true, the
  #maps in the array will not be displayed. The others will be displayed,
  #if all other conditions are there.
  #If you want all maps initially allowed, keep MAP_LIST empty, and set
  #MAPS_LIST_FORBID to true. That's the default settings.
  #If you want all maps initially to be forbiden, keep MAP_LIST empty, and
  #set MAPS_LIST_FORBID to false.
  #You can expand that map list during game with script call, which I provide
  #in the Script Calls section.
  
  UPDATE_WHEN_DISSABLED = true #default is true
  #By default, minimap will update even when disabled.
  #You can set it to false, so is not updated when disabled, and that might 
  #somehow improve the performance, but will also need to completely
  #redraw the minimap, when enabled again. So, it has it's downside too.
  #New with version 1.1.0.
  #You can change that behavior in game with script call, provided in the 
  #script call header.
  #As is assumed that the allowed maps list won't be changed every frame, 
  #a map that is forbiden will not be drawn and will not update regardless of
  #how you set this option.
  
  CACHE_MAPS = []
  #Upon visiting map, the map passability data will be stored within
  #Table object, making it a lot faster to be drawn each next time.
  #A table object increases the memory the game uses. One 500 x 500 map, if
  #cached, would take about one MB operative memory. 
  #Maps that are not in that list still make entry at the cache on visit, 
  #but that entry is removed once player leaves map.
  #Recomended to use for bigger maps. Of course, will make small maps to load
  #even faster, and they won't take too much of data.
  #Even with map inlcuded in Cache, map drawning process won't be too fast, 
  #if map is very big. Cache does not become part of save data.
  
  COMMENT_SCANER_INI = 1
  #Will start scanning from very first event command for match value
  COMMENT_SCANER_FIN = 2 #Set to one, if you want to check only top comment.
  #Will end scanning after third event command.
  #Keep in mind, some event commands get more slots, and even if sometimes
  #it would appear a command is second on the list, could be actually third.
  #That's why, better do not place non-comment commands above the one with
  #the comment tag.
  
  #I had seen other scripts that expect certain comments as first command.
  #So, for compitability atempt, my script will start looking from 
  #COMMENT_SCANER_INI, and end after COMMENT_SCANER_FIN.
  #Strongly recomended COMMENT_SCANER_INI stay 1. As about COMMENT_SCANER_FIN,
  #bigger the range, less probability to miss comment with notetag.
  #But it also means more operations, and that could be felt if the events
  #on the map are too many. If you do not use other scripts that read comments
  #from events, recommended to bring COMMENT_SCANER_FIN value back to 1 too,
  #so it checks only the first event command. If you do that, of course the 
  #comment with the color formating must be on top of the event page.
  
# ============================================================================
#                        Controls Options
# ============================================================================

  ENABLE_DISABLE_BUTTON = :CTRL
  #Set to false or nil, if you don't want the player to be able to
  #switch on and off the minimap at all.
  ENABLE_DISABLE_BUTTON2 = :SHIFT
  #Buttons to use:
  #DOWN LEFT RIGHT UP SHIFT CTRL ALT 
  #A B C X Y Z L R 
  
  #When second button is enabled, it needs to be pressed at same time with 
  #first. Turn second button to nil, to disable. Then will need only first 
  #button. Button don't actually need to be pressed at same time, you can hold 
  #one, then press the other.
  #Notice: Only nil value disables second button. Setting to false would 
  #entirely disable button minimap toggle functionality
  
  #If map is forbiden, buttons pressing will do nothing, even if all other
  #conditions are present.
  
  BUTTON_CONTROL_SWITCH = 0
  #Set to Switch Id (switches used in the Event Editor). When that switch is on,
  #player will be able to turn on and off the minimap. When is off, it will be 
  #not. Keep value as zero, if you do not intend to change in game the player
  #access to toggle button. In game chance of access to toggle button would be 
  #useful, if you have cut scene, and don't want the player to be able to 
  #toggle minimap, or simply the player didn't unlocked the minimap yet.
  BUTTON_SENSIBILITY = 0.4 
  #It will wait 0.4 seconds before the button work again.
  #You can set to lesser or higher value.
  #As seen from default value, the provided value can be decimal.
  #When decimal, the actual time could vary with fragment of the second.

# ============================================================================
#                       How to draw Events on Minimap
# ============================================================================
# By default, my minimap will not draw events. To draw an event, the active
# event page must have comment with special formating, as shown bellow:

# <minimap normal color>
# This one will make the minimap to draw a tile with normal event color
# on the event's coordinates. Normal event color is set in COLORS.

# <minimap color n>
# In the above version, replace n with the color id from the COLORS hash.
# Example:
# <minimap color 6>
# This will set the event to use color 6 instead the normal event color.
# It looks the entry with key 6 from COLORS hash.
# You can add more entries at the color array, which once added, can be used
# as well.

# If you use event as tile, and that tile is non passable, then is good idea
# to use <minimap color 2> on that said event.
# Is good to be noted tile events with bellow priority doesn't need that,
# as the map passabilty data reacts on it.
# Important!! Space between words in comment must stay as in the provided
# example, and it won't recognize tags with upper case letters.
# Recomended to copy paste from here, and only change the color, if you use
# special colored events.

# ===========================================================================
#                        Visual Options
# ===========================================================================

  TILE_SIZE = 6 #The width and the height in pixels of every minimap tile.
  WIDTH = 35
  #Minimap's width. How many tiles per line. Multiplying that value to
  #TILE_SIZE would give the screen width in pixel(add few more for the window
  #border, and you get the total window width).
  #If the actual map have less tiles width than the desired WIDTH of the 
  #minimap, the minimap's width will be reduced.
  HEIGHT = 20 #Same as WIDTH, but here how many tiles are per column.
  X = 'Graphics.width - self.width - 10'
  #The X coordinate of the minimap.
  Y = 5
  #The Y coordinate of the minimap 
  
  #X is set to text value, which will be evaled later to actual digit.
  #That is needed because the self object in the formula is not yet defined.
  #That will be the window, which will contain the minimap.
  #I imagine width and height are the only properties of self, that you
  #might need. If your formula does not contain the self object, then
  #there is no need to be set as text value. For example, the Y cord above
  #does not use self object, which is why I do not need to make it text value.
  #A value to become a text, it needs to be between ' ' or between " "
  #Also, knowing the dimention of your screen and minimap, you can set
  #literal values instead formulas. Y uses literal value. 
  Z = 101 #The z coordinate of the window, that will contain the minimap.
  #The minimap viewport will be with one higher.

  OPACITY = 180 #The minimap's opacity. Valid range: 0 - 255.
  #Does not effect the opacity of the window, that holds the minimap.
  
  WINDOW_BORDER = 5
  #Used to know how much space it will need for the Window Border. On default
  #Window.png file, that is 5 pixels(or at least, I think so), but if you use
  #different one, you should abjust the value so the minimap fit to your border.
  #It have somewhat padding functionality too, if value incresed above actual 
  #border size.
  #Does not define the actual Window Border size!
  WINDOW_OPACITY = 255 #Set between 0 and 255
  WINDOW_BACK_OPACITY = 0 #Set between 0 and 255
  #Above settings set the opacity of the window itself, that holds the
  #minimap. Does not affect the minimap itself.
  #WINDOW_BACK_OPACITY set the Window Background Opacity.

# All colors used for the minimap are set here.
# Use only whole numbers for keys.
  COLORS = {
#   Keys must be whole numbers, and there should not be two same keys.
#   Do not edit the key ID of the existent entries.
#   key            R    G    B 
    1 => Color.new(5,   180, 5  ), #Passable color. Green by default.
    2 => Color.new(0,   0,   0  ), #Unpassable color. Black by default.
    3 => Color.new(0,   0,   255), #Player color. Blue by default.
    4 => Color.new(0,   255, 255), #Normal event color. Teal by default.
    5 => Color.new(255, 0,   255), #Vehicle color. Purple by default
    6 => Color.new(255, 0,   0  ), #Damage floor color. Red by default.
    7 => Color.new(255, 255, 255), #White color. Not used by default.
    8 => Color.new(255, 165, 0  ), #Orange color. Not used by default.
    9 => Color.new(255, 255, 0  ), #Yellow color. Not used by default.
    #Add more colors, so you can use them to color regions, terrain tags
    #or special events that must stand from the crowd. To add new
    #color, just copy paste one of the above, then change its RGB code.
    

    
      }  #Do not delete. Do not add more color entries bellow this line.  
      

  #Do not add entries, only rearange their order, or remove.
  PRIORITY_TILES = [:region, :terrain_tag, :damage_floor]
  #Very recomended to remove entries that will not be used, ever.
  #That will reduce the maps loading time, as there will be much less checks.
  #Don't forget to re-add, if you change mind later.
  
  PRIORITY_CHARACTERS = [:player, :events, :vehicles]
  
  #Removed entry would not display on the minimap, ever(unless there is some
  #sort modification to my script).
  #This said, no comment tags would make events to appear, if you remove them from
  #this array.
  #That array determines the priority of map objects, if two share
  #same cell. Those who are first are with higher priority.
  #With version 1.1.0, they are split into two arrays. I do not see point
  #any tile object to be above character object. Also, tiles are part
  #of the minimap bitmap, while character objects are indepedent sprites.

  REGIONS = { #Do not edit this line
# Entry format:
# region_id => color_key,
# Example entry:
#    50 => 7, #Region 50 will get color 7 from COLORS hash.
# Te active entries should not be commented (no # in the beginning of the line).
# Add your entries:
    

  }#Do not touch, do not add entries bellow this line.

# ==========================================================================
  TERRAIN_TAGS = { #Do not edit this line
# Entry format:
# terrain_tag_id => color_key,
# Example entry:
#   7 => 7, #All tiles with terrain tag 7 will get color 7 from COLORS hash.
# Te active entries should not be commented (no # in the beginning of the line).
# Add more entries:


  } #Do not touch, do not add entries bellow this line.
# ==========================================================================

# ==========================================================================
#                               Script calls
# ==========================================================================
=begin  
  Asside of Input buttons, minimap visibility can be changed with script call
  too. It is one if those two:
  
  Minimap::enabled = true 
  Minimap::enabled = false
  The first one enables it, the second one disables it.
  
  Minimap::map_list_add(map_id) 
  Minimap::map_list_add(map_id_1, map_id_2, map_id_3, ... map_id_n) 
  Adds to the maps list all the entries. Would those maps be displayed or
  ignored, depends from MAPS_LIST_FORBID, which you set in settings.
  
  Minimap::map_list_drop(map_id)
  Minimap::map_list_drop(map_id_1, map_id_2, map_id_3, ... map_id_n) 
  Drops entries from the maps list. 
  
  Minimap::update_when_disabled = false 
  Won't draw and update maps when they are hidden.
  For large maps, can cause lag spike when enabled again. 
 
  Minimap::update_when_disabled = true  
  Will draw and update maps when eve they are hidden.
  If currently hidden, the minimap will be drawn on that script call,
  unless is forbiden to show.
  
  If you need to redraw minimap entirely, because it happens something that
  my minimap didn't react on, you can use this script call:
  
  Minimap::redraw_area
  Redraws entire map.
  In earlier versions i provided Minimap::draw_map, but that will not work
  anymore. That so because while it will draw map again, it will use the old
  passability data. So, use Minimap::redraw_area instead, if other script 
  changed terrain, regions, terrain tag or damage floors.
  
  While redrawing whole map does the best job, is somewhat costly process.
  How costly? With purpose of testing, I did tried what happen if script
  redraws map every frame. Frame rate fell to 3. In not so big small map.
  That how costly it is.
  
  If you need to redraw just certain area, you can use this
  script call:
  Minimap::redraw_area(x1, y1, x2, y2)
  Doing that, the script will redraw only tiles between x1 and x2,
  and  tiles between y1 and y2 (An rectangle area).
  The coordinate x2 can be same as x1, and y2 can be same as y1, so to redraw 
  only one tile. Coordinates x1 and y1 must be same or smaller value than x2
  and y2, otherwise the redraw request will be ignored.
  
  Tested on: Tsukihime's tile swap. It works, but there needs to be at least
  one frame wait between the call that swap the region, and the call
  that will redraw map coordinate. Minimap will never react on Hime's tile
  swap, unless redraw is requested.
  Tested also when removing tile event, that is with bellow player priority.
  On that one my minimap will not react, but redrawing the spot fixes the issue.
  For that instance, there is no need of frame wait between remove tile event
  and redrawing the map coordinate.
  
  If you want to remove manually a passability cache: you can use the following
  script call:
  Minimap::clear_cache(map_id) 
  Will clear a cache entry with the map id.
  
  Minimap::clear_cache(map_id1, map_id2, map_id3...map_idn)
  Will clear the cache entries of all the the maps provided.
  
  Minimap::clear_cache
  Will clear the entire cache.
   
=end
# ============================================================================
#                         The rest of the script bellow.
# ============================================================================
# Do not edit bellow, unless you are a brave knight from the order of the
# Scripters, or one of the scripting legends they sing songs about.
# Defiling that rule would anger the gods, and would lead to great calamities 
# upon your world. You have been warned!! :)
# ============================================================================
  class << self 
    attr_reader :vehicles_bitmap,     :enabled,    :events 
    attr_reader :redo_events_flag,    :vehicles,   :player_bitmap      
    attr_reader :redo_vehicles_flag,  :initialized   
    attr_reader :update_when_disabled 
    
    attr_accessor :refresh_player
# Initialize ===============================================================   

    def on_new_game
      @enabled              = ENABLED_AT_BEGINNING
      @maps_list            = MAPS_LIST
      @maps_list_forbid     = MAPS_LIST_FORBID
      @update_when_disabled = UPDATE_WHEN_DISSABLED
      on_game_start
      @initialized = false;
    end 
   
    def on_game_start
      @cache_maps = CACHE_MAPS
      Mapper::on_game_start
    end

    def initialize
      return if @initialized
      see_and_set_if_map_forbiden
      @timer = 0
      @rect = Rect.new(0, 0, TILE_SIZE, TILE_SIZE)
      create_map
      draw_map_objects
      @initialized = true
    end
    
# Setters ==================================================================        
    def enabled=(bool)
      @enabled = bool
      create_map if @enabled && !update_when_disabled && @map_forbiden
    end  
    
    def set_refresh_flag
      @refresh_flag = true
    end
  
    def set_event_to_refresh(id)
      @events_rfr ||= Hash.new
      @events_rfr[id] = true
    end
  
    def set_vehicle_to_refresh(id)
      @vehicle_rfr ||= Hash.new
      @vehicle_rfr[id] = true
    end
    
    def update_when_disabled=(bool)
      old_value = update_when_disabled
      @update_when_disabled = bool
      create_map unless old_value
    end  
    
    def see_and_set_if_map_forbiden
      @map_forbiden  = @maps_list.include?(map.map_id)
      @map_forbiden ^= !@maps_list_forbid
    end  
    
# Getters ==================================================================    
    def get_events_to_refresh
      @events_rfr ||= Hash.new
      return @events_rfr
    end
    
    def get_vehicles_to_refresh
      @vehicle_rfr ||= Hash.new
      return @vehicle_rfr
    end
        
    def width
      WIDTH < map.width ? WIDTH : map.width
    end 
  
    def height
      HEIGHT < map.height ? HEIGHT : map.height
    end 
    
    def player_color;       COLORS[3] end
    def event_color;        COLORS[4] end
    def vehicle_color;      COLORS[5] end
    def full_map;           @full_map end
      
# Connectors with external objects ======================================
    def map; $game_map       end
    def player; $game_player end
      
# Check value ===========================================================
    def map_forbiden? #called every frame
      @map_forbiden
    end  
    
# Draw methods ==========================================================
    def create_map
      @refresh_flag = false
      return unless map
      return if map_forbiden? 
      return unless @enabled || @update_when_disabled
      if @full_map; @full_map.dispose end
      id = map.map_id
      Pass_Mapper::start(id) unless GGZ_Mini_Cache::table_available?(id)
      draw_map
    end
    
    def draw_map(ini_x = 0, ini_y = 0, fin_x = map.width, fin_y = map.height)   
      id = map.map_id; vt = player.vehicle_type
      @full_map.dispose unless @full_map.disposed? if @full_map
      @full_map = Mapper::draw_map(ini_x, ini_y, fin_x, fin_y, id, vt)
    end  
    
    def redraw_area(x1 = 0, y1 = 0, x2 = map.width - 1, y2 = map.height - 1)
      return unless map
      return unless map.valid?(x1, y1) && map.valid?(x2, y2)
      return unless x1 <= x2 && y1 <= y2
      id = map.map_id; vh = player.vehicle_type
      x2 += 1 unless x2 == map.width; y2 += 1 unless y2 == map.height
      Pass_Mapper::make_pass_map(x1, y1, x2, y2)
      @full_map = Mapper::draw_map(x1, y1, x2, y2, id, vh, @full_map)
    end
    
    def draw_map_objects
      draw_player
      draw_vehicles_bitmap
    end
    
    def draw_player
      @player_bitmap = Bitmap.new(TILE_SIZE, TILE_SIZE)
      @player_bitmap.fill_rect(@player_bitmap.rect, player_color)
    end
    
    def draw_vehicles_bitmap
      @vehicles_bitmap = Bitmap.new(TILE_SIZE, TILE_SIZE)
      @vehicles_bitmap.fill_rect(@vehicles_bitmap.rect, vehicle_color)
      make_vehicles_list
    end
    
    def add_event(id, color)
      @events ||= Hash.new
      @events[id] = Bitmap.new(TILE_SIZE, TILE_SIZE)
      @events[id].fill_rect(@events[id].rect, color)
      @redo_events_flag = true
    end
    
# Get Event Color (called only externally) ================================  
    def get_event_color(event)#the comment tag reader
      return unless event.is_a?(Game_Event)
      return unless event.list
      ini = COMMENT_SCANER_INI - 1
      fin = COMMENT_SCANER_FIN
      for i in ini...fin do
        next unless event.list[i]
        if event.list[i].code == 108
          return event_color if event.list[i].parameters[0]=~/<minimap normal color>/
          return COLORS[$1.to_i] if event.list[i].parameters[0]=~/<minimap color (\d+)>/
        end
      end
      nil
    end
    
# Abjust Minimap (called only externally) =================================
    def adjust_minimap(viewport)
      #Abjust the viewport of the minimap holder.
      w = width; h = height
      x = player.x - w/2; y = player.y - h/2
      x = adjust_x(x) unless map.loop_horizontal?
      y = adjust_y(y) unless map.loop_vertical?
      viewport.ox = x * TILE_SIZE; viewport.oy = y * TILE_SIZE
    end  

# Method with uncategorized functionality ==================================
    def adjust_x(x)
      x += 1 until map.valid?(x, 0)
      x -= 1 until map.valid?(x + (width - 1), 0)
      x
    end
    
    def adjust_y(y)
      y += 1 until map.valid?(0, y) 
      y -= 1 until map.valid?(0, y + (height - 1))
      y
    end
    
    def map_list_add(*args)
      was_forbiden = map_forbiden?
      for map_id in args do
        @maps_list.push(map_id) unless @maps_list.include?(map_id)
      end
      see_and_set_if_map_forbiden
      set_refresh_flag if was_forbiden != map_forbiden? && !map_forbiden?
    end
    
    def map_list_drop(*args)
      was_forbiden = map_forbiden?
      for map_id in args do
        @maps_list.delete(map_id) 
      end
      see_and_set_if_map_forbiden
      set_refresh_flag if was_forbiden != map_forbiden? && !map_forbiden?
    end
    
    def add_vehicle(v_id)
      @vehicles << v_id unless @vehicles.include?(v_id)
      @redo_vehicles_flag = true
    end  
    
    def drop_vehicle(v_id)
      @vehicles.delete(v_id)
      @redo_vehicles_flag = true
    end  
    
    def drop_event(id)
      @events ||= Hash.new
      @events[id].dispose if @events[id]
      @events.delete(id)
      redo_events_flag = true
    end
    
    def make_vehicles_list
      @vehicles = Array.new
      map.vehicles.each_with_index do |v, i|
        next unless v.is_a?(Game_Vehicle)
        if v.map_id == map.map_id
          @vehicles << i
        end  
      end  
    end  

    def toggle_visibility
      return unless @timer == 0
      return if @map_forbiden
      sec_button = ENABLE_DISABLE_BUTTON2 
      return unless Input.press?(sec_button) unless sec_button.nil?
      if BUTTON_CONTROL_SWITCH > 0
        return unless $game_switches[BUTTON_CONTROL_SWITCH]
      end  
      self.enabled = !self.enabled 
      @timer = Graphics.frame_rate * BUTTON_SENSIBILITY
    end  
    
    def clear_update_data
      @redo_events_flag = false
      @redo_vehicles_flag = false
      @events_rfr.clear if @events_rfr
      @vehicles_rfr.clear if @vehicles_rfr
      @player_refresh = false
    end 
    
    #Used only for script call
    def clear_cache(*args)
      cache = GGZ_Mini_Cache
      for i in args do
        cache::delete_tables(i)
      end
      cache::clear_all_tables if args.empty?
    end  
    
    def clear_current_map_cache
      cache = GGZ_Mini_Cache
      cache::delete_tables(map.map_id) unless CACHE_MAPS.include?(map.map_id)
    end  
 
# Disposing In-Module graphical objects(done on player transfer) =======    
    def on_player_transfer
      @initialized = false
      @events.each_value do |e| e.dispose end
      if @full_map; @full_map.dispose end
      @full_map = nil
      @vehicles_bitmap.dispose
      @events.clear
      @vehicles.clear     
      clear_update_data
      clear_current_map_cache
    end
    
# DataManager Assistance ===============================================   
   def make_save_contents(contents)
     contents[:ggz_minimap_enabled1353]      = @enabled
     contents[:ggz_minimap_maps_list1353]    = @maps_list
     contents[:ggz_update_when_disabled1353] = @update_when_disabled
     contents[:ggz_maps_list_forbid1353]     = @maps_list_forbid
     contents
   end  
   
  def extract_save_contents(contents)
    e  = contents[:ggz_minimap_enabled1353]
    ml = contents[:ggz_minimap_maps_list1353]
    u  = contents[:ggz_update_when_disabled1353]
    mf  = contents[:ggz_maps_list_forbid1353]
    
    return on_new_game if  e.nil? || ml.nil? || u.nil? || mf.nil?
    self.enabled = e; @maps_list = ml
    @update_when_disabled = u; @maps_list_forbid = mf
    on_game_start
  end
    
# Update: called every frame ===========================================  
    def update
      @timer -= 1 if @timer > 0 if @timer
      create_map if @refresh_flag
    end  
    
  end #class self  
# ============================================================================
#                         Window_Minimap
# Instance of that class will be used to display the minimap.
# ============================================================================
  class Window_Minimap < Window_Base
    def initialize
      b = WINDOW_BORDER
      w = Minimap::width  * TILE_SIZE
      h = Minimap::height * TILE_SIZE
      super(0, 0, w + 2 * b, h + 2 * b)
      self.x = screen_x
      self.y = screen_y
      self.opacity = WINDOW_OPACITY
      self.z = Z
      self.back_opacity = WINDOW_BACK_OPACITY
      create_viewport(x + b, y + b, w, h)
      create_minimap_objects
      self.visible = false
    end 
    
    def create_minimap_objects
      create_minimap_plane
      z = 20
      PRIORITY_CHARACTERS.reverse.each do |c|
        case c
          when :player; create_player_sprite(z)
          when :events; create_events(z)
          when :vehicles; create_vehicles(z)
        end    
      z += 20  
      end  
    end
    
    def create_minimap_plane
      @minimap = Plane.new(@viewport)
      @minimap.bitmap = Minimap::full_map
      @minimap.opacity = OPACITY
      @minimap.visible = Minimap::enabled
      adjust_minimap
    end  
    
    def create_player_sprite(z)
      @player_z = z
      @player = Sprite.new(@viewport)
      @player.bitmap = Minimap::player_bitmap
      @player.x = $game_player.x * TILE_SIZE
      @player.y = $game_player.y * TILE_SIZE
      @player.z = @player_z
    end  
    
    def create_vehicles(z)
      @vehicles_z = z
      @vehicles = Hash.new
      Minimap::vehicles.each do |i|
        @vehicles[i] = Sprite.new(@viewport)
        @vehicles[i].bitmap = Minimap::vehicles_bitmap
        @vehicles[i].x = $game_map.vehicles[i].x * TILE_SIZE
        @vehicles[i].y = $game_map.vehicles[i].y * TILE_SIZE
        @vehicles[i].z = @vehicles_z
      end  
    end
    
    def create_events(z)
      @events_z = z
      @events = Hash.new
      return unless Minimap::events
      Minimap::events.each do |i, b|
        next unless $game_map.events[i].is_a?(Game_Event)
        @events[i] = Sprite.new(@viewport)
        @events[i].bitmap = b
        @events[i].x = $game_map.events[i].x * TILE_SIZE
        @events[i].y = $game_map.events[i].y * TILE_SIZE
        @events[i].z = @events_z
      end  
    end
    
    def redo_events
      @events.each_value do |e| e.dispose end
      @events.clear
      create_events(@events_z)
    end
    
    def redo_vehicles
      @vehicles.each_value do |v| v.dispose end
      @vehicles.clear
      create_vehicles(@vehicles_z)
    end  
    
    def update_objects
      redo_events if Minimap::redo_events_flag
      redo_vehicles if Minimap::redo_vehicles_flag
      move_player
      update_events
      update_vehicles
    end  
    
    def move_player
      return unless Minimap::refresh_player
      return unless @player.x / TILE_SIZE != $game_player.x || @player.y / TILE_SIZE != $game_player.y
      @player.x = $game_player.x * TILE_SIZE
      @player.y = $game_player.y * TILE_SIZE
      adjust_minimap
    end 
    
    def update_events
      create_events if @events.nil? && Minimap::events
      @events.each do |i, e|
        next unless Minimap::get_events_to_refresh[i]
        next if e.x == $game_map.events[i].x  * TILE_SIZE && e.y == $game_map.events[i].x  * TILE_SIZE
        e.x = $game_map.events[i].x * TILE_SIZE
        e.y = $game_map.events[i].y * TILE_SIZE
      end 
    end

    def update_vehicles
      Minimap::get_vehicles_to_refresh.each_key do |i|
        v = $game_map.vehicles[i]
        next unless v.is_a?(Game_Vehicle)
        if v.map_id == $game_map.map_id
          @vehicles[i].x = v.x * TILE_SIZE if @vehicles[i].x * TILE_SIZE != v.x 
          @vehicles[i].y = v.y * TILE_SIZE if @vehicles[i].y * TILE_SIZE != v.y
        end  
      end  
    end 

    def create_viewport(x, y, w, h)
      @viewport = Viewport.new(x, y, w, h)
      @viewport.visible = Minimap::enabled && Minimap::map_forbiden?
      @viewport.z = self.z + 1
    end
    
    def adjust_minimap
      return if !Minimap::enabled || Minimap::map_forbiden?
      Minimap::adjust_minimap(@viewport)
    end  
    
    def change_visiblity(map_alowed = true)
      self.visible  = Minimap::enabled && map_alowed
      @viewport.visible = Minimap::enabled && map_alowed
      @minimap.visible = Minimap::enabled && map_alowed
      #After load save file, minimap plane doesn't display
      #even if visible == true, unless is set to true
      #again. So far, having no idea why. Is on same viewport.
    end      
    
    def update #Called every frame
      if Minimap::map_forbiden?
        change_visiblity(false) if self.visible || @viewport.visible
      else
        @minimap.bitmap = Minimap::full_map if @minimap.bitmap != Minimap::full_map
        unless @viewport.visible == Minimap::enabled && @viewport.visible == self.visible
          change_visiblity
        end  
        update_objects if Minimap::enabled
      end
     @minimap.bitmap == Minimap::full_map if @minimap.bitmap != Minimap::full_map
    end  
    
    def dispose
      @minimap.dispose
      @player.dispose
      @events.each_value do |e|  e.dispose end
      @vehicles.each_value do |v| v.dispose end
      @viewport.dispose
      super
    end  
    
    def screen_x
      x = X
      x.is_a?(String) ? eval(x) : x
    end 
  
    def screen_y
      y = Y
      y.is_a?(String) ? eval(y) : y
    end 
    
  end #class Window_Minimap 
# ========================================================================
#                   module GGZ_Mini_Cache
# ========================================================================
# Used to store, delete, fetch and check Table objects, and check
# if certain map and vehicle keys have Table entry.
# That data is used so minimaps to be drawn faster, as long Table data is 
# available.
# ========================================================================
  module GGZ_Mini_Cache
    
    class << self
    
      def add_table(map_id, table) 
        @tables ||= Hash.new
        @tables[map_id] = table
      end
      
      def delete_tables(map_id)
        return unless @tables
        return unless @tables[map_id]
        @tables[map_id] = nil
      end
    
      def fetch_table(map_id)
        return unless @tables
        return @tables[map_id] if @tables[map_id]
      end  
      
      def table_available?(map_id)
        return false unless @tables
        @tables[map_id].nil? ? false : true
      end
      
      def clear_all_tables
        return unless @tables
        @tables.clear
      end  
      
    end
    
  end  #module GGZ_Mini_Cache

# =======================================================================
#                   module Pass Mapper
# =======================================================================
# Used to create passability data, although it also includes terrain tag, 
# region and damage floors coloring. Makes Table object @pass_map, that 
# will be stored in GGZ_Mini_Cache. Unlike the flags, this contains final
# passability data for every x and y, plus special colors data used for 
# regions, terrain tags and damage floor.
# =======================================================================
  module Pass_Mapper
    
    class << self
    
      def start(map_id)
        make_pass_map(0, 0, map.width, map.height)
      end  
      
      def make_pass_map(ini_x, ini_y, fin_x, fin_y)
        map_id = map.map_id
        @pass_map = cache::table_available?(map_id) ? 
                    cache::fetch_table(map_id) :
                    Table.new(map.width, map.height, 2)
    
        apply_passability(ini_x, ini_y, fin_x, fin_y)
        add_to_cache(map_id)
      end  
      
      def apply_passability(ini_x, ini_y, fin_x, fin_y)
        for x in ini_x...fin_x
          for y in ini_y...fin_y
            apply_color(x, y)
          end
        end
      end  
      
      def add_to_cache(map_id)
        cache::add_table(map_id, @pass_map)
      end  
    
      def apply_color(x, y)
        color_bit = nil
        PRIORITY_TILES.each do |object|
          break if apply_tiles_color(x, y, object)
        end
        if  @pass_map[x, y, 1] == 0
          @pass_map[x, y, 0] = set_passage_color(x, y)          
        end  
      end
      
      def apply_tiles_color(x, y, object)
        color_id = case object
          when :region
            REGIONS[map.region_id(x, y)] if REGIONS[map.region_id(x, y)]
          when :terrain_tag
            TERRAIN_TAGS[map.terrain_tag(x, y)] if TERRAIN_TAGS[map.terrain_tag(x, y)]
          when :damage_floor
            6 if map.damage_floor?(x, y)
        end 
        return false if color_id.nil?
        @pass_map[x, y, 1] = color_id
        true
      end
      
      def set_passage_color(x, y)
        pass = 0; vpass = 0x0600
        map.all_tiles(x, y).each do |tile_id|
          flag = map.tileset.flags[tile_id]
          next if (flag & 0x010) != 0
          vpass &= flag; pass |= flag & 0x0f
          vpass |= 0x0800 if pass == 0 && (flag & 0x0800 == 0)
          return (vpass >> 5) | pass
        end
      end  
      
      def cache; GGZ_Mini_Cache end
      def map; $game_map        end
      def player; $game_player  end
        
    end #class self 
    
  end #Pass_Mapper
  
# ==========================================================================
#                        Module Mapper
# ==========================================================================
# Used to do the actual minimap drawing. It interprets the passability table
# objects, created by my other module and produces a bitmap.
# ==========================================================================
 module Mapper
    
    class << self
      
      def on_game_start
        create_bitmaps
        create_party_passable_bitmaps
      end  
      
      def draw_map(ini_x, ini_y, fin_x, fin_y, map_id, vehicle_type, btm = nil)
        full_map = btm.nil? ? Bitmap.new(map.width * TILE_SIZE, map.height * TILE_SIZE) :
                               btm
        table = GGZ_Mini_Cache.fetch_table(map_id)
        return unless table
        for x in ini_x...fin_x
          for y in ini_y...fin_y
            if table[x, y, 1] == 0
              bitmap_id = interpret_passage(x, y, table[x, y, 0], vehicle_type)
              bitmap = @bitmaps_pp[bitmap_id]
            else
              bitmap = @bitmaps[table[x, y, 1]]
            end  
            full_map.blt(x * TILE_SIZE, y * TILE_SIZE, bitmap, bitmap.rect)
          end
        end
        return full_map
      end  
      
      def interpret_passage(x, y, bit, vehicle_type)
        return case vehicle_type
          when :boat;    water_passable(x, y, bit, 0x010)
          when :ship;    water_passable(x, y, bit, 0x020)
          when :airship; air_land(x, y, bit, 0x040) 
          else;          bit & 0x0f
        end
      end
      
      def water_passable(x, y, bit, bit_2)
        (bit & bit_2) != bit_2 ? 0 : 0x0f
      end  
      
      def air_land(x, y, bit, bit_2)
        (bit & bit_2) == bit_2 ? 0 : 0x0f
      end  
      
      def create_bitmaps
        @bitmaps = Hash.new
        COLORS.each do |k , c|
          b = Bitmap.new(TILE_SIZE, TILE_SIZE)
          b.fill_rect(b.rect, c)
          @bitmaps[k] = b
        end
      end 
    
      def create_party_passable_bitmaps
        @bitmaps_pp = Hash.new
        @bitmaps_pp[0] = @bitmaps[1]
        @bitmaps_pp[15] = @bitmaps[2]
        for i in 1..14
          b = Bitmap.new(TILE_SIZE, TILE_SIZE)
          b.fill_rect(b.rect, COLORS[1])        
          set_unpasable_2(b) if i & 0x01 != 0
          set_unpasable_4(b) if i & 0x04 != 0
          set_unpasable_6(b) if i & 0x02 != 0
          set_unpasable_8(b) if i & 0x08 != 0
          @bitmaps_pp[i] = b
        end  
      end  
      
      def set_unpasable_2(bitmap)
        height = (TILE_SIZE/3).ceil
        rect = Rect.new(0, TILE_SIZE - height, TILE_SIZE, height)
        bitmap.fill_rect(rect, COLORS[2])
      end

      def set_unpasable_4(bitmap)
        width = (TILE_SIZE/3).ceil
        rect = Rect.new(TILE_SIZE - width, 0, width , TILE_SIZE)
        bitmap.fill_rect(rect, COLORS[2])
      end 
  
      def set_unpasable_6(bitmap)
        width = (TILE_SIZE/3).ceil
        rect = Rect.new(0, 0, width , TILE_SIZE)
        bitmap.fill_rect(rect, COLORS[2])
      end 
  
      def set_unpasable_8(bitmap)
        height = (TILE_SIZE/3).ceil
        rect = Rect.new(0, 0, TILE_SIZE, height)
        bitmap.fill_rect(rect, COLORS[2])
      end
      
      def map;                $game_map    end
      def player;             $game_player end 
        
    end #class self

  end #module Mapper
  
end  #module Minimap
# =======================================================================
#   Adjusting Engine methods bellow, so they work with my minimap.
# =======================================================================
# =======================================================================
#                          class Scene _Map
# Adjusting it so it holds an instance of Minimap::Window, and properly 
# update it.
# =======================================================================
class Scene_Map < Scene_Base
  
  alias_method :ggz_start_old1353,         :start
  alias_method :ggz_update_old1353,        :update
  alias_method :ggz_pre_transfer_old1353,  :pre_transfer
  alias_method :ggz_post_transfer_old1353, :post_transfer
  
  def start(*args)
    ggz_start_old1353(*args)
    ggz_create_minimap1353
  end 
  
  def ggz_create_minimap1353
    Minimap::initialize
    @minimap = Minimap::Window_Minimap.new
  end
  
  def update(*args)
    m = Minimap; m::update
    ggz_update_old1353(*args)
    m::toggle_visibility if Input.press?(m::ENABLE_DISABLE_BUTTON)
  end  
  
  def pre_transfer(*args)
    ggz_pre_transfer_old1353(*args)
    if $game_player.new_map_id != $game_map.map_id
      m = Minimap; @minimap.dispose; m::on_player_transfer
    end  
  end
  
  def post_transfer(*args)
    @minimap.disposed? ? ggz_create_minimap1353 : Minimap::update
    ggz_post_transfer_old1353(*args)
  end
  
  def terminate
    super
    SceneManager.snapshot_for_background
    dispose_spriteset
    perform_battle_transition if SceneManager.scene_is?(Scene_Battle)
  end  
  
end
# ========================================================================
#                  class Game Player
# ========================================================================
# Adjusting it so my minimap reacts when player get on or off of vehicle.
# Making new attribute reader as well.
# ========================================================================
class Game_Player < Game_Character
  
  alias_method :ggzupdate_vehicle_get_on_old1353,  :update_vehicle_get_on
  alias_method :ggzupdate_vehicle_get_off_old1353, :update_vehicle_get_off
  
  attr_reader :new_map_id, :vehicle_type
  
  def update_vehicle_get_on(*args)
    if !@followers.gathering? && !moving?
      Minimap::set_refresh_flag
    end 
    ggzupdate_vehicle_get_on_old1353(*args)
  end
  
  def update_vehicle_get_off(*args)
    if !@followers.gathering? && vehicle.altitude == 0
      Minimap::set_refresh_flag
    end
    ggzupdate_vehicle_get_off_old1353(*args)
  end  
  
end 
# =========================================================================
#                  class Game CharacterBase
# ========================================================================
# Adjusting it so my minimap reacts on characters movements, and set 
# positions. Adding one new method.
# =========================================================================
class Game_CharacterBase
  
  alias_method :ggzmove_straightold1353, :move_straight
  alias_method :ggzmove_diagonalold1353, :move_diagonal
  alias_method :ggzmovetoold1353,        :moveto

  
  def move_straight(*args)
    x1 = @x; y1 = @y
    ggzmove_straightold1353(*args)
    x2 = @x; y2 = @y
    ggz_minimap_add_to_minimap1353(x1, x2, y1, y2)  
  end
  
  def move_diagonal(*args)
    x1 = @x; y1 = @y
    ggzmove_diagonalold1353(*args)
    x2 = @x; y2 = @y
    ggz_minimap_add_to_minimap1353(x1, x2, y1, y2)
  end
  
  def moveto(*args)
    x1 = @x; y1 = @y
    ggzmovetoold1353(*args)
    x2 = @x; y2 = @y
    ggz_minimap_add_to_minimap1353(x1, x2, y1, y2)
  end
  
# New Method =======================================================
  def ggz_minimap_add_to_minimap1353(x1, x2, y1, y2)
    m = Minimap
    return unless m::initialized
    if (x1 != x2 || y1 != y2) 
      m::set_event_to_refresh(id) if self.is_a?(Game_Event) && m::events[id]
      m::refresh_player = true if self.is_a?(Game_Player)
    end 
  end  
  
end
# ========================================================================
#                        class Game Character
# ========================================================================
# Adjusting it so minimap reacts on characters jump.
# ========================================================================
class Game_Character < Game_CharacterBase
  
  alias_method :ggzjumpold1353, :jump
  
  def jump(*args)
    x1 = @x; y1 = @y
    ggzjumpold1353(*args)
    x2 = @x; y2 = @y
    ggz_minimap_add_to_minimap1353(x1, x2, y1, y2)
  end
  
end  
# ========================================================================
#                         class Game Vehicle
# ========================================================================
# Adds a attribute reader for @type and @map_id  property.
# Check if vehicle is set to new location. Support to synch with player
# in minimap too. Adds a method to get the vehicle id from the map vehicles
# array.
# ========================================================================
class Game_Vehicle < Game_Character
  
  alias_method :ggz_set_location_old1353,     :set_location
  alias_method :ggz_sync_with_player_old1353, :sync_with_player
  attr_reader  :type, :map_id 
  
  def set_location(*args)
    m_id1 = @map_id; x1 = @x; y1 = y
    ggz_set_location_old1353(*args)
    m = Minimap
    return unless m::initialized
    m_id2 = @map_id; x2 = @x; y2 = y; map_id = $game_map.map_id
    m::add_vehicle(ggz_get_id1353)  if m_id1 != map_id && m_id2 == map_id
    m::drop_vehicle(ggz_get_id1353) if m_id1 == map_id && m_id2 != map_id
    if (x1 != x2 || y1 != y2 || m_id1 != m_id2)
      m::set_vehicle_to_refresh(id)
    end  
  end
  
  def ggz_get_id1353
    $game_map.vehicles.each_with_index do |vehicle, i|
      return @ggz_vehicle_id = i if self == vehicle
    end  
  end  
  
  def sync_with_player(*args)
    m_id1 = @map_id; x1 = @x; y1 = y
    ggz_sync_with_player_old1353(*args)
    m_id2 = @map_id; x2 = @x; y2 = y
    if (x1 != x2 || y1 != y2 || m_id1 != m_id2)
      ggz_get_id1353 if @ggz_vehicle_id.nil?
      Minimap::set_vehicle_to_refresh(@ggz_vehicle_id)
    end  
  end

end  
# ========================================================================
#                        class Game Event
# ========================================================================
# Adjusting it so it upon refresh will set its id and color, if event
# is to be drawn on minimap.
# ========================================================================
class Game_Event < Game_Character
    
  alias_method :ggzrefreshold1353, :refresh
  
  def refresh(*args)
    ggzrefreshold1353(*args)
    color = Minimap::get_event_color(self)
    Minimap::drop_event(id)
    Minimap::add_event(id, color) unless color.nil?
  end
  
end
# ========================================================================
#                       class Data Manager
# ========================================================================
# Adjusting it so it work with my save data, and do my objects 
# initialisation on new game.
# ========================================================================
module DataManager
  
  class << self
    alias_method :ggzsetup_new_gameold1353,        :setup_new_game
    alias_method :ggzmake_save_contentsold1353,    :make_save_contents
    alias_method :ggzextract_save_contentsold1353, :extract_save_contents
  end

  def self.setup_new_game(*args)
    ggzsetup_new_gameold1353(*args)
    Minimap::on_new_game
  end
  
  def self.make_save_contents(*args)
    contents = ggzmake_save_contentsold1353(*args)
    Minimap::make_save_contents(contents)
  end
  
  def self.extract_save_contents(*args)
    ggzextract_save_contentsold1353(*args)
    Minimap::extract_save_contents(args[0])
  end
  
end
# =========================================================================
#                          class Game Map
# =========================================================================
# Adjusting it so it clears the objects track data from the
# previous scene iteration.
# =========================================================================

class Game_Map
  
  alias_method :ggzupdateold1353, :update
  
  def update(*args)
    Minimap::clear_update_data
    ggzupdateold1353(*args)
  end  
  
end
# =========================================================================
#                              END OF FILE
# =========================================================================
