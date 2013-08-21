﻿inherited GoodsGroupEditForm: TGoodsGroupEditForm
  Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 202
  ClientWidth = 371
  ExplicitWidth = 387
  PixelsPerInch = 96
  TextHeight = 13
  object edName: TcxTextEdit
    Left = 40
    Top = 76
    TabOrder = 1
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 40
    Top = 53
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
  end
  object cxButton1: TcxButton
    Left = 72
    Top = 148
    Width = 75
    Height = 25
    Action = dsdInsertUpdateGuides1
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object cxButton2: TcxButton
    Left = 216
    Top = 148
    Width = 75
    Height = 25
    Action = dsdFormClose1
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 8
    TabOrder = 4
  end
  object cxLabel2: TcxLabel
    Left = 40
    Top = 98
    Caption = #1043#1088#1091#1087#1087#1072' '#1088#1086#1076#1080#1090#1077#1083#1100
  end
  object ceCode: TcxCurrencyEdit
    Left = 40
    Top = 26
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 0
    Width = 273
  end
  object Код: TcxLabel
    Left = 40
    Top = 3
    Caption = #1050#1086#1076
  end
  object ceParentGroup: TcxButtonEdit
    Left = 40
    Top = 121
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 7
    Width = 273
  end
  object ActionList: TActionList
    Left = 328
    Top = 72
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
    end
    object dsdFormClose1: TdsdFormClose
    end
    object dsdInsertUpdateGuides1: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1054#1082
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_GoodsGroup'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = dsdFormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end
      item
        Name = 'inCode'
        Component = ceCode
        DataType = ftInteger
        ParamType = ptInput
        Value = 0.000000000000000000
      end
      item
        Name = 'inName'
        Component = edName
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inParentId'
        Component = dsdGoodsGroupGuides
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end>
    Left = 256
    Top = 8
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end>
    Left = 184
    Top = 24
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_GoodsGroup'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Component = dsdFormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'Code'
        Component = ceCode
        DataType = ftInteger
        ParamType = ptOutput
        Value = 0.000000000000000000
      end
      item
        Name = 'Name'
        Component = edName
        DataType = ftString
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'ParentId'
        Component = dsdGoodsGroupGuides
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptOutput
        Value = '0'
      end
      item
        Name = 'ParentName'
        Component = dsdGoodsGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptOutput
        Value = ''
      end>
    Left = 328
    Top = 16
  end
  object dsdGoodsGroupGuides: TdsdGuides
    Key = '0'
    LookupControl = ceParentGroup
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 296
    Top = 112
  end
end
