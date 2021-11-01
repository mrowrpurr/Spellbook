scriptName Spellbook_Actor

bool function CanTranscribeAnySpells(Actor theActor) global
    Form[] theSpells = Spellbook_SpellNotes.GetSpells(theActor)
    int i = 0
    while i < theSpells.Length
        if CanTranscribe(theActor, theSpells[i] as Spell)
            return true
        endIf
        i += 1
    endWhile
    return false
endFunction

bool function CanTranscribe(Actor theActor, Spell theSpell) global
    string schoolOfMagic   = Spellbook_Spell.GetSchool(theSpell)
    int requiredSkillLevel = Spellbook_Spell.GetSkillLevel(theSpell)
    int actorSkillLevel    = GetSkillLevel(theActor, schoolOfMagic)
    return actorSkillLevel >= requiredSkillLevel
endFunction

int function GetSkillLevel(Actor theActor, string schoolOfMagic) global
    int actorSkillPoints = theActor.GetActorValue(schoolOfMagic) as int
    if actorSkillPoints < 25
        return 1
    elseIf actorSkillPoints < 50
        return 2
    elseIf actorSkillPoints < 75
        return 3
    elseIf actorSkillPoints < 100
        return 4
    else
        return 5
    endIf
endFunction

Form[] function GetTranscribeableSpells(Actor theActor) global
    int transcribableSpells = JArray.object()
    Form[] spellNotesSpells = Spellbook_SpellNotes.GetSpells(theActor)
    int i = 0
    while i < spellNotesSpells.Length
        Spell theSpell = spellNotesSpells[i] as Spell
        if Spellbook_Actor.CanTranscribe(theActor, theSpell)
            JArray.addForm(transcribableSpells, theSpell)
        endIf
        i += 1
    endWhile
    return JArray.asFormArray(transcribableSpells)
endFunction

int function GetHoursRequiredToTranscribeSpell(Actor theActor, Spell theSpell) global
    string schoolOfMagic        = Spellbook_Spell.GetSchool(theSpell)
    int spellSkillLevel         = Spellbook_Spell.GetSkillLevel(theSpell)
    string spellSkillLevelName  = Spellbook_Spell.GetSkillLevelName(theSpell)
    float actorSkillAV          = theActor.GetActorValue(schoolOfMagic)
    int baseHoursRequired       = Spellbook_Config.GetTranscriptionHoursRequired(spellSkillLevelName)
    float hoursToSubtract       = baseHoursRequired * (actorSkillAV / 100.0)
    int hoursRequired           = Math.Ceiling(baseHoursRequired - hoursToSubtract)
    if hoursRequired <= 0
        hoursRequired = 1
    endIf
    return hoursRequired
endFunction

bool function HasSpellNotes(Spellbook spellbookScript, Actor theActor) global
    return theActor.GetItemCount(spellbookScript.Spellbook_SpellNotes_BaseForm) > 0
endFunction

; TODO: update with all additional Spellbook forms, if we add them!
bool function HasSpellbook(Spellbook spellbookScript, Actor theActor) global
    return theActor.GetItemCount(spellbookScript.Spellbook_Spellbook_BaseForm1) > 0
endFunction

; Give the player a spellbook!
function AddSpellbook(Spellbook spellbookScript, Actor theActor) global
    ObjectReference theSpellbook = spellbookScript.SpellbookContainer.GetReference().PlaceAtMe(spellbookScript.Spellbook_Spellbook_BaseForm1)
    spellbookScript.SpellbookBook.ForceRefTo(theSpellbook)

    ; TODO ensure that we give everyone a unique spellbook
    theSpellbook.SetDisplayName(theActor.GetActorBase().GetName() + "'s Spellbook")

    theActor.AddItem(theSpellbook)
endFunction

bool function IsManaged(Actor theActor) global
    return JFormDB.solveObj(theActor, ".spellbook")
endFunction

function ManageActor(Actor theActor) global
    if IsManaged(theActor)
        return
    else
        ; Mark them as being managed
        JFormDB.solveObjSetter(theActor, ".spellbook", JMap.object(), createMissingKeys = true)

        ; Take away their Spell Tomes!
        TakeAwayAllSpellTomes(theActor)

        ; Take away their Spells!
        TakeAwayAllSpells(theActor)
    endIf
