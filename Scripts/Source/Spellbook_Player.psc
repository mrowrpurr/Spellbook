scriptName Spellbook_Player extends ReferenceAlias  

Spellbook SpellbookScript

; When the alias is filled for the first time (on Mod Installation)
event OnInit()
    SpellbookScript = GetOwningQuest() as Spellbook
    PO3_Events_Alias.RegisterForSpellLearned(self)
endEvent

; Load Game Events
event OnPlayerLoadGame()
    SpellbookScript.OnPlayerLoadGame()
    PO3_Events_Alias.RegisterForSpellLearned(self)
endEvent

; Note: this only works for the Player so it's on the Player alias rather than the Spellbook Ability
event OnSpellLearned(Spell theSpell)
    ; TODO ;
endEvent
