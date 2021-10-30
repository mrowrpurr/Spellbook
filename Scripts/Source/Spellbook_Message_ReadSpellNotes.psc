scriptName Spellbook_Message_ReadSpellNotes

function Show(Spellbook spellbookScript) global
    ; TODO if there are any NPCs who are being managed via Spellbook, show a chooser (?)
    Actor theActor = spellbookScript.PlayerRef
    

    spellbookScript.SetMessageText("~ Viewing " + theActor.GetActorBase().GetName() + "'s' Spell Notes ~")
    
    int transcriptSpell = 0
    int viewBook = 1 ; Do nothing (simply closes the Message)
    int closeBook = 2
    int result = spellbookScript.Spellbook_Message_SpellNotes.Show()
    if result == transcriptSpell
        ; 
    elseIf result == closeBook
        Input.TapKey(1) ; Escape
    endIf
endFunction
