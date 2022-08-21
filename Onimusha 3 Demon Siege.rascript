// Onimusha 3: Demon Siege
// #ID = 8548


// Characters Const

SAMANOSUKE = 0x00
JACQUES = 0x01
MICHELLE = 0x02
HEIHACHI = 0x03
ONI_SAMANOSUKE = 0x04

// Utils

function ZoneID() => byte(0x8e1db5)

function SubZoneID() => byte(0x8e1db4)

// INTERESTING LOCATIONS
// (ZoneID, SubZoneID)
// Training = (0x0e, 0x00)
// Ranmaru Honnoji = (0x01, 0x02) ✓
// Tenso Unlock = (0x02, 0x04) ✓
// Brainster = (0x02, 0x08) ✓
// Enja Unlock = (0x03, 0x03) ✓
// Marcellus = (0x03, 0x09) ✓
// Sewer Soldier Rescue = (0x04, 0x05) ✓
// Raisen Unlock = (0x05, 0x0a) ✓
// Heichahi Battle = (0x05, 0x04) ✓
// Enja Unlock = (0x04, 0x07) ✓
// Jacques Dark Realm 1 = (0x0b, (0x04, 0x03)) ✓
// Ranmaru Genma = (0x07, 0x13) ✓
// Hyosai Unlock = (0x07, 0x00) ✓
// Chigo Unlcok = (0x07, 0x18) ✓
// Samanosuke Dark Realm 1 = (0x0b, (0x13, 0x15)) ✓
// Gertrude = (0x07, 0x0b) ✓
// Michelle Weapons / End = (0x08, 0x08) ✓
// Guildenstern = (0x08, 0x0b) ✓
// Jacques Dark Realm 2 = (0x0b, [0x41...0x4b]) ✓
// Samanosuke Dark Realm 2 = (0x0b, [0x51...0x63]) ✓
// Gertrude MSaintMichel = (0x09, 0x11) ✓
// Vega Donna = (0x0c, 0x02) ✓
// Jacques Ultimate Whip = (0x0b, 0x90) ✓
// Jacques Dark Realm 3 = (0x0b, [0x91...0xa3]) ✓
// Samanosuke Dark Realm 3 = (0x0b, [0x70...0x81]) ✓
// End Battle = (0x01, 0x11) ✓
// Genma Puzzle MiniGame V1 = (0x0b, 0xbb) ✓
// Genma Puzzle MiniGame V2 = (0x0b, 0xb7) ✓
// Genma Puzzle MiniGame V3 = (0x0b, 0xb3) ✓
// Bishamon Swrd = (0x0b, 0x70) ✓
// Shoot Training MiniGame = (0x0e, 0x02) ✓ ✓
// Heihachi Adventure (0x00, 0x50) ✓ ✓

function CurrentChar() => byte(0x8f08f2)

// Normal Gameplay Functions

function CriticalMode() => byte(0x8fa34c) == 0x02

function NormalOrMore() => byte(0x8fa33c) >= 0x01

function ChallengeConditions() => CriticalMode() && NormalOrMore()

// Special Modes Functions

function GenmaPuzzleSpaceVersion() => byte(0xa1b568)

function OniIntellectResult() => byte(0xa1b56a)

function OniTargetPracticeStage() => byte(0x9c6850)

function OniTargetPracticeResult() => byte(0x51e94c)

function OniTargetPracticeState() => byte(0xd08d80)

function OniTargetPracticeSubState() => byte(0xd08d81)
//Utils

function CheckBitIncrement(bitID,byte) {
    if     (bitID == 0) {
        return bit0(byte) > prev(bit0(byte))
    } 
    else if(bitID == 1) {
        return bit1(byte) > prev(bit1(byte))
    }
    else if(bitID == 2) {
        return bit2(byte) > prev(bit2(byte))
    }
    else if(bitID == 3) {
        return bit3(byte) > prev(bit3(byte))
    }
    else if(bitID == 4) {
        return bit4(byte) > prev(bit4(byte))
    }
    else if(bitID == 5) {
        return bit5(byte) > prev(bit5(byte))
    }
    else if(bitID == 6) {
        return bit6(byte) > prev(bit6(byte))
    }
    else if(bitID == 7) {
        return bit7(byte) > prev(bit7(byte))
    }
}
 
 
achievement(title = "Tenso",
            description = "Unlock Tenso",
            points = 1,
            trigger = ZoneID() == 0x02 && SubZoneID() == 0x04 && CheckBitIncrement(4,0x8fa4d3) && CurrentChar() == SAMANOSUKE
            ) 

