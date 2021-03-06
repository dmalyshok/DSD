﻿inherited JuridicalEditForm: TJuridicalEditForm
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100'/'#1048#1079#1084#1077#1085#1080#1090#1100' <'#1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086'>'
  ClientHeight = 392
  ClientWidth = 890
  ExplicitWidth = 896
  ExplicitHeight = 420
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 53
    Top = 360
    Action = InsertUpdateGuides
    TabOrder = 3
    ExplicitLeft = 53
    ExplicitTop = 360
  end
  inherited bbCancel: TcxButton
    Left = 164
    Top = 360
    Action = actFormClose
    TabOrder = 4
    ExplicitLeft = 164
    ExplicitTop = 360
  end
  object edName: TcxTextEdit [2]
    Left = 5
    Top = 61
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel [3]
    Left = 5
    Top = 43
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086#1075#1086' '#1083#1080#1094#1072
  end
  object Код: TcxLabel [4]
    Left = 5
    Top = 2
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit [5]
    Left = 5
    Top = 19
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 2
    Width = 273
  end
  object cbisCorporate: TcxCheckBox [6]
    Left = 9
    Top = 146
    Caption = #1053#1072#1096#1077' '#1102#1088'.'#1083'.'
    TabOrder = 1
    Width = 93
  end
  object Panel: TPanel [7]
    Left = 296
    Top = 0
    Width = 594
    Height = 392
    Align = alRight
    BevelEdges = [beLeft]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 7
    object PageControl: TcxPageControl
      Left = 0
      Top = 0
      Width = 592
      Height = 392
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = JuridicalDetailTS
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 392
      ClientRectRight = 592
      ClientRectTop = 24
      object JuridicalDetailTS: TcxTabSheet
        Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099
        ImageIndex = 0
        object edFullName: TcxDBTextEdit
          Left = 16
          Top = 19
          DataBinding.DataField = 'FullName'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 0
          Width = 425
        end
        object edJuridicalAddress: TcxDBTextEdit
          Left = 16
          Top = 63
          DataBinding.DataField = 'JuridicalAddress'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 1
          Width = 425
        end
        object edOKPO: TcxDBTextEdit
          Left = 16
          Top = 110
          DataBinding.DataField = 'OKPO'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 2
          Width = 193
        end
        object edINN: TcxDBTextEdit
          Left = 248
          Top = 110
          DataBinding.DataField = 'INN'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 3
          Width = 193
        end
        object edAccounterName: TcxDBTextEdit
          Left = 248
          Top = 158
          DataBinding.DataField = 'AccounterName'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 5
          Width = 193
        end
        object edNumberVAT: TcxDBTextEdit
          Left = 16
          Top = 158
          DataBinding.DataField = 'NumberVAT'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 4
          Width = 193
        end
        object edBankAccount: TcxDBTextEdit
          Left = 248
          Top = 202
          DataBinding.DataField = 'BankAccount'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 7
          Width = 193
        end
        object cxLabel6: TcxLabel
          Left = 16
          Top = -1
          Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086#1075#1086' '#1083#1080#1094#1072
        end
        object cxLabel7: TcxLabel
          Left = 16
          Top = 44
          Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
        end
        object cxLabel8: TcxLabel
          Left = 16
          Top = 88
          Caption = #1054#1050#1055#1054
        end
        object cxLabel9: TcxLabel
          Left = 248
          Top = 88
          Caption = #1048#1053#1053
        end
        object cxLabel10: TcxLabel
          Left = 16
          Top = 137
          Caption = #8470' '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1072' '#1053#1044#1057
        end
        object cxLabel11: TcxLabel
          Left = 248
          Top = 137
          Caption = #1060#1048#1054' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1072
        end
        object edBank: TcxDBButtonEdit
          Left = 352
          Top = 223
          DataBinding.DataField = 'BankName'
          DataBinding.DataSource = JuridicalDetailsDS
          Properties.Buttons = <
            item
              Action = actChoiceBank
              Default = True
              Kind = bkEllipsis
            end>
          Properties.ReadOnly = True
          TabOrder = 6
          Visible = False
          Width = 193
        end
        object cxLabel12: TcxLabel
          Left = 352
          Top = 203
          Caption = #1041#1072#1085#1082
          Visible = False
        end
        object cxLabel13: TcxLabel
          Left = 248
          Top = 182
          Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
        end
        object cxLabel18: TcxLabel
          Left = 248
          Top = 230
          Caption = #1058#1077#1083#1077#1092#1086#1085
        end
        object edPhone: TcxDBTextEdit
          Left = 248
          Top = 250
          DataBinding.DataField = 'Phone'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 17
          Width = 193
        end
        object JuridicalDetailsGrid: TcxGrid
          Left = 451
          Top = 0
          Width = 141
          Height = 368
          Align = alRight
          TabOrder = 18
          object JuridicalDetailsGridDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = JuridicalDetailsDS
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Appending = True
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
            object colJDData: TcxGridDBColumn
              Caption = #1044#1072#1090#1072
              DataBinding.FieldName = 'StartDate'
              PropertiesClassName = 'TcxDateEditProperties'
              Properties.InputKind = ikRegExpr
              Properties.SaveTime = False
              Properties.ShowTime = False
              Properties.WeekNumbers = True
              Width = 101
            end
          end
          object JuridicalDetailsGridLevel: TcxGridLevel
            GridView = JuridicalDetailsGridDBTableView
          end
        end
        object cxLabel15: TcxLabel
          Left = 16
          Top = 182
          Caption = #1060#1048#1054' '#1076#1080#1088#1077#1082#1090#1086#1088#1072
        end
        object edMainName: TcxDBTextEdit
          Left = 16
          Top = 202
          DataBinding.DataField = 'MainName'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 20
          Width = 193
        end
        object cxLabel16: TcxLabel
          Left = 18
          Top = 230
          Caption = #1042#1080#1090#1103#1075' '#1079' '#1088#1077#1108#1089#1090#1088#1091' '#1087#1083#1072#1090#1085#1080#1082#1110#1074' '#1055#1044#1042
        end
        object edReestr: TcxDBTextEdit
          Left = 18
          Top = 250
          DataBinding.DataField = 'Reestr'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 22
          Width = 193
        end
        object cxLabel17: TcxLabel
          Left = 18
          Top = 278
          Caption = #8470' '#1088#1110#1096#1077#1085#1085#1103' '#1087#1088#1086' '#1074#1080#1076#1072#1095#1091' '#1083#1110#1094#1077#1085#1079#1110#1111
        end
        object edDecision: TcxDBTextEdit
          Left = 18
          Top = 298
          DataBinding.DataField = 'Decision'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 24
          Width = 193
        end
        object cxLabel20: TcxLabel
          Left = 248
          Top = 278
          Caption = #1044#1072#1090#1072' '#1088#1110#1096#1077#1085#1085#1103' '#1087#1088#1086' '#1074#1080#1076#1072#1095#1091' '#1083#1110#1094#1077#1085#1079#1110#1111
        end
        object edDecisionDate: TcxDBTextEdit
          Left = 248
          Top = 298
          ParentCustomHint = False
          DataBinding.DataField = 'DecisionDate'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 26
          Width = 193
        end
        object cxLabel21: TcxLabel
          Left = 18
          Top = 323
          Caption = #8470' '#1083#1110#1094#1077#1085#1079#1110#1111
        end
        object edLicense: TcxDBTextEdit
          Left = 18
          Top = 340
          DataBinding.DataField = 'License'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 28
          Width = 193
        end
      end
      object ContractTS: TcxTabSheet
        Caption = #1044#1086#1075#1086#1074#1086#1088#1072
        ImageIndex = 2
        object ContractDockControl: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 592
          Height = 26
          Align = dalTop
          BarManager = dxBarManager
        end
        object ContractGrid: TcxGrid
          Left = 0
          Top = 26
          Width = 667
          Height = 342
          Align = alLeft
          TabOrder = 0
          object ContractGridDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = ContractDS
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnHiding = True
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            OptionsView.Indicator = True
            Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
            object clName: TcxGridDBColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              DataBinding.FieldName = 'Name'
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaCenter
              Options.Editing = False
              Width = 55
            end
            object colDeferment: TcxGridDBColumn
              Caption = #1054#1090#1089#1088#1086#1095#1082#1072
              DataBinding.FieldName = 'Deferment'
              HeaderAlignmentVert = vaCenter
              Options.Editing = False
            end
            object clComment: TcxGridDBColumn
              Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
              DataBinding.FieldName = 'Comment'
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaCenter
              Width = 100
            end
            object clIsErased: TcxGridDBColumn
              Caption = #1059#1076#1072#1083#1077#1085
              DataBinding.FieldName = 'isErased'
              Visible = False
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaCenter
              Options.Editing = False
              Width = 30
            end
          end
          object ContractGridLevel: TcxGridLevel
            GridView = ContractGridDBTableView
          end
        end
      end
    end
  end
  object cxLabel19: TcxLabel [8]
    Left = 5
    Top = 84
    Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1089#1077#1090#1100
  end
  object ceRetail: TcxButtonEdit [9]
    Left = 5
    Top = 102
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 9
    Width = 273
  end
  object cePercent: TcxCurrencyEdit [10]
    Left = 112
    Top = 146
    Properties.DisplayFormat = ',0.##'
    TabOrder = 12
    Width = 166
  end
  object cxLabel2: TcxLabel [11]
    Left = 112
    Top = 128
    Caption = '% '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080' '#1085#1072#1094#1077#1085#1082#1080
  end
  object cxLabel3: TcxLabel [12]
    Left = 8
    Top = 173
    Caption = #1054#1095#1077#1088#1077#1076#1100' '#1087#1083#1072#1090#1077#1078#1072':'
  end
  object cePayOrder: TcxCurrencyEdit [13]
    Left = 112
    Top = 173
    Properties.AssignedValues.MinValue = True
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = ',0'
    TabOrder = 14
    Width = 166
  end
  object cxLabel4: TcxLabel [14]
    Left = 8
    Top = 203
    Caption = #1052#1080#1085'. '#1079#1072#1082#1072#1079', '#1075#1088#1085
  end
  object ceOrderSumm: TcxCurrencyEdit [15]
    Left = 8
    Top = 221
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 16
    Width = 97
  end
  object cxLabel5: TcxLabel [16]
    Left = 111
    Top = 203
    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '#1084#1080#1085'. '#1089#1091#1084#1084#1077' '#1079#1072#1082#1072#1079#1072
  end
  object ceOrderSummComment: TcxTextEdit [17]
    Left = 111
    Top = 221
    TabOrder = 17
    Width = 167
  end
  object ceOrderTime: TcxTextEdit [18]
    Left = 8
    Top = 264
    TabOrder = 21
    Width = 270
  end
  object cxLabel14: TcxLabel [19]
    Left = 8
    Top = 246
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' ('#1080#1085#1092#1086#1088#1084#1072#1090#1080#1074#1085#1086')'
  end
  object chisLoadBarcode: TcxCheckBox [20]
    Left = 8
    Top = 298
    Caption = #1088#1072#1079#1088#1077#1096#1080#1090#1100' '#1080#1084#1087#1086#1088#1090' '#1096#1090#1088#1080#1093'-'#1082#1086#1076#1086#1074
    TabOrder = 24
    Width = 270
  end
  object cbisDeferred: TcxCheckBox [21]
    Left = 8
    Top = 325
    Caption = #1080#1089#1082#1083#1102#1095#1077#1085#1080#1077' - '#1079#1072#1082#1072#1079' '#1074#1089#1077#1075#1076#1072' "'#1054#1090#1083#1086#1078#1077#1085'"'
    TabOrder = 25
    Width = 270
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 467
    Top = 104
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Left = 72
    Top = 8
  end
  inherited ActionList: TActionList
    Left = 823
    Top = 103
    inherited actRefresh: TdsdDataSetRefresh
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spJuridicalDetails
        end
        item
          StoredProc = spClearDefaluts
        end
        item
          StoredProc = spContract
        end
        item
        end>
    end
    object InsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end
        item
          StoredProc = spJuridicalDetailsIU
        end>
      Caption = 'Ok'
    end
    object actFormClose: TdsdFormClose
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
    end
    object actContractInsert: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      ImageIndex = 0
      FormName = 'TContractEditForm'
      FormNameParam.Value = 'TContractEditForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = edName
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = False
      DataSource = ContractDS
      DataSetRefresh = actContractRefresh
      IdFieldName = 'Id'
    end
    object actContractUpdate: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 115
      ImageIndex = 1
      FormName = 'TContractEditForm'
      FormNameParam.Value = 'TContractEditForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = ContractCDS
          ComponentItem = 'Id'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = edName
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = False
      ActionType = acUpdate
      DataSource = ContractDS
      DataSetRefresh = actContractRefresh
      IdFieldName = 'Id'
    end
    object actContractRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spContract
      StoredProcList = <
        item
          StoredProc = spContract
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object JuridicalDetailsUDS: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spJuridicalDetailsIU
      StoredProcList = <
        item
          StoredProc = spJuridicalDetailsIU
        end>
      DataSource = JuridicalDetailsDS
    end
    object actSave: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 14
      ShortCut = 113
    end
    object actChoiceBank: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = 'actChoiceBank'
      FormName = 'TBankForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Key'
          Value = Null
          Component = JuridicalDetailsCDS
          ComponentItem = 'BankId'
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = JuridicalDetailsCDS
          ComponentItem = 'BankName'
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actMultiContractInsert: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = actSave
        end
        item
          Action = actContractInsert
        end>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      ShortCut = 45
    end
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'Name'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'OKPO'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 120
    Top = 64
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inCode'
        Value = 0.000000000000000000
        Component = ceCode
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
        Name = 'inisCorporate'
        Value = 'False'
        Component = cbisCorporate
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inRetailId'
        Value = ''
        Component = RetailGuides
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
        Name = 'inPayOrder'
        Value = Null
        Component = cePayOrder
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOrderSumm'
        Value = Null
        Component = ceOrderSumm
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOrderSummComment'
        Value = Null
        Component = ceOrderSummComment
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOrderTime'
        Value = Null
        Component = ceOrderTime
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisLoadBarcode'
        Value = False
        Component = chisLoadBarcode
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisDeferred'
        Value = Null
        Component = cbisDeferred
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 240
    Top = 96
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
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
        Name = 'Code'
        Value = 0.000000000000000000
        Component = ceCode
        MultiSelectSeparator = ','
      end
      item
        Name = 'isCorporate'
        Value = 'False'
        Component = cbisCorporate
        MultiSelectSeparator = ','
      end
      item
        Name = 'RetailId'
        Value = ''
        Component = RetailGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'RetailName'
        Value = ''
        Component = RetailGuides
        ComponentItem = 'TextValue'
        DataType = ftString
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
        Name = 'PayOrder'
        Value = Null
        Component = cePayOrder
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'OrderSumm'
        Value = Null
        Component = ceOrderSumm
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'OrderSummComment'
        Value = Null
        Component = ceOrderSummComment
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'OrderTime'
        Value = Null
        Component = ceOrderTime
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'isLoadBarcode'
        Value = False
        Component = chisLoadBarcode
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isDeferred'
        Value = Null
        Component = cbisDeferred
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 56
    Top = 64
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ImageList
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 608
    Top = 104
    DockControlHeights = (
      0
      0
      0
      0)
    object ContractBar: TdxBar
      Caption = 'ContractBar'
      CaptionButtons = <>
      DockControl = ContractDockControl
      DockedDockControl = ContractDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 877
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbContractInsert'
        end
        item
          Visible = True
          ItemName = 'bbContractUpdate'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbStatic: TdxBarStatic
      Caption = '   '
      Category = 0
      Hint = '   '
      Visible = ivAlways
    end
    object bbContractInsert: TdxBarButton
      Action = actMultiContractInsert
      Category = 0
    end
    object bbContractUpdate: TdxBarButton
      Action = actContractUpdate
      Category = 0
    end
  end
  object JuridicalDetailsDS: TDataSource
    DataSet = JuridicalDetailsCDS
    Left = 448
    Top = 176
  end
  object JuridicalDetailsCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 256
  end
  object ContractDS: TDataSource
    DataSet = ContractCDS
    Left = 768
    Top = 104
  end
  object ContractCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 832
    Top = 48
  end
  object spJuridicalDetails: TdsdStoredProc
    StoredProcName = 'gpSelect_ObjectHistory_JuridicalDetails'
    DataSet = JuridicalDetailsCDS
    DataSets = <
      item
        DataSet = JuridicalDetailsCDS
      end>
    Params = <
      item
        Name = 'injuridicalid'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inFullName'
        Value = Null
        Component = FormParams
        ComponentItem = 'Name'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOKPO'
        Value = Null
        Component = FormParams
        ComponentItem = 'OKPO'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 248
    Top = 8
  end
  object spContract: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_ContractJuridical'
    DataSet = ContractCDS
    DataSets = <
      item
        DataSet = ContractCDS
      end>
    Params = <
      item
        Name = 'injuridicalid'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 688
    Top = 104
  end
  object JuridicalDetailsAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 184
    Top = 48
  end
  object ContractAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 480
    Top = 216
  end
  object spJuridicalDetailsIU: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_ObjectHistory_JuridicalDetails'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioid'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'injuridicalid'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 'NULL'
        Component = JuridicalDetailsCDS
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inDecisionDate'
        Value = 'NULL'
        Component = JuridicalDetailsCDS
        ComponentItem = 'DecisionDate'
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inBankId'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'BankId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'infullname'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'FullName'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'injuridicaladdress'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'JuridicalAddress'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inokpo'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'OKPO'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ininn'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'INN'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'innumbervat'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'NumberVAT'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inaccountername'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'AccounterName'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inbankaccount'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'BankAccount'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inphone'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'Phone'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMainName'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'MainName'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inReestr'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'Reestr'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inDecision'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'Decision'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inLicense'
        Value = Null
        Component = JuridicalDetailsCDS
        ComponentItem = 'License'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 280
    Top = 160
  end
  object spClearDefaluts: TdsdStoredProc
    StoredProcName = 'gpGet_JuridicalDetails_ClearDefault'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'FullName'
        Value = Null
        Component = FormParams
        ComponentItem = 'Name'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'OKPO'
        Value = Null
        Component = FormParams
        ComponentItem = 'OKPO'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 896
    Top = 120
  end
  object RetailGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceRetail
    FormNameParam.Value = 'TRetailForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TRetailForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = RetailGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = RetailGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 128
    Top = 8
  end
end
