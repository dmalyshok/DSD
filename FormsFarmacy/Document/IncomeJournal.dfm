inherited IncomeJournalForm: TIncomeJournalForm
  Caption = #1046#1091#1088#1085#1072#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' <'#1055#1088#1080#1093#1086#1076'>'
  ClientHeight = 469
  ClientWidth = 831
  ExplicitWidth = 847
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 831
    Height = 412
    TabOrder = 3
    ExplicitWidth = 831
    ExplicitHeight = 412
    ClientRectBottom = 412
    ClientRectRight = 831
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 831
      ExplicitHeight = 412
      inherited cxGrid: TcxGrid
        Width = 831
        Height = 412
        ExplicitWidth = 831
        ExplicitHeight = 412
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Filter.Options = [fcoCaseInsensitive, fcoShowOperatorDescription]
          DataController.Filter.TranslateBetween = True
          DataController.Filter.TranslateIn = True
          DataController.Filter.TranslateLike = True
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCount
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
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = colTotalSumm
            end
            item
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = colTotalSummMVAT
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCount
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
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = colTotalSumm
            end
            item
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = colTotalSummMVAT
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm
            end>
          OptionsBehavior.GoToNextCellOnEnter = False
          OptionsBehavior.FocusCellOnCycle = False
          OptionsCustomize.DataRowSizing = False
          OptionsData.CancelOnExit = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsView.GroupByBox = True
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          inherited colStatus: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
            Width = 55
          end
          inherited colOperDate: TcxGridDBColumn [1]
            HeaderAlignmentHorz = taCenter
            Width = 74
          end
          inherited colInvNumber: TcxGridDBColumn [2]
            Caption = #8470' '#1076#1086#1082'.'
            HeaderAlignmentHorz = taCenter
            Width = 88
          end
          object colFromName: TcxGridDBColumn
            Caption = #1070#1088' '#1083#1080#1094#1086' '#1087#1086#1089#1090'-'#1082
            DataBinding.FieldName = 'FromName'
            HeaderAlignmentHorz = taCenter
            Width = 187
          end
          object colToName: TcxGridDBColumn
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'ToName'
            HeaderAlignmentHorz = taCenter
            Width = 200
          end
          object colJuridicalName: TcxGridDBColumn
            Caption = #1063#1055
            DataBinding.FieldName = 'JuridicalName'
            HeaderAlignmentHorz = taCenter
            Width = 123
          end
          object colContractName: TcxGridDBColumn
            Caption = #1059#1089#1083#1086#1074#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1072' '#1087#1086#1089#1090'-'#1082#1072
            DataBinding.FieldName = 'ContractName'
            Width = 136
          end
          object colTotalCount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'TotalCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            Width = 60
          end
          object colTotalSummMVAT: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057
            DataBinding.FieldName = 'TotalSummMVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            Width = 111
          end
          object colTotalSumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1089' '#1053#1044#1057
            DataBinding.FieldName = 'TotalSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 2
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            Width = 109
          end
          object colNDSKindName: TcxGridDBColumn
            Caption = #1053#1044#1057
            DataBinding.FieldName = 'NDSKindName'
            Width = 50
          end
          object colSaleSumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1080
            DataBinding.FieldName = 'SaleSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            Options.Editing = False
            Width = 79
          end
          object colPaymentDate: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1086#1087#1083#1072#1090#1099
            DataBinding.FieldName = 'PaymentDate'
            Width = 90
          end
          object colPaySumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1082' '#1086#1087#1083#1072#1090#1077
            DataBinding.FieldName = 'PaySumm'
            Options.Editing = False
            Width = 70
          end
          object colInvNumberBranch: TcxGridDBColumn
            Caption = #8470' '#1074' '#1072#1087#1090#1077#1082#1077
            DataBinding.FieldName = 'InvNumberBranch'
            Options.Editing = False
            Width = 47
          end
          object colBranchDate: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1074' '#1072#1087#1090#1077#1082#1077
            DataBinding.FieldName = 'BranchDate'
            Options.Editing = False
            Width = 50
          end
          object colChecked: TcxGridDBColumn
            Caption = #1055#1088#1086#1074#1077#1088#1077#1085#1086' '#1092#1072#1088#1084#1072#1094#1077#1074#1090#1086#1084
            DataBinding.FieldName = 'Checked'
            Options.Editing = False
            Width = 95
          end
          object colPayColor: TcxGridDBColumn
            DataBinding.FieldName = 'PayColor'
            Visible = False
            VisibleForCustomization = False
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 831
    ExplicitWidth = 831
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 179
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = deEnd
        Properties.Strings = (
          'Date')
      end
      item
        Component = deStart
        Properties.Strings = (
          'Date')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    Left = 40
    Top = 243
  end
  inherited ActionList: TActionList
    Left = 471
    object actGetDataForSendNew: TdsdExecStoredProc [2]
      Category = 'dsdImportExport'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spGetDataForSend
      StoredProcList = <
        item
          StoredProc = spGetDataForSend
        end>
    end
    object mactSendOneDocNEW: TMultiAction [3]
      Category = 'dsdImportExport'
      MoveParams = <>
      ActionList = <
        item
          Action = actGetDataForSendNew
        end
        item
          Action = ADOQueryAction1
        end
        item
          Action = actComplete
        end>
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1088#1080#1093#1086#1076'/'#1088#1072#1089#1093#1086#1076
    end
    inherited actInsert: TdsdInsertUpdateAction
      FormName = 'TIncomeForm'
    end
    inherited actUpdate: TdsdInsertUpdateAction
      FormName = 'TIncomeForm'
    end
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.Component = MasterCDS
          FromParam.ComponentItem = 'id'
          ToParam.Value = Null
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
        end>
      StoredProc = spSelectPrint
      StoredProcList = <
        item
          StoredProc = spSelectPrint
        end>
      Caption = #1055#1077#1095#1072#1090#1100' '#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      Hint = #1055#1077#1095#1072#1090#1100' '#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      ImageIndex = 3
      ShortCut = 16464
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
        end>
      ReportName = #1056#1072#1089#1093#1086#1076#1085#1072#1103'_'#1085#1072#1082#1083#1072#1076#1085#1072#1103'_'#1076#1083#1103'_'#1084#1077#1085#1077#1076#1078#1077#1088#1072
      ReportNameParam.Name = #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' '#1076#1083#1103' '#1084#1077#1085#1077#1076#1078#1077#1088#1072
      ReportNameParam.Value = #1056#1072#1089#1093#1086#1076#1085#1072#1103'_'#1085#1072#1082#1083#1072#1076#1085#1072#1103'_'#1076#1083#1103'_'#1084#1077#1085#1077#1076#1078#1077#1088#1072
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
    end
    object ADOQueryAction1: TADOQueryAction
      Category = 'dsdImportExport'
      MoveParams = <>
    end
    object actGetDataForSend: TdsdExecStoredProc
      Category = 'dsdImportExport'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spGetDataForSend
      StoredProcList = <
        item
          StoredProc = spGetDataForSend
        end>
      Caption = 'actGetDataForSend'
    end
    object mactSendOneDoc: TMultiAction
      Category = 'dsdImportExport'
      MoveParams = <>
      ActionList = <
        item
          Action = actGetDataForSend
        end
        item
          Action = ADOQueryAction1
        end
        item
          Action = actComplete
        end>
      Caption = 'mactSendOneDoc'
    end
    object MultiAction2: TMultiAction
      Category = 'dsdImportExport'
      MoveParams = <>
      ActionList = <>
      Caption = 'MultiAction2'
    end
  end
  inherited MasterDS: TDataSource
    Left = 64
    Top = 139
  end
  inherited MasterCDS: TClientDataSet
    Top = 139
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Income'
    Params = <
      item
        Name = 'instartdate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inenddate'
        Value = 41640d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inIsErased'
        Value = False
        Component = actShowErased
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Value = 'False'
        DataType = ftBoolean
        ParamType = ptUnknown
      end>
    Left = 136
    Top = 163
  end
  inherited BarManager: TdxBarManager
    Left = 224
    Top = 155
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbInsert'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbComplete'
        end
        item
          Visible = True
          ItemName = 'bbUnComplete'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbTax'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'bbShowErased'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbMovementItemContainer'
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
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbNewSend'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end>
    end
    object bbTax: TdxBarButton
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1085#1072#1083#1086#1075#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
      Category = 0
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1085#1072#1083#1086#1075#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
      Visible = ivNever
      ImageIndex = 41
    end
    object bbPrint: TdxBarButton
      Action = actPrint
      Category = 0
    end
    object bbPrintTax_Us: TdxBarButton
      Caption = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' ('#1087#1088#1086#1076#1072#1074#1077#1094')'
      Category = 0
      Hint = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' ('#1087#1088#1086#1076#1072#1074#1077#1094')'
      Visible = ivAlways
      ImageIndex = 16
    end
    object bbPrintTax_Client: TdxBarButton
      Caption = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' ('#1087#1086#1082#1091#1087#1072#1090#1077#1083#1100')'
      Category = 0
      Hint = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' ('#1087#1086#1082#1091#1087#1072#1090#1077#1083#1100')'
      Visible = ivAlways
      ImageIndex = 18
    end
    object bbPrint_Bill: TdxBarButton
      Caption = #1057#1095#1077#1090
      Category = 0
      Hint = #1057#1095#1077#1090
      Visible = ivAlways
      ImageIndex = 21
    end
    object bbSendData: TdxBarButton
      Action = mactSendOneDoc
      Category = 0
      Visible = ivNever
    end
    object bbNewSend: TdxBarButton
      Action = mactSendOneDocNEW
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    ColorRuleList = <
      item
        BackGroundValueColumn = colPayColor
        ColorValueList = <>
      end>
    Left = 320
    Top = 224
  end
  inherited PopupMenu: TPopupMenu
    Left = 640
    Top = 152
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 288
    Top = 144
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
      end>
    Left = 408
    Top = 344
  end
  inherited spMovementComplete: TdsdStoredProc
    StoredProcName = 'gpComplete_Movement_Income'
    Params = <
      item
        Name = 'inmovementid'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 80
    Top = 320
  end
  inherited spMovementUnComplete: TdsdStoredProc
    StoredProcName = 'gpUnComplete_Movement_Income'
    Params = <
      item
        Name = 'inmovementid'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 80
    Top = 384
  end
  inherited spMovementSetErased: TdsdStoredProc
    StoredProcName = 'gpSetErased_Movement_Income'
    Params = <
      item
        Name = 'inmovementid'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 208
    Top = 376
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end
      item
        Name = 'Key'
        Value = Null
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ShowAll'
        Value = False
        DataType = ftBoolean
        ParamType = ptInputOutput
      end
      item
        Name = 'ReportNameIncome'
        Value = Null
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ReportNameIncomeTax'
        Value = Null
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 400
    Top = 200
  end
  object PrintHeaderCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 708
    Top = 217
  end
  object PrintItemsCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 708
    Top = 270
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
      end>
    PackSize = 1
    Left = 535
    Top = 248
  end
  object PrintItemsSverkaCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 628
    Top = 294
  end
  object spGetDataForSend: TdsdStoredProc
    StoredProcName = 'gpGetDataForSend'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'ConnectionString'
        Value = Null
        Component = ADOQueryAction1
        ComponentItem = 'ConnectionString'
      end
      item
        Name = 'QueryText'
        Value = Null
        Component = ADOQueryAction1
        ComponentItem = 'QueryText'
        DataType = ftString
      end>
    PackSize = 1
    Left = 440
    Top = 48
  end
  object spGetDataForSendNew: TdsdStoredProc
    StoredProcName = 'gpGetDataForSendNew'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'ConnectionString'
        Value = Null
        Component = ADOQueryAction1
        ComponentItem = 'ConnectionString'
      end
      item
        Name = 'QueryText'
        Value = Null
        Component = ADOQueryAction1
        ComponentItem = 'QueryText'
        DataType = ftString
      end>
    PackSize = 1
    Left = 440
    Top = 88
  end
end
