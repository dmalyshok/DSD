object IncomeForm: TIncomeForm
  Left = 0
  Top = 0
  Caption = #1044#1086#1082#1091#1084#1077#1085#1090' <'#1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072'>'
  ClientHeight = 492
  ClientWidth = 943
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu
  AddOnFormData.RefreshAction = actRefresh
  AddOnFormData.isSingle = False
  AddOnFormData.Params = FormParams
  PixelsPerInch = 96
  TextHeight = 13
  object DataPanel: TPanel
    Left = 0
    Top = 0
    Width = 943
    Height = 140
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object edInvNumber: TcxTextEdit
      Left = 9
      Top = 23
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 70
    end
    object cxLabel1: TcxLabel
      Left = 9
      Top = 5
      Caption = #8470' '#1076#1086#1082'.'
    end
    object edOperDate: TcxDateEdit
      Left = 171
      Top = 23
      EditValue = 42160d
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 94
    end
    object cxLabel2: TcxLabel
      Left = 171
      Top = 5
      Caption = #1044#1072#1090#1072' ('#1089#1082#1083#1072#1076')'
    end
    object edFrom: TcxButtonEdit
      Left = 271
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 3
      Width = 173
    end
    object edTo: TcxButtonEdit
      Left = 451
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 2
      Width = 144
    end
    object cxLabel3: TcxLabel
      Left = 271
      Top = 5
      Caption = #1054#1090' '#1082#1086#1075#1086
    end
    object cxLabel4: TcxLabel
      Left = 451
      Top = 5
      Caption = #1050#1086#1084#1091
    end
    object edPriceWithVAT: TcxCheckBox
      Left = 271
      Top = 64
      Caption = #1062#1077#1085#1072' '#1089' '#1053#1044#1057' ('#1076#1072'/'#1085#1077#1090')'
      TabOrder = 9
      Width = 130
    end
    object edVATPercent: TcxCurrencyEdit
      Left = 404
      Top = 64
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = ',0'
      TabOrder = 10
      Width = 40
    end
    object cxLabel5: TcxLabel
      Left = 85
      Top = 5
      Caption = #8470' '#1076#1086#1082'. '#1091' '#1087#1086#1089#1090'.'
    end
    object cxLabel6: TcxLabel
      Left = 171
      Top = 45
      Caption = #1044#1072#1090#1072' '#1076#1086#1082'. '#1091' '#1087#1086#1089#1090'.'
    end
    object edOperDatePartner: TcxDateEdit
      Left = 171
      Top = 63
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 7
      Width = 94
    end
    object edInvNumberPartner: TcxTextEdit
      Left = 85
      Top = 23
      TabOrder = 6
      Width = 81
    end
    object edChangePercent: TcxCurrencyEdit
      Left = 451
      Top = 63
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.DecimalPlaces = 3
      Properties.DisplayFormat = ',0.###'
      Properties.ReadOnly = True
      TabOrder = 8
      Width = 144
    end
    object cxLabel7: TcxLabel
      Left = 404
      Top = 45
      Caption = '% '#1053#1044#1057
    end
    object cxLabel8: TcxLabel
      Left = 451
      Top = 45
      Caption = '(-)% '#1057#1082#1080#1076#1082#1080' (+)% '#1053#1072#1094#1077#1085#1082#1080
    end
    object cxLabel9: TcxLabel
      Left = 688
      Top = 5
      Caption = #1044#1086#1075#1086#1074#1086#1088
    end
    object edContract: TcxButtonEdit
      Left = 688
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Enabled = False
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 4
      Width = 113
    end
    object cxLabel10: TcxLabel
      Left = 603
      Top = 5
      Caption = #1060#1086#1088#1084#1072' '#1086#1087#1083#1072#1090#1099
    end
    object edPaidKind: TcxButtonEdit
      Left = 603
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 77
    end
    object cxLabel13: TcxLabel
      Left = 603
      Top = 45
      Caption = #1047#1072#1075#1086#1090#1086#1074#1080#1090#1077#1083#1100
    end
    object edPacker: TcxButtonEdit
      Left = 603
      Top = 63
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 11
      Width = 198
    end
    object cxLabel11: TcxLabel
      Left = 8
      Top = 40
      Caption = #1057#1090#1072#1090#1091#1089
    end
    object ceStatus: TcxButtonEdit
      Left = 9
      Top = 63
      Properties.Buttons = <
        item
          Action = CompleteMovement
          Kind = bkGlyph
        end
        item
          Action = UnCompleteMovement
          Default = True
          Kind = bkGlyph
        end
        item
          Action = DeleteMovement
          Kind = bkGlyph
        end>
      Properties.Images = dmMain.ImageList
      Properties.ReadOnly = True
      TabOrder = 24
      Width = 157
    end
    object cxLabel12: TcxLabel
      Left = 891
      Top = 45
      Caption = #1050#1091#1088#1089
    end
    object edCurrencyValue: TcxCurrencyEdit
      Left = 891
      Top = 64
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = ',0.####;-,0.####; ;'
      Properties.ReadOnly = True
      TabOrder = 26
      Width = 44
    end
    object cxLabel14: TcxLabel
      Left = 807
      Top = 45
      Caption = #1042#1072#1083#1102#1090#1072' ('#1094#1077#1085#1072')'
    end
    object edCurrencyDocument: TcxButtonEdit
      Left = 808
      Top = 64
      Properties.Buttons = <
        item
          Default = True
          Enabled = False
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 28
      Width = 77
    end
    object cxLabel15: TcxLabel
      Left = 808
      Top = 5
      Caption = #1042#1072#1083#1102#1090#1072' ('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
    end
    object edCurrencyPartner: TcxButtonEdit
      Left = 808
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 30
      Width = 127
    end
    object cxLabel16: TcxLabel
      Left = 603
      Top = 85
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
    end
    object ceComment: TcxTextEdit
      Left = 603
      Top = 103
      TabOrder = 32
      Width = 332
    end
    object cxLabel19: TcxLabel
      Left = 453
      Top = 85
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077' '#8470' ('#1089#1095#1077#1090')'
    end
    object edInvNumberInvoice: TcxButtonEdit
      Left = 450
      Top = 103
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 34
      Width = 145
    end
  end
  object cxPageControl: TcxPageControl
    Left = 0
    Top = 166
    Width = 943
    Height = 326
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = cxTabSheetMain
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 326
    ClientRectRight = 943
    ClientRectTop = 24
    object cxTabSheetMain: TcxTabSheet
      Caption = #1057#1090#1088#1086#1095#1085#1072#1103' '#1095#1072#1089#1090#1100
      ImageIndex = 0
      object cxGrid: TcxGrid
        Left = 0
        Top = 0
        Width = 943
        Height = 302
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = MasterDS
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountPartner
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountPacker
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colHeadCount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountSumm
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colLiveWeight
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountRemains
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount_unit
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount_diff
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount_parent
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountPartner
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountPacker
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colHeadCount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountSumm
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colLiveWeight
            end
            item
              Kind = skSum
              Column = colPrice
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmountRemains
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount_unit
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount_diff
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colAmount_parent
            end>
          DataController.Summary.SummaryGroups = <>
          Images = dmMain.SortImageList
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object clGoodsGroupNameFull: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' ('#1074#1089#1077')'
            DataBinding.FieldName = 'GoodsGroupNameFull'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 120
          end
          object colCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GoodsCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 50
          end
          object colName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GoodsName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = actGoodsChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 200
          end
          object colGoodsKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsKindName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = actGoodsKindChoice
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object colPartionGoods: TcxGridDBColumn
            Caption = #1055#1072#1088#1090#1080#1103
            DataBinding.FieldName = 'PartionGoods'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object colMeasureName: TcxGridDBColumn
            Caption = #1045#1076'. '#1080#1079#1084'.'
            DataBinding.FieldName = 'MeasureName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object colAmountRemains: TcxGridDBColumn
            Caption = #1054#1089#1090'. '#1082#1086#1083'-'#1074#1086' '
            DataBinding.FieldName = 'AmountRemains'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object colAmount_unit: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' ('#1089#1082#1083#1072#1076' '#1080#1090#1086#1075')'
            DataBinding.FieldName = 'Amount_unit'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object colAmount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' ('#1089#1082#1083#1072#1076')'
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colAmountPartner: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1091' '#1087#1086#1089#1090'.'
            DataBinding.FieldName = 'AmountPartner'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colAmountPacker: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1091' '#1079#1072#1075#1086#1090#1086#1074'.'
            DataBinding.FieldName = 'AmountPacker'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 75
          end
          object colAmount_diff: TcxGridDBColumn
            Caption = #1050#1086#1083'. (-)'#1091#1073#1099#1083#1100' (+)'#1101#1082#1086#1085#1086#1084'.'
            DataBinding.FieldName = 'Amount_diff'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object colPrice: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'Price'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object colCountForPrice: TcxGridDBColumn
            Caption = #1050#1086#1083'. '#1074' '#1094#1077#1085#1077
            DataBinding.FieldName = 'CountForPrice'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object colAmountSumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.FieldName = 'AmountSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Properties.ReadOnly = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 91
          end
          object colLiveWeight: TcxGridDBColumn
            Caption = #1046#1080#1074#1086#1081' '#1074#1077#1089' '
            DataBinding.FieldName = 'LiveWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object colHeadCount: TcxGridDBColumn
            Caption = #1050#1086#1083'. '#1075#1086#1083#1086#1074
            DataBinding.FieldName = 'HeadCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object colAssetName: TcxGridDBColumn
            Caption = #1076#1083#1103' '#1054'C / '#1052#1053#1052#1040
            DataBinding.FieldName = 'AssetName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object colAmount_parent: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' ('#1089#1095#1077#1090')'
            DataBinding.FieldName = 'Amount_parent'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colPrice_parent: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' ('#1089#1095#1077#1090')'
            DataBinding.FieldName = 'Price_parent'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object clInfoMoneyCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1059#1055
            DataBinding.FieldName = 'InfoMoneyCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object clInfoMoneyGroupName: TcxGridDBColumn
            Caption = #1059#1055' '#1075#1088#1091#1087#1087#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
            DataBinding.FieldName = 'InfoMoneyGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object clInfoMoneyDestinationName: TcxGridDBColumn
            Caption = #1059#1055' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077
            DataBinding.FieldName = 'InfoMoneyDestinationName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object clInfoMoneyName: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
            DataBinding.FieldName = 'InfoMoneyName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object clInfoMoneyName_all: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103
            DataBinding.FieldName = 'InfoMoneyName_all'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 90
          end
          object clInvNumber_Invoice: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082'. '#1057#1095#1077#1090
            DataBinding.FieldName = 'InvNumber_Invoice'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = actInvoiceJournalDetailChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1054#1089#1085#1086#1074#1072#1085#1080#1077' ('#1089#1095#1077#1090')'
            Width = 92
          end
          object colIsErased: TcxGridDBColumn
            Caption = #1059#1076#1072#1083#1077#1085' ('#1076#1072'/'#1085#1077#1090')'
            DataBinding.FieldName = 'isErased'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colMIId_Invoice: TcxGridDBColumn
            DataBinding.FieldName = 'MIId_Invoice'
            Visible = False
            VisibleForCustomization = False
            Width = 30
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDBTableView
        end
      end
    end
    object cxTabSheet1: TcxTabSheet
      Caption = #1047#1072#1090#1088#1072#1090#1099
      ImageIndex = 1
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 943
        Height = 302
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DataSourceCost
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Images = dmMain.SortImageList
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object clStatus: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082'. '#1079#1072#1090#1088#1072#1090#1099
            DataBinding.FieldName = 'StatusCode'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = dmMain.ImageList
            Properties.Items = <
              item
                Description = #1053#1077' '#1087#1088#1086#1074#1077#1076#1077#1085
                ImageIndex = 11
                Value = 1
              end
              item
                Description = #1055#1088#1086#1074#1077#1076#1077#1085
                ImageIndex = 12
                Value = 2
              end
              item
                Description = #1059#1076#1072#1083#1077#1085
                ImageIndex = 13
                Value = 3
              end>
            Properties.ReadOnly = True
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 56
          end
          object InvNumber: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082'. '#1079#1072#1090#1088#1072#1090#1099
            DataBinding.FieldName = 'InvNumber'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 123
          end
          object clComment: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '#1076#1086#1082'. '#1079#1072#1090#1088#1072#1090#1099
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 210
          end
          object ItemName: TcxGridDBColumn
            Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            DataBinding.FieldName = 'ItemName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 99
          end
          object MasterStatusCode: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1091#1089
            DataBinding.FieldName = 'MasterStatusCode'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = dmMain.ImageList
            Properties.Items = <
              item
                Description = #1053#1077' '#1087#1088#1086#1074#1077#1076#1077#1085
                ImageIndex = 11
                Value = 1
              end
              item
                Description = #1055#1088#1086#1074#1077#1076#1077#1085
                ImageIndex = 12
                Value = 2
              end
              item
                Description = #1059#1076#1072#1083#1077#1085
                ImageIndex = 13
                Value = 3
              end>
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 99
          end
          object MasterOperDate: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'MasterOperDate'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 79
          end
          object MasterInvNumber: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            DataBinding.FieldName = 'MasterInvNumber'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = CostJournalChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 123
          end
          object JuridicalName: TcxGridDBColumn
            Caption = #1070#1088'.'#1083#1080#1094#1086
            DataBinding.FieldName = 'JuridicalName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object InfoMoneyCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1059#1055
            DataBinding.FieldName = 'InfoMoneyCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object InfoMoneyName_all: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103
            DataBinding.FieldName = 'InfoMoneyName_all'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 168
          end
          object MasterComment: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'MasterComment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 120
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  object cbCalcAmountPartner: TcxCheckBox
    Left = 9
    Top = 103
    Caption = #1040#1074#1090#1086' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1077'  <'#1050#1086#1083'-'#1074#1086' '#1091' '#1087#1086#1089#1090'.>'
    Properties.ReadOnly = False
    State = cbsChecked
    TabOrder = 3
    Width = 220
  end
  object cxLabel25: TcxLabel
    Left = 271
    Top = 85
    Caption = #1055#1091#1090#1077#1074#1086#1081' '#1083#1080#1089#1090
  end
  object edInvNumberTransport: TcxButtonEdit
    Left = 271
    Top = 103
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 7
    Width = 173
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ShowAll'
        Value = False
        Component = actShowAll
        DataType = ftBoolean
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end>
    Left = 262
    Top = 375
  end
  object spSelectMI: TdsdStoredProc
    StoredProcName = 'gpSelect_MovementItem_Income'
    DataSet = MasterCDS
    DataSets = <
      item
        DataSet = MasterCDS
      end>
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
        Name = 'inInvoiceId'
        Value = Null
        Component = InvoiceGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inShowAll'
        Value = False
        Component = FormParams
        ComponentItem = 'ShowAll'
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
      end>
    PackSize = 1
    Left = 256
    Top = 263
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
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 22
    Top = 231
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar: TdxBar
      AllowClose = False
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 51
      FloatClientHeight = 71
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbInsertUpdateMovement'
        end
        item
          Visible = True
          ItemName = 'bbShowErased'
        end
        item
          Visible = True
          ItemName = 'bbShowAll'
        end
        item
          Visible = True
          ItemName = 'bbShowErasedCost'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbAddMask'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
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
          ItemName = 'bbInsertRecord'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbCompleteCost'
        end
        item
          Visible = True
          ItemName = 'bbactUnCompleteCost'
        end
        item
          Visible = True
          ItemName = 'bbactSetErasedCost'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbMIContainer'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbMovementItemProtocol'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbGridToExel'
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
      Caption = '     '
      Category = 0
      Visible = ivAlways
    end
    object bbInsertUpdateMovement: TdxBarButton
      Action = actInsertUpdateMovement
      Category = 0
    end
    object bbShowErased: TdxBarButton
      Action = actShowErased
      Category = 0
    end
    object bbShowAll: TdxBarButton
      Action = actShowAll
      Category = 0
    end
    object bbRefresh: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object bbPrint: TdxBarButton
      Action = actPrint
      Category = 0
    end
    object bbGridToExel: TdxBarButton
      Action = GridToExcel
      Category = 0
    end
    object bbErased: TdxBarButton
      Action = SetErased
      Category = 0
    end
    object bbUnErased: TdxBarButton
      Action = SetUnErased
      Category = 0
    end
    object bbMIContainer: TdxBarButton
      Action = actMIContainer
      Category = 0
    end
    object bbMovementItemProtocol: TdxBarButton
      Action = MovementItemProtocolOpenForm
      Category = 0
    end
    object bbCalcAmountPartner: TdxBarControlContainerItem
      Caption = #1040#1074#1090#1086' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1077'  <'#1050#1086#1083'-'#1074#1086' '#1091' '#1087#1086#1089#1090'.>'
      Category = 0
      Hint = #1040#1074#1090#1086' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1077'  <'#1050#1086#1083'-'#1074#1086' '#1091' '#1087#1086#1089#1090'.>'
      Visible = ivAlways
      Control = cbCalcAmountPartner
    end
    object bbAddMask: TdxBarButton
      Action = actAddMask
      Category = 0
    end
    object bbInsertRecord: TdxBarButton
      Action = InsertRecord1
      Category = 0
    end
    object bbCompleteCost: TdxBarButton
      Action = actCompleteCost
      Category = 0
    end
    object bbactUnCompleteCost: TdxBarButton
      Action = actUnCompleteCost
      Category = 0
    end
    object bbactSetErasedCost: TdxBarButton
      Action = actSetErasedCost
      Category = 0
    end
    object bbShowErasedCost: TdxBarButton
      Action = actShowErasedCost
      Category = 0
    end
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
    StorageType = stStream
    Left = 81
    Top = 232
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 51
    Top = 231
    object actInsertUpdateMovement: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdateMovement
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMovement
        end>
      Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 14
      ShortCut = 113
    end
    object actShowErasedCost: TBooleanStoredProcAction
      Category = 'DSDLib'
      TabSheet = cxTabSheet1
      MoveParams = <>
      Enabled = False
      StoredProc = spSelect_Movement_Cost
      StoredProcList = <
        item
          StoredProc = spSelect_Movement_Cost
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndex = 64
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndexTrue = 65
      ImageIndexFalse = 64
    end
    object actShowErased: TBooleanStoredProcAction
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      MoveParams = <>
      StoredProc = spSelectMI
      StoredProcList = <
        item
          StoredProc = spSelectMI
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndex = 64
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndexTrue = 65
      ImageIndexFalse = 64
    end
    object actShowAll: TBooleanStoredProcAction
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      MoveParams = <>
      StoredProc = spSelectMI
      StoredProcList = <
        item
          StoredProc = spSelectMI
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 63
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndexTrue = 62
      ImageIndexFalse = 63
    end
    object actUpdateClientDataCost: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate_Movement_Cost
      StoredProcList = <
        item
          StoredProc = spInsertUpdate_Movement_Cost
        end
        item
          StoredProc = spSelect_Movement_Cost
        end>
      Caption = 'actUpdateClientDataCost'
      DataSource = DataSourceCost
    end
    object actUpdateMasterDS: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdateMIMaster
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMIMaster
        end
        item
          StoredProc = spGetTotalSumm
        end>
      Caption = 'actUpdateMasterDS'
      DataSource = MasterDS
    end
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spGetTotalSumm
        end
        item
          StoredProc = spSelectMI
        end
        item
          StoredProc = spSelect_Movement_Cost
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelectPrint
      StoredProcList = <
        item
          StoredProc = spSelectPrint
        end>
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
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
          Name = 'InvNumber'
          Value = ''
          Component = edInvNumber
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'From'
          Value = ''
          Component = GuidesFrom
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'OperDate'
          Value = 0d
          Component = edOperDate
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      ReportName = 'PrintMovement_Income'
      ReportNameParam.Value = 'PrintMovement_Income'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object GridToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      MoveParams = <>
      Grid = cxGrid
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
    object SetErased: TdsdUpdateErased
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      MoveParams = <>
      StoredProc = spErasedMIMaster
      StoredProcList = <
        item
          StoredProc = spErasedMIMaster
        end
        item
          StoredProc = spGetTotalSumm
        end>
      Caption = #1059#1076#1072#1083#1080#1090#1100' <'#1069#1083#1077#1084#1077#1085#1090'>'
      Hint = #1059#1076#1072#1083#1080#1090#1100' <'#1069#1083#1077#1084#1077#1085#1090'>'
      ImageIndex = 2
      ShortCut = 46
      ErasedFieldName = 'isErased'
      DataSource = MasterDS
    end
    object SetUnErased: TdsdUpdateErased
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      MoveParams = <>
      StoredProc = spUnErasedMIMaster
      StoredProcList = <
        item
          StoredProc = spUnErasedMIMaster
        end
        item
          StoredProc = spGetTotalSumm
        end>
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 8
      ShortCut = 46
      ErasedFieldName = 'isErased'
      isSetErased = False
      DataSource = MasterDS
    end
    object UnCompleteMovement: TChangeGuidesStatus
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spChangeStatus
      StoredProcList = <
        item
          StoredProc = spChangeStatus
        end
        item
        end
        item
        end>
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 11
      Status = mtUncomplete
      Guides = StatusGuides
    end
    object CompleteMovement: TChangeGuidesStatus
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spChangeStatus
      StoredProcList = <
        item
          StoredProc = spChangeStatus
        end
        item
        end
        item
        end>
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      Hint = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      ImageIndex = 12
      Status = mtComplete
      Guides = StatusGuides
    end
    object DeleteMovement: TChangeGuidesStatus
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spChangeStatus
      StoredProcList = <
        item
          StoredProc = spChangeStatus
        end
        item
        end
        item
        end>
      Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      Hint = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      ImageIndex = 13
      Status = mtDelete
      Guides = StatusGuides
    end
    object actMIContainer: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' <'#1055#1088#1086#1074#1086#1076#1082#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'>'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' <'#1055#1088#1086#1074#1086#1076#1082#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'>'
      ImageIndex = 57
      FormName = 'TMovementItemContainerForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object MovementItemProtocolOpenForm: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' <'#1055#1088#1086#1090#1086#1082#1086#1083#1072' '#1089#1090#1088#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'>'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' <'#1055#1088#1086#1090#1086#1082#1086#1083#1072' '#1089#1090#1088#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'>'
      ImageIndex = 34
      FormName = 'TMovementItemProtocolForm'
      FormNameParam.Value = 'TMovementItemProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsName'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsName'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actGoodsKindChoice: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = 'actGoodsKindChoice'
      FormName = 'TGoodsKind_ObjectForm'
      FormNameParam.Value = 'TGoodsKind_ObjectForm'
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
    object CostJournalChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = 'CostJournalChoiceForm'
      FormName = 'TCostJournalChoiceForm'
      FormNameParam.Value = 'TCostJournalChoiceForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'key'
          Value = Null
          Component = ClientDataCost
          ComponentItem = 'MasterMovementId'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = ClientDataCost
          ComponentItem = 'MasterInvNumber'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'OperDate'
          Value = 'NULL'
          Component = ClientDataCost
          ComponentItem = 'MasterOperDate'
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'StatusCode'
          Value = Null
          Component = ClientDataCost
          ComponentItem = 'MasterStatusCode'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'MasterUnitId'
          Value = Null
          Component = GuidesTo
          ComponentItem = 'Key'
          MultiSelectSeparator = ','
        end
        item
          Name = 'MasterUnitName'
          Value = Null
          Component = GuidesTo
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actAddMask: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertMaskMIMaster
      StoredProcList = <
        item
          StoredProc = spInsertMaskMIMaster
        end
        item
          StoredProc = spSelectMI
        end>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086' '#1084#1072#1089#1082#1077
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086' '#1084#1072#1089#1082#1077
      ImageIndex = 54
    end
    object actGoodsChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = 'GoodsForm'
      FormName = 'TGoods_ObjectForm'
      FormNameParam.Value = 'TGoods_ObjectForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Key'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsId'
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsName'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'Code'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsCode'
          MultiSelectSeparator = ','
        end>
      isShowModal = True
    end
    object InsertRecord1: TInsertRecord
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      PostDataSetAfterExecute = True
      View = cxGridDBTableView1
      Action = CostJournalChoiceForm
      Params = <>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1044#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099'>'
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1044#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099'>'
      ShortCut = 45
      ImageIndex = 0
    end
    object actCompleteCost: TdsdChangeMovementStatus
      Category = 'DSDLib'
      TabSheet = cxTabSheet1
      MoveParams = <>
      Enabled = False
      StoredProc = spMovementCompleteCost
      StoredProcList = <
        item
          StoredProc = spMovementCompleteCost
        end>
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099
      Hint = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099
      ImageIndex = 12
      Status = mtComplete
      DataSource = DataSourceCost
    end
    object actSetErasedCost: TdsdChangeMovementStatus
      Category = 'DSDLib'
      TabSheet = cxTabSheet1
      MoveParams = <>
      Enabled = False
      StoredProc = spMovementSetErasedCost
      StoredProcList = <
        item
          StoredProc = spMovementSetErasedCost
        end>
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099
      ImageIndex = 13
      Status = mtDelete
      DataSource = DataSourceCost
    end
    object actUnCompleteCost: TdsdChangeMovementStatus
      Category = 'DSDLib'
      TabSheet = cxTabSheet1
      MoveParams = <>
      Enabled = False
      StoredProc = spMovementUnCompleteCost
      StoredProcList = <
        item
          StoredProc = spMovementUnCompleteCost
        end>
      Caption = #1056#1072#1089#1087#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099
      Hint = #1056#1072#1089#1087#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1079#1072#1090#1088#1072#1090#1099
      ImageIndex = 11
      Status = mtUncomplete
      DataSource = DataSourceCost
    end
    object actInvoiceJournalDetailChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = 'actInvoiceJournalDetailChoiceForm'
      FormName = 'TInvoiceJournalDetailChoiceForm'
      FormNameParam.Value = 'TInvoiceJournalDetailChoiceForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'InvNumber_Full'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'InvNumber_Invoice'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'MovementItemId'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'MIId_Invoice'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'MasterJuridicalId'
          Value = ''
          Component = GuidesFrom
          ComponentItem = 'Key'
          MultiSelectSeparator = ','
        end
        item
          Name = 'MasterJuridicalName'
          Value = ''
          Component = GuidesFrom
          ComponentItem = 'TextValue'
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = True
    end
  end
  object MasterDS: TDataSource
    DataSet = MasterCDS
    Left = 46
    Top = 303
  end
  object MasterCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 303
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
        DataType = ftString
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
    Left = 520
  end
  object PopupMenu: TPopupMenu
    Images = dmMain.ImageList
    Left = 456
    Top = 200
    object N1: TMenuItem
      Action = actRefresh
    end
  end
  object spInsertUpdateMIMaster: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MovementItem_Income'
    DataSets = <>
    OutputType = otResult
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
        Name = 'ioAmount'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ioAmountPartner'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AmountPartner'
        DataType = ftFloat
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inAmountPacker'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AmountPacker'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsCalcAmountPartner'
        Value = Null
        Component = cbCalcAmountPartner
        DataType = ftBoolean
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
        Name = 'inMIId_Invoice'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'MIId_Invoice'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ioCountForPrice'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'CountForPrice'
        DataType = ftFloat
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outAmountSumm'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AmountSumm'
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'inLiveWeight'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'LiveWeight'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inHeadCount'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'HeadCount'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPartionGoods'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'PartionGoods'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsKindId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'GoodsKindId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inAssetId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AssetId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 150
    Top = 287
  end
  object MasterViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableView
    OnDblClickActionList = <
      item
      end>
    ActionItemList = <
      item
      end>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <
      item
        Param.Value = Null
        Param.Component = FormParams
        Param.ComponentItem = 'TotalSumm'
        Param.DataType = ftString
        Param.MultiSelectSeparator = ','
        DataSummaryItemIndex = 6
      end>
    Left = 347
    Top = 337
  end
  object UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 326
    Top = 287
  end
  object spInsertUpdateMovement: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_Income'
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
        Name = 'inInvNumber'
        Value = ''
        Component = edInvNumber
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 0d
        Component = edOperDate
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDatePartner'
        Value = 0d
        Component = edOperDatePartner
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inInvNumberPartner'
        Value = ''
        Component = edInvNumberPartner
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPriceWithVAT'
        Value = 'False'
        Component = edPriceWithVAT
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVATPercent'
        Value = 0.000000000000000000
        Component = edVATPercent
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inChangePercent'
        Value = 0.000000000000000000
        Component = edChangePercent
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inFromId'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inToId'
        Value = ''
        Component = GuidesTo
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPaidKindId'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inContractId'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPersonalPackerId'
        Value = ''
        Component = PackerGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inCurrencyDocumentId'
        Value = ''
        Component = CurrencyDocumentGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inCurrencyPartnerId'
        Value = ''
        Component = CurrencyPartnerGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outCurrencyValue'
        Value = 0.000000000000000000
        Component = edCurrencyValue
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'inComment'
        Value = Null
        Component = ceComment
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 402
    Top = 232
  end
  object HeaderSaver: THeaderSaver
    IdParam.Value = Null
    IdParam.Component = FormParams
    IdParam.ComponentItem = 'Id'
    IdParam.MultiSelectSeparator = ','
    StoredProc = spInsertUpdateMovement
    ControlList = <
      item
        Control = edInvNumber
      end
      item
        Control = edInvNumberPartner
      end
      item
        Control = edOperDate
      end
      item
        Control = edOperDatePartner
      end
      item
        Control = edFrom
      end
      item
        Control = edTo
      end
      item
        Control = edPriceWithVAT
      end
      item
        Control = edVATPercent
      end
      item
        Control = edChangePercent
      end
      item
        Control = edContract
      end
      item
        Control = edPaidKind
      end
      item
        Control = edPacker
      end
      item
        Control = edCurrencyDocument
      end
      item
        Control = edCurrencyPartner
      end
      item
        Control = edCurrencyValue
      end
      item
        Control = ceComment
      end>
    GetStoredProc = spGet
    Left = 248
    Top = 241
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Income'
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
        Name = 'inOperDate'
        Value = 'NULL'
        Component = FormParams
        ComponentItem = 'inOperDate'
        DataType = ftDateTime
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
        Name = 'OperDatePartner'
        Value = 0d
        Component = edOperDatePartner
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumberPartner'
        Value = ''
        Component = edInvNumberPartner
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
        Name = 'ToParentId'
        Value = ''
        Component = GuidesTo
        ComponentItem = 'ParentId'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PriceWithVAT'
        Value = 'False'
        Component = edPriceWithVAT
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'VATPercent'
        Value = 0.000000000000000000
        Component = edVATPercent
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'ChangePercent'
        Value = 0.000000000000000000
        Component = edChangePercent
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'CurrencyValue'
        Value = 0.000000000000000000
        Component = edCurrencyValue
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'ContractId'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'ContractName'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PaidKindId'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'PaidKindName'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PersonalPackerId'
        Value = ''
        Component = PackerGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'PersonalPackerName'
        Value = ''
        Component = PackerGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'CurrencyDocumentId'
        Value = ''
        Component = CurrencyDocumentGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'CurrencyDocumentName'
        Value = ''
        Component = CurrencyDocumentGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'CurrencyPartnerId'
        Value = ''
        Component = CurrencyPartnerGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'CurrencyPartnerName'
        Value = ''
        Component = CurrencyPartnerGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'StatusCode'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'Key'
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
        Name = 'Comment'
        Value = Null
        Component = ceComment
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'MovementId_Transport'
        Value = Null
        Component = TransportChoiceGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumber_Transport'
        Value = Null
        Component = TransportChoiceGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvoiceId'
        Value = Null
        Component = InvoiceGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvoiceName'
        Value = Null
        Component = InvoiceGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 200
    Top = 240
  end
  object RefreshAddOn: TRefreshAddOn
    DataSet = 'ClientDataSet'
    KeyField = 'Id'
    RefreshAction = 'actRefresh'
    FormParams = 'FormParams'
    Left = 422
    Top = 306
  end
  object GuidesFiller: TGuidesFiller
    IdParam.Value = Null
    IdParam.Component = FormParams
    IdParam.ComponentItem = 'Id'
    IdParam.MultiSelectSeparator = ','
    GuidesList = <
      item
        Guides = GuidesFrom
      end
      item
        Guides = GuidesTo
      end>
    ActionItemList = <
      item
        Action = actInsertUpdateMovement
      end>
    Left = 144
    Top = 224
  end
  object ContractGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edContract
    FormNameParam.Value = 'TContractForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TContractForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        DataType = ftString
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
    Left = 728
    Top = 8
  end
  object PaidKindGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPaidKind
    FormNameParam.Value = 'TPaidKindForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPaidKindForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 624
  end
  object PackerGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPacker
    FormNameParam.Value = 'TPersonal_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPersonal_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = PackerGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = PackerGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 680
    Top = 80
  end
  object spErasedMIMaster: TdsdStoredProc
    StoredProcName = 'gpSetErased_MovementItem'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementItemId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outIsErased'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'isErased'
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 534
    Top = 248
  end
  object spUnErasedMIMaster: TdsdStoredProc
    StoredProcName = 'gpSetUnErased_MovementItem'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementItemId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outIsErased'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'isErased'
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 398
    Top = 408
  end
  object StatusGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceStatus
    FormNameParam.Value = ''
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 39
    Top = 40
  end
  object spChangeStatus: TdsdStoredProc
    StoredProcName = 'gpUpdate_Status_Income'
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
        Name = 'inStatusCode'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 124
    Top = 56
  end
  object GuidesFrom: TdsdGuides
    KeyField = 'Id'
    LookupControl = edFrom
    FormNameParam.Value = 'TContractChoicePartnerForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TContractChoicePartnerForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'PartnerId'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'PartnerName'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PaidKindId'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'PaidKindName'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'Key'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'ChangePercent'
        Value = 0.000000000000000000
        Component = edChangePercent
        DataType = ftFloat
        MultiSelectSeparator = ','
      end>
    Left = 336
    Top = 8
  end
  object spGetTotalSumm: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_TotalSumm'
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
        Name = 'TotalSumm'
        Value = Null
        Component = FormParams
        ComponentItem = 'TotalSumm'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 492
    Top = 260
  end
  object CurrencyDocumentGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edCurrencyDocument
    FormNameParam.Value = 'TCurrency_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TCurrency_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = CurrencyDocumentGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = CurrencyDocumentGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 824
    Top = 56
  end
  object CurrencyPartnerGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edCurrencyPartner
    FormNameParam.Value = 'TCurrency_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TCurrency_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = CurrencyPartnerGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = CurrencyPartnerGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 840
  end
  object PrintHeaderCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 548
    Top = 297
  end
  object PrintItemsCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 548
    Top = 350
  end
  object spSelectPrint: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Income_Print'
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
    Left = 567
    Top = 208
  end
  object spInsertMaskMIMaster: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MovementItem_Income'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = 0
        ParamType = ptInput
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
        Name = 'ioAmount'
        Value = 0.000000000000000000
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ioAmountPartner'
        Value = 0.000000000000000000
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inAmountPacker'
        Value = 0.000000000000000000
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsCalcAmountPartner'
        Value = 'True'
        Component = cbCalcAmountPartner
        DataType = ftBoolean
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
        Name = 'inMIId_Invoice'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'MIId_Invoice'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ioCountForPrice'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'CountForPrice'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outAmountSumm'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AmountSumm'
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'inLiveWeight'
        Value = 0.000000000000000000
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inHeadCount'
        Value = 0.000000000000000000
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPartionGoods'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'PartionGoods'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsKindId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'GoodsKindId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inAssetId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'AssetId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 150
    Top = 343
  end
  object TransportChoiceGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edInvNumberTransport
    Key = '0'
    FormNameParam.Value = 'TTransportJournalChoiceForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TTransportJournalChoiceForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = TransportChoiceGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumber_Full'
        Value = ''
        Component = TransportChoiceGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'PartnerId'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'PartnerName'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 340
    Top = 88
  end
  object HeaderSaver2: THeaderSaver
    IdParam.Value = Null
    IdParam.Component = FormParams
    IdParam.ComponentItem = 'Id'
    IdParam.MultiSelectSeparator = ','
    StoredProc = spInsertUpdateMovement_Params
    ControlList = <
      item
        Control = edInvNumberTransport
      end>
    GetStoredProc = spGet
    Left = 328
    Top = 225
  end
  object spInsertUpdateMovement_Params: TdsdStoredProc
    StoredProcName = 'gpUpdate_Movement_Income_Transport'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMovementId_Transport'
        Value = '0'
        Component = TransportChoiceGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 153
    Top = 400
  end
  object ClientDataCost: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 768
    Top = 223
  end
  object DataSourceCost: TDataSource
    DataSet = ClientDataCost
    Left = 814
    Top = 223
  end
  object spSelect_Movement_Cost: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Cost'
    DataSet = ClientDataCost
    DataSets = <
      item
        DataSet = ClientDataCost
      end>
    Params = <
      item
        Name = 'inPerentId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsErased'
        Value = False
        Component = actShowErasedCost
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 704
    Top = 247
  end
  object spInsertUpdate_Movement_Cost: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_Cost'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = ClientDataCost
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inParentId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMovementId'
        Value = Null
        Component = ClientDataCost
        ComponentItem = 'MasterMovementId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inComment'
        Value = Null
        Component = ClientDataCost
        ComponentItem = 'Comment'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 790
    Top = 271
  end
  object spMovementUnCompleteCost: TdsdStoredProc
    StoredProcName = 'gpUnComplete_Movement'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = ClientDataCost
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 696
    Top = 345
  end
  object spMovementCompleteCost: TdsdStoredProc
    StoredProcName = 'gpComplete_Movement_Cost'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = ClientDataCost
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 816
    Top = 361
  end
  object spMovementSetErasedCost: TdsdStoredProc
    StoredProcName = 'gpSetErased_Movement'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = ClientDataCost
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 816
    Top = 305
  end
  object InvoiceGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edInvNumberInvoice
    Key = '0'
    FormNameParam.Value = 'TInvoiceJournalChoiceForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TInvoiceJournalChoiceForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = InvoiceGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumber_Full'
        Value = ''
        Component = InvoiceGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterJuridicalId'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterJuridicalName'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'ContractId'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ContractName'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'PaidKindId'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'PaidKindName'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'CurrencyDocumentId'
        Value = ''
        Component = CurrencyDocumentGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'CurrencyDocumentName'
        Value = ''
        Component = CurrencyDocumentGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ChangePercent'
        Value = 0.000000000000000000
        Component = edChangePercent
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'VATPercent'
        Value = 0.000000000000000000
        Component = edVATPercent
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'PriceWithVAT'
        Value = 'True'
        Component = edPriceWithVAT
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalId'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'JuridicalName'
        Value = ''
        Component = GuidesFrom
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 484
    Top = 96
  end
end
