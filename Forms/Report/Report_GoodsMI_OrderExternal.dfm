inherited Report_GoodsMI_OrderExternalForm: TReport_GoodsMI_OrderExternalForm
  Caption = #1054#1090#1095#1077#1090' <'#1047#1072#1103#1074#1082#1072' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103'>'
  ClientHeight = 483
  ClientWidth = 1187
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  AddOnFormData.Params = FormParams
  ExplicitWidth = 1203
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 91
    Width = 1187
    Height = 392
    TabOrder = 3
    ExplicitTop = 91
    ExplicitWidth = 1187
    ExplicitHeight = 392
    ClientRectBottom = 392
    ClientRectRight = 1187
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 1187
      ExplicitHeight = 392
      inherited cxGrid: TcxGrid
        Width = 1187
        Height = 392
        ExplicitWidth = 1187
        ExplicitHeight = 392
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountSumm1
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Weight1
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Sh1
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountSumm
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountSumm2
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Sh2
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Weight2
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Weight
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Sh
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Weight_Dozakaz1
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Sh_Dozakaz1
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountSumm_Dozakaz1
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_WeightSK
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Sh_Dozakaz2
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = Amount_Weight_Dozakaz2
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountSumm_Dozakaz2
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = AmountSumm1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Weight1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Sh1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = AmountSumm
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = AmountSumm2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Sh2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Weight2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Weight
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Sh
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Weight_Dozakaz1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Sh_Dozakaz1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = AmountSumm_Dozakaz1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_WeightSK
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Sh_Dozakaz2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount_Weight_Dozakaz2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = AmountSumm_Dozakaz2
            end>
          OptionsData.Editing = False
          OptionsView.GroupByBox = True
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object RouteGroupName: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1084'. / '#1052#1072#1088#1096#1088#1091#1090
            DataBinding.FieldName = 'RouteGroupName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object RouteName: TcxGridDBColumn
            Caption = #1052#1072#1088#1096#1088#1091#1090
            DataBinding.FieldName = 'RouteName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object RouteSortingName: TcxGridDBColumn
            Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1084#1072#1088#1096#1088#1091#1090#1072
            DataBinding.FieldName = 'RouteSortingName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object InvNumber: TcxGridDBColumn
            Caption = #8470' '#1079#1072#1103#1074#1082#1080
            DataBinding.FieldName = 'InvNumber'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object InvNumberPartner: TcxGridDBColumn
            Caption = #8470' '#1079'. '#1091' '#1087#1086#1082'.'
            DataBinding.FieldName = 'InvNumberPartner'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object ContractCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1076#1086#1075'.'
            DataBinding.FieldName = 'ContractCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object ContractNumber: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1075'.'
            DataBinding.FieldName = 'ContractNumber'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object ContractTagGroupName: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1087#1088#1080#1079#1085#1072#1082' '#1076#1086#1075'.'
            DataBinding.FieldName = 'ContractTagGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object ContractTagName: TcxGridDBColumn
            Caption = #1055#1088#1080#1079#1085#1072#1082' '#1076#1086#1075'.'
            DataBinding.FieldName = 'ContractTagName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object PersonalName: TcxGridDBColumn
            Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082' ('#1101#1082#1089#1087#1077#1076#1080#1090#1086#1088')'
            DataBinding.FieldName = 'PersonalName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object RetailName: TcxGridDBColumn
            Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1089#1077#1090#1100
            DataBinding.FieldName = 'RetailName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object RegionName: TcxGridDBColumn
            Caption = #1054#1073#1083#1072#1089#1090#1100
            DataBinding.FieldName = 'RegionName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object CityKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1085'.'#1087'.'
            DataBinding.FieldName = 'CityKindName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 35
          end
          object CityName: TcxGridDBColumn
            Caption = #1053#1072#1089#1077#1083#1077#1085#1085#1099#1081' '#1087#1091#1085#1082#1090
            DataBinding.FieldName = 'CityName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object StreetKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1091#1083'./'#1087#1088'.'
            DataBinding.FieldName = 'StreetKindName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 25
          end
          object StreetName: TcxGridDBColumn
            Caption = #1059#1083#1080#1094#1072
            DataBinding.FieldName = 'StreetName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object JuridicalName: TcxGridDBColumn
            Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086
            DataBinding.FieldName = 'JuridicalName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object PartnerTagName: TcxGridDBColumn
            Caption = #1055#1088#1080#1079#1085#1072#1082' '#1058#1058
            DataBinding.FieldName = 'PartnerTagName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object FromCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1082'.'
            DataBinding.FieldName = 'FromCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 44
          end
          object FromName: TcxGridDBColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            DataBinding.FieldName = 'FromName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object ToName: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076
            DataBinding.FieldName = 'ToName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object PaidKindName: TcxGridDBColumn
            Caption = #1060#1086#1088#1084#1072' '#1086#1087#1083#1072#1090#1099
            DataBinding.FieldName = 'PaidKindName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object TradeMarkName: TcxGridDBColumn
            Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1084#1072#1088#1082#1072
            DataBinding.FieldName = 'TradeMarkName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 68
          end
          object GoodsGroupNameFull: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1072' ('#1074#1089#1077')'
            DataBinding.FieldName = 'GoodsGroupNameFull'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object GoodsGroupName: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object GoodsCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GoodsCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 44
          end
          object GoodsName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GoodsName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 150
          end
          object GoodsKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsKindName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object MeasureName: TcxGridDBColumn
            Caption = #1045#1076'. '#1080#1079#1084'.'
            DataBinding.FieldName = 'MeasureName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 45
          end
          object Amount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' ('#1080#1090#1086#1075')'
            DataBinding.FieldName = 'Amount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object Amount_Sh1: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086'1 '#1096#1090' '
            DataBinding.FieldName = 'Amount_Sh1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Weight1: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086'1, '#1074#1077#1089
            DataBinding.FieldName = 'Amount_Weight1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object AmountSumm1: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' 1, '#1075#1088#1085
            DataBinding.FieldName = 'AmountSumm1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Sh2: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086'2, '#1096#1090' '
            DataBinding.FieldName = 'Amount_Sh2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Weight2: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086'2, '#1074#1077#1089
            DataBinding.FieldName = 'Amount_Weight2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object AmountSumm2: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' 2, '#1075#1088#1085
            DataBinding.FieldName = 'AmountSumm2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Sh: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1096#1090', '#1080#1090#1086#1075
            DataBinding.FieldName = 'Amount_Sh'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Weight: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1074#1077#1089', '#1080#1090#1086#1075
            DataBinding.FieldName = 'Amount_Weight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object AmountSumm: TcxGridDBColumn
            Caption = #1048#1090#1086#1075#1086', '#1075#1088#1085
            DataBinding.FieldName = 'AmountSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Sh_Dozakaz1: TcxGridDBColumn
            Caption = #1044#1086#1079#1072#1082#1072#1079'1 ,  '#1096#1090'.'
            DataBinding.FieldName = 'Amount_Sh_Dozakaz1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Weight_Dozakaz1: TcxGridDBColumn
            Caption = #1044#1086#1079#1072#1082#1072#1079'1, '#1074#1077#1089
            DataBinding.FieldName = 'Amount_Weight_Dozakaz1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object AmountSumm_Dozakaz1: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1076#1086#1079#1072#1082#1072#1079'1'
            DataBinding.FieldName = 'AmountSumm_Dozakaz1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Sh_Dozakaz2: TcxGridDBColumn
            Caption = #1044#1086#1079#1072#1082#1072#1079'2 ,  '#1096#1090'.'
            DataBinding.FieldName = 'Amount_Sh_Dozakaz2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_Weight_Dozakaz2: TcxGridDBColumn
            Caption = #1044#1086#1079#1072#1082#1072#1079'2, '#1074#1077#1089
            DataBinding.FieldName = 'Amount_Weight_Dozakaz2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object AmountSumm_Dozakaz2: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1076#1086#1079#1072#1082#1072#1079'2'
            DataBinding.FieldName = 'AmountSumm_Dozakaz2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Amount_WeightSK: TcxGridDBColumn
            Caption = #1057'/'#1050', '#1074#1077#1089' '
            DataBinding.FieldName = 'Amount_WeightSK'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.###;-,0.###; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object InfoMoneyCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1059#1055' ('#1076#1086#1075'.)'
            DataBinding.FieldName = 'InfoMoneyCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object InfoMoneyName: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103' ('#1076#1086#1075'.)'
            DataBinding.FieldName = 'InfoMoneyName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object InfoMoneyName_all: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' ('#1076#1086#1075'.)'
            DataBinding.FieldName = 'InfoMoneyName_all'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object InfoMoneyCode_goods: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1059#1055' ('#1090#1086#1074'.)'
            DataBinding.FieldName = 'InfoMoneyCode_goods'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object InfoMoneyName_goods: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103' ('#1090#1086#1074'.)'
            DataBinding.FieldName = 'InfoMoneyName_goods'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object InfoMoneyName_goods_all: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' ('#1090#1086#1074'.)'
            DataBinding.FieldName = 'InfoMoneyName_goods_all'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 1187
    Height = 65
    ExplicitWidth = 1187
    ExplicitHeight = 65
    inherited deStart: TcxDateEdit
      Left = 113
      EditValue = 42736d
      Properties.SaveTime = False
      ExplicitLeft = 113
    end
    inherited deEnd: TcxDateEdit
      Left = 113
      Top = 34
      EditValue = 42736d
      Properties.SaveTime = False
      ExplicitLeft = 113
      ExplicitTop = 34
    end
    inherited cxLabel1: TcxLabel
      Left = 25
      ExplicitLeft = 25
    end
    inherited cxLabel2: TcxLabel
      Left = 6
      Top = 35
      ExplicitLeft = 6
      ExplicitTop = 35
    end
    object cxLabel4: TcxLabel
      Left = 937
      Top = 6
      Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074':'
    end
    object edGoodsGroup: TcxButtonEdit
      Left = 1028
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 5
      Width = 169
    end
    object cxLabel13: TcxLabel
      Left = 426
      Top = 35
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1084#1072#1088#1096#1088#1091#1090#1072':'
    end
    object edRouteSorting: TcxButtonEdit
      Left = 548
      Top = 34
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 7
      Width = 170
    end
    object cxLabel7: TcxLabel
      Left = 723
      Top = 35
      Caption = #1052#1072#1088#1096#1088#1091#1090':'
    end
    object edRoute: TcxButtonEdit
      Left = 777
      Top = 34
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 9
      Width = 154
    end
    object cxLabel3: TcxLabel
      Left = 426
      Top = 6
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090':'
    end
    object edPartner: TcxButtonEdit
      Left = 495
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 11
      Width = 223
    end
    object edByDoc: TcxCheckBox
      Left = 937
      Top = 34
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1087#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1084'  ('#1076#1072'/'#1085#1077#1090')'
      TabOrder = 12
      Width = 218
    end
    object cxLabel6: TcxLabel
      Left = 204
      Top = 35
      Caption = #1058#1086#1088#1075'. '#1089#1077#1090#1100':'
    end
    object edRetail: TcxButtonEdit
      Left = 264
      Top = 34
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 14
      Width = 157
    end
  end
  object edTo: TcxButtonEdit [2]
    Left = 763
    Top = 5
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 6
    Width = 168
  end
  object cxLabel8: TcxLabel [3]
    Left = 723
    Top = 6
    Caption = #1057#1082#1083#1072#1076':'
  end
  object cxLabel5: TcxLabel [4]
    Left = 204
    Top = 6
    Caption = #1070#1088'. '#1083#1080#1094#1086':'
  end
  object edJuridical: TcxButtonEdit [5]
    Left = 259
    Top = 5
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 9
    Width = 162
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 59
    Top = 320
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
        Component = GoodsGroupGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = GuidesJuridical
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = GuidesPartner
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = GuidesRetail
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = GuidesRoute
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = GuidesRouteSorting
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = GuidesTo
        Properties.Strings = (
          'Key'
          'TextValue')
      end>
    Left = 48
  end
  inherited ActionList: TActionList
    Left = 623
    Top = 279
    inherited actRefresh: TdsdDataSetRefresh
      TabSheet = tsMain
    end
    object actPrint_byType_Group: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1080' '#1075#1088#1091#1087#1087#1077' '#1090#1086#1074#1072#1088#1072')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1080' '#1075#1088#1091#1087#1087#1077' '#1090#1086#1074#1072#1088#1072')'
      ImageIndex = 21
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'goodskindname;GoodsGroupNameFull;goodsname'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 42005d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 42005d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1080' '#1075#1088#1091#1087#1087#1077' '#1090#1086#1074#1072#1088#1072')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1080' '#1075#1088#1091#1087#1087#1077' '#1090#1086#1074#1072#1088#1072')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byType: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1090#1086#1074#1072#1088#1072')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1090#1086#1074#1072#1088#1072')'
      ImageIndex = 21
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'goodskindname;GoodsGroupNameFull;goodsname'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1090#1086#1074#1072#1088#1072')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1074#1080#1076#1091' '#1090#1086#1074#1072#1088#1072')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byPack: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1076#1083#1103' '#1059#1087#1072#1082#1086#1074#1082#1080')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1076#1083#1103' '#1059#1087#1072#1082#1086#1074#1082#1080')'
      ImageIndex = 19
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsGroupNameFull;goodsname;goodskindname'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1076#1083#1103' '#1059#1087#1072#1082#1086#1074#1082#1080')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1076#1083#1103' '#1059#1087#1072#1082#1086#1074#1082#1080')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byProductionDozakaz: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1044#1086#1079#1072#1082#1072#1079')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1044#1086#1079#1072#1082#1072#1079')'
      ImageIndex = 17
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsGroupNameFull;GoodsName;GoodsKindName'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 42005d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 42005d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'PrintParam'
          Value = '1'
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1085#1072' '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1085#1072' '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byProduction: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1085#1072' '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1085#1072' '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')'
      ImageIndex = 20
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsGroupNameFull;GoodsName;GoodsKindName'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'PrintParam'
          Value = '0'
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1085#1072' '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1085#1072' '#1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byRouteItog: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1080#1090#1086#1075#1086')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1080#1090#1086#1075#1086')'
      ImageIndex = 16
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'InfoMoneyName;routename'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1080#1090#1086#1075#1086')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1080#1090#1086#1075#1086')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byRoute: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1076#1077#1090#1072#1083#1100#1085#1086')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1076#1077#1090#1072#1083#1100#1085#1086')'
      ImageIndex = 22
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'routename;routesortingname;fromname;InvNumber'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1076#1077#1090#1072#1083#1100#1085#1086')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1052#1072#1088#1096#1088#1091#1090#1072#1084'-'#1076#1077#1090#1072#1083#1100#1085#1086')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byByer: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1055#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084'-'#1074#1089#1077')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1055#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084'-'#1074#1089#1077')'
      ImageIndex = 18
      ShortCut = 16464
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 
            'FromName;RouteSortingName;RouteName;InvNumber;GoodsGroupNameFull' +
            ';GoodsName;GoodsKindName'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1055#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084'-'#1074#1089#1077')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1087#1086' '#1055#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084'-'#1074#1089#1077')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_byCross: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect_Cross
      StoredProcList = <
        item
          StoredProc = spSelect_Cross
        end>
      Caption = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1082#1088#1086#1089#1089')'
      Hint = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1082#1088#1086#1089#1089')'
      ImageIndex = 18
      DataSets = <
        item
          DataSet = HeaderCDS
          UserName = 'frxDBDHeader'
        end
        item
          DataSet = ItemsCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsGroupNameFull;goodsgroupname;goodsname;goodskindname'
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1082#1088#1086#1089#1089')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' - '#1079#1072#1103#1074#1082#1080' ('#1082#1088#1086#1089#1089')'
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 35
      FormName = 'TReport_GoodsMI_OrderExternalDialogForm'
      FormNameParam.Value = 'TReport_GoodsMI_OrderExternalDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 42005d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 42005d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'PartnerId'
          Value = ''
          Component = GuidesPartner
          ComponentItem = 'Key'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'PartnerName'
          Value = ''
          Component = GuidesPartner
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupId'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupName'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'RouteSortingId'
          Value = ''
          Component = GuidesRouteSorting
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'RouteSortingName'
          Value = ''
          Component = GuidesRouteSorting
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'RouteId'
          Value = ''
          Component = GuidesRoute
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'RouteName'
          Value = ''
          Component = GuidesRoute
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'ToId'
          Value = ''
          Component = GuidesTo
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'ToName'
          Value = ''
          Component = GuidesTo
          ComponentItem = 'TextValue'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'inIsByDoc'
          Value = 'False'
          Component = edByDoc
          DataType = ftBoolean
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = GuidesJuridical
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = Null
          Component = GuidesJuridical
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'RetailId'
          Value = Null
          Component = GuidesRetail
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'RetailName'
          Value = Null
          Component = GuidesRetail
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
  end
  inherited MasterDS: TDataSource
    Left = 112
    Top = 200
  end
  inherited MasterCDS: TClientDataSet
    Left = 40
    Top = 208
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpReport_OrderExternal'
    DataSets = <
      item
        DataSet = MasterCDS
      end
      item
      end
      item
      end>
    Params = <
      item
        Name = 'inStartDate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndDate'
        Value = 41640d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inJuridicalId'
        Value = Null
        Component = GuidesJuridical
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inRetailId'
        Value = Null
        Component = GuidesRetail
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inFromId'
        Value = ''
        Component = GuidesPartner
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
        Name = 'inRouteId'
        Value = ''
        Component = GuidesRoute
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inRouteSortingId'
        Value = ''
        Component = GuidesRouteSorting
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsGroupId'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsByDoc'
        Value = 'False'
        Component = edByDoc
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 176
    Top = 200
  end
  inherited BarManager: TdxBarManager
    Left = 408
    Top = 272
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
          ItemName = 'bbExecuteDialog'
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
          ItemName = 'bbPrint'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_byPack'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_byProduction'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_Dozakaz'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_byType'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_byType_Group'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_byRoute'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_byRouteItog'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint_byCross'
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
    object bbPrint: TdxBarButton
      Action = actPrint_byByer
      Category = 0
    end
    object bbPrint_byPack: TdxBarButton
      Action = actPrint_byPack
      Category = 0
    end
    object bbPrint_byProduction: TdxBarButton
      Action = actPrint_byProduction
      Category = 0
    end
    object bbPrint_byType: TdxBarButton
      Action = actPrint_byType
      Category = 0
    end
    object bbPrint_byRoute: TdxBarButton
      Action = actPrint_byRoute
      Category = 0
    end
    object bbPrint_byRouteItog: TdxBarButton
      Action = actPrint_byRouteItog
      Category = 0
    end
    object bbPrint_byCross: TdxBarButton
      Action = actPrint_byCross
      Category = 0
    end
    object bbExecuteDialog: TdxBarButton
      Action = ExecuteDialog
      Category = 0
    end
    object bbPrint_Dozakaz: TdxBarButton
      Action = actPrint_byProductionDozakaz
      Category = 0
    end
    object bbPrint_byType_Group: TdxBarButton
      Action = actPrint_byType_Group
      Category = 0
      ImageIndex = 3
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    Left = 696
    Top = 136
  end
  inherited PopupMenu: TPopupMenu
    Left = 144
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 56
    Top = 32
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
        Component = deStart
      end
      item
        Component = deEnd
      end
      item
        Component = GoodsGroupGuides
      end
      item
        Component = GuidesPartner
      end
      item
        Component = GuidesRoute
      end
      item
        Component = GuidesRouteSorting
      end
      item
        Component = GuidesTo
      end
      item
        Component = edByDoc
      end
      item
        Component = GuidesRetail
      end
      item
        Component = GuidesJuridical
      end>
    Left = 592
    Top = 144
  end
  object GoodsGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edGoodsGroup
    FormNameParam.Value = 'TGoodsGroup_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TGoodsGroup_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 1000
    Top = 8
  end
  object FormParams: TdsdFormParams
    Params = <>
    Left = 320
    Top = 154
  end
  object GuidesRouteSorting: TdsdGuides
    KeyField = 'Id'
    LookupControl = edRouteSorting
    FormNameParam.Value = 'TRouteSortingForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TRouteSortingForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesRouteSorting
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesRouteSorting
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 544
    Top = 24
  end
  object GuidesRoute: TdsdGuides
    KeyField = 'Id'
    LookupControl = edRoute
    FormNameParam.Value = 'TRouteForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TRouteForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesRoute
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesRoute
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 808
    Top = 24
  end
  object GuidesPartner: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPartner
    FormNameParam.Value = 'TPartner_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPartner_ObjectForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesPartner
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesPartner
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 544
    Top = 65528
  end
  object GuidesTo: TdsdGuides
    KeyField = 'Id'
    LookupControl = edTo
    FormNameParam.Value = 'TStoragePlace_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TStoragePlace_ObjectForm'
    PositionDataSet = 'ClientDataSet'
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
    Left = 799
    Top = 65532
  end
  object HeaderCDS: TClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    Left = 288
    Top = 256
  end
  object spSelect_Cross: TdsdStoredProc
    StoredProcName = 'gpReport_OrderExternal_Cross'
    DataSet = HeaderCDS
    DataSets = <
      item
        DataSet = HeaderCDS
      end
      item
        DataSet = ItemsCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inStartDate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndDate'
        Value = 41640d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inJuridicalId'
        Value = Null
        Component = GuidesJuridical
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inRetailId'
        Value = Null
        Component = GuidesRetail
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inFromId'
        Value = ''
        Component = GuidesPartner
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
        Name = 'inRouteId'
        Value = ''
        Component = GuidesRoute
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inRouteSortingId'
        Value = ''
        Component = GuidesRouteSorting
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsGroupId'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inIsByDoc'
        Value = 'False'
        Component = edByDoc
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 200
    Top = 320
  end
  object ItemsCDS: TClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    Left = 288
    Top = 312
  end
  object GuidesJuridical: TdsdGuides
    KeyField = 'Id'
    LookupControl = edJuridical
    FormNameParam.Value = 'TJuridical_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TJuridical_ObjectForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesJuridical
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesJuridical
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 344
    Top = 2
  end
  object GuidesRetail: TdsdGuides
    KeyField = 'Id'
    LookupControl = edRetail
    FormNameParam.Value = 'TRetailForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TRetailForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesRetail
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesRetail
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    Left = 288
    Top = 26
  end
end
