inherited ContractEditForm: TContractEditForm
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100'/'#1080#1079#1084#1077#1085#1080#1090#1100' '#1044#1086#1075#1086#1074#1086#1088
  ClientHeight = 349
  ClientWidth = 353
  ExplicitWidth = 359
  ExplicitHeight = 377
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 60
    Top = 311
    ExplicitLeft = 60
    ExplicitTop = 311
  end
  inherited bbCancel: TcxButton
    Left = 204
    Top = 311
    ExplicitLeft = 204
    ExplicitTop = 311
  end
  object cxLabel2: TcxLabel [2]
    Left = 8
    Top = 307
    Caption = #1050#1086#1076
    Visible = False
  end
  object edCode: TcxCurrencyEdit [3]
    Left = 8
    Top = 323
    EditValue = 0.000000000000000000
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 2
    Visible = False
    Width = 95
  end
  object cxLabel1: TcxLabel [4]
    Left = 8
    Top = 11
    Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
  end
  object edName: TcxTextEdit [5]
    Left = 8
    Top = 32
    TabOrder = 3
    Width = 168
  end
  object cxLabel4: TcxLabel [6]
    Left = 8
    Top = 61
    Caption = #1043#1083#1072#1074#1085#1086#1077' '#1102#1088'. '#1083#1080#1094#1086
  end
  object ceJuridicalBasis: TcxButtonEdit [7]
    Left = 8
    Top = 81
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 4
    Width = 168
  end
  object cxLabel3: TcxLabel [8]
    Left = 8
    Top = 256
    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
  end
  object edComment: TcxTextEdit [9]
    Left = 8
    Top = 276
    TabOrder = 7
    Width = 339
  end
  object cxLabel5: TcxLabel [10]
    Left = 182
    Top = 61
    Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086
  end
  object ceJuridical: TcxButtonEdit [11]
    Left = 182
    Top = 81
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 5
    Width = 165
  end
  object cxLabel6: TcxLabel [12]
    Left = 8
    Top = 115
    Caption = #1044#1085#1077#1081' '#1086#1090#1089#1088#1086#1095#1082#1080
  end
  object ceDeferment: TcxCurrencyEdit [13]
    Left = 8
    Top = 133
    EditValue = 0.000000000000000000
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 6
    Width = 95
  end
  object cxLabel7: TcxLabel [14]
    Left = 125
    Top = 115
    Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1089
  end
  object edStartDate: TcxDateEdit [15]
    Left = 125
    Top = 133
    EditValue = 42370d
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 15
    Width = 103
  end
  object cxLabel8: TcxLabel [16]
    Left = 244
    Top = 115
    Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1076#1086
  end
  object edEndDate: TcxDateEdit [17]
    Left = 244
    Top = 133
    EditValue = 42370d
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 17
    Width = 103
  end
  object cxLabel9: TcxLabel [18]
    Left = 182
    Top = 11
    Caption = '% '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080' '#1085#1072#1094#1077#1085#1082#1080
  end
  object cePercent: TcxCurrencyEdit [19]
    Left = 182
    Top = 32
    Properties.DisplayFormat = ',0.##'
    TabOrder = 19
    Width = 165
  end
  object cxLabel10: TcxLabel [20]
    Left = 8
    Top = 159
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1087#1072#1094#1080#1077#1085#1090#1072'('#1057#1086#1094'.'#1087#1088#1086#1077#1082#1090')'
  end
  object ceGroupMemberSP: TcxButtonEdit [21]
    Left = 8
    Top = 179
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 21
    Width = 168
  end
  object cxLabel11: TcxLabel [22]
    Left = 184
    Top = 159
    Caption = '% '#1089#1082#1080#1076#1082#1080' ('#1057#1086#1094'. '#1087#1088#1086#1077#1082#1090')'
  end
  object cePercentSP: TcxCurrencyEdit [23]
    Left = 182
    Top = 179
    Properties.DisplayFormat = ',0.##'
    TabOrder = 23
    Width = 165
  end
  object cxLabel12: TcxLabel [24]
    Left = 8
    Top = 209
    Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
  end
  object edBankAccount: TcxButtonEdit [25]
    Left = 8
    Top = 229
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 25
    Width = 168
  end
  object edBank: TcxTextEdit [26]
    Left = 182
    Top = 229
    Properties.ReadOnly = True
    TabOrder = 26
    Width = 165
  end
  object cxLabel13: TcxLabel [27]
    Left = 182
    Top = 208
    Caption = #1041#1072#1085#1082
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 291
    Top = 73
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Left = 304
    Top = 304
  end
  inherited ActionList: TActionList
    Left = 119
    Top = 8
  end
  inherited FormParams: TdsdFormParams
    Left = 216
    Top = 21
  end
  inherited spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Contract'
    Params = <
      item
        Name = 'ioId'
        Value = '0'
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inCode'
        Value = 0.000000000000000000
        Component = edCode
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inName'
        Value = ''
        Component = edName
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inJuridicalBasisId'
        Value = ''
        Component = JuridicalBasisGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inJuridicalId'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGroupMemberSPId'
        Value = Null
        Component = GroupMemberSPGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inBankAccountId'
        Value = Null
        Component = BankAccountGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inDeferment'
        Value = 0.000000000000000000
        Component = ceDeferment
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPercent'
        Value = Null
        Component = cePercent
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPercentSP'
        Value = Null
        Component = cePercentSP
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inComment'
        Value = ''
        Component = edComment
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inStartDate'
        Value = 42370d
        Component = edStartDate
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndDate'
        Value = 42370d
        Component = edEndDate
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 298
    Top = 244
  end
  inherited spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Contract'
    Params = <
      item
        Name = 'Id'
        Value = '0'
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'Code'
        Value = 0.000000000000000000
        Component = edCode
        MultiSelectSeparator = ','
      end
      item
        Name = 'Name'
        Value = ''
        Component = edName
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalBasisId'
        Value = ''
        Component = JuridicalBasisGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalBasisName'
        Value = ''
        Component = JuridicalBasisGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalId'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalName'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'GroupMemberSPid'
        Value = Null
        Component = GroupMemberSPGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'GroupMemberSPName'
        Value = Null
        Component = GroupMemberSPGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'Comment'
        Value = ''
        Component = edComment
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'Deferment'
        Value = 0.000000000000000000
        Component = ceDeferment
        MultiSelectSeparator = ','
      end
      item
        Name = 'StartDate'
        Value = 'NULL'
        Component = edStartDate
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'EndDate'
        Value = 'NULL'
        Component = edEndDate
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'Percent'
        Value = Null
        Component = cePercent
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'PercentSP'
        Value = Null
        Component = cePercentSP
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'BankAccountId'
        Value = Null
        Component = BankAccountGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'BankAccountName'
        Value = Null
        Component = BankAccountGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'BankName'
        Value = Null
        Component = edBank
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 226
    Top = 177
  end
  object JuridicalBasisGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceJuridicalBasis
    FormNameParam.Value = 'TJuridicalForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TJuridicalForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = JuridicalBasisGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = JuridicalBasisGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 80
    Top = 76
  end
  object JuridicalGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceJuridical
    FormNameParam.Value = 'TJuridicalForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TJuridicalForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 226
    Top = 68
  end
  object GroupMemberSPGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceGroupMemberSP
    FormNameParam.Value = 'TGroupMemberSPForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TGroupMemberSPForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GroupMemberSPGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GroupMemberSPGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 72
    Top = 164
  end
  object BankAccountGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edBankAccount
    FormNameParam.Value = 'TBankAccountForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TBankAccountForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = BankAccountGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = BankAccountGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'BankName'
        Value = Null
        Component = edBank
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 72
    Top = 222
  end
end
