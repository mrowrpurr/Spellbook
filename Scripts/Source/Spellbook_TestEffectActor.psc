scriptName Spellbook_TestEffectActor extends ActiveMagicEffect  

; Spellbook script
Spellbook property SpellbookScript auto

event OnEffectStart(Actor target, Actor caster)
    Actor marcurio = target ; Game.GetForm(0xb9986) as Actor

    Debug.Trace(marcurioBase)

    ActorBase marcurioBase = marcurio.GetActorBase()
    
    int baseSpells = JArray.object()
    int count = marcurioBase.GetSpellCount()
    int i = 0

    while i < count
        JArray.addForm(baseSpells, marcurioBase.GetNthSpell(i))
        Debug.Trace(marcurioBase.GetNthSpell(i))
        i += 1
    endWhile

    i = 0
    while i < count
        Debug.Trace("Removing " + JArray.getForm(baseSpells, i).GetName())
        PO3_SKSEFunctions.RemoveBaseSpell(marcurio, JArray.getForm(baseSpells, i) as Spell)
        i += 1
    endWhile
endEvent




    ; if ! Spellbook_Actor.IsManaged(target)
    ;     Debug.MessageBox("Managing new actor " + target.GetActorBase().GetName())
    ;     Spellbook_Actor.ManageActor(target)
    ; endIf

    ; if ! Spellbook_Actor.HasSpellbook(SpellbookScript, target)
    ;     Spellbook_Actor.AddSpellbook(SpellbookScript, target)
    ; endIf