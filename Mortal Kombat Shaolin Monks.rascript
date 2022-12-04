// Mortal Kombat: Shaolin Monks
// #ID = 19201

function bios_current_executable() => dword(0x015510)

function game_state() => dword(0x5E1650)

gs_main_menu = 0x08
gs_gameplay = 0x0a
end_game = 0x13
credits = 0x14

function player_life_upgrades() => byte(0xC29760)

function p1_special_move_square() => byte(0xC29844)

function p1_special_move_triangle() => byte(0xC29845)

function p1_special_move_circle() => byte(0xC29846)

function p1_special_move_r2() => byte(0xC29847)

function p1_combo1_unlocked() => byte(0xC29851)

function p1_combo2_unlocked() => byte(0xC29852)

function p1_combo3_unlocked() => byte(0xC29853)

function p1_combo4_unlocked() => byte(0xC29854)

function p1_combo5_unlocked() => byte(0xC29855)

function game_save_data_ascii() => dword(0xc29684)

function is_main_game() => never(bios_current_executable() != 0x53554c53) 

function is_singleplayer() => is_main_game() && game_save_data_ascii() != 0x6f2d6f4b

function in_game() => game_state() == gs_gameplay

function end_game() => game_state() == end_game

function game_time() => dword(0xC29680)

function game_fatalities_count() => dword(0x5C3C98)

function p1_animation() => dword(0x5e6b64)

function p1_char() => dword(0xC2974C)

function unlockables_mk2() => byte(0x5D82B0)

function game_current_area() => dword(0xC29748)

function unlockables_scorpion() => byte(0x5D82B8)

function unlockables_subzero() => byte(0x5D82B4)

//Utilities

liu_kang_fatalities = {
0x14e: "Shaolin Soccer",
0x150: "Bonebreak Combo", 
0x156: "Fire Kick Combo", 
0x158: "Flipping Uppercut", 
0x15A: "Dragon",
0x154: "Giant Stomp", 
0x152: "Head Clap",
0x15c: "Arm Rip"
}

kung_lao_fatalities = {
0x1f0: "Body Slice",
0x1f2: "Mid Air Slice",
0x1f7: "Friendly Rabit",
0x1f9: "Arm Cutter",
0x1fb: "Head Toss",
0x1ff: "Many Chops",
0x201: "Headache",
0x203: "Buzzsaw",
0x1fd: "Unfriendly Rabbit"
}

sub_zero_fatalities = {
0xa5f: "Spine Rip",
0xa61: "Snowball",
0xa63: "Freeze Uppercut"
}

scorpion_fatalities = {
0x853: "Flame",
0x855: "Spear Slice"
}
function check_event_update(area_id, event_id) {
    trigger = always_false()
    events_array_start = 0xc2a070
    for i in range(0, 1499) {
        current_area = events_array_start + (i * 8)
        current_event = current_area + 4
        trigger =   trigger ||
                    dword(current_area) == area_id &&
                    dword(current_event) == event_id &&
                    prev(dword(current_area)) == 0
    }
    return trigger
}

function achiev_event(title, description, area_id, event_id, points, cheevo_id) {

    achievement(title, description, points,
                trigger =   is_singleplayer() && 
                            in_game() &&
                            check_event_update(area_id, event_id)
                )
}

function check_no_upgrades() => player_life_upgrades() < 0x02 && p1_special_move_square() == 0x01 && p1_special_move_triangle() == 0x01 && p1_special_move_circle() == 0x01 && p1_special_move_r2() == 0x01
                                && p1_combo1_unlocked() == 0x00 && p1_combo2_unlocked() == 0x00 && p1_combo3_unlocked() == 0x00 && p1_combo4_unlocked() == 0x00 && p1_combo5_unlocked() == 0x00
                                
function check_all_upgrades(total) =>  p1_special_move_square() + p1_special_move_triangle() + p1_special_move_circle() + p1_special_move_r2() + p1_combo1_unlocked() + p1_combo2_unlocked() + p1_combo3_unlocked()
                                         + p1_combo4_unlocked() + p1_combo5_unlocked() == total && prev(p1_special_move_square() + p1_special_move_square() + p1_special_move_circle() + p1_special_move_r2() 
                                         + p1_combo1_unlocked() + p1_combo2_unlocked() + p1_combo3_unlocked()+ p1_combo4_unlocked() + p1_combo5_unlocked()) == total-1  

char_upgrades = {
"Liu Kang":0x15,
"Kung Lao":0x15,
"Sub-Zero":0x0e,
"Scorpion":0x11
}       

characters = {
"Liu Kang": 0x00,
"Kung Lao": 0x01,
"Scorpion": 0x52,
"Sub-Zero": 0x58
}                     

//Challenges Achievements
//(0x49, 0x04) -> Shang Tsung Defeated
//(0x49, 0x05) -> Kintaro Defeated
//(0x49, 0x06) -> Shao Khan Defeated

