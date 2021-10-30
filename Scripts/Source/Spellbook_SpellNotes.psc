scriptName Spellbook_SpellNotes extends ObjectReference  

; Spellbook script
Spellbook property SpellbookScript auto

; Handle when the SpellNote is read by the player
event OnRead()
    SpellbookScript.ReadSpellNotes()
endEvent
