scriptName Spellbook_Spellbook extends ObjectReference  

; Spellbook script
Spellbook property SpellbookScript auto

; Handle when the SpellNote is read by the player
event OnRead()
    Utility.WaitMenuMode(1)
    Spellbook_UI_ReadSpellbook.Show(SpellbookScript)
endEvent

; Is the provided Form a Spellbook?
bool function IsSpellbook(Spellbook spellbookScript, Form theForm) global
    return SpellbookScript.Spellbook_SpellbooksFormList.HasForm(theForm)
endFunction

function AddUnpreparedSpell(Actor theActor, Spell theSpell) global
    Debug.Notification("This will add unprepared spell")
endFunction
