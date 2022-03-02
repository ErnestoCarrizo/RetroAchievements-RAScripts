// Tokyo Xtreme Racer
// #ID = 10836

// $0709BC: Screen ID:
//          0x01 = Main Menu
//          0x02 = Quest Menu
//          0x03 = Garage
//          0x04 = Tuning
//          0x0a = Rivals
//          0x0f = Quick Race
//          0x10 = Select Route
//          0x22 = Playing
function InGameplay() => byte(0x0709BC)

// $156B11: Game Mode:
//          0x00 = Quck Mode
//          0x01 = Vs. Mode
//          0x02 = Quest Mode
//          0x03 = Practice
//          0x04 = Options
function Mode() => byte(0x156B11)


function Active() => InGameplay() == 0x22 && Mode() == 0x02

Rivals = {"Rolling Guy":bit0(0x1528d0),
          "Curving Edge":bit4(0x1528d0),
          "SS Limited":bit1(0x1528d1),
          "Elegant Wild":bit7(0x1528d1),
          "Max Racing":bit5(0x1528d2),
          "Diamond Image":bit5(0x1528d3),
          "Fine Drive":bit3(0x1528d4),
          "Twister":bit3(0x1528d5),
          "R.Gangs":bit1(0x1528d6),
          "Tokio Jungle":bit0(0x1528d7),
          "Top Level":bit7(0x1528d7),
          "Free Way":bit5(0x1528d8),
          "Another Star":bit6(0x1528d9),
          "Speed Box":bit3(0x1528da),
          "TR Racing":bit1(0x1528db),
          "Cupid Arrows":bit7(0x1528db),
          "Wind Stars":bit5(0x1528dc),
          "R.R.":bit6(0x1528dd),
          "Rings":bit6(0x1528de),
          "Speed Master":bit4(0x1528df),
          }
          
Bosses = {"Grim Reaper":bit5(0x1528e0),
          "Midnight Cinderella":bit6(0x1528e0),
          "Nocturnal Wolf":bit7(0x1528e0),
          "Banshee":bit0(0x1528e1),
          "Raven Blood":bit1(0x1528e1),
          "Exhaust Eve":bit2(0x1528e1),
          "ZERO":bit3(0x1528e1),
          "???":bit4(0x1528e1)}
            
         
function LeadersAchievements(team){
    
    achievement(
    title = team,
    description = "Defeat " + team + " Leader",
    points = 5,
    trigger = Active() && prev(Rivals[team]) < Rivals[team] 
    ) 
}


for i in Rivals{
    LeadersAchievements(i)
}



function BossesAchievements(boss){
    
    if(boss != "???"){
    achievement(
    title = boss,
    description = "Defeat " + boss,
    points = 10,
    trigger = Active() && prev(Bosses[boss]) < Bosses[boss] 
    )}
    else{
    achievement(
    title = boss,
    description = "Defeat " + boss,
    points = 25,
    trigger = Active() && prev(Bosses[boss]) < Bosses[boss]
    )}
}


for i in Bosses{
    BossesAchievements(i)
}














