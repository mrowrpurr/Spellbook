scriptName Spellbook_Actor

bool function CanTranscribeAnySpells(Actor theActor) global
    Form[] theSpells = Spellbook_SpellNotes.GetSpells(theActor)
    int i = 0
    while i < theSpells.Length
        if CanTranscribe(theActor, theSpells[i] as Spell)
            return true
        endIf
        i += 1
    endWhile
    return false
endFunction

bool function CanTranscribe(Actor theActor, Spell theSpell) global
    string schoolOfMagic   = Spellbook_Spell.GetSchool(theSpell)
    int requiredSkillLevel = Spellbook_Spell.GetSkillLevel(theSpell)
    int actorSkillLevel    = GetSkillLevel(theActor, schoolOfMagic)
    return actorSkillLevel >= requiredSkillLevel
endFunction

int function GetSkillLevel(Actor theActor, string schoolOfMagic) global
    int actorSkillPoints = theActor.GetActorValue(schoolOfMagic) as int
    if actorSkillPoints < 25
        return 1
    elseIf actorSkillPoints < 50
        return 2
    elseIf actorSkillPoints < 75
        return 3
    elseIf actorSkillPoints < 100
        return 4
    else
        return 5
    endIf
endFunction
