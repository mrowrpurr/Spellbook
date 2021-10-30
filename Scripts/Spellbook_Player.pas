.info
  .source "Spellbook_Player.psc"
  .modifyTime 1635556800
  .compileTime 1635557372
  .user "mrowr"
  .computer "MROWR-PURR"
.endInfo
.userFlagsRef
  .flag conditional 1
  .flag hidden 0
.endUserFlagsRef
.objectTable
  .object Spellbook_Player ReferenceAlias
    .userFlags 0
    .docString ""
    .autoState 
    .variableTable
      .variable SpellbookScript Spellbook
        .userFlags 0
        .initialValue None
      .endVariable
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
        .function OnInit 
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
          .endParamTable
          .localTable
            .local ::temp0 quest
            .local ::temp1 spellbook
          .endLocalTable
          .code
            CALLMETHOD GetOwningQuest self ::temp0  ;@line 7
            CAST ::temp1 ::temp0 ;@line 7
            ASSIGN SpellbookScript ::temp1 ;@line 7
          .endCode
        .endFunction
        .function OnPlayerLoadGame 
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
          .endParamTable
          .localTable
            .local ::nonevar none
          .endLocalTable
          .code
            CALLMETHOD OnPlayerLoadGame SpellbookScript ::nonevar  ;@line 12
          .endCode
        .endFunction
      .endState
    .endStateTable
  .endObject
.endObjectTable