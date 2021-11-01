scriptName Spellbook_TestEffectActor extends ActiveMagicEffect  

; Spellbook script
Spellbook property SpellbookScript auto

event OnEffectStart(Actor target, Actor caster)
    Actor marcurio = target ; Game.GetForm(0xb9986) as Actor
    Spell testSpell = marcurio.GetActorBase().GetNthSpell(1) as Spell
    Debug.Trace("Removing ActorBase spell " + testSpell.GetName() + " from Actor " + marcurio)
    PO3_SKSEFunctions.RemoveBaseSpell(marcurio, testSpell)
    Debug.Trace("Removed!")
endEvent




    ; if ! Spellbook_Actor.IsManaged(target)
    ;     Debug.MessageBox("Managing new actor " + target.GetActorBase().GetName())
    ;     Spellbook_Actor.ManageActor(target)
    ; endIf

    ; if ! Spellbook_Actor.HasSpellbook(SpellbookScript, target)
    ;     Spellbook_Actor.AddSpellbook(SpellbookScript, target)
    ; endIf