scriptName SpellbookMCM extends SKI_ConfigBase

; Spellbook script
Spellbook property SpellbookScript auto

event OnConfigInit()
    ModName = "Spellbook"
    Pages = new string[4]
    Pages[0] = "Spellbook"
    Pages[1] = "Spell Notes"
    Pages[2] = "Followers / NPCs"
    Pages[3] = "Innate Spellcasting"
endEvent

event OnPageReset(string page)
    
endEvent
