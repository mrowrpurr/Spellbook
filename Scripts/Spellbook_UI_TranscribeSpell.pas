.info
  .source "Spellbook_UI_TranscribeSpell.psc"
  .modifyTime 1635644218
  .compileTime 1635644443
  .user "mrowr"
  .computer "MROWR-PURR"
.endInfo
.userFlagsRef
  .flag conditional 1
  .flag hidden 0
.endUserFlagsRef
.objectTable
  .object Spellbook_UI_TranscribeSpell 
    .userFlags 0
    .docString ""
    .autoState 
    .variableTable
    .endVariableTable
    .propertyTable
    .endPropertyTable
    .stateTable
      .state
        .function GetState
          .userFlags 0
          .docString "Function that returns the current state"
          .return String
          .paramTable
          .endParamTable
          .localTable
          .endLocalTable
          .code
            RETURN ::state
          .endCode
        .endFunction
        .function GotoState
          .userFlags 0
          .docString "Function that switches this object to the specified state"
          .return None
          .paramTable
            .param newState String
          .endParamTable
          .localTable
            .local ::NoneVar None
          .endLocalTable
          .code
            CALLMETHOD onEndState self ::NoneVar
            ASSIGN ::state newState
            CALLMETHOD onBeginState self ::NoneVar
          .endCode
        .endFunction
        .function Show static
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param spellbookScript Spellbook
            .param theSpell Spell
            .param theActor Actor
          .endParamTable
          .localTable
            .local ::temp0 int
            .local ::temp1 string
            .local ::temp2 string
            .local ::nonevar none
            .local ::temp3 message
            .local ::temp4 bool
            .local ::temp5 bool
            .local hoursRequired int
            .local yes int
            .local no int
            .local result int
          .endLocalTable
          .code
            CALLSTATIC spellbook_actor GetHoursRequiredToTranscribeSpell ::temp0 theActor theSpell ;@line 4
            ASSIGN hoursRequired ::temp0 ;@line 4
            CALLSTATIC spellbook_spell GetSkillLevelName ::temp1 theSpell ;@line 8
            STRCAT ::temp1 "Transcribing " ::temp1 ;@line 7
            STRCAT ::temp1 ::temp1 " " ;@line 8
            CALLSTATIC spellbook_spell GetSchool ::temp2 theSpell ;@line 9
            STRCAT ::temp1 ::temp1 ::temp2 ;@line 8
            STRCAT ::temp2 ::temp1 " " ;@line 9
            STRCAT ::temp1 ::temp2 "Spell " ;@line 9
            CALLMETHOD GetName theSpell ::temp2  ;@line 10
            STRCAT ::temp1 ::temp1 ::temp2 ;@line 10
            STRCAT ::temp2 ::temp1 "\n\nTranscribing this spell will take " ;@line 10
            CAST ::temp1 hoursRequired ;@line 11
            STRCAT ::temp1 ::temp2 ::temp1 ;@line 11
            STRCAT ::temp2 ::temp1 " hours.\n\n" ;@line 11
            STRCAT ::temp1 ::temp2 "Are you ready to transcribe?" ;@line 11
            CALLMETHOD SetMessageText spellbookScript ::nonevar ::temp1 ;@line 6
            ASSIGN yes 0 ;@line 14
            ASSIGN no 1 ;@line 15
            PROPGET Spellbook_Message_TranscribeSpell spellbookScript ::temp3 ;@line 16
            CALLMETHOD Show ::temp3 ::temp0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 ;@line 16
            ASSIGN result ::temp0 ;@line 16
            COMPAREEQ ::temp4 result yes ;@line 17
            JUMPF ::temp4 label2 ;@line 17
            CALLSTATIC debug MessageBox ::nonevar "TODO" ;@line 18
            JUMP label0
            label2:
            COMPAREEQ ::temp5 result no ;@line 19
            JUMPF ::temp5 label1 ;@line 19
            CALLSTATIC spellbook_ui_readspellnotes Show ::nonevar spellbookScript ;@line 20
            JUMP label0
            label1:
            label0:
          .endCode
        .endFunction
        .function onBeginState
          .userFlags 0
          .docString "Event received when this state is switched to"
          .return None
          .paramTable
          .endParamTable
          .localTable
          .endLocalTable
          .code
          .endCode
        .endFunction
        .function onEndState
          .userFlags 0
          .docString "Event received when this state is switched away from"
          .return None
          .paramTable
          .endParamTable
          .localTable
          .endLocalTable
          .code
          .endCode
        .endFunction
      .endState
    .endStateTable
  .endObject
.endObjectTable