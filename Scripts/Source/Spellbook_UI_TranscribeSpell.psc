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

        Input.TapKey(1) ; Escape (Book)

        FadeToBlack(spellbookScript)

        Utility.WaitMenuMode(1)

        Input.TapKey(1) ; Escape (Inventory)
        Input.TapKey(1) ; Escape (Inventory)

        Utility.WaitMenuMode(1)

        spellbookScript.GameHour.Mod(hoursRequired)

        ; Play a sound!
        Debug.Notification("Waiting...")
        Utility.WaitMenuMode(4.0)
        Debug.Notification("Will play a sound here...")
        Utility.WaitMenuMode(4.0)

        FadeFromBlack(spellbookScript)

        theActor.AddSpell(theSpell, abVerbose = false)
        Debug.Notification(theActor.GetActorBase().GetName() + " transcribed " + theSpell.GetName())
    elseIf result == no
        Spellbook_UI_ReadSpellNotes.Show(spellbookScript)
    endIf
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
