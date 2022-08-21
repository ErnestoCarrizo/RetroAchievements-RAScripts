// Crackout
// #ID = 4861

// $0020: Game State:
//        0x01 = Game Title
//        0x02 = Demo Mode
//        0x03 = Title Screen Music
//        0x04 = Main Menu
//        0x05 = Gameplay
//        0x06 = Game Over Screen
//        0x08 = Staff
//        0x09 = Break Up System
//        0x0a = Cast
function GameState() => byte(0x000020)
TITLE = 0x01
DEMO = 0x02
MENU = 0x04
GAMEPLAY = 0x05
GAMEOVER = 0x06
STAFF = 0x08
CAST = 0x0a

// $0037: Sub Zone ID
//        0x14 = Last Stage of Cubic and Mirror Zone
//        0x0a = Last Stage of Tube and Final Zone
function SubZone() => byte(0x000037)

// $0038: Zone ID
//        0x00 = Cubic Zone
//        0x01 = Mirror Zone
//        0x02 = Tube Zone
//        0x03 = Final Zone
//        0x04 = Credits
function Zone() => byte(0x000038)

CUBIC = 0x00
MIRROR = 0x01
TUBE = 0x02
FINAL = 0x03


Zones = {CUBIC: "Cubic",
         MIRROR: "Mirror",
         TUBE: "Tube",
         FINAL: "Final"}
         
// $0039: Player Lives
function Lives() => byte(0x000039)

// $003A: Gameplay State:
//        0x00 - 0x02 = Loading
//        0x03 - 0x04 = Loading Blocks
//        0x05 = Playing
//        0x06 = Level Completed Normaly
//        0x07 - 0x0a = Transition to Next Level
//        0x0b = Level Completed by Power-Up
//        0x0c = Area Screen
function GameplayState() => byte(0x00003A)

function BossLife1() => byte(0x00004f4)
function BossLife2() => byte(0x00004f5)
function PlayerLife() => byte(0x00004d0)

// $0480: Power Up
//        0x00 = None
//        0x01 = Double Ball
//        0x02 = Scatter Mines
//        0x03 = Slowdown Doll
//        0x04 = Heavy Ball
//        0x05 = Paddle Extender
//        0x06 = Stopwatch
//        0x07 = Remote Missiles
function PowerUp() => byte(0x000480)

function BlocksLeft() => byte(0x0000059)

function CheckEnemiesFirst() => (BossLife1() == 0x00 && prev(BossLife1()) == 0x0c && BossLife2() == 0x00 && prior(BossLife2()) == 0x0c) 
|| (BossLife2() == 0x00 && prev(BossLife2()) == 0x0c && BossLife1() == 0x00 && prior(BossLife1()) == 0x0c)

function CheckDamageless() => PlayerLife() == 0x00 && trigger_when(BossLife1() == 0x00) && trigger_when(GameplayState() == 0x0c) && trigger_when(prev(GameplayState()) == 0x06)

function PickAllPowerUps() {
    powerups = []
    for i in range(0,7){
       array_push(powerups, once(PowerUp() == i))
    }
    array_push(powerups, once(GameplayState() == 0x0b))
    array_push(powerups, always_false())
    return measured(tally(9,powerups))
}

// $07E4: [24-Bits] BCD Score
function GetScore() => lower4(0x07e4)*10 + high4(0x07e4)*100 + lower4(0x07e5)*1000 + high4(0x07e5)*10000 + lower4(0x07e6)*100000 + high4(0x07e6)*1000000

function AntiPass(zone) => once(Zone() == zone && GameState() == GAMEPLAY && SubZone() == 0x00)

function ZoneAchievement(zone) { 
                                achievement(title = Zones[zone] + " Zone",
                                description = "Complete " + Zones[zone] + " Zone",
                                points = 10,
                                trigger = AntiPass(zone) && never(GameState() == TITLE) && prev(Zone()) == zone && Zone() == zone + 1
                                )
                               }

function ZoneAchievementNoContinues(zone) { 
                                achievement(title = Zones[zone] + " Zone" + " Master",
                                description = "Complete " + Zones[zone] + " Zone" + " Without Using Continues",
                                points = 25,
                                trigger = AntiPass(zone) && never(GameState() == TITLE || GameState() == GAMEOVER) && prev(Zone()) == zone && trigger_when(Zone() == zone + 1)
                                )
                               }

for key in Zones {
                  ZoneAchievement(key)
                  ZoneAchievementNoContinues(key)     
                 }
  
achievement(title = "Arkanoid Knowledgest",
            description = "Break the High Score of the game",
            points = 5,
            trigger = GameState() == GAMEPLAY && high4(0x07e5) == 1 && prev(high4(0x07e5)) == 0x00
            )

achievement(title = "Rectangular Bomber",
            description = "Collect all power-ups",
            points = 5,
            trigger = unless(GameState() == DEMO) && GameState() == GAMEPLAY && PickAllPowerUps()
            )

achievement(title = "Pest Exterminator",
            description = "Defeat the Final Zone boss without taking damage",
            points = 5,
            trigger = CheckDamageless() && Zone() == FINAL && trigger_when(SubZone() == 0x00) && trigger_when(prev(SubZone()) == 0x0a))

achievement(title = "Moai Bait",
            description = "Defeat the Mirror Zone boss without taking damage",
            points = 5,
            trigger = CheckDamageless() && Zone() == MIRROR && trigger_when(SubZone() == 0x00) && trigger_when(prev(SubZone()) == 0x0a))

achievement(title = "Save the Frames",
            description = "In Level 1-06 in Cubic Zone, Defeat the enemies before destroying all the blocks",
            points = 5,
            trigger = Zone() == CUBIC && SubZone() == 0x0f && CheckEnemiesFirst() && BlocksLeft() > 0x00)


