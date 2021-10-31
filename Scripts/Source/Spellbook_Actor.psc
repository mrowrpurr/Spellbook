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

Form[] function GetTranscribeableSpells(Actor theActor) global
    int transcribableSpells = JArray.object()
    Form[] spellNotesSpells = Spellbook_SpellNotes.GetSpells(theActor)
    int i = 0
    while i < spellNotesSpells.Length
        Spell theSpell = spellNotesSpells[i] as Spell
        if Spellbook_Actor.CanTranscribe(theActor, theSpell)
            JArray.addForm(transcribableSpells, theSpell)
        endIf
        i += 1
    endWhile
    return JArray.asFormArray(transcribableSpells)
endFunction

int function GetHoursRequiredToTranscribeSpell(Actor theActor, Spell theSpell) global
    string schoolOfMagic        = Spellbook_Spell.GetSchool(theSpell)
    int spellSkillLevel         = Spellbook_Spell.GetSkillLevel(theSpell)
    string spellSkillLevelName  = Spellbook_Spell.GetSkillLevelName(theSpell)
    float actorSkillAV          = theActor.GetActorValue(schoolOfMagic)
    int baseHoursRequired       = Spellbook_Config.GetTranscriptionHoursRequired(spellSkillLevelName)
    float hoursToSubtract       = baseHoursRequired * (actorSkillAV / 100.0)
    int hoursRequired           = Math.Ceiling(baseHoursRequired - hoursToSubtract)
    if hoursRequired <= 0
        hoursRequired = 1
    endIf
    return hoursRequired
endFunction
