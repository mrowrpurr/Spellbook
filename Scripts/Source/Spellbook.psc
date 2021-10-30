scriptName Spellbook extends Quest

; The player
Actor property PlayerRef auto

; Versioning
string property CurrentlyInstalledVersion auto

; Spellbook Quest Aliases
ReferenceAlias property SpellbookBook auto
ReferenceAlias property SpellbookText auto
ReferenceAlias property SpellbookContainer auto

; Spellbook Type Forms
Form property Spellbook_Spellbook1 auto

; Messages
Message property Spellbook_Message_Ok auto

; Text Replacement Forms
Form property Spellbook_SpellbookText_BaseForm auto
Form property Spellbook_MessageText_BaseForm auto

; Mod Installation
event OnInit()
    CurrentlyInstalledVersion = GetCurrentVersion()
    AddSpellbookToPlayer()
endEvent

; Load Game Events
event OnPlayerLoadGame()
    ; TODO
endEvent

; Versioning
string function GetCurrentVersion() global
    return "1.0"
endFunction

; Give the player a spellbook!
function AddSpellbookToPlayer()
    ObjectReference theSpellbook = SpellbookContainer.GetReference().PlaceAtMe(Spellbook_Spellbook1)
    SpellbookBook.ForceRefTo(theSpellbook)
    PlayerRef.AddItem(theSpellbook)
endFunction

; Sets the visible text in whatever Spellbook is being read
function SetBookText(string text)
    Spellbook_SpellbookText_BaseForm.SetName(text)
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
