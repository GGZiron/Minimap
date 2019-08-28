($imported ||= {})[:GGZiron_Minimap] = '1.0.0'

module Minimap

=begin

  Script Name: Minimap
  Author: GGZiron
  Engine: RPG Maker VX Ace
  Terms: Free for non comercial projects. Sending me a copy of your game 
  would be apreciated, but is not mandatory.
  For comercial projects, I request free copy or activation code 
  for the game. 
  Must be credited as GGZiron in both comercial and uncomercial projects.
  Not allowed to repost, only allowed to post link to this script tread in
  RPG maker forum.
  Allowed to edit, and allowed to post your edit, but together with link to this
  script tread in RPG Maker forums. Not the case if the very post is within
  the tread of this script in RPG Maker forums.
  Terms are subject of change. The valid terms for you are the ones active
  during your project release. Need this so I add one or another type
  of license, if I see the need for it.
  I very much doubt to make drastic changes on them, if any, but still be 
  adviced to check them during release of your project.
  Version: 1.0.0
  
  Script Purpose: Adds Minimap on the Scene Map, to be used for navigation.
  Compitability: Check it yourself, for your project :).
  
  How easy to install?: From medium to hard, dependings how much of the settings
  you plan to change. Even if none, you gotta place comment tags for events,
  if you want them drawn on minimap, and check the toogle option with button, 
  as the probability to like the default is not too high, especially if you
  love to dash in debug through during playtest.
  
  Warning!! As that is my initial version, you might want me to patch it a 
  little before including that into your project. Currently, recomended only
  for preview purpose. Still, you can include it in your project, if you see
  no issues. Just be sure to check for updates :).
  
  Version digits explanation: 
  The digit before first dot is counter for very major changes.
  So say, I remove all code and do it again, then would increase it with one.
  Otherwise, will stay 1 forever.
  Digit after first dot counts the number of updates, that add new features.
  They could add fixes as well, but they need to add new feature.
  Digit after second dot counts the bug fixes, compitability patches or small 
  optimisation after last feature adding update, or after initial version.
  Version 1.0.7 would mean I did 7 times bug fixes or code improvements after
  release, but no new feature added.
  Version 1.11.1 means I added 11 times new features, and then did one bug
  fix, compitability patch or code optimisation. That number does not bring
  information how many fixes and optimisation I had in previous versions,
  for that you got to see the Version History.
  
  Version History:
   Version 1.0.0 Realeased on: 28/08/2019
   That is the initial version. 
  
  Made this script with the idea to be as compitable as possible. Also made
  it to be as processor sparing as possible. This said, that does not mean 
  I achieve those, only highlighting I did some efforts about it.
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
 
  This said, there are script calls that would completely redraw entire map,
  or selected rectangle from it. They would be useful only if you know what
  actions my minimap doesn't respond to, and if that doesn't happen too often.
  The script draws bitmap with the whole map, but the part that fit within
  the window viewport will have the size you set in settings.
  That bitmap is redrawn when player changes vehicle, or visit new map, or
  on script calls, which I provide bellow.
  
  Good example for when you would need to redraw manually the map is, if the 
  player recieve swimming ability by another script, and you want the new 
  passability to be reflected on my minimap. Player having through passage flag 
  would not reflect on my minimap, nor it refelcts how events are drawn. 
  If they have the page comment tag, they will be drawn, and if they don't, 
  they won't.
  It checks only for events that have minimap color.
  If minimap is not visible, then is not updated at all. It would be updated
  ocne is visible.
  
  Features:
    *Kinda simplificstic minimap, but not simple on features.
    *Draws passable area. 
    *Draws unpassable area.
    *Option to set or unset buttons for toogling minimap visibility.
    *Draws partly passable as passable, but then draw unpassable line on the 
     edge of the tile. You will see what I mean if you test ledders, walls
     with walkable upper floor, ladders, bridges and so on.
    *Draws events, but not by default. You need to put comments with certain
     formation, similar like in the notetags. Also, while there is default color
     for the events characters, you can set to use different one, to make
     characters standing out of the crowd(quest NPC, point of special interest).
    *Option to draw regions and terrain tags too.
    *Draws damage floor.
    *Updates player and event movement on straight move, diagonal move, jump,
     set position.
    *Redraws passage map on changing vehicle, according the new passability.
     For example, riding boat will turn all water tiles as passable, and all
     ground as unpassable. Region and terrain tag, sane as damage floor 
     remain unchanged.
     When using airship, will draw the land ok tiles, instead passable tiles.
     Otherwise riding airship means to have one color minimap, with no tiles
     within, as airship can pass through everything. This said, region and 
     terrain tag tiles remain even on airship.
    *Option to change the character object priority. Priority is used so if
     two objects are within same tile, it will draw the color of the one with
     higher priority. Objects are: player, events, damage floor, region,
     terrain_tag, vehicle. When two events share a tile, it will draw the one
     with higher id number.
    *Configurable minimap size; transparency; x, y and z coordinates.
    *Reacts on loop maps, as then the minimap loops too.
     The x and y coordinates are the coordinate of the upper left corner.
    *Option to determine how deep to look in event commands for the needed
     comment tags. In ideal case, should be setted to look only the top one
     comment, but if there is other script requiring comments to be on top,
     then you can set to look for second command or third and so on.
     Merging same comment to have many tags for the different scripts is option
     too.
