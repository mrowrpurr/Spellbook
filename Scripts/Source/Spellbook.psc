scriptName Spellbook extends Quest

; The player
Actor property PlayerRef auto

; Versioning
string property CurrentlyInstalledVersion auto

; Quest Aliases
ReferenceAlias property SpellNotes auto
ReferenceAlias property SpellNotesContainer auto
ReferenceAlias property SpellbookBook auto
ReferenceAlias property SpellbookContainer auto

; Spellbook and Spell Note Type Forms
Form property Spellbook_SpellNotes_BaseForm auto
Form property Spellbook_Spellbook_BaseForm1 auto

; Messages
Message property Spellbook_Message_Ok auto

; Text Replacement Forms
Form property Spellbook_MessageText_BaseForm auto
Form property Spellbook_BookOrNoteText_BaseForm auto

; Mod Installation
event OnInit()
    CurrentlyInstalledVersion = GetCurrentVersion()
    AddSpellbook(PlayerRef)
endEvent

; Load Game Events
event OnPlayerLoadGame()
    ; TODO
endEvent

; Versioning
string function GetCurrentVersion() global
    return "1.0"
endFunction

; Sets the visible text in whatever Spellbook is being read
function SetBookText(string text)
    Spellbook_BookOrNoteText_BaseForm.SetName(text)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Messages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function ShowOkMessage(string text)
    SetMessageText(text)
    Spellbook_Message_Ok.Show()
endFunction

function SetMessageText(string text)
    Spellbook_MessageText_BaseForm.SetName(text)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Spell Notes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function ReadSpellNotes()
    ; Nothing to do here yet. This *will* shortly open a UIListMenu!
endFunction

function SetPlayerSpellNoteText()
    int spellList = GetSpellNotesList(PlayerRef)
    string noteText = "<font size='30'>Spells to learn</font>\n\n<ul>\n"
    int spellListCount = JArray.count(spellList)
    int i = 0
    while i < spellListCount
        Form theSpell = JArray.getForm(spellList, i)
        noteText += "<li>" + theSpell.GetName() + "</li>\n"
        i += 1
    endWhile
    noteText += "</ul>"
    SetBookText(noteText)
endFunction

bool function HasSpellNotes(Actor theActor)
    return theActor.GetItemCount(Spellbook_SpellNotes_BaseForm) > 0
endFunction

function AddSpellToSpellNotes(Actor theActor, Spell theSpell)
    Debug.MessageBox("Adding spell to notes for actor " + theActor)
    Debug.MessageBox("The data for the actor is: " + GetSpellNotesMap(theActor))
    Debug.MessageBox("The list of spells for the actor is: " + GetSpellNotesList(theActor))

    if theActor != PlayerRef
        Debug.MessageBox("Adding spells to spell notes only currently supported for the Player")
        return
    endIf

    if ! HasSpellNotes(theActor)
        AddSpellNotes(theActor)
    endIf

    JArray.addForm(GetSpellNotesList(theActor), theSpell)
    SetPlayerSpellNoteText()

    ShowOkMessage("Added notes for spell '" + theSpell.GetName() + "' to your Spell Notes")
endFunction

int function GetSpellNotesMap(Actor theActor)
    int spellNotesMap = JFormDB.solveObj(theActor, ".spellbook.spellnotes")
    if ! spellNotesMap
        spellNotesMap = JMap.object()
        JMap.setObj(spellNotesMap, "spellList", JArray.object())
        JFormDB.solveObjSetter(theActor, ".spellbook.spellnotes", spellNotesMap, createMissingKeys = true)
    endIf
    return spellNotesMap
endFunction

int function GetSpellNotesList(Actor theActor)
    return JMap.getObj(GetSpellNotesMap(theActor), "spellList")
endFunction

; Give the player spell notes!
function AddSpellNotes(Actor theActor)
    ObjectReference theSpellNotes = SpellbookContainer.GetReference().PlaceAtMe(Spellbook_SpellNotes_BaseForm)
    SpellbookBook.ForceRefTo(theSpellNotes)
    theActor.AddItem(theSpellNotes)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Spell Book (the actual inventory book)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO: update with all additional Spellbook forms, if we add them!
bool function HasSpellbook(Actor theActor)
    return theActor.GetItemCount(Spellbook_Spellbook_BaseForm1) > 0
endFunction

; Give the player a spellbook!
function AddSpellbook(Actor theActor)
    ObjectReference theSpellbook = SpellbookContainer.GetReference().PlaceAtMe(Spellbook_Spellbook_BaseForm1)
    SpellbookBook.ForceRefTo(theSpellbook)
    theActor.AddItem(theSpellbook)
endFunction
