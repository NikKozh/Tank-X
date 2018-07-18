#define move_smooth_init
/**
* move_smooth_init(precision)
* Initializes the variables needed for the move_smooth_step script
* Higher precision means smoother motion, but also extra processing
* Increasing the value of course yields diminishing utility, so don't get carried away ;)
* NOTE: This script must be called for EACH INSTANCE using the engine
*/

var spr_w, spr_h;

precision = argument0;

dir_inc = 360 / precision;
spr_w = sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index);
spr_h = sprite_get_bbox_right(sprite_index)-sprite_get_bbox_left(sprite_index);
max_dist = min(spr_w,spr_h);
loops2 = floor((precision+3)/4);
#define move_smooth_step
// move_smooth(speed,direction)
// I think you can guess what this does ;-)
// Note that only solids count as obstacles for the purposes of this script

var spe, dir;

spe = argument0;
dir = argument1;

if spe != 0 {
 loops1 = ceil(abs(spe)/max_dist);
 repeat (loops1) {
  xold = x;
  yold = y;
  new_spe = min(spe,max_dist);
  spe -= new_spe;
  for (i2 = 0; i2 < loops2; i2 += 1) {
   dir_offset = i2*dir_inc;
   new_spe2 = new_spe;
   new_spe2 *= 1 - (dir_offset/90); // Slow down when set off course
   dir1 = dir + dir_offset;
   xtar1 = x + lengthdir_x(new_spe2,dir1);
   ytar1 = y + lengthdir_y(new_spe2,dir1);
   if i2 > 0 {
    dir2 = direction - dir_offset;
    xtar2 = x + lengthdir_x(new_spe2,dir2);
    ytar2 = y + lengthdir_y(new_spe2,dir2);
   }
   if place_free(xtar1,ytar1) {
    x = xtar1;
    y = ytar1;
    break;
   }
   else if i2 > 0 {
    if place_free(xtar2,ytar2) {
     x = xtar2;
     y = ytar2;
     break;
    }
   }
  }
 }
}
#define scr_shadows
//draws the shadow of objects
var height;

height=argument0 //how close the shadow is to the object

depth-=1 //makes sure the 
draw_sprite_ext(sprite_index,image_single,x+height,y+height,image_xscale+(height/25),image_yscale+(height/25),image_angle,c_black,self.image_alpha - 0.7)
depth+=1
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,self.image_alpha)



#define scr_EnCreator
/*
Скрипт, выполняющий создание врагов. Облегчает работу и оптимизирует код.
 argument0 = Название объекта необходимого врага
Пример: scr_EnCreator( Enemy0 )
*/

E_Smoke_Xrnd = random( room_width )
E_Smoke_Yrnd = random( room_height )
part_emitter_region( smoke2, emit1, E_Smoke_Xrnd, E_Smoke_Xrnd + 20-random(40), E_Smoke_Yrnd, E_Smoke_Yrnd + 20-random(40), ps_shape_ellipse, ps_distr_gaussian);
sound_play( snd_Create_EP )
part_emitter_burst( smoke2, emit1, prt, 80 )

if argument0 = Enemy0
 then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 ) 
else begin

 if argument0 = Enemy1_wh
  then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 )
 else begin

  if argument0 = Enemy2_wh
   then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 )
  else begin
  
   if argument0 = Enemy3_wh
    then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 )
   else begin
   
    if argument0 = Enemy_Tank then
      begin
       instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, Enemy_Tank )
       instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, Enemy_Turret )
      end
    else show_error( "Возникла ошибка при создании объекта!", false )
    
end
 end
  end
   end
#define scr_BonCreator
E_Smoke_Xrnd = argument1
E_Smoke_Yrnd = argument2
sound_play( snd_Create_B )
effect_create_above( ef_explosion, E_Smoke_Xrnd, E_Smoke_Yrnd, 3, c_navy )

if argument0 = Shield
 then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 ) 
else begin

 if argument0 = Health_Kit
  then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 )
 else begin

  if argument0 = SA
   then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 )
  else begin
  
   if argument0 = Life
    then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 )
   else begin
   
    if argument0 = Speed
     then instance_create( E_Smoke_Xrnd, E_Smoke_Yrnd, argument0 )
    else show_error( "Возникла ошибка при создании бонуса!", false )
    
end
 end
  end
   end
#define random_range
/* Данный скрипт возвращает случайное число в диапазоне между
двух указанных аргументов. */

if argument1 > argument0 then return random( argument1 - argument0 ) + argument0
if argument1 < argument0 then return random( argument0 - argument1 ) + argument1
#define scr_PlayerKeys
/*Отключает управление игрока, вплоть до мыши.  argument0 = true\false, вкл.\выкл. управление */M = argument0if M = false then begin global.PlayerDie = 10 Turret.mouse = false cursor.sprite_index = spr_Cur_Menu endif M = true then begin global.PlayerDie = 0 Turret.mouse = true cursor.sprite_index = spr_Cur_Fight end 