=end

# ============================================================================
#                        General Options
# ============================================================================
  
  ENABLED_AT_BEGINNING = true
  #Map will be visible with game start. There is script call to change
  #that at anytime.  
  
  COMMENT_SCANER_INI = 1
  #Will start scanning from very first event command for match value
  COMMENT_SCANER_FIN = 2 #Set to one, if you want to check only top comment.
  #Will end scanning after third event command.
  #Keep in mind, some event commands get more slots, and even though sometimes
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
  #When second button enabled, it need to be pressed at same time with first.
  #Turn second button to nil, to disable. Then will need only first button.
  #Button don't actually need to be pressed at same time, you can hold one,
  #then press the other.
  #Notice: Only nil value disables second button. Setting to false would entirely
  #disable button minimap toogle visibility 
  
  BUTTON_CONTROL_SWITCH = 0
  #Set to Switch Id from the Event Editor. When that switch is on, player will
  #be able to turn on and off the minimap. When is off, it will be not.
  #Keep value as zero, if you do not intent to change in game the player
  #acess to toogle button
  #In game chance of access to toogle button would be useful, if you have
  #cut scene, and don't want the player to be able to toogle minimap, or
  #simply the player didn't unlocked the minimap yet.
  BUTTON_SENSIBILITY = 0.4 
  #It will wait 0.4 seconds before the button work again.
  #You can set to lesser value or higher value.
  #As seen from default value, the provided value can be decimal.
  #When decimal, the actual time could vary with fragment of the second.

  UPDATE_WHEN_DISSABLED = true #default is true
  #By default, minimap will update even when disabled.
  #You can set it to false, so is not updated when disabled, and that might 
  #somehow improve the performance, but will also need to completely
  #redraw the minimap, when enabled again. So, it has it's downside too.

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

