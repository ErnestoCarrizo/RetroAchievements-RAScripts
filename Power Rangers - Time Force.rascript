// Power Rangers - Time Force
// #ID = 10424

// $00C597: Game State/ Screen ID:
//          0x01 = Main Menu
//          0x02 = Gameplay
//          0x03 = Dimensional Space
//          0x04 = Password
//          0x05 = Options
//          0x06 = Continue Screen
//          0x07 = Select Ranger
//          0x09 = Megazord Battle
//          0x0a = Megazord Select
//          0x0b = Stage Clear
//          0x0c = Vortex Blaster Minigame
//          0x0d = Title Screen
//          0x0f = Mission Info
//          0x10 = Boss Explosion
//          0x11 = Megazord Boss Explosion
//          0x13 = Copyright / Developers Info
//          0x14 = Animation Intro
//          0x17 = Game Intro
function State() => byte(0x00C597)

// $00C5F5: Options Difficulty:
//          0x00 = Easy
//          0x01 = Normal
//          0x02 = Hard
function Difficulty() => byte(0x00C5F5)
DifficultyLookUp = {
    0x00: "Easy",
    0x01: "Normal",
    0x02: "Hard"
}

// $00C5F6: Level ID:
//          0x01 = Silver Hills
//          0x02 = Underwater Base
//          0x03 = Jungle
//          0x04 = Fabled City (Present Day)
//          0x05 = Fabled City (In The Future)
//          0x06 = Fabled City (In The Past)
//          0x09 = Energy Plant (In The Future)
//          0x0a = Castle (In The Past)
//          0x0b = Secret Base (Present Day)
function LevelID() => byte(0x00C5F6)
Levels = {
    0x01: "Silver Hills",
    0x02: "Underwater Base",
    0x03: "Jungle",
    0x04: "Fabled City (Present Day)",
    0x05: "Fabled City (In The Future)",
    0x06: "Fabled City (In The Past)",
    0x09: "Energy Plant (In The Future)",
    0x0a: "Castle (In The Past)",
    0x0b: "Secret Base (Present Day)"
}
// $00C5FB: Chapter
function Chapter() => byte(0x00C5FB)

// $00C5FE: Extra Vortex Blaster Shoots
function ExtraShoots() => byte(0x00C5FE)

// $00C5FF: Flag: Vortex Blaster Shoot Taken
function ShootTaken() => byte(0x00C5FF)

// $012000: Megazord ID:
//          0x00 = Red Mode
//          0x01 = Blue Mode
//          0x02 = Shadow Force Megazord Red Mode
//          0x03 = Shadow Force Megazord Blue Mode
function ZordID() => byte(0x012000)

// $012002: Losses in Megazord Battle
//          0x03 = Shadow Force Megazord Unlocked
function LossesZord() => byte(0x012002)

function NormalOrLess() => Difficulty() <= 0x01

function ProgressAchievements(diff,stage,point){
    if(diff<2)
        achievement(
            title = Levels[stage],
            description = "Complete " + Levels[stage] + " Level (on " + DifficultyLookUp[diff] + " or less)",
            points = point,
            trigger = LevelID() == stage && NormalOrLess() && (prev(State()) == 0x10 || prev(State()) == 0x11) && State() == 0x0b)
    else
        achievement(
            title = Levels[stage] + " Hard",
            description = "Complete " + Levels[stage] + " Level (on " + DifficultyLookUp[diff] + ")",
            points = point,
            trigger = LevelID() == stage && !NormalOrLess() && (prev(State()) == 0x10 || prev(State()) == 0x11) && State() == 0x0b)
}


function CollectablesAchievements(stage){
    achievement(
        title = "Vortex Collector " + Levels[stage],
        description = "Collect Both Extra Vortex Shoots in " + Levels[stage] + " Level",
        points = 2,
        trigger = State() == 0x02 && LevelID() == stage && (prev(ExtraShoots()) + prev(ShootTaken()) == 0x01) && (ExtraShoots() + ShootTaken() == 0x02)
    )
}



for i in Levels{
    ProgressAchievements(1,i,3)
    ProgressAchievements(2,i,4)
    CollectablesAchievements(i)
}



achievement("Reinforment","Unlock Shadow Force Megazords",1,prev(State()) == 0x06 && State() == 0x0a && LossesZord() == 0x03)

















