inherited PriceForm: TPriceForm
  Caption = #1055#1088#1072#1081#1089' - '#1083#1080#1089#1090' '#1090#1077#1082#1091#1097#1080#1081
  ClientHeight = 386
  ClientWidth = 846
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  ExplicitWidth = 862
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel [0]
    Left = 0
    Top = 0
    Width = 846
    Height = 32
    Align = alTop
    TabOrder = 6
    object deOperDate: TcxDateEdit
      Left = 800
      Top = 5
      EditValue = 42460d
      Properties.DateOnError = deToday
      Properties.DisplayFormat = 'dd.mm.yyyy hh:mm'
      Properties.EditFormat = 'dd.mm.yyyy hh:mm'
      Properties.Kind = ckDateTime
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 0
      Visible = False
      Width = 42
    end
    object cxLabel3: TcxLabel
      Left = 1
      Top = 6
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object cxLabel1: TcxLabel
      Left = 760
      Top = 6
      Caption = #1094#1077#1085#1072' '#1085#1072':'
      Visible = False
    end
    object cxLabel2: TcxLabel
      Left = 389
      Top = 6
      Caption = #1058#1086#1074#1072#1088':'
    end
  end
  inherited PageControl: TcxPageControl
    Top = 58
    Width = 846
    Height = 328
    ExplicitTop = 58
    ExplicitWidth = 846
    ExplicitHeight = 328
    ClientRectBottom = 328
    ClientRectRight = 846
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 846
      ExplicitHeight = 328
      inherited cxGrid: TcxGrid
        Width = 846
        Height = 328
        ExplicitWidth = 846
        ExplicitHeight = 328
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = clRemainsNotMCS
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = clSummaNotMCS
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colRemains
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = SummaRemains
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = #1042#1089#1077#1075#1086' '#1089#1090#1088#1086#1082': ,0'
              Kind = skCount
              Column = clGoodsName
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = clRemainsNotMCS
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = clSummaNotMCS
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = SummaRemains
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colRemains
            end>
          OptionsData.CancelOnExit = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsView.CellEndEllipsis = True
          OptionsView.GroupByBox = True
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object clGoodsGroupName: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsGroupName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 101
          end
          object clGoodsCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 62
          end
          object clGoodsName: TcxGridDBColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 234
          end
          object clNDSKindName: TcxGridDBColumn
            Caption = #1053#1044#1057
            DataBinding.FieldName = 'NDSKindName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object clIsClose: TcxGridDBColumn
            Caption = #1047#1072#1082#1088#1099#1090' '#1082#1086#1076' '#1087#1086' '#1074#1089#1077#1081' '#1089#1077#1090#1080
            DataBinding.FieldName = 'IsClose'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 67
          end
          object clGoods_isTop: TcxGridDBColumn
            Caption = #1058#1054#1055' ('#1087#1086' '#1089#1077#1090#1080')'
            DataBinding.FieldName = 'Goods_isTop'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object clisTop: TcxGridDBColumn
            Caption = #1058#1054#1055' ('#1072#1087#1090#1077#1082#1072')'
            DataBinding.FieldName = 'isTop'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 60
          end
          object colTOPDateChange: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1058#1054#1055' ('#1072#1087#1090#1077#1082#1072')'
            DataBinding.FieldName = 'TOPDateChange'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object clGoods_PercentMarkup: TcxGridDBColumn
            Caption = '% '#1085#1072#1094#1077#1085#1082#1080' ('#1087#1086' '#1089#1077#1090#1080')'
            DataBinding.FieldName = 'Goods_PercentMarkup'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = '% '#1085#1072#1094#1077#1085#1082#1080
            Options.Editing = False
            Width = 70
          end
          object clPercentMarkup: TcxGridDBColumn
            Caption = '% '#1085#1072#1094#1077#1085#1082#1080' ('#1072#1087#1090#1077#1082#1072')'
            DataBinding.FieldName = 'PercentMarkup'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 2
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = '% '#1085#1072#1094#1077#1085#1082#1080
            Width = 70
          end
          object colPercentMarkupDateChange: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' % '#1085#1072#1094#1077#1085#1082#1080' ('#1072#1087#1090#1077#1082#1072')'
            DataBinding.FieldName = 'PercentMarkupDateChange'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' % '#1085#1072#1094#1077#1085#1082#1080
            Options.Editing = False
            Width = 74
          end
          object clisFirst: TcxGridDBColumn
            Caption = '1-'#1074#1099#1073#1086#1088
            DataBinding.FieldName = 'isFirst'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 60
          end
          object clisSecond: TcxGridDBColumn
            Caption = #1053#1077#1087#1088#1080#1086#1088#1080#1090#1077#1090'. '#1074#1099#1073#1086#1088
            DataBinding.FieldName = 'isSecond'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 60
          end
          object clisPromo: TcxGridDBColumn
            Caption = #1052#1072#1088#1082#1077#1090#1080#1085#1075#1086#1074#1099#1081' '#1082#1086#1085#1090#1088#1072#1082#1090
            DataBinding.FieldName = 'isPromo'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.AllowGrayed = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object StartDate: TcxGridDBColumn
            Caption = #1048#1089#1090#1086#1088#1080#1103' '#1089
            DataBinding.FieldName = 'StartDate'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 58
          end
          object clDateChange: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083'. '#1080#1079#1084'. '#1094#1077#1085#1099
            DataBinding.FieldName = 'DateChange'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 71
          end
          object clPrice: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'Price'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 2
            Properties.DisplayFormat = ',0.00'
            Properties.MinValue = 0.010000000000000000
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 56
          end
          object clMCSDateChange: TcxGridDBColumn
            AlternateCaption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1077#1089#1085#1080#1078#1072#1077#1084#1086#1075#1086' '#1090#1086#1074#1072#1088#1085#1086#1075#1086' '#1079#1072#1087#1072#1089#1072
            Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083'. '#1080#1079#1084'. '#1053#1058#1047
            DataBinding.FieldName = 'MCSDateChange'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1077#1089#1085#1080#1078#1072#1077#1084#1086#1075#1086' '#1090#1086#1074#1072#1088#1085#1086#1075#1086' '#1079#1072#1087#1072#1089#1072
            Options.Editing = False
            Width = 81
          end
          object clMCSValue: TcxGridDBColumn
            AlternateCaption = #1053#1077#1089#1085#1080#1078#1072#1077#1084#1099#1081' '#1090#1086#1074#1072#1088#1085#1099#1081' '#1079#1072#1087#1072#1089
            Caption = #1053#1058#1047
            DataBinding.FieldName = 'MCSValue'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1053#1077#1089#1085#1080#1078#1072#1077#1084#1099#1081' '#1090#1086#1074#1072#1088#1085#1099#1081' '#1079#1072#1087#1072#1089
            Width = 53
          end
          object clMCSPeriod: TcxGridDBColumn
            Caption = #1087#1077#1088#1080#1086#1076' '#1072#1085#1072#1083#1080#1079#1072'***'
            DataBinding.FieldName = 'MCSPeriod'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0.#;-,0.#; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1085#1077#1081' '#1076#1083#1103' '#1072#1085#1072#1083#1080#1079#1072' '#1053#1058#1047
            Options.Editing = False
            Width = 70
          end
          object clMCSDay: TcxGridDBColumn
            Caption = #1079#1072#1087#1072#1089' '#1076#1085#1077#1081'***'
            DataBinding.FieldName = 'MCSDay'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0.#;-,0.#; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1057#1090#1088#1072#1093#1086#1074#1086#1081' '#1079#1072#1087#1072#1089' '#1076#1085#1077#1081' '#1076#1083#1103' '#1053#1058#1047
            Options.Editing = False
            Width = 53
          end
          object colRemains: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082
            DataBinding.FieldName = 'Remains'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object SummaRemains: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1086#1089#1090#1072#1090#1086#1082
            DataBinding.FieldName = 'SummaRemains'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object clRemainsNotMCS: TcxGridDBColumn
            Caption = #1042#1080#1088#1090'. '#1074#1086#1079#1074#1088#1072#1090
            DataBinding.FieldName = 'RemainsNotMCS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1089#1090#1072#1090#1082#1072' '#1089#1074#1077#1088#1093' '#1053#1058#1047
            Options.Editing = False
            Width = 70
          end
          object clSummaNotMCS: TcxGridDBColumn
            Caption = #1042#1080#1088#1090'. '#1089#1091#1084#1084#1072' '#1074#1086#1079#1074#1088#1072#1090#1072
            DataBinding.FieldName = 'SummaNotMCS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1057#1091#1084#1084#1072' '#1086#1089#1090#1072#1090#1082#1072' '#1089#1074#1077#1088#1093' '#1053#1058#1047
            Options.Editing = False
            Width = 80
          end
          object clMCSIsClose: TcxGridDBColumn
            Caption = #1059#1073#1080#1090#1100' '#1082#1086#1076
            DataBinding.FieldName = 'MCSIsClose'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 44
          end
          object colMCSIsCloseDateChange: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' "'#1091#1073#1080#1090#1100' '#1082#1086#1076'"'
            DataBinding.FieldName = 'MCSIsCloseDateChange'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 52
          end
          object clMCSNotRecalc: TcxGridDBColumn
            Caption = #1057#1087#1077#1094#1082#1086#1085#1090#1088#1086#1083#1100' '#1082#1086#1076#1072
            DataBinding.FieldName = 'MCSNotRecalc'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1053#1077' '#1087#1077#1088#1077#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1053#1058#1047
            Width = 59
          end
          object colMCSNotRecalcDateChange: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' "'#1057#1087#1077#1094#1082#1086#1085#1090#1088#1086#1083#1100' '#1082#1086#1076#1072'"'
            DataBinding.FieldName = 'MCSNotRecalcDateChange'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 85
          end
          object colFix: TcxGridDBColumn
            AlternateCaption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1094#1077#1085#1072
            Caption = #1060#1080#1082#1089'. '#1094#1077#1085#1072
            DataBinding.FieldName = 'Fix'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1094#1077#1085#1072
            Width = 48
          end
          object colFixDateChange: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' "'#1060#1080#1082#1089'. '#1094#1077#1085#1072'"'
            DataBinding.FieldName = 'FixDateChange'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colMinExpirationDate: TcxGridDBColumn
            Caption = #1057#1088#1086#1082' '#1075#1086#1076#1085#1086#1089#1090#1080' '#1086#1089#1090#1072#1090#1082#1072
            DataBinding.FieldName = 'MinExpirationDate'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 112
          end
          object clisErased: TcxGridDBColumn
            AlternateCaption = #1058#1086#1074#1072#1088' '#1091#1076#1072#1083#1077#1085
            Caption = #1061
            DataBinding.FieldName = 'isErased'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1058#1086#1074#1072#1088' '#1091#1076#1072#1083#1077#1085
            Options.Editing = False
            Width = 27
          end
          object clConditionsKeepName: TcxGridDBColumn
            Caption = #1059#1089#1083#1086#1074#1080#1103' '#1093#1088#1072#1085#1077#1085#1080#1103
            DataBinding.FieldName = 'ConditionsKeepName'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 75
          end
          object Color_ExpirationDate: TcxGridDBColumn
            DataBinding.FieldName = 'Color_ExpirationDate'
            Visible = False
            Options.Editing = False
            VisibleForCustomization = False
            Width = 30
          end
        end
      end
    end
  end
  object ceUnit: TcxButtonEdit [2]
    Left = 90
    Top = 5
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.Nullstring = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'>'
    Properties.ReadOnly = True
    Properties.UseNullString = True
    TabOrder = 5
    Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'>'
    Width = 290
  end
  object ceGoods: TcxButtonEdit [3]
    Left = 427
    Top = 5
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.Nullstring = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1086#1074#1072#1088'>'
    Properties.ReadOnly = True
    Properties.UseNullString = True
    TabOrder = 7
    Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1086#1074#1072#1088'>'
    Width = 294
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end
      item
        Component = UnitGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = GoodsGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end>
  end
  inherited ActionList: TActionList
    inherited actRefresh: TdsdDataSetRefresh
      PostDataSetAfterExecute = True
    end
    object actShowAll: TBooleanStoredProcAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1090#1086#1074#1072#1088#1099' '#1073#1077#1079' '#1094#1077#1085#1099
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1090#1086#1074#1072#1088#1099' '#1073#1077#1079' '#1094#1077#1085#1099
      ImageIndex = 63
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1090#1086#1074#1072#1088#1099' '#1089' '#1094#1077#1085#1072#1084#1080
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1090#1086#1074#1072#1088#1099' '#1073#1077#1079' '#1094#1077#1085#1099
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1090#1086#1074#1072#1088#1099' '#1089' '#1094#1077#1085#1072#1084#1080
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1090#1086#1074#1072#1088#1099' '#1073#1077#1079' '#1094#1077#1085#1099
      ImageIndexTrue = 62
      ImageIndexFalse = 63
    end
    object actShowDel: TBooleanStoredProcAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
      ImageIndex = 65
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1088#1072#1073#1086#1095#1080#1077' '#1090#1086#1074#1072#1088#1099
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1088#1072#1073#1086#1095#1080#1077' '#1090#1086#1074#1072#1088#1099
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1082' '#1078#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1090#1086#1074#1072#1088#1099
      ImageIndexTrue = 64
      ImageIndexFalse = 65
    end
    object dsdUpdatePrice: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'dsdUpdatePrice'
      DataSource = MasterDS
    end
    object actStartLoadMCS: TMultiAction
      Category = 'LoadMCS'
      MoveParams = <>
      ActionList = <
        item
          Action = actGetImportSetting_MCS
        end
        item
          Action = actDoLoadMCS
        end
        item
          Action = actRefresh
        end>
      QuestionBeforeExecute = #1053#1072#1095#1072#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1091' '#1053#1058#1047' '#1085#1072' '#1074#1099#1073#1088#1072#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'?'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1053#1058#1047
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1053#1058#1047
      ImageIndex = 41
    end
    object actGetImportSetting_MCS: TdsdExecStoredProc
      Category = 'LoadMCS'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spGetImportSetting_MCS
      StoredProcList = <
        item
          StoredProc = spGetImportSetting_MCS
        end>
      Caption = 'actGetImportSetting_MCS'
    end
    object actDoLoadMCS: TExecuteImportSettingsAction
      Category = 'LoadMCS'
      MoveParams = <>
      ImportSettingsId.Value = Null
      ImportSettingsId.Component = FormParams
      ImportSettingsId.ComponentItem = 'ImportSettingId_MCS'
      ImportSettingsId.MultiSelectSeparator = ','
      ExternalParams = <
        item
          Name = 'inUnitId'
          Value = Null
          Component = FormParams
          ComponentItem = 'UnitId'
          MultiSelectSeparator = ','
        end>
    end
    object actStartLoadPrice: TMultiAction
      Category = 'LoadPrice'
      MoveParams = <>
      ActionList = <
        item
          Action = actGetImportSetting_Price
        end
        item
          Action = actDoLoadPrice
        end
        item
          Action = actRefresh
        end>
      QuestionBeforeExecute = #1053#1072#1095#1072#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1091' '#1094#1077#1085' '#1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1086#1084#1091' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1102'?'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1094#1077#1085#1099
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1094#1077#1085#1099
      ImageIndex = 75
    end
    object actGetImportSetting_Price: TdsdExecStoredProc
      Category = 'LoadPrice'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spGetImportSetting_Price
      StoredProcList = <
        item
          StoredProc = spGetImportSetting_Price
        end>
      Caption = 'actGetImportSetting_Price'
    end
    object actDoLoadPrice: TExecuteImportSettingsAction
      Category = 'LoadPrice'
      MoveParams = <>
      ImportSettingsId.Value = Null
      ImportSettingsId.Component = FormParams
      ImportSettingsId.ComponentItem = 'ImportSettingId_Price'
      ImportSettingsId.MultiSelectSeparator = ','
      ExternalParams = <
        item
          Name = 'inUnitId'
          Value = Null
          Component = FormParams
          ComponentItem = 'UnitId'
          MultiSelectSeparator = ','
        end>
    end
    object actRecalcMCS: TdsdExecStoredProc
      Category = 'RecalcMCS'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spRecalcMCS
      StoredProcList = <
        item
          StoredProc = spRecalcMCS
        end>
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1053#1058#1047
      Hint = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1053#1058#1047
    end
    object actStartRecalcMCS: TMultiAction
      Category = 'RecalcMCS'
      MoveParams = <>
      ActionList = <
        item
          Action = actRecalcMCSDialog
        end
        item
          Action = actRecalcMCS
        end
        item
          Action = actRefresh
        end>
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1053#1058#1047
      Hint = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1053#1058#1047
      ImageIndex = 38
    end
    object actRecalcMCSDialog: TExecuteDialog
      Category = 'RecalcMCS'
      MoveParams = <>
      Caption = 'actRecalcMCSDialog'
      FormName = 'TRecalcMCS_DialogForm'
      FormNameParam.Name = 'TRecalcMCS_DialogForm'
      FormNameParam.Value = 'TRecalcMCS_DialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'RecalcMCS_Period'
          Value = Null
          Component = FormParams
          ComponentItem = 'RecalcMCS_Period'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'RecalcMCS_Day'
          Value = Null
          Component = FormParams
          ComponentItem = 'RecalcMCS_Day'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      OpenBeforeShow = True
    end
    object actDelete_Object_MCS: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spDelete_Object_MCS
      StoredProcList = <
        item
          StoredProc = spDelete_Object_MCS
        end
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1053#1058#1047
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1053#1058#1047
      ImageIndex = 52
      QuestionBeforeExecute = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1053#1058#1047' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103'?'
      InfoAfterExecute = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1053#1058#1047' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' '#1073#1099#1083#1080' '#1091#1089#1087#1077#1096#1085#1086' '#1086#1095#1080#1097#1077#1085#1099'.'
    end
    object actPriceHistoryOpen: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1094#1077#1085' '#1080' '#1053#1058#1047
      Hint = #1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1094#1077#1085' '#1080' '#1053#1058#1047
      ImageIndex = 35
      FormName = 'TPriceHistoryForm'
      FormNameParam.Value = 'TPriceHistoryForm'
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
        end>
      isShowModal = False
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      FormName = 'TPriceGoodsDialogForm'
      FormNameParam.Value = 'TPriceGoodsDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'OperDate'
          Value = 42430d
          Component = deOperDate
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitId'
          Value = 42370d
          Component = UnitGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = Null
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsId'
          Value = Null
          Component = GoodsGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsName'
          Value = Null
          Component = GoodsGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      OpenBeforeShow = True
    end
    object dsdOpenForm: TdsdOpenForm
      Category = #1055#1088#1086#1090#1086#1082#1086#1083
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
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
          Name = 'TextValue'
          Value = Null
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
  end
  inherited MasterDS: TDataSource
    Top = 144
  end
  inherited MasterCDS: TClientDataSet
    Left = 8
    Top = 144
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_Price'
    Params = <
      item
        Name = 'inUnitId'
        Value = Null
        Component = FormParams
        ComponentItem = 'UnitId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsId'
        Value = Null
        Component = GoodsGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisShowAll'
        Value = Null
        Component = actShowAll
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisShowDel'
        Value = Null
        Component = actShowDel
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 88
    Top = 144
  end
  inherited BarManager: TdxBarManager
    Left = 184
    Top = 152
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbChoice'
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
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
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
          ItemName = 'dxBarButton5'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbOpenForm'
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
        end>
    end
    object dxBarControlContainerItemUnit: TdxBarControlContainerItem
      Caption = #1042#1099#1073#1086#1088' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      Category = 0
      Hint = #1042#1099#1073#1086#1088' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      Visible = ivAlways
      Control = ceUnit
    end
    object dxBarButton1: TdxBarButton
      Action = actShowAll
      Category = 0
      AllowAllUp = True
    end
    object dxBarButton2: TdxBarButton
      Action = actShowDel
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actStartLoadMCS
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = actStartLoadPrice
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = actStartRecalcMCS
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = actDelete_Object_MCS
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = actPriceHistoryOpen
      Category = 0
    end
    object bbOpenForm: TdxBarButton
      Action = dsdOpenForm
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    DateEdit = deOperDate
    ColorRuleList = <
      item
        ColorColumn = clDateChange
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clGoods_isTop
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clGoods_PercentMarkup
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clGoodsCode
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clGoodsGroupName
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clGoodsName
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clIsClose
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clisErased
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clisFirst
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clisPromo
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clisSecond
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clisTop
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clMCSDateChange
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clMCSDay
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clMCSIsClose
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clMCSNotRecalc
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clMCSPeriod
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clMCSValue
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clNDSKindName
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clPercentMarkup
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clPrice
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clRemainsNotMCS
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = clSummaNotMCS
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colFix
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colFixDateChange
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colMCSIsCloseDateChange
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colMCSNotRecalcDateChange
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colMinExpirationDate
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colPercentMarkupDateChange
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colRemains
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = colTOPDateChange
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = StartDate
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end
      item
        ColorColumn = SummaRemains
        ValueColumn = Color_ExpirationDate
        ColorValueList = <>
      end>
  end
  object UnitGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceUnit
    FormNameParam.Value = 'TUnitTreeForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TUnitTreeForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 120
    Top = 192
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'UnitId'
        Value = Null
        Component = UnitGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'UnitName'
        Value = Null
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ImportSettingId_MCS'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'ImportSettingId_Price'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'RecalcMCS_Period'
        Value = '40'
        MultiSelectSeparator = ','
      end
      item
        Name = 'RecalcMCS_Day'
        Value = '5'
        MultiSelectSeparator = ','
      end>
    Left = 264
    Top = 48
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Price'
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
        Name = 'ioStartDate'
        Value = 73051d
        DataType = ftDateTime
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
        Name = 'inMCSValue'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'MCSValue'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMCSPeriod'
        Value = '0'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMCSDay'
        Value = '0'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPercentMarkup'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'PercentMarkup'
        DataType = ftFloat
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
        Name = 'inUnitId'
        Value = Null
        Component = FormParams
        ComponentItem = 'UnitId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMCSIsClose'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'MCSIsClose'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMCSNotRecalc'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'MCSNotRecalc'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inFix'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Fix'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisTop'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'isTop'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outDateChange'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'DateChange'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outMCSDateChange'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'MCSDateChange'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outMCSIsCloseDateChange'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'MCSIsCloseDateChange'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outMCSNotRecalcDateChange'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'MCSNotRecalcDateChange'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outFixDateChange'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'FixDateChange'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outStartDate'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outTOPDateChange'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'TOPDateChange'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'outPercentMarkupDateChange'
        Value = 'NULL'
        Component = MasterCDS
        ComponentItem = 'PercentMarkupDateChange'
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 272
    Top = 152
  end
  object rdUnit: TRefreshDispatcher
    IdParam.Value = Null
    IdParam.MultiSelectSeparator = ','
    RefreshAction = actRefresh
    ComponentList = <
      item
        Component = UnitGuides
      end>
    Left = 176
    Top = 216
  end
  object spGetImportSetting_MCS: TdsdStoredProc
    StoredProcName = 'gpGet_DefaultValue'
    DataSets = <
      item
      end>
    OutputType = otResult
    Params = <
      item
        Name = 'inDefaultKey'
        Value = 'TPriceForm;zc_Object_ImportSetting_MCS'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUserKeyId'
        Value = '0'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'gpGet_DefaultValue'
        Value = Null
        Component = FormParams
        ComponentItem = 'ImportSettingId_MCS'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 232
    Top = 264
  end
  object spGetImportSetting_Price: TdsdStoredProc
    StoredProcName = 'gpGet_DefaultValue'
    DataSets = <
      item
      end>
    OutputType = otResult
    Params = <
      item
        Name = 'inDefaultKey'
        Value = 'TPriceForm;zc_Object_ImportSetting_Price'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUserKeyId'
        Value = '0'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'gpGet_DefaultValue'
        Value = Null
        Component = FormParams
        ComponentItem = 'ImportSettingId_Price'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 344
    Top = 264
  end
  object spRecalcMCS: TdsdStoredProc
    StoredProcName = 'gpRecalcMCS'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inUnitId'
        Value = Null
        Component = FormParams
        ComponentItem = 'UnitId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inPeriod'
        Value = Null
        Component = FormParams
        ComponentItem = 'RecalcMCS_Period'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inDay'
        Value = Null
        Component = FormParams
        ComponentItem = 'RecalcMCS_Day'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 408
    Top = 136
  end
  object spDelete_Object_MCS: TdsdStoredProc
    StoredProcName = 'gpDelete_Object_MCS'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inUnitId'
        Value = ''
        Component = FormParams
        ComponentItem = 'UnitId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 504
    Top = 136
  end
  object GoodsGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceGoods
    FormNameParam.Value = 'TGoodsLiteForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TGoodsLiteForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GoodsGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GoodsGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 552
  end
  object RefreshDispatcher: TRefreshDispatcher
    IdParam.Value = Null
    IdParam.MultiSelectSeparator = ','
    RefreshAction = actRefresh
    ComponentList = <
      item
        Component = GoodsGuides
      end
      item
        Component = UnitGuides
      end>
    Left = 656
    Top = 184
  end
end
