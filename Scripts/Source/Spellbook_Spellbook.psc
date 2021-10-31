scriptName Spellbook_Spellbook extends ObjectReference  

; Spellbook script
Spellbook property SpellbookScript auto

; Handle when the SpellNote is read by the player
event OnRead()
    Utility.WaitMenuMode(1)
    Spellbook_UI_ReadSpellbook.Show(SpellbookScript)
endEvent