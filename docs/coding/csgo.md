## 控制台下一些常用命令

### 准星

```
cl_crosshairdot 设置准星中间有点没点， 0 是没点 1 是有点
cl_crosshairsize 设置准星的大小
cl_crosshairgap 设置准星中心的大小
cl_crosshairthickness 设置准星线条的粗细
```

### 跑图

```
mp_autoteambalance 0 关掉自动平衡
mp_limitteams 0 关掉最大队伍人数
mp_humanteam any 可以加入任何一方

// Server config
sv_cheats 1

mp_roundtime 60
mp_roundtime_defuse 60
mp_maxmoney 60000
mp_startmoney 60000
mp_freezetime 0
mp_buytime 9999
mp_buy_anywhere 1
sv_infinite_ammo 1
ammo_grenade_limit_total 5
bot_kickmp_warmup_endmp_randomspawn 0
bot_difficulty 4
// Practicesv_grenade_trajectory 1
sv_grenade_trajectory_time 10
sv_showimpacts 1
sv_showimpacts_time 1
mp_restartgame 1
```

### 网络

```
cl_showfps 1 //显示当前fps值
net_graph 1 //显示当前fps、ping值、loss、choke、tick
```

### 快捷键

```
bind "v" "use weapon_knife;use weapon_flashbang" //无缝切闪
alias "+dj" "+duck;+jump"
alias "-dj" "-jump;-duck"
bind "x" "+dj" //一键蹲跳
bind "shift" "+speed;r_cleardecals" //静步清除血迹
bind "n" "toggle cl_crosshairsize 1000 2.5"//切换准星

```

### MyConfig

```
cl_crosshair_drawoutline "0"
cl_crosshair_dynamic_maxdist_splitratio "0.35"
cl_crosshair_dynamic_splitalpha_innermod "1"
cl_crosshair_dynamic_splitalpha_outermod "0.5"
cl_crosshair_dynamic_splitdist "7"
cl_crosshair_friendly_warning "1"
cl_crosshair_outlinethickness "0.5"
cl_crosshair_sniper_show_normal_inaccuracy "0"
cl_crosshair_sniper_width "1"
cl_crosshair_t "0"
cl_crosshairalpha "255"
cl_crosshaircolor "5"
cl_crosshaircolor_b "0"
cl_crosshaircolor_g "0"
cl_crosshaircolor_r "0"
cl_crosshairdot "1"
cl_crosshairgap "-10.500000"
cl_crosshairgap_useweaponvalue "0"
cl_crosshairscale "0"
cl_crosshairsize "1000"
cl_crosshairstyle "4"
cl_crosshairthickness "0"
cl_crosshairusealpha "1"
cl_fixedcrosshairgap "2.000000"
cl_viewmodel_shift_left_amt "0.5"
cl_viewmodel_shift_right_amt "0.25"
viewmodel_fov "60"
viewmodel_offset_x "1"
viewmodel_offset_y "1"
viewmodel_offset_z "-1"
viewmodel_presetpos "1"
viewmodel_recoil "0"
cl_bob_lower_amt "12"
cl_bobamt_lat "0.10"
cl_bobamt_vert "0.10"
cl_bobcycle "0.98"
cl_hud_background_alpha "1.00"
cl_hud_bomb_under_radar "1"
cl_hud_color "1"
cl_hud_healthammo_style "1"
cl_hud_playercount_pos "0"
cl_hud_playercount_showcount "1"
cl_hud_radar_scale "1.3"
hud_scaling "0.750000"
hud_showtargetid "1"
cl_righthand "1"
cl_color "4"
cl_radar_always_centered "1"
cl_radar_icon_scale_min "0.4"
cl_radar_rotate "1"
cl_radar_scale "0.350000"
cl_radar_square_with_scoreboard "1"


```
