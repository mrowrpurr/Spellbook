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
        Debug.MessageBox("TODO")
    elseIf result == no
        Spellbook_UI_ReadSpellNotes.Show(spellbookScript)
    endIf
endFunction