# ===========================================================================
#                        Visual Options
# ===========================================================================

  TILE_SIZE = 6 #The width and the height in pixels of every minimap tile.
  WIDTH = 35
  #Minimap's width. How many tiles per line. Multiplying that value to
  #TILE_SIZE would give the screen width in pixel(add few more for the window
  #border, and you get the total window width)
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
  Z = 2 #The z coordinate of the window, that will contain the minimap.

  OPACITY = 200 #The minimap's opacity. Valid range: 0 - 255.
  WINDOW_BORDER = 5
  #Used to know how much space it will need for the Window Border. On default
  #Window.png file, that is 5 pixels(or at least, I think so), but if you use
  #different one, you should abjust the value so the minimap fit to your border.
  #It have somewhat padding functionality too, if value incresed above actual 
  #border size.
  #Does not define Window Border size!
  
  WINDOW_BACK_OPACITY = 255 #Set between 0 and 255

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
  PRIORITY =[
            :player, :events, :vehicle, :region, :terrain_tag, :damage_floor
            ]
  #Removed entry would not display on the minimap, ever(unless there is some
  #sort modification to my script).
  #This said, no comment tags would make event to appear, if you remove it from
  #this array.
  #That array determines the priority of map objects, if two share
  #same cell. Those who are first are with higher priority.
  #This said, player would be with highest priority, and damage floor
  #with lowest. Passability colors are bellow everything, that's why
  #they are not in the array. Just doesn't make sence they to be above
  #something, otherwise that something would never display.

  REGIONS = { #Do not edit this line
# Entry format:
# region_id => COLORS[color_key],
# Example entry:
#   50 => COLORS[7], #Region 50 will get white color.
# Te active entries should not be commented (no # in the beginning of the line).
# Add your entries:
    

  }#Do not touch, do not add entries bellow this line.

