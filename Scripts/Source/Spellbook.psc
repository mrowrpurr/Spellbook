scriptName Spellbook extends Quest

Actor property PlayerRef auto

; Spellbook Quest Aliases
ReferenceAlias property SpellbookBook auto
ReferenceAlias property SpellbookText auto
ReferenceAlias property SpellbookContainer auto

; Spellbook Type Forms
Form property Spellbook_Spellbook1 auto
Form property Spellbook_SpellbookText_BaseForm auto

; Mod Installation
event OnInit()
    AddSpellbookToPlayer()
endEvent

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
