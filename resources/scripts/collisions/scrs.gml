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
