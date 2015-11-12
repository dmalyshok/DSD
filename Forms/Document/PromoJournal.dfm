inherited PromoJournalForm: TPromoJournalForm
  Caption = #1046#1091#1088#1085#1072#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' <'#1040#1082#1094#1080#1080'>'
  ClientHeight = 430
  ExplicitHeight = 468
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Height = 373
    TabOrder = 3
    ExplicitHeight = 373
    ClientRectBottom = 373
    inherited tsMain: TcxTabSheet
      ExplicitHeight = 373
      inherited cxGrid: TcxGrid
        Height = 373
        ExplicitHeight = 373
        inherited cxGridDBTableView: TcxGridDBTableView
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          inherited colStatus: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
          end
          inherited colInvNumber: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
          end
          inherited colOperDate: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
          end
          object colPromoKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1072#1082#1094#1080#1080
            DataBinding.FieldName = 'PromoKindName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 173
          end
          object colStartPromo: TcxGridDBColumn
            Caption = #1040#1082#1094#1080#1103' '#1089
            DataBinding.FieldName = 'StartPromo'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
          end
          object colEndPromo: TcxGridDBColumn
            Caption = #1040#1082#1094#1080#1103' '#1087#1086
            DataBinding.FieldName = 'EndPromo'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 74
          end
          object colStartSale: TcxGridDBColumn
            Caption = #1054#1090#1075#1088#1091#1079#1082#1072' '#1089
            DataBinding.FieldName = 'StartSale'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
          end
          object colEndSale: TcxGridDBColumn
            Caption = #1054#1090#1075#1088#1091#1079#1082#1072' '#1087#1086
            DataBinding.FieldName = 'EndSale'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 72
          end
          object colCostPromo: TcxGridDBColumn
            Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1091#1095#1072#1089#1090#1080#1103
            DataBinding.FieldName = 'CostPromo'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 74
          end
          object colAdvertisingName: TcxGridDBColumn
            Caption = #1056#1077#1082#1083#1072#1084#1085#1072#1103' '#1087#1086#1076#1076#1077#1088#1078#1082#1072
            DataBinding.FieldName = 'AdvertisingName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 110
          end
          object colUnitName: TcxGridDBColumn
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'UnitName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 112
          end
          object colComment: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 101
          end
          object colPersonalTradeName: TcxGridDBColumn
            Caption = #1060#1048#1054' ('#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1080#1081' '#1086#1090#1076#1077#1083')'
            DataBinding.FieldName = 'PersonalTradeName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1087#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100' '#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1086#1075#1086' '#1086#1090#1076#1077#1083#1072
            Width = 103
          end
          object colPersonalName: TcxGridDBColumn
            Caption = #1060#1048#1054' ('#1084#1072#1088#1082#1077#1090#1080#1085#1075#1086#1074#1099#1081' '#1086#1090#1076#1077#1083')'
            DataBinding.FieldName = 'PersonalName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1087#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100' '#1084#1072#1088#1082#1077#1090#1080#1085#1075#1086#1074#1086#1075#1086' '#1086#1090#1076#1077#1083#1072
            Width = 109
          end
          object colPriceListName: TcxGridDBColumn
            Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090
            DataBinding.FieldName = 'PriceListName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 95
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    inherited deStart: TcxDateEdit
      EditValue = 42005d
    end
    inherited deEnd: TcxDateEdit
      EditValue = 42005d
    end
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 99
    Top = 323
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Left = 40
    Top = 323
  end
  inherited ActionList: TActionList
    Left = 271
    Top = 322
    inherited actInsert: TdsdInsertUpdateAction
      FormName = 'TPromoForm'
      FormNameParam.Value = 'TPromoForm'
    end
    inherited actInsertMask: TdsdInsertUpdateAction
      FormName = 'TPromoForm'
      FormNameParam.Value = 'TPromoForm'
    end
    inherited actUpdate: TdsdInsertUpdateAction
      FormName = 'TPromoForm'
      FormNameParam.Value = 'TPromoForm'
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id'
          ParamType = ptInput
        end
        item
          Name = 'ShowAll'
          Value = False
          DataType = ftBoolean
        end
        item
          Name = 'inOperDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
        end>
    end
    object actPrint: TdsdPrintAction [22]
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect_Movement_Promo_Print
      StoredProcList = <
        item
          StoredProc = spSelect_Movement_Promo_Print
        end>
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
      ImageIndex = 3
      ShortCut = 16464
      DataSets = <
        item
          DataSet = PrintHead
          UserName = 'frxHead'
        end>
      Params = <>
      ReportName = #1040#1082#1094#1080#1103
      ReportNameParam.Value = #1040#1082#1094#1080#1103
      ReportNameParam.DataType = ftString
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
          ItemName = 'bbShowErased'
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
          ItemName = 'bbMovementItemContainer'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbMovementProtocol'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
    end
    object dxBarButton1: TdxBarButton
      Action = actPrint
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    Left = 208
  end
  inherited PopupMenu: TPopupMenu
    Left = 200
    Top = 320
  end
  inherited spMovementComplete: TdsdStoredProc
    StoredProcName = 'gpComplete_Movement_Promo'
    Left = 64
    Top = 208
  end
  inherited spMovementUnComplete: TdsdStoredProc
    StoredProcName = 'gpUnComplete_Movement_Promo'
    Left = 64
    Top = 160
  end
  inherited spMovementSetErased: TdsdStoredProc
    StoredProcName = 'gpSetErased_Movement_Promo'
    Left = 64
    Top = 256
  end
  inherited FormParams: TdsdFormParams
    Left = 344
    Top = 320
  end
  inherited spMovementReComplete: TdsdStoredProc
    StoredProcName = 'gpReComplete_Movement_Promo'
    Left = 200
    Top = 264
  end
  object spSelect_Movement_Promo_Print: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Promo_Print'
    DataSet = PrintHead
    DataSets = <
      item
        DataSet = PrintHead
      end>
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 504
    Top = 136
  end
  object PrintHead: TClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    Left = 456
    Top = 136
  end
end