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
    ; Is this a Spell Tome?
    Spell taughtSpell
    Book theBook = theItem as Book
    if theBook
        taughtSpell = theBook.GetSpell()
    endIf

    if theBook && taughtSpell
        ThisActor.RemoveItem(theBook, count, abSilent = true)
        SpellbookScript.AddSpellToSpellNotes(ThisActor, taughtSpell)
    elseIf Spellbook_Spellbook.IsSpellbook(SpellbookScript, theItem)
        ; TODO check whether or not this is their FIRST one
        SpellbookScript.ShowOkMessage("You have acquired a Spellbook!\n\nOpen this book to view or prepare your spells.")
    endIf
endEvent
