scriptName Spellbook_Spell

string function GetSchool(Spell theSpell) global
    return StringUtil.Split(theSpell.GetPerk().GetName(), " ")[1]
endFunction

string function GetSkillLevelName(Spell theSpell) global
    return StringUtil.Split(theSpell.GetPerk().GetName(), " ")[0]
endFunction

; 1 - Novice
; 2 - Apprentice
; 3 - Adept
; 4 - Expert
; 5 - Master
int function GetSkillLevel(Spell theSpell) global
    string skillLevelName = GetSkillLevelName(theSpell)
    if skillLevelName == "Novice"
        return 1
    elseIf skillLevelName == "Apprentice"
        return 2
    elseIf skillLevelName == "Adept"
        return 3
    elseIf skillLevelName == "Expert"
        return 4
    elseIf skillLevelName == "Master"
        return 5
    endIf
endFunction
