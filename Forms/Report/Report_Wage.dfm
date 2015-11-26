inherited Report_WageForm: TReport_WageForm
  Caption = #1086#1090#1095#1077#1090' '#1087#1086' '#1088#1072#1089#1095#1077#1090#1091' '#1079#1072#1088#1086#1073#1086#1090#1085#1086#1081' '#1087#1083#1072#1090#1099
  ClientHeight = 581
  ClientWidth = 991
  AddOnFormData.RefreshAction = nil
  ExplicitWidth = 1007
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 115
    Width = 991
    Height = 466
    TabOrder = 3
    ExplicitTop = 115
    ExplicitWidth = 991
    ExplicitHeight = 466
    ClientRectBottom = 466
    ClientRectRight = 991
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 991
      ExplicitHeight = 466
      inherited cxGrid: TcxGrid
        Width = 991
        Height = 466
        ExplicitWidth = 991
        ExplicitHeight = 466
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colAmountOnOneMember
            end
            item
              Format = ',0.000'
              Kind = skSum
              Column = colGrossOnOneMember
            end>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object colUnitName: TcxGridDBColumn
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'UnitName'
            Width = 130
          end
          object colPositionName: TcxGridDBColumn
            Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
            DataBinding.FieldName = 'PositionName'
            Width = 106
          end
          object colPositionLevelName: TcxGridDBColumn
            Caption = #1056#1072#1079#1088#1103#1076' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
            DataBinding.FieldName = 'PositionLevelName'
            Width = 98
          end
          object colPersonalCount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1095#1077#1083#1086#1074#1077#1082
            DataBinding.FieldName = 'PersonalCount'
          end
          object colMemberName: TcxGridDBColumn
            Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
            DataBinding.FieldName = 'MemberName'
            Width = 102
          end
          object colSheetWorkTime_Amount: TcxGridDBColumn
            Caption = #1054#1090#1088#1072#1073'. '#1095#1072#1089#1086#1074
            DataBinding.FieldName = 'SheetWorkTime_Amount'
          end
          object colServiceModelName: TcxGridDBColumn
            Caption = #1052#1086#1076#1077#1083#1100' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103' / '#1058#1080#1087' '#1089#1091#1084#1084#1099
            DataBinding.FieldName = 'ServiceModelName'
            Width = 131
          end
          object colPrice: TcxGridDBColumn
            Caption = #1075#1088#1085'. '#1079#1072' '#1082#1075' / '#1089#1090#1072#1074#1082#1072
            DataBinding.FieldName = 'Price'
            Width = 81
          end
          object colFromName: TcxGridDBColumn
            Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099': '#1086#1090' '#1082#1086#1075#1086
            DataBinding.FieldName = 'FromName'
            Width = 129
          end
          object colToName: TcxGridDBColumn
            Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099': '#1082#1086#1084#1091
            DataBinding.FieldName = 'ToName'
            Width = 132
          end
          object colMovementDescName: TcxGridDBColumn
            Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099': '#1090#1080#1087
            DataBinding.FieldName = 'MovementDescName'
            Width = 118
          end
          object colModelServiceItemChild_FromName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088': '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'ModelServiceItemChild_FromName'
            Width = 105
          end
          object colModelServiceItemChild_ToName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088': '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'ModelServiceItemChild_ToName'
            Width = 112
          end
          object colOperDate: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'OperDate'
          end
          object colCount_MemberInDay: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1095#1077#1083#1086#1074#1077#1082
            DataBinding.FieldName = 'Count_MemberInDay'
            Width = 99
          end
          object Gross: TcxGridDBColumn
            Caption = #1054#1073#1097#1072#1103' '#1084#1072#1089#1089#1072
            DataBinding.FieldName = 'Gross'
            Width = 92
          end
          object colGrossOnOneMember: TcxGridDBColumn
            Caption = #1052#1072#1089#1089#1072' '#1085#1072' 1-'#1075#1086' '#1095#1077#1083'.'
            DataBinding.FieldName = 'GrossOnOneMember'
            Width = 73
          end
          object colAmount: TcxGridDBColumn
            Caption = #1054#1073#1097#1072#1103' '#1089#1091#1084#1084#1072
            DataBinding.FieldName = 'Amount'
            Width = 65
          end
          object colAmountOnOneMember: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1085#1072' 1 '#1095#1077#1083
            DataBinding.FieldName = 'AmountOnOneMember'
          end
          object colPersonalServiceListName: TcxGridDBColumn
            Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
            DataBinding.FieldName = 'PersonalServiceListName'
            Width = 164
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 991
    Height = 89
    ExplicitWidth = 991
    ExplicitHeight = 89
    inherited deStart: TcxDateEdit
      Left = 10
      Top = 23
      ExplicitLeft = 10
      ExplicitTop = 23
      ExplicitWidth = 91
      Width = 91
    end
    inherited deEnd: TcxDateEdit
      Left = 144
      Top = 23
      ExplicitLeft = 144
      ExplicitTop = 23
      ExplicitWidth = 97
      Width = 97
    end
    inherited cxLabel2: TcxLabel
      Left = 144
      ExplicitLeft = 144
    end
    object cxLabel4: TcxLabel
      Left = 281
      Top = 6
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object ceUnit: TcxButtonEdit
      Left = 281
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 256
    end
    object cxLabel3: TcxLabel
      Left = 543
      Top = 6
      Caption = #1052#1086#1076#1077#1083#1100' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
    end
    object ceModelService: TcxButtonEdit
      Left = 543
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 7
      Width = 256
    end
    object cxLabel5: TcxLabel
      Left = 10
      Top = 50
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    end
    object cePosition: TcxButtonEdit
      Left = 10
      Top = 67
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 9
      Width = 256
    end
    object cxLabel7: TcxLabel
      Left = 281
      Top = 50
      Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082':'
    end
    object ceMember: TcxButtonEdit
      Left = 281
      Top = 67
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 11
      Width = 256
    end
    object chkDetailDay: TcxCheckBox
      Left = 543
      Top = 50
      Caption = #1055#1086' '#1076#1085#1103#1084
      TabOrder = 12
      Width = 66
    end
    object chkDetailModelService: TcxCheckBox
      Left = 687
      Top = 50
      Caption = #1055#1086' '#1084#1086#1076#1077#1083#1103#1084
      TabOrder = 13
      Width = 82
    end
    object chkDetailModelServiceItemMaster: TcxCheckBox
      Left = 543
      Top = 67
      Caption = #1055#1086' '#1090#1080#1087#1072#1084' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      TabOrder = 14
      Width = 138
    end
    object chkDetailModelServiceItemChild: TcxCheckBox
      Left = 687
      Top = 67
      Caption = #1055#1086' '#1058#1086#1074#1072#1088#1091' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1077
      TabOrder = 15
      Width = 146
    end
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = chkDetailDay
        Properties.Strings = (
          'Checked')
      end
      item
        Component = chkDetailModelService
        Properties.Strings = (
          'Checked')
      end
      item
        Component = chkDetailModelServiceItemChild
        Properties.Strings = (
          'Checked')
      end
      item
        Component = chkDetailModelServiceItemMaster
        Properties.Strings = (
          'Checked')
      end
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
        Component = MemberGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = ModelServiceGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = PositionGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = UnitGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end>
  end
  inherited ActionList: TActionList
    object actPrint1: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProcList = <>
      Caption = #1062#1077#1093' '#1076#1077#1083#1080#1082'.'
      Hint = #1055#1077#1095#1072#1090#1100' '#1074#1077#1076#1086#1084#1086#1089#1090#1080' ('#1062#1077#1093' '#1076#1077#1083#1080#1082#1072#1090#1077#1089#1086#1074')'
      ImageIndex = 3
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxMasterCDS'
          IndexFieldNames = 'UnitId;PersonalServiceListId;MemberName'
        end>
      Params = <
        item
          Name = 'DateStart'
          Value = Null
          Component = deStart
          DataType = ftDateTime
        end
        item
          Name = 'dateEnd'
          Value = Null
          Component = deEnd
          DataType = ftDateTime
        end
        item
          Name = 'UnitName'
          Value = Null
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
        end>
      ReportName = #1042#1077#1076#1086#1084#1086#1089#1090#1100'_'#1087#1086'_'#1079#1072#1088#1087#1083#1072#1090#1077'_1'
      ReportNameParam.Value = #1042#1077#1076#1086#1084#1086#1089#1090#1100'_'#1087#1086'_'#1079#1072#1088#1087#1083#1072#1090#1077'_1'
      ReportNameParam.DataType = ftString
    end
    object actPrint2: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProcList = <>
      Caption = #1062#1077#1093' '#1089'/'#1082
      Hint = #1055#1077#1095#1072#1090#1100' '#1074#1077#1076#1086#1084#1086#1089#1090#1080' ('#1062#1077#1093' '#1089'/'#1082')'
      ImageIndex = 3
      DataSets = <
        item
          DataSet = MasterCDS
          UserName = 'frxMasterCDS'
          IndexFieldNames = 
            'UnitId;PersonalServiceListId;PositionName;PositionLevelName;Memb' +
            'erName'
        end>
      Params = <
        item
          Name = 'DateStart'
          Value = 41395d
          Component = deStart
          DataType = ftDateTime
        end
        item
          Name = 'dateEnd'
          Value = 41395d
          Component = deEnd
          DataType = ftDateTime
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
        end>
      ReportName = #1042#1077#1076#1086#1084#1086#1089#1090#1100'_'#1087#1086'_'#1079#1072#1088#1087#1083#1072#1090#1077'_2'
      ReportNameParam.Value = #1042#1077#1076#1086#1084#1086#1089#1090#1100'_'#1087#1086'_'#1079#1072#1088#1087#1083#1072#1090#1077'_2'
      ReportNameParam.DataType = ftString
    end
  end
  inherited MasterDS: TDataSource
    Left = 48
    Top = 152
  end
  inherited MasterCDS: TClientDataSet
    Left = 16
    Top = 152
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Report_Wage'
    Params = <
      item
        Name = 'inStartDate'
        Value = 41395d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndDate'
        Value = 41395d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inUnitId'
        Value = Null
        Component = UnitGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inModelServiceId'
        Value = Null
        Component = ModelServiceGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inMemberId'
        Value = Null
        Component = MemberGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPositionId'
        Value = Null
        Component = PositionGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inDetailDay'
        Value = Null
        Component = chkDetailDay
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inDetailModelService'
        Value = Null
        Component = chkDetailModelService
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inDetailModelServiceItemMaster'
        Value = Null
        Component = chkDetailModelServiceItemMaster
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inDetailModelServiceItemChild'
        Value = Null
        Component = chkDetailModelServiceItemChild
        DataType = ftBoolean
        ParamType = ptInput
      end>
    Left = 80
    Top = 152
  end
  inherited BarManager: TdxBarManager
    Left = 920
    Top = 32
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
          ItemName = 'bbRefresh'
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
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end>
    end
    object dxBarButton1: TdxBarButton
      Action = actPrint1
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actPrint2
      Category = 0
    end
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 184
    Top = 144
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    Left = 112
    Top = 192
  end
  object UnitGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceUnit
    FormNameParam.Value = 'TUnitForm'
    FormNameParam.DataType = ftString
    FormName = 'TUnitForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 392
    Top = 13
  end
  object ModelServiceGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceModelService
    FormNameParam.Value = 'TModelServiceForm'
    FormNameParam.DataType = ftString
    FormName = 'TModelServiceForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = ModelServiceGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = ModelServiceGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 656
    Top = 5
  end
  object PositionGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = cePosition
    FormNameParam.Value = 'TPositionForm'
    FormNameParam.DataType = ftString
    FormName = 'TPositionForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = PositionGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = PositionGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 88
    Top = 53
  end
  object MemberGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceMember
    FormNameParam.Value = 'TMemberForm'
    FormNameParam.DataType = ftString
    FormName = 'TMemberForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = MemberGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = MemberGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 352
    Top = 53
  end
end