scriptName Spellbook_TestEffectSelf extends ActiveMagicEffect  

; Spellbook script
Spellbook property SpellbookScript auto

event OnEffectStart(Actor target, Actor caster)
    if ! Spellbook_Actor.HasSpellbook(SpellbookScript, caster)
        Spellbook_Actor.AddSpellbook(SpellbookScript, caster)
    endIf
endEvent