achievement(title = "Proof of Minimalism",
            description = "Beat the game without obtaining more than one health upgrade, and no ability upgrades.",
            points = 25,
            trigger = is_singleplayer() && end_game() && check_no_upgrades() && prev(game_state()) == gs_gameplay)

//01:40:00:00 at 60 fps is 360000 frames     
achievement(title = "Proof of Speed",
            description = "Beat the game within 1h40m in-game time.",
            points = 50,
            trigger = is_singleplayer() && end_game() && prev(game_state()) == gs_gameplay && game_time() <= 0x57e40)

//Misc
//Fatalities
           
achievement(title = "Healthy Monk",
            description = "Obtain all health upgrades.",
            points = 10,
            trigger = is_singleplayer() && in_game() && player_life_upgrades() == 0x04 && prev(player_life_upgrades()) == 0x03)

achievement(title = "Fatal Monk",
            description = "Perform 25 Fatalities.",
            points = 10,
            trigger = is_singleplayer() && in_game() && game_fatalities_count() == 0x19 && prev(game_fatalities_count()) == 0x18)

for fatalitie in liu_kang_fatalities {
    achievement(title = liu_kang_fatalities[fatalitie], 
                description = "Liu Kang: Perform " + liu_kang_fatalities[fatalitie] + " Fatality.", 
                points = 3,
                trigger = is_singleplayer() && in_game() && p1_animation() == fatalitie
                )
}

for fatalitie in kung_lao_fatalities {
    achievement(title = kung_lao_fatalities[fatalitie], 
                description = "Kung Lao: Perform " + kung_lao_fatalities[fatalitie] + " Fatality.", 
                points = 3,
                trigger = is_singleplayer() && in_game() && p1_animation() == fatalitie
                )
}

for fatalitie in sub_zero_fatalities {
    achievement(title = sub_zero_fatalities[fatalitie], 
                description = "Sub-Zero: Perform " + sub_zero_fatalities[fatalitie] + " Fatality.", 
                points = 3,
                trigger = is_singleplayer() && in_game() && p1_animation() == fatalitie
                )
}

for fatalitie in scorpion_fatalities {
    achievement(title = scorpion_fatalities[fatalitie], 
                description = "Scorpion: Perform " + scorpion_fatalities[fatalitie] + " Fatality.", 
                points = 3,
                trigger = is_singleplayer() && in_game() && p1_animation() == fatalitie
                )
}

//Multalities
achievement(title = "Dragons Fury",
            description = "Liu Kang: Perform Dragons Fury Multality.",
            points = 3,
            trigger = is_singleplayer() && in_game() && p1_animation() == 0x161
            )

achievement(title = "Hat Control",
            description = "Kung Lao: Perform Hat Control Multality.",
            points = 3,
            trigger = is_singleplayer() && in_game() && p1_animation() == 0x1f6
            )

//Upgrades

achievement(title = "Dragon Master",
           description = "Liu Kang: Unlock all move upgrades.",
           points = 10,
           trigger = is_singleplayer() && in_game() && check_all_upgrades(char_upgrades["Liu Kang"]) && p1_char() == characters["Liu Kang"]
)

achievement(title = "Shaolin Master",
           description = "Kung Lao: Unlock all move upgrades.",
           points = 10,
           trigger = is_singleplayer() && in_game() && check_all_upgrades(char_upgrades["Kung Lao"]) && p1_char() == characters["Kung Lao"]
)

achievement(title = "Lin Kuei Master",
           description = "Sub-Zero: Unlock all move upgrades.",
           points = 10,
           trigger = is_singleplayer() && in_game() && check_all_upgrades(char_upgrades["Sub-Zero"]) && p1_char() == characters["Sub-Zero"]
)

achievement(title = "Shirai Ryu Master",
           description = "Scorpion: Unlock all move upgrades.",
           points = 10,
           trigger = is_singleplayer() && in_game() && check_all_upgrades(char_upgrades["Scorpion"]) && p1_char() == characters["Scorpion"]
)

//Unlockables

achievement(title = "Only Smoke Knows How To Play MK2",
            description = "Unlock MKII.",
            points = 10,
            trigger = is_singleplayer() && in_game() && unlockables_mk2() == 0x01 && prev(unlockables_mk2()) == 0x00 && game_current_area() == 0x92
)

achievement(title = "Can You See the Invisible Penguin?",
            description = "Unlock Scorpion for Story Mode.",
            points = 10,
            trigger = is_singleplayer() && game_state() == credits && unlockables_scorpion() == 0x01 && prev(unlockables_scorpion()) == 0x00
)

achievement(title = "Sometimes Your Enemy Is Your Friend",
            description = "Unlock Sub-Zero for Story Mode.",
            points = 10,
            trigger = is_singleplayer() && game_state() == credits && unlockables_subzero() == 0x01 && prev(unlockables_subzero()) == 0x00
)