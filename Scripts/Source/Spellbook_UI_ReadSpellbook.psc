scriptName Spellbook_UI_ReadSpellbook

; TODO ~ if in combat, do not allow reading the Spell Notes! just give a message and close the book

function Show(Spellbook spellbookScript) global
    ; TODO if there are any NPCs who are being managed via Spellbook, show a chooser (?)
    Actor theActor = spellbookScript.PlayerRef

    spellbookScript.SetMessageText("~ Viewing " + theActor.GetActorBase().GetName() + "'s Spellbook ~")
    
    int prepareSpells = 0
    int readBook = 1 ; Do nothing (simply closes the Message)
    int closeBook = 2
    int result = spellbookScript.Spellbook_Message_Spellbook.Show()
    if result == prepareSpells
        Debug.MessageBox("TODO PREPARE SPELLS")
    elseIf result == closeBook
        Input.TapKey(1) ; Escape
    endIf
endFunction
