scriptName Spellbook_UI_TranscribeSpell

function Show(Spellbook spellbookScript, Spell theSpell, Actor theActor) global
    int hoursRequired = Spellbook_Actor.GetHoursRequiredToTranscribeSpell(theActor, theSpell)

    spellbookScript.SetMessageText( \
        "Transcribing " + \
        Spellbook_Spell.GetSkillLevelName(theSpell) + " " + \
        Spellbook_Spell.GetSchool(theSpell) + " " + \
        "Spell " + theSpell.GetName() + \
        "\n\nTranscribing this spell will take " + hoursRequired + " hours.\n\n" + \
        "Are you ready to transcribe?")

    int yes = 0
    int no = 1
    int result = spellbookScript.Spellbook_Message_TranscribeSpell.Show()
    if result == yes
        RunTranscribeSpellScene(spellbookScript, theActor, theSpell, hoursRequired)
    elseIf result == no
        Spellbook_UI_ReadSpellNotes.Show(spellbookScript)
    endIf
endFunction

function RunTranscribeSpellScene(Spellbook spellbookScript, Actor theActor, Spell theSpell, int hoursRequired) global
    FadeToBlack(spellbookScript)

    Input.TapKey(1) ; Escape (Close Book)
    Utility.WaitMenuMode(0.1)
    Input.TapKey(1) ; Escape (Inventory)
    Utility.WaitMenuMode(0.1)
    Input.TapKey(1) ; Escape (Inventory)

    Utility.WaitMenuMode(1)
    spellbookScript.ITMBookOpen.Play(theActor)

    Utility.WaitMenuMode(1.5)
    spellbookScript.ITMBookPageTurnForward.Play(theActor)
    
    Utility.WaitMenuMode(1.5)
    spellbookScript.ITMBookPageTurnBackward.Play(theActor)

    Utility.WaitMenuMode(1.5)
    spellbookScript.ITMBookPageTurnForward.Play(theActor)

    Utility.WaitMenuMode(1.5)
    spellbookScript.ITMBookOpen.Play(theActor)

    Utility.WaitMenuMode(1)

    spellbookScript.GameHour.Mod(hoursRequired)

    FadeFromBlack(spellbookScript)

    theActor.AddSpell(theSpell, abVerbose = false)
    Spellbook_SpellNotes.RemoveSpell(theActor, theSpell)

    Debug.Notification(theActor.GetActorBase().GetName() + " transcribed " + theSpell.GetName())
endFunction

function FadeToBlack(Spellbook spellbookScript) global
    spellbookScript.FadeToBlack_Enter.Apply()
    Utility.WaitMenuMode(2)
    spellbookScript.FadeToBlack_Enter.PopTo(spellbookScript.FadeToBlack_Hold)
endFunction

function FadeFromBlack(Spellbook spellbookScript) global
    spellbookScript.FadeToBlack_Enter.Remove()
    spellbookScript.FadeToBlack_Hold.PopTo(spellbookScript.FadeToBlack_Leave)
    spellbookScript.FadeToBlack_Hold.Remove()
endFunction
