scriptName Spellbook_Config

int function GetTranscriptionHoursRequired(string spellSkillLevel) global
    int hoursRequired = JDB.solveObj(".spellbook.config.transcriptionHours")
    if ! hoursRequired
        hoursRequired = JValue.readFromFile(GetConfigFilePath("TranscriptionHoursRequired.json"))
    endIf
    return JMap.getInt(hoursRequired, spellSkillLevel)
endFunction

string function GetConfigFilePath(string filename) global
    return "Data/Spellbook/" + filename
endFunction
