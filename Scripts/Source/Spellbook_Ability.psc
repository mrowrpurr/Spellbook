scriptName Spellbook_Ability extends ActiveMagicEffect  
{The main ability applied to the Player or desired NPCs
which tracks their behavior with regards to Spellbook limitations}

; Player
Actor property PlayerRef auto

; Spellbook script
Spellbook property SpellbookScript auto

; When an item, e.g. a Spell Tome, is added to the player
event OnItemAdded(Form theItem, int count, ObjectReference itemReference, ObjectReference container)
    Book theBook = theItem as Book
    if theBook
        Spell taughtSpell = theBook.GetSpell()
        if taughtSpell
            if GetTargetActor() == PlayerRef
                ; TODO what if they do not yet have a spell book
                SpellbookScript.ShowOkMessage("You picked up a spell tome for " + taughtSpell.GetName() + "\n\nIt has been added to your notes!")
            else
                Debug.MessageBox(GetTargetActor().GetActorBase().GetName() + " picked up a Spell Tome")
            endIf
        endIf
    endIf
endEvent
