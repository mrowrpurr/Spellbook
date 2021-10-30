scriptName Spellbook_Player extends ReferenceAlias  

Spellbook SpellbookScript

; When the alias is filled for the first time (on Mod Installation)
event OnInit()
    SpellbookScript = GetOwningQuest() as Spellbook
endEvent

; Load Game Events
event OnPlayerLoadGame()
    SpellbookScript.OnPlayerLoadGame()
endEvent
