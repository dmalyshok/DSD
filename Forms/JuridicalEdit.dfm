﻿object JuridicalEditForm: TJuridicalEditForm
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086#1075#1086' '#1083#1080#1094#1072
  ClientHeight = 333
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  isAlwaysRefresh = True
  isFree = False
  PixelsPerInch = 96
  TextHeight = 13
  object edName: TcxTextEdit
    Left = 40
    Top = 68
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 40
    Top = 48
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object cxButton1: TcxButton
    Left = 72
    Top = 293
    Width = 75
    Height = 25
    Action = InsertUpdateGuides
    Default = True
    ModalResult = 8
    TabOrder = 6
  end
  object cxButton2: TcxButton
    Left = 216
    Top = 293
    Width = 75
    Height = 25
    Action = dsdFormClose
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 8
    TabOrder = 7
  end
  object Код: TcxLabel
    Left = 40
    Top = 3
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit
    Left = 40
    Top = 25
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 8
    Width = 273
  end
  object cxLabel2: TcxLabel
    Left = 40
    Top = 92
    Caption = #1050#1086#1076' GLN'
  end
  object edGLNCode: TcxTextEdit
    Left = 40
    Top = 115
    TabOrder = 1
    Width = 153
  end
  object cbisCorporate: TcxCheckBox
    Left = 202
    Top = 115
    Caption = #1053#1072#1096#1077' '#1102#1088'. '#1083#1080#1094#1086
    TabOrder = 2
    Width = 111
  end
  object cxLabel3: TcxLabel
    Left = 40
    Top = 139
    Caption = #1043#1088#1091#1087#1087#1072' '#1102#1088'. '#1083#1080#1094
  end
  object cxLabel4: TcxLabel
    Left = 40
    Top = 184
    Caption = #1050#1083#1072#1089#1089#1080#1092#1080#1082#1072#1090#1086#1088' '#1089#1074#1086#1081#1089#1090#1074' '#1090#1086#1074#1072#1088#1072
  end
  object ceJuridicalGroup: TcxButtonEdit
    Left = 40
    Top = 162
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 3
    Width = 273
  end
  object ceGoodsProperty: TcxButtonEdit
    Left = 40
    Top = 207
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 4
    Width = 273
  end
  object cxLabel5: TcxLabel
    Left = 40
    Top = 232
    Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
  end
  object ceInfoMoney: TcxButtonEdit
    Left = 40
    Top = 255
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 5
    Width = 273
  end
  object ActionList: TActionList
    Left = 296
    Top = 72
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
        end
        item
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
    end
    object InsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'Ok'
    end
    object dsdFormClose: TdsdFormClose
      Category = 'DSDLib'
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = dsdFormParams
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
        Component = edName
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inGLNCode'
        Value = ''
        Component = edGLNCode
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inisCorporate'
        Value = 'False'
        Component = cbisCorporate
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalGroupId'
        Value = ''
        Component = JuridicalGroupGuides
        ParamType = ptInput
      end
      item
        Name = 'inGoodsPropertyId'
        Value = ''
        Component = GoodsPropertyGuides
        ParamType = ptInput
      end
      item
        Name = 'inInfoMoneyId'
        Value = ''
        Component = InfoMoneyGuides
        ParamType = ptInput
      end>
    Left = 240
    Top = 48
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end
      item
        Name = 'GroupId'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'GroupName'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 240
    Top = 8
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = dsdFormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'Name'
        Value = ''
        Component = edName
        DataType = ftString
      end
      item
        Name = 'Code'
        Value = 0.000000000000000000
        Component = ceCode
      end
      item
        Name = 'GLNCode'
        Value = ''
        Component = edGLNCode
        DataType = ftString
      end
      item
        Name = 'isCorporate'
        Value = 'False'
        Component = cbisCorporate
      end
      item
        Name = 'JuridicalGroupId'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'JuridicalGroupName'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'GoodsPropertyId'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'GoodsPropertyName'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'InfoMoneyId'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'InfoMoneyName'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'TextValue'
      end>
    Left = 192
    Top = 88
  end
  object JuridicalGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceJuridicalGroup
    FormName = 'TJuridicalGroupForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 224
    Top = 152
  end
  object GoodsPropertyGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceGoodsProperty
    FormName = 'TGoodsPropertyForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 288
    Top = 192
  end
  object InfoMoneyGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceInfoMoney
    FormName = 'TInfoMoneyForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 288
    Top = 240
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 16
    Top = 280
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    StorageName = 'cxPropertiesStore'
    Left = 304
    Top = 120
  end
end
