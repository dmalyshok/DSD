inherited PromoJournalForm: TPromoJournalForm
  Caption = #1046#1091#1088#1085#1072#1083' <'#1052#1072#1088#1082#1077#1090#1080#1085#1075#1086#1074#1099#1081' '#1082#1086#1085#1090#1088#1072#1082#1090'>'
  ClientHeight = 491
  ClientWidth = 769
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  AddOnFormData.AddOnFormRefresh.SelfList = 'Promo'
  AddOnFormData.AddOnFormRefresh.DataSet = MasterCDS
  AddOnFormData.AddOnFormRefresh.KeyField = 'Id'
  AddOnFormData.AddOnFormRefresh.KeyParam = 'inMovementId'
  AddOnFormData.AddOnFormRefresh.GetStoredProc = spGet_Movement_Promo
  ExplicitWidth = 785
  ExplicitHeight = 529
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 769
    Height = 434
    TabOrder = 3
    ExplicitWidth = 769
    ExplicitHeight = 434
    ClientRectBottom = 434
    ClientRectRight = 769
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 769
      ExplicitHeight = 434
      inherited cxGrid: TcxGrid
        Width = 769
        Height = 434
        ExplicitWidth = 769
        ExplicitHeight = 434
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colTotalSumm
            end
            item
              Format = ',0.00'
              Kind = skSum
            end>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object cxGridDBTableViewColumn1: TcxGridDBColumn [0]
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            DataBinding.FieldName = 'Id'
            Visible = False
            Width = 30
          end
          inherited colStatus: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
            Width = 49
          end
          inherited colInvNumber: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
            Width = 71
          end
          inherited colOperDate: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
            Width = 62
          end
          object colMakerName: TcxGridDBColumn
            Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'MakerName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 157
          end
          object colTotalCount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'TotalCount'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.000'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 58
          end
          object colTotalSumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.FieldName = 'TotalSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object StartPromo: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1085#1072#1095'. '#1082#1086#1085#1090#1088#1072#1082#1090#1072
            DataBinding.FieldName = 'StartPromo'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 76
          end
          object EndPromo: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085'. '#1082#1086#1085#1090#1088#1072#1082#1090#1072
            DataBinding.FieldName = 'EndPromo'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = ' '#9#1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
            Width = 82
          end
          object colChangePercent: TcxGridDBColumn
            Caption = '% '#1073#1086#1085#1091#1089#1072' '#1086#1090' '#1079#1072#1082#1091#1087#1082#1080
            DataBinding.FieldName = 'ChangePercent'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 78
          end
          object colAmount: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1082#1086#1085#1090#1088#1072#1082#1090#1072
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colPersonalName: TcxGridDBColumn
            Caption = #1054#1090#1074'. '#1084#1072#1088#1082#1077#1090#1086#1083#1086#1075
            DataBinding.FieldName = 'PersonalName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1087#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100' '#1084#1072#1088#1082#1077#1090#1080#1085#1075#1086#1074#1086#1075#1086' '#1086#1090#1076#1077#1083#1072
            Options.Editing = False
            Width = 104
          end
          object colComment: TcxGridDBColumn
            Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 147
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 769
    ExplicitWidth = 769
  end
  inherited ActionList: TActionList
    Left = 55
    Top = 154
    inherited actInsert: TdsdInsertUpdateAction
      FormName = 'TPromoForm'
      FormNameParam.Value = 'TPromoForm'
    end
    inherited actUpdate: TdsdInsertUpdateAction
      FormName = 'TPromoForm'
      FormNameParam.Value = 'TPromoForm'
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 35
      FormName = 'TMovement_PeriodDialogForm'
      FormNameParam.Value = 'TMovement_PeriodDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Promo'
  end
  inherited BarManager: TdxBarManager
    DockControlHeights = (
      0
      0
      26
      0)
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    Left = 488
    Top = 416
  end
  inherited PopupMenu: TPopupMenu
    Left = 8
    Top = 152
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 424
    Top = 8
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    Left = 456
    Top = 8
  end
  inherited spMovementComplete: TdsdStoredProc
    StoredProcName = 'gpComplete_Movement_Promo'
  end
  inherited spMovementUnComplete: TdsdStoredProc
    StoredProcName = 'gpUnComplete_Movement_Promo'
    Left = 384
    Top = 264
  end
  inherited spMovementSetErased: TdsdStoredProc
    StoredProcName = 'gpSetErased_Movement_Promo'
    Left = 384
    Top = 216
  end
  inherited FormParams: TdsdFormParams
    Left = 32
    Top = 400
  end
  inherited spMovementReComplete: TdsdStoredProc
    StoredProcName = 'gpReComplete_Movement_Promo'
    Left = 384
    Top = 120
  end
  object spGet_Movement_Promo: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Promo'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = 41640d
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 41640d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'Id'
        Value = False
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumber'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'OperDate'
        Value = 'NULL'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'StatusCode'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'StatusName'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'TotalCount'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'TotalSumm'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalId'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalName'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'Comment'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 240
    Top = 267
  end
end