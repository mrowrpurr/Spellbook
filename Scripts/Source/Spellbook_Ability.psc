scriptName Spellbook_Ability extends ActiveMagicEffect  
{The main ability applied to the Player or desired NPCs
which tracks their behavior with regards to Spellbook limitations}

; Player
Actor property PlayerRef auto

; Target Actor
Actor property ThisActor auto

; Spellbook script
Spellbook property SpellbookScript auto

; When the Ability is added to this Player or NPC
event OnEffectStart(Actor target, Actor caster)
    ThisActor = target
endEvent

; When an item, e.g. a Spell Tome, is added to the player
event OnItemAdded(Form theItem, int count, ObjectReference itemReference, ObjectReference container)
    Book theBook = theItem as Book
    if theBook
        Spell taughtSpell = theBook.GetSpell()
        if taughtSpell
            ThisActor.RemoveItem(theBook, count, abSilent = true)
            SpellbookScript.AddSpellToSpellNotes(ThisActor, taughtSpell)
        endIf
    endIf
endEvent
