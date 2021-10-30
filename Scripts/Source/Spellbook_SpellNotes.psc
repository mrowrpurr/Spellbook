scriptName Spellbook_SpellNotes extends ObjectReference  

; Spellbook script
Spellbook property SpellbookScript auto

; Handle when the SpellNote is read by the player
event OnRead()
    SpellbookScript.ReadSpellNotes()
endEvent

; Return a list of all of the Spells for this actor
Form[] function GetSpells(Actor theActor) global
    return JArray.asFormArray(Data_GetSpellsArray(theActor))
endFunction

; Add a spell to the spell notes for this actor
function AddSpell(Actor theActor, Spell theSpell) global
    JArray.addForm(Data_GetSpellsArray(theActor), theSpell)
endFunction

; Set the text for the 'Spell Notes'
; MUST be called BEFORE you trigger OnRead() of the 'Spell Notes'
function UpdateSpellNotesText(Spellbook spellbookScript, Actor theActor) global
    int spellsArray = Data_GetSpellsArray(theActor)
    string noteText = "<font size='30'>Spell Notes</font>\n\n<ul>\n"
    int spellsArrayCount = JArray.count(spellsArray)
    int i = 0
    while i < spellsArrayCount
        Form theSpell = JArray.getForm(spellsArray, i)
        noteText += "<li>" + theSpell.GetName() + "</li>\n"
        i += 1
    endWhile
    noteText += "</ul>"
    SetSpellNotesText(spellbookScript, noteText)
endFunction

; Sets the visible text in whatever Spell Note is being read
function SetSpellNotesText(Spellbook spellbookScript, string text) global
    spellbookScript.Spellbook_SpellNotesText_BaseForm.SetName(text)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data structures below
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

int function Data_GetNotesMap(Actor theActor) global
    int spellNotesMap = JFormDB.solveObj(theActor, ".spellbook.spellnotes")
    if ! spellNotesMap
        spellNotesMap = JMap.object()
        JMap.setObj(spellNotesMap, "spellList", JArray.object())
        JFormDB.solveObjSetter(theActor, ".spellbook.spellnotes", spellNotesMap, createMissingKeys = true)
    endIf
    return spellNotesMap
endFunction

int function Data_GetSpellsArray(Actor theActor) global
    return JMap.getObj(Data_GetNotesMap(theActor), "spellList")
endFunction
