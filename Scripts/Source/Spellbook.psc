scriptName Spellbook extends Quest

; The player
Actor property PlayerRef auto

; Versioning
string property CurrentlyInstalledVersion auto

; Game Time
GlobalVariable property GameHour auto

; Quest Aliases
ReferenceAlias property SpellNotes auto
ReferenceAlias property SpellNotesContainer auto
ReferenceAlias property SpellbookBook auto
ReferenceAlias property SpellbookContainer auto

; Spellbook Forms
FormList property Spellbook_SpellbooksFormList auto
Form property Spellbook_Spellbook_BaseForm1 auto

; Spell Note Forms
Form property Spellbook_SpellNotes_BaseForm auto

; Messages
Message property Spellbook_Message_Ok auto
Message property Spellbook_Message_Spellbook auto
Message property Spellbook_Message_SpellNotes auto
Message property Spellbook_Message_TranscribeSpell auto

; Text Replacement Forms
Form property Spellbook_MessageText_BaseForm auto
Form property Spellbook_SpellbookText_BaseForm auto
Form property Spellbook_SpellNotesText_BaseForm1 auto

; Global Variables
GlobalVariable property Spellbook_CanTranscribeSpells auto

; UI Extensions Widgets and Workaround (because UI Extensions gets blocked when the Book menu is open)
bool property OnSelect_DelegateToTranscribeSpell auto
UIListMenu property CurrentListMenu auto
Actor property CurrentActor auto

; Effects
ImageSpaceModifier property FadeToBlack_Enter auto
ImageSpaceModifier property FadeToBlack_Hold auto
ImageSpaceModifier property FadeToBlack_Leave auto
Sound property ITMBookOpen auto
Sound property ITMBookClose auto
Sound property ITMBookPageTurnForward auto
Sound property ITMBookPageTurnBackward auto

; TODO TODO TODO ~ REMOVE THIS ~ DO NOT RELEASE THIS FUNCTION TO NEXUS ~ TODO TODO TODO
function AddTestItems()
    ; Add some Spell Tomes

    Utility.Wait(1)

    ; [Alteration]
    ; Novice
    PlayerRef.AddSpell(Game.GetForm(0x0005ad5c) as Spell)
    PlayerRef.AddItem(Game.GetForm(0x0009e2a7))
    ; Apprentice
    PlayerRef.AddItem(Game.GetForm(0x000a26e2))
    ; Adept
    PlayerRef.AddItem(Game.GetForm(0x000a26e6))

    ; [Destruction]
    ; Novice
    PlayerRef.AddSpell(Game.GetForm(0x0002dd2a) as Spell)
    PlayerRef.AddItem(Game.GetForm(0x0009cd52))
    ; Apprentice
    PlayerRef.AddItem(Game.GetForm(0x000a26fe))
    ; Adept
    PlayerRef.AddItem(Game.GetForm(0x000a2708))
endFunction

; Mod Installation
event OnInit()
    CurrentlyInstalledVersion = GetCurrentVersion()
    AddTestItems()
    RegisterForModEvent("UIListMenu_SelectItem", "OnSelect")
endEvent

Event OnSelect(string eventName, string strArg, float numArg, Form formArg)
    CurrentListMenu.Unlock()
    CurrentListMenu = None

    if OnSelect_DelegateToTranscribeSpell
        OnSelect_DelegateToTranscribeSpell = false 
        Spellbook_UI_ChooseSpellToTranscribe.OnChooseSpell(self, CurrentActor, strArg as int)
    endIf
EndEvent

; Load Game Events
event OnPlayerLoadGame()
    ; TODO
endEvent

; Versioning
string function GetCurrentVersion() global
    return "1.0"
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

; TODO Move to Spell Notes

Book function GetSpellNotes(Actor theActor)
    return SpellNotes.GetReference().GetBaseObject() as Book
endFunction

function AddSpellToSpellNotes(Actor theActor, Spell theSpell)
    if theActor != PlayerRef
        Debug.MessageBox("Adding spells to spell notes only currently supported for the Player")
        return
    endIf

    if Spellbook_Actor.HasSpellNotes(self, theActor)
        PO3_SKSEFunctions.ClearReadFlag(GetSpellNotes(theActor))
    else
        AddSpellNotes(theActor)
    endIf

    Spellbook_SpellNotes.AddSpell(theActor, theSpell)
    Spellbook_SpellNotes.UpdateSpellNotesText(self, theActor)

    ShowOkMessage("Added notes for spell '" + theSpell.GetName() + "' to your Spell Notes")
endFunction

; Give the player spell notes!
function AddSpellNotes(Actor theActor)
    if ! Spellbook_Actor.HasSpellNotes(self, theActor)
        ObjectReference theSpellNotes = SpellbookContainer.GetReference().PlaceAtMe(Spellbook_SpellNotes_BaseForm)
        SpellNotes.ForceRefTo(theSpellNotes)
        theActor.AddItem(theSpellNotes)
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Spell Book (the actual inventory book)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Sets the visible text in whatever Spellbook is being read
function SetSpellbookText(string text)
    Spellbook_SpellbookText_BaseForm.SetName(text)
endFunction
