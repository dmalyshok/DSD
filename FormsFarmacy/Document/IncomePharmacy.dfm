inherited IncomePharmacyForm: TIncomePharmacyForm
  Caption = #1044#1086#1082#1091#1084#1077#1085#1090' <'#1055#1088#1080#1093#1086#1076'>'
  ClientHeight = 524
  ClientWidth = 985
  ExplicitWidth = 1001
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 126
    Width = 985
    Height = 398
    ExplicitTop = 126
    ExplicitWidth = 985
    ExplicitHeight = 398
    ClientRectBottom = 398
    ClientRectRight = 985
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 985
      ExplicitHeight = 374
      inherited cxGrid: TcxGrid
        Width = 985
        Height = 374
        ExplicitWidth = 985
        ExplicitHeight = 374
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
              Position = spFooter
              Column = SaleSumm
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = SaleSumm
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = SaleSumm
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountManual
            end
            item
              Format = '+,0.###;-0.###; ;'
              Kind = skSum
              Column = AmountDiff
            end
            item
              Format = #1042#1089#1077#1075#1086' '#1089#1090#1088#1086#1082': ,0'
              Kind = skCount
              Column = GoodsName
            end>
          OptionsBehavior.FocusCellOnCycle = False
          OptionsCustomize.DataRowSizing = False
          OptionsData.CancelOnExit = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsView.GroupSummaryLayout = gslStandard
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object GoodsCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GoodsCode'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Caption = 'actChoiceGoods'
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 45
          end
          object GoodsName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GoodsName'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 222
          end
          object Amount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 73
          end
          object SalePrice: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1088#1077#1072#1083'. '#1089' '#1053#1044#1057
            DataBinding.FieldName = 'SalePrice'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            Options.Editing = False
            Width = 76
          end
          object SaleSumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1088#1077#1072#1083'. '#1089' '#1053#1044#1057
            DataBinding.FieldName = 'SaleSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            Options.Editing = False
            Width = 83
          end
          object ExpirationDate: TcxGridDBColumn
            Caption = #1057#1088#1086#1082' '#1075#1086#1076#1085#1086#1089#1090#1080
            DataBinding.FieldName = 'ExpirationDate'
            Options.Editing = False
            Width = 70
          end
          object PartitionGoods: TcxGridDBColumn
            Caption = #1057#1077#1088#1080#1103
            DataBinding.FieldName = 'PartionGoods'
            Options.Editing = False
            Width = 70
          end
          object MakerName: TcxGridDBColumn
            Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'MakerName'
            Options.Editing = False
            Width = 100
          end
          object Measure: TcxGridDBColumn
            Caption = #1045#1076'. '#1080#1079#1084
            DataBinding.FieldName = 'Measure'
            Options.Editing = False
            Width = 53
          end
          object SertificatNumber: TcxGridDBColumn
            AlternateCaption = #1053#1086#1084#1077#1088' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Caption = #8470' '#1088#1077#1075
            DataBinding.FieldName = 'SertificatNumber'
            HeaderHint = #1053#1086#1084#1077#1088' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Options.Editing = False
            Width = 54
          end
          object SertificatStart: TcxGridDBColumn
            AlternateCaption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Caption = #1053#1072#1095'. '#1088#1077#1075'.'
            DataBinding.FieldName = 'SertificatStart'
            HeaderHint = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Options.Editing = False
            Width = 63
          end
          object SertificatEnd: TcxGridDBColumn
            AlternateCaption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Caption = #1054#1082#1086#1085#1095'. '#1088#1077#1075'.'
            DataBinding.FieldName = 'SertificatEnd'
            HeaderHint = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
            Options.Editing = False
            Width = 58
          end
          object DublePriceColour: TcxGridDBColumn
            DataBinding.FieldName = 'DublePriceColour'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
          end
          object WarningColor: TcxGridDBColumn
            DataBinding.FieldName = 'WarningColor'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
          end
          object AmountManual: TcxGridDBColumn
            Caption = #1060#1072#1082#1090'. '#1082#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'AmountManual'
            Width = 59
          end
          object AmountDiff: TcxGridDBColumn
            Caption = #1056#1072#1079#1085#1080#1094#1072' '#1082#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'AmountDiff'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '+0.###;-0.###; ;'
            Options.Editing = False
          end
          object ReasonDifferencesName: TcxGridDBColumn
            Caption = #1055#1088#1080#1095#1080#1085#1072' '#1088#1072#1079#1085#1086#1075#1083#1072#1089#1080#1103
            DataBinding.FieldName = 'ReasonDifferencesName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = ChoiceReasonDifferences
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            Width = 131
          end
          object isPrint: TcxGridDBColumn
            Caption = #1055#1077#1095'. '#1089#1090#1080#1082#1077#1088
            DataBinding.FieldName = 'isPrint'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 50
          end
          object PrintCount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1089#1090#1080#1082#1077#1088#1086#1074
            DataBinding.FieldName = 'PrintCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1050#1086#1083'-'#1074#1086' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1093' '#1089#1090#1080#1082#1077#1088#1086#1074
            Options.Editing = False
            Width = 62
          end
          object isDeferred: TcxGridDBColumn
            Caption = #1054#1090#1083#1086#1078#1077#1085#1072' ('#1079#1072#1103#1074#1082#1072')'
            DataBinding.FieldName = 'isDeferred'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
            Width = 30
          end
          object isSp: TcxGridDBColumn
            Caption = #1057#1086#1094'. '#1087#1088#1086#1077#1082#1090
            DataBinding.FieldName = 'isSp'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1042' '#1089#1087#1080#1089#1082#1077' '#1087#1088#1086#1077#1082#1090#1072' '#171#1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1083#1077#1082#1072#1088#1089#1090#1074#1072#187
            Options.Editing = False
            Width = 60
          end
        end
      end
    end
  end
  inherited DataPanel: TPanel
    Width = 985
    Height = 100
    TabOrder = 3
    ExplicitWidth = 985
    ExplicitHeight = 100
    inherited edInvNumber: TcxTextEdit
      Left = 8
      Enabled = False
      Properties.ReadOnly = False
      ExplicitLeft = 8
      ExplicitWidth = 105
      Width = 105
    end
    inherited cxLabel1: TcxLabel
      Left = 8
      ExplicitLeft = 8
    end
    inherited edOperDate: TcxDateEdit
      Left = 114
      Enabled = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      ExplicitLeft = 114
    end
    inherited cxLabel2: TcxLabel
      Left = 114
      ExplicitLeft = 114
    end
    inherited cxLabel15: TcxLabel
      Top = 45
      ExplicitTop = 45
    end
    inherited ceStatus: TcxButtonEdit
      Top = 63
      TabOrder = 7
      ExplicitTop = 63
      ExplicitWidth = 158
      ExplicitHeight = 22
      Width = 158
    end
    object cxLabel3: TcxLabel
      Left = 330
      Top = 5
      Caption = #1054#1090' '#1082#1086#1075#1086' '#1087#1088#1080#1093#1086#1076
    end
    object edFrom: TcxButtonEdit
      Left = 330
      Top = 23
      Enabled = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 4
      Width = 194
    end
    object edTo: TcxButtonEdit
      Left = 530
      Top = 23
      Enabled = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 5
      Width = 191
    end
    object cxLabel4: TcxLabel
      Left = 530
      Top = 5
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    end
    object cxLabel10: TcxLabel
      Left = 635
      Top = 46
      Caption = #1058#1080#1087' '#1053#1044#1057
    end
    object edNDSKind: TcxButtonEdit
      Left = 635
      Top = 63
      Enabled = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 11
      Width = 86
    end
    object cxLabel12: TcxLabel
      Left = 190
      Top = 65
      Caption = #1055#1088#1086#1074#1077#1088#1077#1085
    end
    object cxLabel11: TcxLabel
      Left = 224
      Top = 5
      Caption = #1044#1072#1090#1072' '#1072#1087#1090#1077#1082#1080
    end
    object edPointDate: TcxDateEdit
      Left = 224
      Top = 23
      EditValue = 42132d
      Enabled = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 14
      Width = 100
    end
    object cxLabel9: TcxLabel
      Left = 530
      Top = 46
      Caption = #8470' '#1074' '#1072#1087#1090#1077#1082#1077
    end
    object edPointNumber: TcxTextEdit
      Left = 530
      Top = 63
      Enabled = False
      Properties.ReadOnly = False
      TabOrder = 16
      Width = 99
    end
    object cbFarmacyShow: TcxCheckBox
      Left = 173
      Top = 63
      Action = mactFarmacyShow
      TabOrder = 17
      Width = 17
    end
    object cbisDocument: TcxCheckBox
      Left = 249
      Top = 63
      Caption = #1054#1088#1080#1075#1080#1085#1072#1083' '#1085#1072#1082#1083'. ('#1076#1072'/'#1085#1077#1090')'
      Properties.ReadOnly = True
      TabOrder = 18
      Width = 154
    end
    object cbisRegistered: TcxCheckBox
      Left = 405
      Top = 63
      Caption = #1052#1077#1076#1088#1077#1077#1089#1090#1088' Pfizer'
      Properties.ReadOnly = True
      TabOrder = 19
      Width = 119
    end
  end
  object cxLabel13: TcxLabel [2]
    Left = 789
    Top = 22
    Caption = #1070#1088#1083#1080#1094#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1100
    Visible = False
  end
  object edJuridical: TcxButtonEdit [3]
    Left = 791
    Top = 40
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 7
    Visible = False
    Width = 140
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 179
    Top = 416
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Tag'
          'Width')
      end>
    Left = 40
    Top = 432
  end
  inherited ActionList: TActionList
    Left = 55
    Top = 303
    inherited actRefresh: TdsdDataSetRefresh
      RefreshOnTabSetChanges = True
    end
    inherited actInsertUpdateMovement: TdsdExecStoredProc
      Enabled = False
    end
    inherited actUpdateMainDS: TdsdUpdateDataSet
      StoredProc = spUpdate_MovementItem_Income_AmountManual
      StoredProcList = <
        item
          StoredProc = spUpdate_MovementItem_Income_AmountManual
        end
        item
          StoredProc = spGetTotalSumm
        end
        item
        end>
    end
    inherited actPrint: TdsdPrintAction
      StoredProc = spSelectPrint
      StoredProcList = <
        item
          StoredProc = spSelectPrint
        end>
      Caption = #1055#1077#1095#1072#1090#1100' '#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      Hint = #1055#1077#1095#1072#1090#1100' '#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      DataSets = <
        item
          DataSet = PrintHeaderCDS
          UserName = 'frxDBDHeader'
        end
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
        end>
      Params = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
          MultiSelectSeparator = ','
        end>
      ReportName = #1056#1072#1089#1093#1086#1076#1085#1072#1103'_'#1085#1072#1082#1083#1072#1076#1085#1072#1103
      ReportNameParam.Name = #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      ReportNameParam.Value = #1056#1072#1089#1093#1086#1076#1085#1072#1103'_'#1085#1072#1082#1083#1072#1076#1085#1072#1103
      ReportNameParam.ParamType = ptInput
    end
    inherited actUnCompleteMovement: TChangeGuidesStatus
      StoredProcList = <
        item
          StoredProc = spChangeStatus
        end
        item
        end>
    end
    inherited actCompleteMovement: TChangeGuidesStatus
      StoredProcList = <
        item
          StoredProc = spChangeStatus
        end
        item
        end>
    end
    object actGoodsKindChoice: TOpenChoiceForm [13]
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = 'GoodsKindForm'
      FormName = 'TGoodsKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Key'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsKindId'
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsKindName'
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = True
    end
    object actRefreshPrice: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object actPrintForManager: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelectPrint
      StoredProcList = <
        item
          StoredProc = spSelectPrint
        end>
      Caption = 'actPrintForManager'
      ImageIndex = 16
      DataSets = <
        item
          DataSet = PrintHeaderCDS
          UserName = 'frxDBDHeader'
        end
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
        end>
      Params = <>
      ReportName = #1056#1072#1089#1093#1086#1076#1085#1072#1103'_'#1085#1072#1082#1083#1072#1076#1085#1072#1103'_'#1076#1083#1103'_'#1084#1077#1085#1077#1076#1078#1077#1088#1072
      ReportNameParam.Value = #1056#1072#1089#1093#1086#1076#1085#1072#1103'_'#1085#1072#1082#1083#1072#1076#1085#1072#1103'_'#1076#1083#1103'_'#1084#1077#1085#1077#1076#1078#1077#1088#1072
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object ChoiceReasonDifferences: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = #1042#1099#1073#1086#1088' '#1087#1088#1080#1095#1080#1085#1099' '#1088#1072#1079#1085#1086#1075#1083#1072#1089#1080#1103
      FormName = 'TReasonDifferencesForm'
      FormNameParam.Value = 'TReasonDifferencesForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Key'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'ReasonDifferencesId'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'ReasonDifferencesName'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actisDocument: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spisDocument
      StoredProcList = <
        item
          StoredProc = spisDocument
        end>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' "'#1054#1088#1080#1075#1080#1085#1072#1083' '#1044#1072'/'#1053#1077#1090'"'
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' "'#1054#1088#1080#1075#1080#1085#1072#1083' '#1044#1072'/'#1053#1077#1090'"'
      ImageIndex = 58
    end
    object actSetAmountEqual: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Value = Null
          FromParam.Component = MasterCDS
          FromParam.ComponentItem = 'Amount'
          FromParam.DataType = ftFloat
          FromParam.MultiSelectSeparator = ','
          ToParam.Value = Null
          ToParam.Component = MasterCDS
          ToParam.ComponentItem = 'AmountManual'
          ToParam.DataType = ftFloat
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = 0
          FromParam.MultiSelectSeparator = ','
          ToParam.Value = Null
          ToParam.Component = MasterCDS
          ToParam.ComponentItem = 'ReasonDifferencesId'
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = ' '
          FromParam.DataType = ftString
          FromParam.MultiSelectSeparator = ','
          ToParam.Value = Null
          ToParam.Component = MasterCDS
          ToParam.ComponentItem = 'ReasonDifferencesName'
          ToParam.DataType = ftString
          ToParam.MultiSelectSeparator = ','
        end>
      PostDataSetBeforeExecute = False
      PostDataSetAfterExecute = True
      StoredProc = spUpdate_MovementItem_Income_AmountManual
      StoredProcList = <
        item
          StoredProc = spUpdate_MovementItem_Income_AmountManual
        end>
      Caption = #1060#1072#1082#1090' = '#1076#1086#1082#1091#1084#1077#1085#1090
      ShortCut = 32
    end
    object mactFarmacyShow: TMultiAction
      Category = 'AmountManual'
      MoveParams = <>
      ActionList = <
        item
          Action = actGet_Movement_ManualAmountTrouble
        end
        item
          Action = actaOpen_Income_AmountTroubleForm
        end>
    end
    object actGet_Movement_ManualAmountTrouble: TdsdExecStoredProc
      Category = 'AmountManual'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spGet_Movement_ManualAmountTrouble
      StoredProcList = <
        item
          StoredProc = spGet_Movement_ManualAmountTrouble
        end>
      Caption = 'actGet_Movement_ManualAmountTrouble'
    end
    object actaOpen_Income_AmountTroubleForm: TdsdOpenForm
      Category = 'AmountManual'
      MoveParams = <>
      FormName = 'TIncome_AmountTroubleForm'
      FormNameParam.Value = 'TIncome_AmountTroubleForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actUpdate_MovementItem_Income_SetEqualAmount: TdsdExecStoredProc
      Category = 'AmountManual'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spUpdate_MovementItem_Income_SetEqualAmount
      StoredProcList = <
        item
          StoredProc = spUpdate_MovementItem_Income_SetEqualAmount
        end
        item
          StoredProc = spSelect
        end>
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' <'#1060#1072#1082#1090'. '#1082#1086#1083'-'#1074#1086'> = <'#1082#1086#1083'-'#1074#1086'>'
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' <'#1060#1072#1082#1090'. '#1082#1086#1083'-'#1074#1086'> = <'#1082#1086#1083'-'#1074#1086'>'
      ImageIndex = 30
    end
    object actPrintStickerOld: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProcList = <>
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072'-'#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      Hint = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072'-'#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ImageIndex = 18
      DataSets = <
        item
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsName'
          GridView = cxGridDBTableView
        end>
      Params = <
        item
          Name = 'UnitName'
          Value = 42370d
          Component = GuidesTo
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = 42371d
          Component = GuidesJuridical
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      ReportName = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.Value = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrintSticker: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelectPrintSticker
      StoredProcList = <
        item
          StoredProc = spSelectPrintSticker
        end>
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072'-'#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      Hint = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072'-'#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ImageIndex = 18
      DataSets = <
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsName'
        end>
      Params = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = GuidesTo
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = GuidesJuridical
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'isPrice'
          Value = 'True'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end>
      ReportName = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.Name = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.Value = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrintSticker_notPrice: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelectPrintSticker
      StoredProcList = <
        item
          StoredProc = spSelectPrintSticker
        end>
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072'-'#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080' '#1073#1077#1079' '#1094#1077#1085#1099
      Hint = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072'-'#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080' '#1073#1077#1079' '#1094#1077#1085#1099
      ImageIndex = 19
      DataSets = <
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsName'
        end>
      Params = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = GuidesTo
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = GuidesJuridical
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'isPrice'
          Value = 'FALSE'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end>
      ReportName = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.Name = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.Value = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1089#1072#1084#1086#1082#1083#1077#1081#1082#1080
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
      ReportNameParam.MultiSelectSeparator = ','
    end
  end
  inherited MasterDS: TDataSource
    Top = 376
  end
  inherited MasterCDS: TClientDataSet
    Left = 96
    Top = 448
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_MovementItem_Income'
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inShowAll'
        Value = False
        Component = actShowAll
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsErased'
        Value = False
        Component = actShowErased
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Value = ''
        ParamType = ptUnknown
        MultiSelectSeparator = ','
      end
      item
        Value = 0d
        Component = edOperDate
        DataType = ftDateTime
        ParamType = ptUnknown
        MultiSelectSeparator = ','
      end>
    Left = 160
    Top = 248
  end
  inherited BarManager: TdxBarManager
    Left = 80
    Top = 207
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbShowErased'
        end
        item
          Visible = True
          ItemName = 'bbShowAll'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbAddMask'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbErased'
        end
        item
          Visible = True
          ItemName = 'bbUnErased'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrintTax_Client'
        end
        item
          Visible = True
          ItemName = 'bbPrintSticker_notPrice'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbisDocument'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbMovementItemProtocol'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end>
    end
    object bbPrint_Bill: TdxBarButton [5]
      Caption = #1057#1095#1077#1090
      Category = 0
      Hint = #1057#1095#1077#1090
      Visible = ivAlways
      ImageIndex = 21
    end
    object bbPrintTax: TdxBarButton [6]
      Caption = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' ('#1087#1088#1086#1076#1072#1074#1077#1094')'
      Category = 0
      Hint = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' ('#1087#1088#1086#1076#1072#1074#1077#1094')'
      Visible = ivAlways
      ImageIndex = 16
    end
    object bbPrintTax_Client: TdxBarButton [7]
      Action = actPrintSticker
      Category = 0
    end
    inherited bbAddMask: TdxBarButton
      Visible = ivNever
    end
    object bbTax: TdxBarButton
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' <'#1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103'>'
      Category = 0
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' <'#1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103'>'
      Visible = ivAlways
      ImageIndex = 41
    end
    object dxBarButton1: TdxBarButton
      Action = actPrintForManager
      Category = 0
      Visible = ivNever
    end
    object dxBarButton2: TdxBarButton
      Action = actUpdate_MovementItem_Income_SetEqualAmount
      Category = 0
    end
    object bbisDocument: TdxBarButton
      Action = actisDocument
      Category = 0
    end
    object bbPrintSticker_notPrice: TdxBarButton
      Action = actPrintSticker_notPrice
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    ColorRuleList = <
      item
        BackGroundValueColumn = DublePriceColour
        ColorValueList = <>
      end
      item
        ValueColumn = WarningColor
        ColorValueList = <>
      end>
    SummaryItemList = <
      item
        Param.Value = Null
        Param.Component = FormParams
        Param.ComponentItem = 'TotalSumm'
        Param.DataType = ftString
        Param.MultiSelectSeparator = ','
        DataSummaryItemIndex = 5
      end>
    Left = 830
    Top = 265
  end
  inherited PopupMenu: TPopupMenu
    Left = 744
    Top = 464
    object N2: TMenuItem
      Action = actMISetErased
    end
    object N3: TMenuItem
      Action = actMISetUnErased
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
        Name = 'Key'
        Value = Null
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ShowAll'
        Value = False
        Component = actShowAll
        DataType = ftBoolean
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ReportNameIncome'
        Value = 'PrintMovement_Sale1'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ReportNameIncomeTax'
        Value = Null
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ReportNameIncomeBill'
        Value = Null
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 280
    Top = 416
  end
  inherited StatusGuides: TdsdGuides
    Left = 80
    Top = 48
  end
  inherited spChangeStatus: TdsdStoredProc
    StoredProcName = 'gpUpdate_Status_Income'
    Left = 80
    Top = 88
  end
  inherited spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Income'
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumber'
        Value = ''
        Component = edInvNumber
        MultiSelectSeparator = ','
      end
      item
        Name = 'OperDate'
        Value = 0d
        Component = edOperDate
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'StatusCode'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'Key'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'StatusName'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PriceWithVAT'
        Value = 'False'
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'FromId'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'FromName'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'ToId'
        Value = ''
        Component = GuidesTo
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'ToName'
        Value = ''
        Component = GuidesTo
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'NDSKindId'
        Value = ''
        Component = NDSKindGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'NDSKindName'
        Value = ''
        Component = NDSKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'ContractId'
        Value = Null
        Component = ContractGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'ContractName'
        Value = Null
        Component = ContractGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PaymentDate'
        Value = 'NULL'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'BranchDate'
        Value = Null
        Component = edPointDate
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumberBranch'
        Value = Null
        Component = edPointNumber
        MultiSelectSeparator = ','
      end
      item
        Name = 'Checked'
        Value = Null
        Component = cbFarmacyShow
        MultiSelectSeparator = ','
      end
      item
        Name = 'isDocument'
        Value = Null
        Component = cbisDocument
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isRegistered'
        Value = Null
        Component = cbisRegistered
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalId'
        Value = Null
        Component = GuidesJuridical
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalName'
        Value = Null
        Component = GuidesJuridical
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 216
    Top = 248
  end
  inherited spInsertUpdateMovement: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_IncomeSale'
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inChecked'
        Value = ''
        Component = cbFarmacyShow
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 162
    Top = 312
  end
  inherited GuidesFiller: TGuidesFiller
    GuidesList = <
      item
        Guides = GuidesFrom
      end
      item
        Guides = GuidesTo
      end>
    Left = 160
    Top = 192
  end
  inherited HeaderSaver: THeaderSaver
    ControlList = <
      item
      end>
    Left = 232
    Top = 193
  end
  inherited RefreshAddOn: TRefreshAddOn
    FormName = 'TIncomePharmacyJournal'
    DataSet = 'MasterCDS'
    Left = 912
    Top = 320
  end
  inherited spErasedMIMaster: TdsdStoredProc
    StoredProcName = 'gpMovementItem_Income_SetErased'
    Left = 710
    Top = 376
  end
  inherited spUnErasedMIMaster: TdsdStoredProc
    StoredProcName = 'gpMovementItem_Income_SetUnErased'
    Left = 710
    Top = 328
  end
  inherited spInsertUpdateMIMaster: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MovementItem_Income'
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'GoodsId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inAmount'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPrice'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Price'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inSalePrice'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'SalePrice'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPrintCount'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'PrintCount'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisPrint'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'isPrint'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inFEA'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'FEA'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMeasure'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Measure'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 160
    Top = 368
  end
  inherited spInsertMaskMIMaster: TdsdStoredProc
    Params = <
      item
        Name = 'ioId'
        Value = '0'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'GoodsId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inAmount'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPrice'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Price'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 368
    Top = 272
  end
  inherited spGetTotalSumm: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Summ'
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TotalSummMVAT'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'TotalSummPVAT'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end>
    Left = 420
    Top = 188
  end
  object RefreshDispatcher: TRefreshDispatcher
    IdParam.Value = Null
    IdParam.MultiSelectSeparator = ','
    RefreshAction = actRefreshPrice
    ComponentList = <
      item
      end>
    Left = 544
    Top = 312
  end
  object PrintHeaderCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 508
    Top = 193
  end
  object PrintItemsCDS: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'GoodsName'
    Params = <>
    Left = 508
    Top = 246
  end
  object PrintItemsSverkaCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 644
    Top = 334
  end
  object spSelectPrint: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Sale_Print'
    DataSet = PrintHeaderCDS
    DataSets = <
      item
        DataSet = PrintHeaderCDS
      end
      item
        DataSet = PrintItemsCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 319
    Top = 208
  end
  object GuidesFrom: TdsdGuides
    KeyField = 'Id'
    LookupControl = edFrom
    FormNameParam.Value = 'TJuridicalForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TJuridicalForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 192
    Top = 16
  end
  object GuidesTo: TdsdGuides
    KeyField = 'Id'
    LookupControl = edTo
    FormNameParam.Value = 'TUnit_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TUnit_ObjectForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesTo
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesTo
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 464
  end
  object NDSKindGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edNDSKind
    FormNameParam.Value = 'TNDSKindForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TNDSKindForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = NDSKindGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = NDSKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 632
    Top = 80
  end
  object ContractGuides: TdsdGuides
    KeyField = 'Id'
    FormNameParam.Value = 'TContractForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TContractForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 671
    Top = 200
  end
  object spIncome_GoodsId: TdsdStoredProc
    StoredProcName = 'gpUpdate_MovementItem_Income_GoodsId'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 264
    Top = 296
  end
  object spCalculateSalePrice: TdsdStoredProc
    StoredProcName = 'gpUpdate_MovementItem_Income_SendPrice'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inIncomeId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 320
    Top = 160
  end
  object spUpdate_MovementItem_Income_AmountManual: TdsdStoredProc
    StoredProcName = 'gpUpdate_MovementItem_Income_AmountManual'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMovementItemId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inAmountManual'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AmountManual'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inReasonDifferences'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'ReasonDifferencesId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outAmountDiff'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AmountDiff'
        DataType = ftFloat
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 368
    Top = 336
  end
  object spGet_Movement_ManualAmountTrouble: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_ManualAmountTrouble'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inReverce'
        Value = False
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ioChecked'
        Value = Null
        Component = cbFarmacyShow
        DataType = ftBoolean
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outTrouble'
        Value = Null
        Component = actaOpen_Income_AmountTroubleForm
        ComponentItem = 'Enabled'
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 536
    Top = 400
  end
  object spUpdate_MovementItem_Income_SetEqualAmount: TdsdStoredProc
    StoredProcName = 'gpUpdate_MovementItem_Income_SetEqualAmount'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 368
    Top = 432
  end
  object spisDocument: TdsdStoredProc
    StoredProcName = 'gpUpdateMovement_isDocument'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId '
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisDocument'
        Value = 'False'
        Component = cbisDocument
        DataType = ftBoolean
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 800
    Top = 203
  end
  object GuidesJuridical: TdsdGuides
    KeyField = 'Id'
    LookupControl = edJuridical
    FormNameParam.Value = 'TJuridicalCorporateForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TJuridicalCorporateForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesJuridical
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesJuridical
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 824
    Top = 32
  end
  object spSelectPrintSticker: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Income_PrintSticker'
    DataSet = PrintItemsCDS
    DataSets = <
      item
        DataSet = PrintItemsCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 719
    Top = 264
  end
end