achievement(title = "Brainster",
            description = "Destroy Brainster in the Arc of Triumph",
            points = 3,
            trigger = ZoneID() == 0x02 && SubZoneID() == 0x08 && CheckBitIncrement(4,0x8fa3d2) && CurrentChar() == SAMANOSUKE
            ) 

achievement(title = "Enja",
            description = "Unlock Enaja",
            points = 1,
            trigger = ZoneID() == 0x03 && SubZoneID() == 0x03 && CheckBitIncrement(3,0x8fa4d3) && CurrentChar() == JACQUES
            ) 
            
achievement(title = "Marcellus",
            description = "Defeat Marcellus at Mt.Hiei",
            points = 5,
            trigger = ZoneID() == 0x03 && SubZoneID() == 0x09 && CheckBitIncrement(0,0x8fa3d0) && CurrentChar() == JACQUES
            ) 

achievement(title = "Samu-Rescuer",
            description = "Reach and Save the soldier at the sewer",
            points = 1,
            trigger = ZoneID() == 0x04 && SubZoneID() == 0x05 && CheckBitIncrement(1,0x8fa46a) && CurrentChar() == SAMANOSUKE
            ) 
            
achievement(title = "Raisen",
            description = "Unlock Raisen",
            points = 2,
            trigger = ZoneID() == 0x05 && SubZoneID() == 0x0a && CheckBitIncrement(0,0x8fa4d3) && CurrentChar() == JACQUES
            ) 
            
achievement(title = "Culture Curator",
            description = "Defeat Ranmaru at Honnoji temple without broke any panel",
            points = 2,
            trigger = ZoneID() == 0x01 && SubZoneID() == 0x02 && CheckBitIncrement(6,0x8fa3d4) && CurrentChar() == SAMANOSUKE && prior(byte(0x8fa412)) == 0x00
            )
            
achievement(title = "Friend Or Foe",
            description = "Defeat Heihachi at Sakai port",
            points = 3,
            trigger = ZoneID() == 0x05 && SubZoneID() == 0x04 && CheckBitIncrement(3,0x8fa3d5) && CurrentChar() == JACQUES
            )
            
achievement(title = "[Jacques] To The Deep I",
            description = "Clear all nodes at Dark Realm of Undersea Temple",
            points = 3,
            trigger = ZoneID() == 0x0b && (SubZoneID() == 0x04 || SubZoneID() == 0x03) && prev(bitcount(0x662310)) == 0x04 && bitcount(0x662310) == 0x05 && CurrentChar() == JACQUES
            )
            
achievement(title = "The Corrupted",
            description = "Defeat Ranmaru at Undersea Temple",
            points = 10,
            trigger = ZoneID() == 0x07 && SubZoneID() == 0x13 && CheckBitIncrement(1,0x8fa3db) && CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "Hyosai",
            description = "Unlock Hyosai",
            points = 3,
            trigger = ZoneID() == 0x07 && SubZoneID() == 0x00 && CheckBitIncrement(3,0x8fa4d7) && CurrentChar() == JACQUES
            )
            
achievement(title = "Chigo",
            description = "Unlock Chigo",
            points = 3,
            trigger = ZoneID() == 0x07 && SubZoneID() == 0x18 && CheckBitIncrement(7,0x8fa4d7) && CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "[Samanosuke] To The Deep I",
            description = "Clear all nodes at Dark Realm of Undersea Temple",
            points = 3,
            trigger = ZoneID() == 0x0b && (SubZoneID() == 0x13 || SubZoneID() == 0x15) && prev(bitcount(0x662312)) == 0x05 && bitcount(0x662312) == 0x06 && CurrentChar() == SAMANOSUKE
            )

achievement(title = "Gertrude",
            description = "Defeat gertrude at Undersea Temple",
            points = 10,
            trigger = ZoneID() == 0x07 && SubZoneID() == 0x0b && CheckBitIncrement(4,0x8fa40d) && CurrentChar() == JACQUES
            )
            