# ==========================================================================
  TERRAIN_TAGS = { #Do not edit this line
# Entry format:
# terrain_tag_id => COLORS[color_key],
# Example entry:
#   7 => COLORS[7], #All tiles with terrain tag 7 will be colored in white.
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
  The first one enables it, the second one dissables it.

  If you need to redraw minimap entirely, because it happens something that
  my minimap didn't react on, you can use this script call:
  
  Minimap::draw_map
  Redraws entire map
  
  Minimap::set_refresh_flag
  Same as above, but is done on the next Minimap update.
  
  While redrawing whole map does the best job, is somewhat costly process.
  How costly? With purpose of testing, I did tried what happen if script
  redraws map every frame. Frame rate fell to 3. That how costly it is.
  
  If you need only to redraw just certain area, you can use this
  script call:
  Minimap::redraw_area(x1, y1, x2, y2)
  Doing that, the script will redraw only tiles between x1 and x2,
  and  tiles between y1 and y2 (An rectangle area).
  The coordinate x2 can be same as x1, and y2 can be same as y1, so to redraw 
  only one tile. Coordinates x1 and y1 must be same or smaller value than x2
  and y2, otherwise it will the redraw request will be ignored.
  
  Possible good reason to redraw: Other script changed the tile data, or 
  changed passability, and my minimap doesn't seem to react on that. 
  Then together with the other script call, use mine to update the minimap. 
  If you need to do that very often though, then you better request for 
  compitability patch. And if doesn't work well with engines' build-in 
  functions, then you can file it as bug, which would get higher priority than 
  compitability patch.
 
=end
# ============================================================================
#                         The rest of the script bellow.
# ============================================================================
# Do not edit bellow, unless you are a brave knight from the order of the
# Scripters, or one of the scripting legends they sing songs about.
# Defiling that rule would anger the gods, and would lead to great calamities 
# upon your world. You have been warned :)
# ============================================================================
  class << self 
    attr_reader :player_x, :player_y, :enabled
    
# Initialize ===============================================================    
    
    def initialize
      @timer = 0
      @rect = Rect.new(0, 0, TILE_SIZE, TILE_SIZE)
      create_map
    end  
# Setters ==================================================================    
    
    def enabled=(bool)
      @enabled = bool
      draw_map if bool && @full_map && $game_map && $game_player unless UPDATE_WHEN_DISSABLED
    end  
    
    def set_refresh_flag
      @refresh_flag = true
    end
  
    def set_event_to_refresh(id, x1, x2, y1, y2)
      @events ||= Hash.new
      @events[id] = {:x1 => x1, :x2 => x2, :y1 => y1,:y2 => y2}
    end
    
    def set_events_to_trace(id, color)
      @events_trc ||= Hash.new
      @events_trc[id] = color
    end  
  
    def set_tiles_to_refresh(x, y)
      @refr_tiles ||= Array.new
      @refr_tiles << {:x => x, :y => y}
    end  
    
# Getters ==================================================================    
    def get_events_to_refresh
      @events ||= Hash.new
      return @events
    end
  
    def get_events_to_trace
      @events_trc ||= Hash.new
      return @events_trc
    end
        
    def width
      return WIDTH  if $game_map.loop_horizontal?
      WIDTH < $game_map.width ? WIDTH : $game_map.width
    end 
  
    def height
      return HEIGHT  if $game_map.loop_vertical?
      HEIGHT < $game_map.height ? HEIGHT : $game_map.height
    end 
    
    def passable_color;     COLORS[1] end  
    def unpasable_color;    COLORS[2] end  
    def player_color;       COLORS[3] end
    def event_color;        COLORS[4] end
    def vehicle_color;      COLORS[5] end
    def damage_floor_color; COLORS[6] end
    def full_map;           @full_map end
      
# External objects getters ==============================================
    def map; $game_map end
      
      
# Check value ===========================================================
    def vehicles?(x, y)
      map = $game_map
      $game_map.boat.pos_nt?(x, y) || $game_map.ship.pos_nt?(x, y) || $game_map.airship.pos_nt?(x, y)
    end
  
    def events?(x, y)
      $game_map.events_xy(x, y).any? do |event|
        event.normal_priority? || self.is_a?(Game_Event)
      end
    end
    
# Draw methods ==========================================================

    def create_map
      return unless map
      @full_map = Bitmap.new(map.width * TILE_SIZE, map.height * TILE_SIZE)
      draw_map
    end
    
    def draw_map(ini_x = 0, ini_y = 0, fin_x = $game_map.width, fin_y = $game_map.height)
      clear_update_data
      @player_x = $game_player.x
      @player_y = $game_player.y
      for x in ini_x..fin_x
        for y in ini_y..fin_y
          @rect.x = x * TILE_SIZE; @rect.y = y * TILE_SIZE
          color = determine_color(x, y)
          @full_map.fill_rect(@rect, color)
          do_procs #Apply partly pasable tiles.
        end
      end
      @refresh_flag = false
    end  

    def redraw_area(x1 = 0, y1 = 0, x2 = width, y2 = height)
      return unless map
      return unless map.valid?(x1, y1) && map.valid?(x2, y2)
      return unless x1 <= x2 && y1 <= y2
      draw_map(x1, y1, x2, y2)
    end
    
    def redraw_player
      redraw_tile(@player_x, @player_y)
      @player_x = $game_player.x; @player_y = $game_player.y;
      redraw_tile(@player_x, @player_y)
    end 
  
    def redraw_event(id)
      cords = get_events_to_refresh.delete(id)
      redraw_tile(cords[:x1], cords[:y1])
      redraw_tile(cords[:x2], cords[:y2])
    end 
  
   def redraw_tile(x, y)
      @rect.x = x * TILE_SIZE; @rect.y = y * TILE_SIZE
      color = determine_color(x, y)
      @full_map.fill_rect(@rect, color) if color
      do_procs
    end  
    
    def do_procs #Used to apply partly pasable tiles.
      return unless @procs
      @procs.each do |proc|
        proc.call
      end
      @procs = nil
    end
    
# Color calculating methods =============================================    
    
    def determine_color(x, y)
      color = nil
      PRIORITY.each do |object|
        color = determine_color_with_priority(x, y, object)
        break if color
      end
      color = set_passage_color(x, y) unless color
      color
    end
  
    def determine_color_with_priority(x, y, object)
      return case object
        when :player
          player_color if x == $game_player.x && y == $game_player.y
        when :events
          event = map.events_xy(x, y).to_a.reverse.find {|event| event.is_a?(Game_Event) }
          return unless event
          return @events_trc[event.id]
        when :vehicle
          vehicle_color if Minimap::vehicles?(x, y)
        when :region
          REGIONS[map.region_id(x, y)] if REGIONS[map.region_id(x, y)]
        when :terrain_tag
          TERRAIN_TAGS[map.terrain_tag(x, y)] if TERRAIN_TAGS[map.terrain_tag(x, y)]
        when :damage_floor
          damage_floor_color if map.damage_floor?(x, y)
      end   
    end  
    
    def set_passage_color(x, y)
      vehicle = $game_player.vehicle
      if vehicle 
        vehicle = $game_player.vehicle
        if vehicle.type == :boat || vehicle.type == :ship
          return water_passage(x, y)
        end
        if vehicle.type == :airship
          return airship_landing(x, y)
        end  
      end  
      walking_passage(x, y) 
    end  
    
    def get_event_color(event)
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
      return nil
    end
    
    def set_unpasable_2(x, y)
      height = (TILE_SIZE/3).ceil
      rect = Rect.new(x * TILE_SIZE, (y + 1)* TILE_SIZE - height, TILE_SIZE, height)
      @full_map.fill_rect(rect, unpasable_color)
    end

    def set_unpasable_4(x, y)
      width = (TILE_SIZE/3).ceil
      rect = Rect.new((x + 1) * TILE_SIZE - width, y * TILE_SIZE, width , TILE_SIZE)
      @full_map.fill_rect(rect, unpasable_color)
    end 
  
    def set_unpasable_6(x, y)
      width = (TILE_SIZE/3).ceil
      rect = Rect.new(x * TILE_SIZE, y * TILE_SIZE, width , TILE_SIZE)
      @full_map.fill_rect(rect, unpasable_color)
    end 
  
    def set_unpasable_8(x, y)
      height = (TILE_SIZE/3).ceil
      rect = Rect.new(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, height)
     @full_map.fill_rect(rect, unpasable_color)
    end
    
# Color calculating methods: Passage Calcultors =========================
    def water_passage(x, y)
      $game_player.map_passable?(x, y, 2) ? passable_color  : unpasable_color
      #Player have boat or ship vehicle, and water have no directional
      #passage, which is why is enough to check one(any valid) direction.
    end  
    
    def airship_landing(x, y)
      $game_map.airship_land_ok?(x, y) ? passable_color  : unpasable_color
    end
    
    def walking_passage(x, y)
      pass = false; @procs = Array.new
      for dir in (2..8).step(2) do
        if $game_player.map_passable?(x, y, dir)
          pass = true
        else
          @procs << Proc.new do set_unpasable_2(x, y) end if dir == 2
          @procs << Proc.new do set_unpasable_4(x, y) end if dir == 6
          @procs << Proc.new do set_unpasable_6(x, y) end if dir == 4
          @procs << Proc.new do set_unpasable_8(x, y) end if dir == 8
        end
      end
      unless pass
        @procs = nil #No passage, procs for partly passable tiles are not needed.
        return unpasable_color
      end
      passable_color 
    end  

# Abjust Minimap (called only externally) =================================
    
    def abjust_minimap(plane) #parameter must be Plane object
      #Abjust a minimap holder, Plane object.
      return if $game_map.width <= WIDTH && $game_map.height <= HEIGHT
      w = width; h = height
      x = @player_x - w/2; y = @player_y - h/2
      x = abjust_x(x, w) unless $game_map.loop_horizontal?
      y = abjust_y(y, h) unless $game_map.loop_vertical?
      plane.ox = x * TILE_SIZE; plane.oy = y * TILE_SIZE
    end  
    
# Method with uncategorized functionality ==================================

    def abjust_x(x, w)
      x += 1 until $game_map.valid?(x, 0)
      x -= 1 until $game_map.valid?(x + (w - 1), 0)
      x
    end
    
    def abjust_y(y, h)
      y += 1 until $game_map.valid?(0, y) 
      y -= 1 until $game_map.valid?(0, y + (h - 1))
      y
    end 

    def toogle_visibility
      return unless @timer
      return unless @timer == 0
      sec_button = ENABLE_DISABLE_BUTTON2 
      return unless Input.press?(sec_button) unless sec_button.nil?
      if BUTTON_CONTROL_SWITCH > 0
        return unless $game_switches[BUTTON_CONTROL_SWITCH]
      end  
      self.enabled = !self.enabled
      @timer = Graphics.frame_rate * BUTTON_SENSIBILITY
    end  
    
    def clear_update_data
      @events.clear if @events
      @refr_tiles.clear if @refr_tiles
    end 
 
# Disposing In Module graphical objects(done on player transfer) =======    
    def dispose
      @events_trc.clear
      @full_map.dispose
    end  
# Update: called every frame ===========================================  
    def update
      @timer -= 1 if @timer > 0 if @timer
      return unless @enabled || UPDATE_WHEN_DISSABLED
      return draw_map if @refresh_flag
      get_events_to_trace.each do |id, color|
        next unless id
        next unless map.events[id].is_a?(Game_Event)
        next unless map.events_xy(map.events[id].x, map.events[id].y)
        redraw_event(id) if Minimap::get_events_to_refresh[id]
      end
      if @refr_tiles
        @refr_tiles.each do |tile|
          redraw_tile(tile[:x], tile[:y])
        end
        @@refr_tiles = nil
      end
      redraw_player if @player_x != $game_player.x || @player_y != $game_player.y
    end  
    
  end #class self  
# ============================================================================
#                         Window_Minimap
# Instance of that class will be used to display the minimap.
# ============================================================================
  class Window_Minimap < Window_Base
    def initialize
      b = Minimap::WINDOW_BORDER
      w = Minimap::width  * Minimap::TILE_SIZE
      h = Minimap::height * Minimap::TILE_SIZE
      super(0, 0, w + 2 * b, h + 2 * b)
      self.x = screen_x
      self.y = screen_y
      self.opacity = Minimap::OPACITY
      self.z = Minimap::Z
      self.back_opacity = WINDOW_BACK_OPACITY
      self.padding = 0
      create_viewport(x + b, y + b, w, h)
      @minimap = Plane.new(@viewport)
      @minimap.bitmap = Minimap::full_map
      @minimap.opacity = Minimap::OPACITY
      @minimap.visible = Minimap::enabled
      self.visible = Minimap::enabled
      @player_x = 0; @player_y = 0
    end    

    def create_viewport(x, y, w, h)
      @viewport = Viewport.new(x, y, w, h)
      @viewport.z = self.z + 1
    end
    
    def abjust_minimap
      Minimap::abjust_minimap(@minimap)
      @player_x = Minimap::player_x
      @player_y = Minimap::player_y
    end  
    
    def change_visiblity
      self.visible     = Minimap::enabled
      @minimap.visible = Minimap::enabled
    end  
    
    def update #Called Every frame
      change_visiblity unless self.visible == Minimap::enabled
      abjust_minimap if @player_x != Minimap::player_x || @player_y != Minimap::player_y
    end  
    
    def dispose
      @minimap.bitmap.dispose
      @minimap.dispose
      @viewport.dispose
      super
    end  
    
    def screen_x
      x = Minimap::X
      x.is_a?(String) ? eval(x) : x
    end 
  
    def screen_y
      y = Minimap::Y
      y.is_a?(String) ? eval(y) : y
    end 
    
  end #class Window_Minimap 
  
end  #module Minimap

# =======================================================================
#   Abjusting Engine methods bellow, so they work with my minimap.
# =======================================================================
# =======================================================================
#                          class Scene _Map
# Abjusting it so it holds an instance of Minimap::Window, and properly 
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
    ggz_update_old1353(*args)
    m = Minimap; m::update
    m::toogle_visibility if Input.press?(m::ENABLE_DISABLE_BUTTON)
  end  
  
  def pre_transfer(*args)
    ggz_pre_transfer_old1353(*args)
    @minimap.dispose
    Minimap::dispose
  end
  
  def post_transfer(*args)
    ggz_create_minimap1353 
    ggz_post_transfer_old1353(*args)
  end
  
end
# ========================================================================
#                  class Game Player
# Abjusting it so my minimap reacts when player get on or off of vehicle.
# ========================================================================
class Game_Player < Game_Character
  
  alias_method :ggzupdate_vehicle_get_on_old1353, :update_vehicle_get_on
  alias_method :ggzupdate_vehicle_get_off_old1353, :update_vehicle_get_off
  
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
# Abjusting it so my minimap reacts on characters movements, and set positions.
# =========================================================================
class Game_CharacterBase
  
  alias_method :ggzmove_straightold1353, :move_straight
  alias_method :ggzmove_diagonalold1353, :move_diagonal
  alias_method :ggzmovetoold1353, :moveto
  
  def move_straight(*args)
    x1 = @x; y1 = @y
    ggzmove_straightold1353(*args)
    x2 = @x; y2 = @y
    if (x1 != x2 || y1 != y2) && id != 0 && Minimap::get_events_to_trace[id]
      Minimap::set_event_to_refresh(id, x1, x2, y1, y2)
    end  
  end
  
  def move_diagonal(*args)
    x1 = @x; y1 = @y
    ggzmove_diagonalold1353(*args)
    x2 = @x; y2 = @y
    if (x1 != x2 || y1 !=y2) && id != 0 && Minimap::get_events_to_trace[id]
      Minimap::set_event_to_refresh(id, x1, x2, y1, y2)
    end  
  end
  
  def moveto(*args)
    x1 = @x; y1 = @y
    ggzmovetoold1353(*args)
    x2 = @x; y2 = @y
    if (x1 != x2 || y1 !=y2) && id != 0 && Minimap::get_events_to_trace[id]
      Minimap::set_event_to_refresh(id, x1, x2, y1, y2)
    end  
  end
  
end
# ========================================================================
#                class Game Character
# Abjusting it so minimap reacts on characters jump.
# ========================================================================
class Game_Character < Game_CharacterBase
  
  alias_method :ggzjumpold1353, :jump
  
  def jump(*args)
    x1 = @x; y1 = @y
    ggzjumpold1353(*args)
    x2 = @x; y2 = @y
    if (x1 != x2 || y1 !=y2) && id != 0 && Minimap::get_events_to_trace[id]
      Minimap::set_event_to_refresh(id, x1, x2, y1, y2)
    end  
  end
  
end  
# ========================================================================
#               class Game Vehicle
# Adds a reader for @type property.
# ========================================================================
class Game_Vehicle < Game_Character
  
  attr_reader :type
  
end  
# ========================================================================
#              class Game Event
# Abjusting it so it upon refresh will set its id and color, if event
# is to be drawn on minimap.
# ========================================================================
class Game_Event < Game_Character
    
  alias_method :ggzrefreshold1353, :refresh
  
  def refresh(*args)
    ggzrefreshold1353(*args)
    color = Minimap::get_event_color(self)
    Minimap::get_events_to_trace.delete(id)
    Minimap::set_events_to_trace(id, color) if color
    Minimap::set_tiles_to_refresh(@x, @y)
  end
  
end
# ========================================================================
#              class Data Manager
# Abjusting it so the initial minimap visibility is initialized, and 
# current minimap visibility is saved and extracted .
# ========================================================================

module DataManager
  
  class << self
    alias_method :ggzsetup_new_gameold1353,        :setup_new_game
    alias_method :ggzmake_save_contentsold1353,    :make_save_contents
    alias_method :ggzextract_save_contentsold1353, :extract_save_contents
  end

  def self.setup_new_game(*args)
    ggzsetup_new_gameold1353(*args)
    Minimap::enabled = Minimap::ENABLED_AT_BEGINNING
  end
  
  
  def self.make_save_contents(*args)
    contents = ggzmake_save_contentsold1353(*args)
    contents[:ggz_minimap_enabled1353] = Minimap::enabled
    contents
  end
  
  def self.extract_save_contents(*args)
    ggzextract_save_contentsold1353(*args)
    enabled = args[0][:ggz_minimap_enabled1353]
    Minimap::enabled = enabled.nil? ? true : enabled
  end
  
end
# =========================================================================
#                              END OF FILE
# =========================================================================
