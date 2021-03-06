﻿inherited MemberEditForm: TMemberEditForm
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100'/'#1048#1079#1084#1077#1085#1080#1090#1100' <'#1060#1080#1079#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086'>'
  ClientHeight = 346
  ClientWidth = 354
  ExplicitWidth = 360
  ExplicitHeight = 374
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 45
    Top = 313
    TabOrder = 1
    ExplicitLeft = 45
    ExplicitTop = 313
  end
  inherited bbCancel: TcxButton
    Left = 177
    Top = 313
    TabOrder = 2
    ExplicitLeft = 177
    ExplicitTop = 313
  end
  object cxPageControl1: TcxPageControl [2]
    Left = 0
    Top = 0
    Width = 354
    Height = 309
    Align = alTop
    TabOrder = 0
    Properties.ActivePage = tsContact
    Properties.CustomButtons.Buttons = <>
    ExplicitWidth = 287
    ClientRectBottom = 309
    ClientRectRight = 354
    ClientRectTop = 24
    object tsCommon: TcxTabSheet
      Caption = #1054#1073#1097#1080#1077' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 0
      ExplicitLeft = 3
      ExplicitTop = 3
      object edMeasureName: TcxTextEdit
        Left = 7
        Top = 66
        TabOrder = 1
        Width = 273
      end
      object cxLabel1: TcxLabel
        Left = 7
        Top = 50
        Caption = #1060#1048#1054
      end
      object Код: TcxLabel
        Left = 7
        Top = 4
        Caption = #1050#1086#1076
      end
      object ceCode: TcxCurrencyEdit
        Left = 7
        Top = 22
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '0'
        TabOrder = 0
        Width = 124
      end
      object ceINN: TcxTextEdit
        Left = 7
        Top = 107
        TabOrder = 3
        Width = 157
      end
      object cxLabel2: TcxLabel
        Left = 7
        Top = 90
        Caption = #1048#1053#1053
      end
      object cxLabel3: TcxLabel
        Left = 171
        Top = 90
        Caption = #1042#1086#1076#1080#1090#1077#1083#1100#1089#1082#1086#1077' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1077
      end
      object cxLabel4: TcxLabel
        Left = 7
        Top = 233
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      end
      object ceDriverCertificate: TcxTextEdit
        Left = 171
        Top = 107
        TabOrder = 4
        Width = 157
      end
      object ceComment: TcxTextEdit
        Left = 7
        Top = 251
        TabOrder = 5
        Width = 321
      end
      object cbOfficial: TcxCheckBox
        Left = 143
        Top = 22
        Hint = #1054#1092#1086#1088#1084#1083#1077#1085' '#1086#1092#1080#1094#1080#1072#1083#1100#1085#1086
        Caption = #1054#1092#1086#1088#1084#1083#1077#1085' '#1086#1092#1080#1094#1080#1072#1083#1100#1085#1086
        TabOrder = 2
        Width = 141
      end
      object cxLabel7: TcxLabel
        Left = 171
        Top = 138
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100
      end
      object ceEducation: TcxButtonEdit
        Left = 171
        Top = 155
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        TabOrder = 12
        Width = 157
      end
      object cxLabel8: TcxLabel
        Left = 7
        Top = 138
        Caption = #1058#1077#1083#1077#1092#1086#1085
      end
      object edPhone: TcxTextEdit
        Left = 7
        Top = 155
        TabOrder = 14
        Width = 157
      end
      object cxLabel9: TcxLabel
        Left = 7
        Top = 182
        Caption = #1052#1077#1089#1090#1086' '#1087#1088#1086#1078#1080#1074#1072#1085#1080#1103
      end
      object edAddress: TcxTextEdit
        Left = 7
        Top = 202
        TabOrder = 16
        Width = 321
      end
    end
    object tsContact: TcxTabSheet
      Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 1
      ExplicitWidth = 287
      object cxLabel5: TcxLabel
        Left = 7
        Top = 4
        Caption = 'E-mail'
      end
      object edEmail: TcxTextEdit
        Left = 7
        Top = 25
        TabOrder = 1
        Width = 322
      end
      object cxLabel6: TcxLabel
        Left = 7
        Top = 55
        Caption = 'E-mail '#1087#1086#1076#1087#1080#1089#1100
      end
      object EMailSign: TcxMemo
        Left = 7
        Top = 77
        TabOrder = 3
        Height = 59
        Width = 322
      end
      object cxLabel10: TcxLabel
        Left = 7
        Top = 143
        Caption = #1060#1086#1090#1086
      end
      object Photo: TcxMemo
        Left = 7
        Top = 166
        TabOrder = 5
        Height = 107
        Width = 322
      end
    end
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 107
    Top = 272
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Left = 40
    Top = 272
  end
  inherited ActionList: TActionList
    Images = dmMain.ImageList
    Left = 239
    Top = 271
    inherited actRefresh: TdsdDataSetRefresh
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spGetMemberContact
        end>
    end
    inherited InsertUpdateGuides: TdsdInsertUpdateGuides
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end
        item
          StoredProc = spInsertUpdateContact
        end>
    end
  end
  inherited FormParams: TdsdFormParams
    Left = 168
    Top = 264
  end
  inherited spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Member'
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inCode'
        Value = 0.000000000000000000
        Component = ceCode
        ParamType = ptInput
      end
      item
        Name = 'inName'
        Value = ''
        Component = edMeasureName
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inIsOfficial'
        Value = 'False'
        Component = cbOfficial
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inINN'
        Value = ''
        Component = ceINN
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inDriverCertificate'
        Value = ''
        Component = ceDriverCertificate
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inComment'
        Value = ''
        Component = ceComment
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inPhone'
        Value = Null
        Component = edPhone
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inAddress'
        Value = Null
        Component = edAddress
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inPhoto'
        Value = Null
        Component = Photo
        DataType = ftWideString
        ParamType = ptInput
      end
      item
        Name = 'inEducationId'
        Value = Null
        Component = EducationGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end>
    Left = 224
    Top = 48
  end
  inherited spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Member'
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'Code'
        Value = 0.000000000000000000
        Component = ceCode
      end
      item
        Name = 'Name'
        Value = ''
        Component = edMeasureName
        DataType = ftString
      end
      item
        Name = 'IsOfficial'
        Value = 'False'
        Component = cbOfficial
        DataType = ftBoolean
      end
      item
        Name = 'INN'
        Value = ''
        Component = ceINN
        DataType = ftString
      end
      item
        Name = 'DriverCertificate'
        Value = ''
        Component = ceDriverCertificate
        DataType = ftString
      end
      item
        Name = 'Comment'
        Value = ''
        Component = ceComment
        DataType = ftString
      end
      item
        Name = 'EducationId'
        Value = Null
        Component = EducationGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'EducationName'
        Value = Null
        Component = EducationGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'Address'
        Value = Null
        Component = edAddress
        DataType = ftString
      end
      item
        Name = 'Phone'
        Value = Null
        Component = edPhone
        DataType = ftString
      end
      item
        Name = 'Photo'
        Value = Null
        Component = Photo
        DataType = ftWideString
      end>
    Left = 216
    Top = 120
  end
  object spInsertUpdateContact: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_MemberContact'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inEmail'
        Value = 0.000000000000000000
        Component = edEmail
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inEmailSign'
        Value = Null
        Component = EMailSign
        DataType = ftWideString
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 88
    Top = 80
  end
  object spGetMemberContact: TdsdStoredProc
    StoredProcName = 'gpGet_Object_MemberContact'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'EMail'
        Value = ''
        Component = edEmail
        DataType = ftString
      end
      item
        Name = 'EMailSign'
        Value = Null
        Component = EMailSign
        DataType = ftString
      end>
    PackSize = 1
    Left = 96
    Top = 120
  end
  object EducationGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceEducation
    FormNameParam.Value = 'TEducationForm'
    FormNameParam.DataType = ftString
    FormName = 'TEducationForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = EducationGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = EducationGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 312
    Top = 88
  end
end