achievement(title = "Zooperative",
            description = "Complete Michelle act at the Zoo with both hidden weapons collected",
            points = 5,
            trigger = ZoneID() == 0x08 && SubZoneID() == 0x08 && CheckBitIncrement(1,0x8fa3d4) && (bit2(0x8fa470) + bit4(0x8fa479)) == 0x02 && CurrentChar() == MICHELLE
            )
            
achievement(title = "Guildenster",
            description = "Defeat Guildenstern at Zoo labs",
            points = 10,
            trigger = ZoneID() == 0x08 && SubZoneID() == 0x0b && CheckBitIncrement(6,0x8fa3d9) && CurrentChar() == SAMANOSUKE
            )

achievement(title = "[Jacques] To The Deep II",
            description = "Clear all nodes at Dark Realm of MSaint Michel",
            points = 5,
            trigger = ZoneID() == 0x0b && SubZoneID() >= 0x41 && SubZoneID() <= 0x4b && (prev(bitcount(0x662318)) + prev(bitcount(0x662319))) == 0x0c && (bitcount(0x662318) + bitcount(0x662319)) == 0x0d 
            && CurrentChar() == JACQUES
            )
            
achievement(title = "[Samanosuke] To The Deep II",
            description = "Clear all nodes at Dark Realm of MSaint Michel",
            points = 5,
            trigger = ZoneID() == 0x0b && SubZoneID() >= 0x51 && SubZoneID() <= 0x63 && (prev(bitcount(0x66231a)) + prev(bitcount(0x66231b)) + prev(bitcount(0x66231c))) == 0x13 
            && (bitcount(0x66231a) + bitcount(0x66231b) + bitcount(0x66231c)) == 0x14 && CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "Gertrude's Revenge",
            description = "Defeat Gertrude at MSaint Michel",
            points = 10,
            trigger = ZoneID() == 0x09 && SubZoneID() == 0x11 && CheckBitIncrement(3,0x8fa40d) && CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "Vega Donna",
            description = "Defeat Vega Donna at Azuchi Castle",
            points = 10,
            trigger = ZoneID() == 0x0c && SubZoneID() == 0x02 && CheckBitIncrement(1,0x8fa3dd) && CurrentChar() == JACQUES
            )
            
achievement(title = "Ultimate Whip",
            description = "Unlock Ultimate Whip",
            points = 5,
            trigger = ZoneID() == 0x0b && SubZoneID() == 0x90 && CheckBitIncrement(5,0x8fa495) && CurrentChar() == JACQUES
            )
            
achievement(title = "Bishamon Sword",
            description = "Unlock Bishamon Sword",
            points = 5,
            trigger = ZoneID() == 0x0b && SubZoneID() == 0x70 && CheckBitIncrement(6,0x8fa495) && CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "[Samanosuke] To The Deep III",
            description = "Clear all nodes at Dark Realm of Honnoji Temple",
            points = 10,
            trigger = ZoneID() == 0x0b && SubZoneID() >= 0x70 && SubZoneID() <= 0x81 && (prev(bitcount(0x66231e)) + prev(bitcount(0x66231f)) + prev(bitcount(0x662320))) == 0x11
            && (bitcount(0x66231e) + bitcount(0x66231f) + bitcount(0x662320)) == 0x12 && CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "Sneaky Samurai",
            description = "As Samanosuke cross the crystal room trap without taking damage",
            points = 2,
            trigger = once(CurrentChar() == SAMANOSUKE && ZoneID() == 0x07 && SubZoneID() == 0x17 && dword(0x8f0988) >= 0x44b49c62 && bit5(0x8fa4f0) == 0x01) && never(prev(word(0x8f2ad8)) > word(0x8f2ad8))
            && trigger_when(dword(0x8f0988) <= 0x43e9fc7a) && never(byte(0x8f08f8) != 0x01)
            )
            
achievement(title = "[Jacques] To The Deep III",
            description = "Clear all nodes at Dark Realm of Honnoji Temple",
            points = 10,
            trigger = ZoneID() == 0x0b && SubZoneID() >= 0x91 && SubZoneID() <= 0xa3 && (prev(bitcount(0x662322)) + prev(bitcount(0x662323)) + prev(bitcount(0x662324))) == 0x13
            && (bitcount(0x662322) + bitcount(0x662323) + bitcount(0x662324)) == 0x14 && CurrentChar() == JACQUES
            )
            
