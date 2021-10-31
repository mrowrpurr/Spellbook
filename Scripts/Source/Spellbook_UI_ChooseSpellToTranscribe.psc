scriptName Spellbook_UI_ChooseSpellToTranscribe

Spell function ChooseSpell(Spellbook spellbookScript, Actor theActor) global
    Form[] transcribeableSpells = Spellbook_Actor.GetTranscribeableSpells(theActor)
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    listMenu.AddEntryItem("[Choose Spell to Transcribe]")

    int i = 0
    while i < transcribeableSpells.Length
        Form theSpell = transcribeableSpells[i]
        listMenu.AddEntryItem(theSpell.GetName())
        i += 1
    endWhile

    ; ~ UI Extensions workaround ~
    spellbookScript.CurrentListMenu = listMenu
    spellbookScript.CurrentActor    = theActor
    spellbookScript.OnSelect_DelegateToTranscribeSpell = true

    listMenu.OpenMenu() ; D'oh - it gets locked here...

    ; The Spellbook script handles the choice of option and delegated it to `OnChooseSpell` below
endFunction

function OnChooseSpell(Spellbook spellbookScript, Actor theActor, int spellIndex) global
    Form[] transcribeableSpells = Spellbook_Actor.GetTranscribeableSpells(theActor)
    if spellIndex < 1
        Spellbook_UI_ReadSpellNotes.Show(spellbookScript)
    else
        int index = spellIndex - 1 ; Remove 1 for the title "[Choose Spell to Transcribe]"
        Form theSpell = transcribeableSpells[index]
        Spellbook_UI_TranscribeSpell.Show(spellbookScript, theSpell as Spell, theActor)
    endIf
endFunction
