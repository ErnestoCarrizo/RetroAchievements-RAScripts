// Mortal Kombat Gold
// #ID = 6366

function CharacterID() => byte(0x3162B4)

CharacterDic = {0x00: "Scorpion",
                0x01: "Raiden",
                0x02: "Sonya",
                0x03: "Liu Kang",
                0x04: "Sub-Zero",
                0x05: "Fujin",
                0x06: "Shinnok",
                0x07: "Reiko",
                0x08: "Quan Chi",
                0x09: "Tanya",
                0x0a: "Reptile",
                0x0b: "Kai",
                0x0c: "Jarek",
                0x0d: "Jax",
                0x0e: "Johnny Cage",
                0x0f: "Goro",
                0x10: "Kitana",
                0x11: "Noob Saibot",
                0x12: "Baraka",
                0x13: "Mileena",
                0x14: "Cyrax",
                0x15: "Kung Lao",
                0x16: "Sektor"}

function MenuScreen() => byte(0x336298)

function TowerDiff() => byte(0x324734)

function CombatFlag() => byte(0x316238)

function Mode2on2flag() => byte(0x21f044)

function ModeEnduranceflag() => byte(0x3377a8)

function ModeTournamentflag() => byte(0x3377c0)

function ModePracticeflag() => byte(0x3377a4)

function P1RoundsWinned() => byte(0x31626c)

function RoundResult() => byte(0x31622c)

function TowerPosition() => byte(0x3249d4)

function OptionsRoundsToWin() => byte(0x3369a0)

function CPUon() => byte(0x3361a0) == 0x00

function Difficulty() => byte(0x316204)

DiffDic = {0x00: "Very Easy",
           0x01: "Easy",
           0x02: "Medium",
           0x03: "Hard",
           0x04: "Very Hard",
           0x05: "Ultimate"}
           
function TowerDifficulty() => byte(0x324734)

TowerDiffDic = {0x00: "Novice",
                0x01: "Beginner",
                0x02: "Warrior",
                0x03: "Master",
                0x04: "Master II"}
                
function AltsArcadeMode() => tally(6,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x00 
                             && trigger_when(OptionsRoundsToWin() == P1RoundsWinned()) && trigger_when(prev(P1RoundsWinned()) < OptionsRoundsToWin())|| 
                             tally(7,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x01 
                             && trigger_when(OptionsRoundsToWin() == P1RoundsWinned()) && trigger_when(prev(P1RoundsWinned()) < OptionsRoundsToWin())||
                             tally(8,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x02 
                             && trigger_when(OptionsRoundsToWin() == P1RoundsWinned()) && trigger_when(prev(P1RoundsWinned()) < OptionsRoundsToWin())||
                             tally(8,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x03 
                             && trigger_when(OptionsRoundsToWin() == P1RoundsWinned()) && trigger_when(prev(P1RoundsWinned()) < OptionsRoundsToWin())||
                             tally(8,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x04 
                             && trigger_when(OptionsRoundsToWin() == P1RoundsWinned()) && trigger_when(prev(P1RoundsWinned()) < OptionsRoundsToWin())

function AltsEnduranceMode() => tally(6,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x00 || 
                                tally(7,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x01 ||
                                tally(8,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x02 ||
                                tally(8 ,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x03 ||
                                tally(8,((prev(TowerPosition()) < TowerPosition()) && RoundResult() == 0x01 && CombatFlag() == 0x01 && CPUon())) && TowerDiff() == 0x04
                
function ArcadeModeCharsAnyDiff(char){
    achievement(
    title = CharacterDic[char],
    description = "Complete Arcade mode 1v1 with just " + CharacterDic[char] + " (P1, Any Difficulty)",
    points = 5,
    trigger = never(CharacterID() != char) && never(Mode2on2flag() != 0x00) && never(ModeEnduranceflag() != 0x00) && never(ModeTournamentflag() != 0x00) &&
            never(CombatFlag() == 0x00 && MenuScreen() == 0x06) && AltsArcadeMode())
}


for i in CharacterDic{
    ArcadeModeCharsAnyDiff(i)
}


function UltimateEnduranceFlag() => byte(0x3377bc)

achievement(
    title = "Endurance Warrior",
    description = "Complete endurance mode, any difficulty (No Goro)",
    points = 5,
    trigger = trigger_when(RoundResult() == 0x01) && prev(RoundResult()) == 0x00 && never(ModeEnduranceflag() == 0x00) && never(UltimateEnduranceFlag() == 0x01) && CombatFlag() == 0x01 && AltsEnduranceMode() 
)


function AltCustom() => byte(0x315474)

achievement(
    title = "Chameleon",
    description = "Complete Arcade Mode 1v1 with an alt custome (P1, Any Difficulty)",
    points = 3,
    trigger = never(Mode2on2flag() != 0x00) && never(ModeEnduranceflag() != 0x00) && never(ModeTournamentflag() != 0x00) && never(ModePracticeflag() != 0x00) && 
            never(CombatFlag() == 0x00 && MenuScreen() == 0x06) && AltsArcadeMode() && AltCustom() != 0x00)