achievement(title = "Nobunaga's End",
            description = "Defeat Nobunaga Oda",
            points = 25,
            trigger = ZoneID() == 0x01 && SubZoneID() == 0x11 && CheckBitIncrement(4,0x8fa3dd) && CurrentChar() == ONI_SAMANOSUKE
            )
            
achievement(title = "Oni Intellectual I",
            description = "Complete the Genma Puzzle Space (Onimusha 1 Version) with 200 Oni Intelect",
            points = 5,
            trigger = ZoneID() == 0x0b && SubZoneID() == 0xbb && CheckBitIncrement(0,0xa1b56b) && GenmaPuzzleSpaceVersion() == 0x00 && OniIntellectResult() == 0xc8 &&CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "Oni Intellectual II",
            description = "Complete the Genma Puzzle Space (Onimusha 2 Version) with 200 Oni Intelect",
            points = 5,
            trigger = ZoneID() == 0x0b && SubZoneID() == 0xb7 && CheckBitIncrement(0,0xa1b56b) && GenmaPuzzleSpaceVersion() == 0x01 && OniIntellectResult() == 0xc8 &&CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "Oni Intellectual III",
            description = "Complete the Genma Puzzle Space (Onimusha 3 Version) with 200 Oni Intelect",
            points = 5,
            trigger = ZoneID() == 0x0b && SubZoneID() == 0xb3 && CheckBitIncrement(0,0xa1b56b) && GenmaPuzzleSpaceVersion() == 0x02 && OniIntellectResult() == 0xc8 &&CurrentChar() == SAMANOSUKE
            )
            
achievement(title = "Tengu Collector",
            description = "Collect all Tengu chests",
            points = 10,
            trigger = prev(bit7(0x8fa4b0)) + prev(bitcount(0x8fa4b1)) + prev(bitcount(0x8fa4b2)) + prev(bitcount(0x8fa4b3)) == 0x16 && 
            measured(bit7(0x8fa4b0) + bitcount(0x8fa4b1) + bitcount(0x8fa4b2) + bitcount(0x8fa4b3) == 0x17)
            )
            
achievement(title = "Oni Solver",
            description = "Resolve and open all puzzle chests",
            points = 10,
            trigger = prev(bit6(0x8fa491)) + (prev(byte(0x8fa492)) & 0xfc) + prev(bitcount(0x8fa493)) == 0x104 && 
            bit6(0x8fa491) + (byte(0x8fa492) & 0xfc) + bitcount(0x8fa493) == 0x105
            ) 
            
achievement(title = "Brainster Critical",
            description = "Destroy Brainster in the Arc of Triumph in Critical Mode (Normal Difficulty or higher)",
            points = 10,
            trigger = ZoneID() == 0x02 && SubZoneID() == 0x08 && CheckBitIncrement(4,0x8fa3d2) && CurrentChar() == SAMANOSUKE && ChallengeConditions()
            ) 
            
achievement(title = "Marcellus Critical",
            description = "Defeat Marcellus at Mt.Hiei in Critical Mode (Normal Difficulty or higher)",
            points = 10,
            trigger = ZoneID() == 0x03 && SubZoneID() == 0x09 && CheckBitIncrement(0,0x8fa3d0) && CurrentChar() == JACQUES && ChallengeConditions()
            ) 
            
achievement(title = "Friend Or Foe Critical",
            description = "Defeat Heihachi at Sakai port in Critical Mode (Normal Difficulty or higher)",
            points = 10,
            trigger = ZoneID() == 0x05 && SubZoneID() == 0x04 && CheckBitIncrement(3,0x8fa3d5) && CurrentChar() == JACQUES && ChallengeConditions()
            )
            
achievement(title = "The Corrupted Critical",
            description = "Defeat Ranmaru at Undersea Temple in Critical Mode (Normal Difficulty or higher)",
            points = 25,
            trigger = ZoneID() == 0x07 && SubZoneID() == 0x13 && CheckBitIncrement(1,0x8fa3db) && CurrentChar() == SAMANOSUKE && ChallengeConditions()
            )
            