endFunction

function UnmanageActor(Actor theActor) global
    if IsManaged(theActor)
        JFormDB.solveObjSetter(theActor, ".spellbook", 0)
    endIf
endFunction

function TakeAwayAllSpellTomes(Actor theActor) global
    int count = theActor.GetNumItems()
    int numberOfTomesRemoved = 0
    int i = 0
    while i < count
        Book theBook = theActor.GetNthForm(i - numberOfTomesRemoved) as Book
        Spell theSpell
        if theBook
            theSpell = theBook.GetSpell()
        endIf
        if theSpell
            Debug.MessageBox("Removed spell tome " + theBook.GetName() + " from " + theActor.GetActorBase().GetName())
            theActor.RemoveItem(theBook, 999999, abSilent = true)
            Spellbook_SpellNotes.AddSpell(theActor, theSpell)
            numberOfTomesRemoved += 1
        endIf
        i += 1
    endWhile
endfunction

function TakeAwayAllSpells(Actor theActor) global
    Debug.MessageBox("Taking away spells from " + theActor.GetActorBase().GetName())
    int count = theActor.GetSpellCount()
    int numberOfSpellRemoved = 0
    int i = 0
    while i < count
        ; Spell theSpell = theActor.GetNthSpell(i - numberOfSpellRemoved)
        ; if theSpell.GetName()
        ;     Debug.MessageBox("Spell " + theSpell.GetName() + " perk " + theSpell.GetPerk().GetName())
        ;     if theSpell.GetPerk() ; Track it by default!
        ;         theActor.RemoveSpell(theSpell)
        ;         Debug.MessageBox("Removed spell " + theSpell.GetName() + " from " + theActor.GetActorBase().GetName())
        ;         Spellbook_Spellbook.AddUnpreparedSpell(theActor, theSpell)
        ;         numberOfSpellRemoved += 1
        ;     endIf
        ; endIf
        i += 1
    endWhile

    ; Actor Base
    ActorBase theActorBase = theActor.GetActorBase()
    count = theActorBase.GetSpellCount()
    numberOfSpellRemoved = 0
    i = 0
    while i < count
        Spell theSpell = theActorBase.GetNthSpell(i - numberOfSpellRemoved)
        if theSpell.GetName()
            ; Debug.MessageBox("Removing Spell: " + theSpell.GetName() + " - " + theSpell.GetPerk().GetName())
            Debug.Trace("... Removing Spell: " + theSpell.GetName() + " ~ Perk: " + theSpell.GetPerk().GetName() + " ...")
            ; Utility.Wait(3)

            ; Debug.MessageBox("[Actor Base] Spell " + theSpell.GetName() + " perk " + theSpell.GetPerk().GetName())
            ; if theSpell.GetPerk() ; Track it by default!
                theActor.RemoveSpell(theSpell)
                PO3_SKSEFunctions.RemoveBaseSpell(theActor, theSpell)
                Debug.Trace("[Actor Base] Removed spell " + theSpell.GetName() + " from " + theActor.GetActorBase().GetName())
                Spellbook_Spellbook.AddUnpreparedSpell(theActor, theSpell)
                numberOfSpellRemoved += 1
            ; endIf
        endIf
        i += 1
    endWhile

    ; ; Race
    ; Race theActorRace = theActor.GetRace()
    ; count = theActorRace.GetSpellCount()
    ; numberOfSpellRemoved = 0
    ; i = 0
    ; while i < count
    ;     Spell theSpell = theActorRace.GetNthSpell(i - numberOfSpellRemoved)
    ;     Debug.MessageBox("[Actor RACE] Spell " + theSpell.GetName() + " perk " + theSpell.GetPerk().GetName())
    ;     ; if theSpell.GetPerk() ; Track it by default!
    ;         theActor.RemoveSpell(theSpell)
    ;         PO3_SKSEFunctions.RemoveBaseSpell(theActor, theSpell)
    ;         Debug.MessageBox("[Actor RACE] Removed spell " + theSpell.GetName() + " from " + theActor.GetActorBase().GetName())
    ;         Spellbook_Spellbook.AddUnpreparedSpell(theActor, theSpell)
    ;         numberOfSpellRemoved += 1
    ;     ; endIf
    ;     i += 1
    ; endWhile
endFunction
