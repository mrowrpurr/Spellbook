scriptName Spellbook_Actor

bool function CanTranscribeAnySpells(Spellbook spellbookScript, Actor theActor) global
    Form[] theSpells = Spellbook_SpellNotes.GetSpells(theActor)
    int i = 0
    while i < theSpells.Length
        if ! CanTranscribe(theSpells[i] as Spell)
            return false
        endIf
        i += 1
    endWhile
    return true
endFunction

bool function CanTranscribe(Spell theSpell) global
    Debug.Notification(theSpell.GetPerk().GetName() + " " + theSpell.GetName())
    return true
endFunction