achievement(title = "Gertrude Critical",
            description = "Defeat gertrude at Undersea Temple in Critical Mode (Normal Difficulty or higher)",
            points = 25,
            trigger = ZoneID() == 0x07 && SubZoneID() == 0x0b && CheckBitIncrement(4,0x8fa40d) && CurrentChar() == JACQUES && ChallengeConditions()
            )
            
achievement(title = "Guildenster Critical",
            description = "Defeat Guildenstern at Zoo labs in Critical Mode (Normal Difficulty or higher)",
            points = 25,
            trigger = ZoneID() == 0x08 && SubZoneID() == 0x0b && CheckBitIncrement(6,0x8fa3d9) && CurrentChar() == SAMANOSUKE && ChallengeConditions()
            )
            
achievement(title = "Gertrude's Revenge Criticala",
            description = "Defeat Gertrude at MSaint Michel in Critical Mode (Normal Difficulty or higher)",
            points = 25,
            trigger = ZoneID() == 0x09 && SubZoneID() == 0x11 && CheckBitIncrement(3,0x8fa40d) && CurrentChar() == SAMANOSUKE && ChallengeConditions()
            )
            
achievement(title = "Vega Donna Critical",
            description = "Defeat Vega Donna at Azuchi Castle in Critical Mode (Normal Difficulty or higher)",
            points = 25,
            trigger = ZoneID() == 0x0c && SubZoneID() == 0x02 && CheckBitIncrement(1,0x8fa3dd) && CurrentChar() == JACQUES && ChallengeConditions()
            )
            
achievement(title = "Nobunaga's End Critical",
            description = "Defeat Nobunaga Oda in Critical Mode (Normal Difficulty or higher)",
            points = 50,
            trigger = ZoneID() == 0x01 && SubZoneID() == 0x11 && CheckBitIncrement(4,0x8fa3dd) && CurrentChar() == ONI_SAMANOSUKE && ChallengeConditions()
            )
            
achievement(title = "Elemental Master",
            description = "Collect all elemental Seals",
            points = 10,
            trigger = prev(bitcount(0x8fa495) & 0x19) == 0x02 && (bitcount(0x8fa495) & 0x19) == 0x3
            )
            
achievement(title = "Special Forces Collector",
            description = "Open all Michelle's special chests",
            points = 5,
            trigger = (prev(bit2(0x8fa470)) + (prev(byte(0x8fa479)) & 0x13) + prev(bit0(0x8fa47d))) == 0x14 &&
            (bit2(0x8fa470) + (byte(0x8fa479) & 0x13) + bit0(0x8fa47d)) == 0x15 && CurrentChar() == MICHELLE
            )
            
achievement(title = "Oni Sniper",
            description = "Complete Stage 8 in Oni Target Practice",
            points = 10,
            trigger = ZoneID() == 0x0e && SubZoneID() == 0x02 && OniTargetPracticeStage() == 0x07 && OniTargetPracticeState() == 0x02 && OniTargetPracticeSubState() == 0x10 && prev(OniTargetPracticeSubState()) == 0x0f 
             && OniTargetPracticeResult() <= 0x03
            )
       
achievement(title = "Oni Advanced",
            description = "Complete all the lessons of the protective mirror",
            points = 10,
            trigger = ZoneID() == 0x0e && SubZoneID() == 0x00 && (byte(0xa1b820) & 0x1c) + (byte(0xa1b821) & 0xf8) + bitcount(0xa1b822) + bitcount(0xa1b823) == 0x124
            && prev((byte(0xa1b820) & 0x1c) + (byte(0xa1b821) & 0xf8) + bitcount(0xa1b822) + bitcount(0xa1b823)) == 0x123
            )
            
achievement(title = "Oni Master",
            description = "Complete all the lessons of the protective mirror",
            points = 10,
            trigger = ZoneID() == 0x0e && SubZoneID() == 0x01 && (bitcount(0x547811) + bitcount(0x547812) + bitcount(0x547813) == 0x18)
            && prev(bitcount(0x547811) + bitcount(0x547812) + bitcount(0x547813)) == 0x17
            )
  
achievement(title = "Great Adventure",
            description = "Complete Heihachi's adventure",
            points = 10,
            trigger = ZoneID() == 0x00 && SubZoneID() == 0x50 && CheckBitIncrement(1,0x8fa3d6) && CurrentChar() == HEIHACHI
            )  