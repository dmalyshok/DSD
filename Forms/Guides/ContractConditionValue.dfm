object ContractConditionValueForm: TContractConditionValueForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' <'#1044#1086#1075#1086#1074#1086#1088#1072' ('#1089' '#1091#1089#1083#1086#1074#1080#1103#1084#1080')>'
  ClientHeight = 473
  ClientWidth = 1179
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.isAlwaysRefresh = False
  AddOnFormData.RefreshAction = actRefresh
  AddOnFormData.ChoiceAction = dsdChoiceGuides
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 26
    Width = 1179
    Height = 447
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = False
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = dmMain.SortImageList
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = clComment
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.HeaderHeight = 40
      OptionsView.Indicator = True
      Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
      object clContractStateKindName: TcxGridDBColumn
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1076#1086#1075#1086#1074#1086#1088#1072
        DataBinding.FieldName = 'ContractStateKindCode'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Properties.Images = dmMain.ImageList
        Properties.Items = <
          item
            Description = #1055#1086#1076#1087#1080#1089#1072#1085
            ImageIndex = 12
            Value = 1
          end
          item
            Description = #1053#1077' '#1087#1086#1076#1087#1080#1089#1072#1085
            ImageIndex = 11
            Value = 2
          end
          item
            Description = #1047#1072#1074#1077#1088#1096#1077#1085
            ImageIndex = 13
            Value = 3
          end
          item
            Description = #1059' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
            ImageIndex = 66
            Value = 4
          end>
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 60
      end
      object clCode: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'Code'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 35
      end
      object clInvNumberArchive: TcxGridDBColumn
        Caption = #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' '#8470
        DataBinding.FieldName = 'InvNumberArchive'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 51
      end
      object clInvNumber: TcxGridDBColumn
        Caption = #8470' '#1076#1086#1075#1086#1074#1086#1088#1072
        DataBinding.FieldName = 'InvNumber'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 51
      end
      object clJuridicalCode: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1102#1088'.'#1083'.'
        DataBinding.FieldName = 'JuridicalCode'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 45
      end
      object clJuridicalName: TcxGridDBColumn
        Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086
        DataBinding.FieldName = 'JuridicalName'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = JuridicalChoiceForm
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 120
      end
      object clJuridicalName_find: TcxGridDBColumn
        Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086' ('#1087#1086#1080#1089#1082')'
        DataBinding.FieldName = 'JuridicalName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 100
      end
      object clOKPO: TcxGridDBColumn
        Caption = #1054#1050#1055#1054
        DataBinding.FieldName = 'OKPO'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clPaidKindName: TcxGridDBColumn
        Caption = #1060#1086#1088#1084#1072' '#1086#1087#1083#1072#1090#1099
        DataBinding.FieldName = 'PaidKindName'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = PaidKindChoiceForm
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 40
      end
      object clContractKindName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1076#1086#1075#1086#1074#1086#1088#1072
        DataBinding.FieldName = 'ContractKindName'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = ContractKindChoiceForm
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 55
      end
      object clSigningDate: TcxGridDBColumn
        Caption = #1044#1072#1090#1072' '#1079#1072#1082#1083#1102#1095#1077#1085#1080#1103
        DataBinding.FieldName = 'SigningDate'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 60
      end
      object clStartDate: TcxGridDBColumn
        Caption = #1044#1077#1081#1089#1090#1074'. '#1089
        DataBinding.FieldName = 'StartDate'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 44
      end
      object clEndDate: TcxGridDBColumn
        Caption = #1044#1077#1081#1089#1090#1074'. '#1076#1086
        DataBinding.FieldName = 'EndDate'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 46
      end
      object clInfoMoneyGroupCode: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1059#1055' '#1075#1088#1091#1087#1087#1099
        DataBinding.FieldName = 'InfoMoneyGroupCode'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clInfoMoneyGroupName: TcxGridDBColumn
        Caption = #1059#1055' '#1075#1088#1091#1087#1087#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
        DataBinding.FieldName = 'InfoMoneyGroupName'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = InfoMoneyChoiceForm
            Default = True
            Kind = bkEllipsis
          end>
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 113
      end
      object clInfoMoneyDestinationCode: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1059#1055' '#1085#1072#1079#1085#1072#1095'.'
        DataBinding.FieldName = 'InfoMoneyDestinationCode'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clInfoMoneyDestinationName: TcxGridDBColumn
        Caption = #1059#1055' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077
        DataBinding.FieldName = 'InfoMoneyDestinationName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 80
      end
      object clInfoMoneyCode: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1059#1055
        DataBinding.FieldName = 'InfoMoneyCode'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = InfoMoneyChoiceForm
            Default = True
            Kind = bkEllipsis
          end>
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 36
      end
      object clInfoMoneyName: TcxGridDBColumn
        Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
        DataBinding.FieldName = 'InfoMoneyName'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = InfoMoneyChoiceForm
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 70
      end
      object clContractConditionKindName: TcxGridDBColumn
        Caption = #1059#1089#1083#1086#1074#1080#1077' '#1076#1086#1075#1086#1074#1086#1088#1072
        DataBinding.FieldName = 'ContractConditionKindName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 60
      end
      object clBonusKindName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1073#1086#1085#1091#1089#1072
        DataBinding.FieldName = 'BonusKindName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 45
      end
      object clValue: TcxGridDBColumn
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077
        DataBinding.FieldName = 'Value'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 40
      end
      object clContractConditionComment: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' ('#1091#1089#1083#1086#1074#1080#1077' '#1076#1086#1075'.)'
        DataBinding.FieldName = 'ContractConditionComment'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 70
      end
      object clInfoMoneyGroupCode_ch: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1059#1055' '#1075#1088#1091#1087#1087#1099' ('#1091#1089#1083#1086#1074#1080#1077' '#1076#1086#1075'.)'
        DataBinding.FieldName = 'InfoMoneyGroupCode_ch'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clInfoMoneyGroupName_ch: TcxGridDBColumn
        Caption = #1059#1055' '#1075#1088#1091#1087#1087#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103' ('#1091#1089#1083#1086#1074#1080#1077' '#1076#1086#1075'.)'
        DataBinding.FieldName = 'InfoMoneyGroupName_ch'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 113
      end
      object clInfoMoneyDestinationCode_ch: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1059#1055' '#1085#1072#1079#1085#1072#1095'. ('#1091#1089#1083#1086#1074#1080#1077' '#1076#1086#1075'.)'
        DataBinding.FieldName = 'InfoMoneyDestinationCode_ch'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clInfoMoneyDestinationName_ch: TcxGridDBColumn
        Caption = #1059#1055' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077' ('#1091#1089#1083#1086#1074#1080#1077' '#1076#1086#1075'.)'
        DataBinding.FieldName = 'InfoMoneyDestinationName_ch'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 80
      end
      object clInfoMoneyCode_ch: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1059#1055' ('#1091#1089#1083#1086#1074#1080#1077' '#1076#1086#1075'.)'
        DataBinding.FieldName = 'InfoMoneyCode_ch'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 36
      end
      object clInfoMoneyName_ch: TcxGridDBColumn
        Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103' ('#1091#1089#1083#1086#1074#1080#1077' '#1076#1086#1075'.)'
        DataBinding.FieldName = 'InfoMoneyName_ch'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 90
      end
      object clPersonalName: TcxGridDBColumn
        Caption = #1054#1090#1074'.'#1089#1086#1090#1088#1091#1076#1085#1080#1082
        DataBinding.FieldName = 'PersonalName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clAreaName: TcxGridDBColumn
        Caption = #1056#1077#1075#1080#1086#1085
        DataBinding.FieldName = 'AreaName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clContractArticleName: TcxGridDBColumn
        Caption = #1055#1088#1077#1076#1084#1077#1090' '#1076#1086#1075#1086#1074#1086#1088#1072
        DataBinding.FieldName = 'ContractArticleName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clJuridicalBasisName: TcxGridDBColumn
        Caption = #1043#1083#1072#1074#1085#1086#1077' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086
        DataBinding.FieldName = 'JuridicalBasisName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 70
      end
      object clBankAccount: TcxGridDBColumn
        Caption = #1056'.'#1089#1095#1077#1090
        DataBinding.FieldName = 'BankAccount'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 46
      end
      object clBankName: TcxGridDBColumn
        Caption = #1041#1072#1085#1082
        DataBinding.FieldName = 'BankName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 56
      end
      object clisDefault: TcxGridDBColumn
        Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        DataBinding.FieldName = 'isDefault'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 40
      end
      object clisStandart: TcxGridDBColumn
        Caption = #1058#1080#1087#1086#1074#1086#1081
        DataBinding.FieldName = 'isStandart'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 30
      end
      object clComment: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        DataBinding.FieldName = 'Comment'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 82
      end
      object clIsErased: TcxGridDBColumn
        Caption = #1059#1076#1072#1083#1077#1085
        DataBinding.FieldName = 'isErased'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 40
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 56
    Top = 96
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    MasterFields = 'Id'
    Params = <>
    Left = 64
    Top = 160
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = clComment
        Properties.Strings = (
          'Width')
      end
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
    Left = 248
    Top = 72
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
    Left = 152
    Top = 88
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
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
          Visible = True
          ItemName = 'bbSetErased'
        end
        item
          Visible = True
          ItemName = 'bbSetUnErased'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbUnSigned'
        end
        item
          Visible = True
          ItemName = 'bbInPartner'
        end
        item
          Visible = True
          ItemName = 'bbSigned'
        end
        item
          Visible = True
          ItemName = 'bbClose'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbInsertJuridical'
        end
        item
          Visible = True
          ItemName = 'bbUpdateJuridical'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          Visible = True
          ItemName = 'bbChoiceGuides'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbRefresh: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object bbInsert: TdxBarButton
      Action = actInsert
      Category = 0
    end
    object bbEdit: TdxBarButton
      Action = actUpdate
      Category = 0
    end
    object bbSetErased: TdxBarButton
      Action = dsdSetErased
      Category = 0
    end
    object bbSetUnErased: TdxBarButton
      Action = dsdSetUnErased
      Category = 0
    end
    object bbGridToExcel: TdxBarButton
      Action = dsdGridToExcel
      Category = 0
    end
    object dxBarStatic1: TdxBarStatic
      Caption = '    '
      Category = 0
      Hint = '    '
      Visible = ivAlways
    end
    object bbChoiceGuides: TdxBarButton
      Action = dsdChoiceGuides
      Category = 0
    end
    object bbInsertJuridical: TdxBarButton
      Action = actInsertJuridical
      Category = 0
    end
    object bbUpdateJuridical: TdxBarButton
      Action = actUpdateJuridical
      Category = 0
    end
    object bbUnSigned: TdxBarButton
      Action = actContractUnRead
      Category = 0
    end
    object bbInPartner: TdxBarButton
      Action = actContractInPartner
      Category = 0
    end
    object bbSigned: TdxBarButton
      Action = actContractRead
      Category = 0
    end
    object bbClose: TdxBarButton
      Action = actContractClose
      Category = 0
    end
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 248
    Top = 136
    object actInsert: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      ImageIndex = 0
      FormName = 'TContractEditForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
        end
        item
          Name = 'JuridicalId'
          Value = 0
        end
        item
          Name = 'JuridicalName'
          Value = ''
          DataType = ftString
        end>
      isShowModal = True
      DataSource = DataSource
      DataSetRefresh = actRefresh
      IdFieldName = 'Id'
    end
    object actUpdate: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 115
      ImageIndex = 1
      FormName = 'TContractEditForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Id'
          Component = ClientDataSet
          ComponentItem = 'Id'
          ParamType = ptInput
        end
        item
          Name = 'JuridicalId'
          Component = ClientDataSet
          ComponentItem = 'JuridicalId'
        end
        item
          Name = 'JuridicalName'
          Component = ClientDataSet
          ComponentItem = 'JuridicalName'
          DataType = ftString
        end>
      isShowModal = True
      ActionType = acUpdate
      DataSource = DataSource
      DataSetRefresh = actRefresh
      IdFieldName = 'Id'
    end
    object dsdSetErased: TdsdUpdateErased
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spErasedUnErased
      StoredProcList = <
        item
          StoredProc = spErasedUnErased
        end>
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 2
      ShortCut = 46
      ErasedFieldName = 'isErased'
      DataSource = DataSource
    end
    object dsdSetUnErased: TdsdUpdateErased
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spErasedUnErased
      StoredProcList = <
        item
          StoredProc = spErasedUnErased
        end>
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 8
      ShortCut = 32776
      ErasedFieldName = 'isErased'
      isSetErased = False
      DataSource = DataSource
    end
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = dsdStoredProc
      StoredProcList = <
        item
          StoredProc = dsdStoredProc
        end
        item
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object dsdGridToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      MoveParams = <>
      Grid = cxGrid
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
    object dsdChoiceGuides: TdsdChoiceGuides
      Category = 'DSDLib'
      MoveParams = <>
      Params = <
        item
          Name = 'Key'
          Component = ClientDataSet
          ComponentItem = 'Id'
        end
        item
          Name = 'TextValue'
          Component = ClientDataSet
          ComponentItem = 'InvNumber'
          DataType = ftString
        end
        item
          Name = 'JuridicalName'
          Component = ClientDataSet
          ComponentItem = 'JuridicalName'
          DataType = ftString
        end>
      Caption = #1042#1099#1073#1086#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Hint = #1042#1099#1073#1086#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      ImageIndex = 7
    end
    object actUpdateDataSet: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      StoredProcList = <>
      Caption = 'actUpdateDataSet'
      DataSource = DataSource
    end
    object InfoMoneyChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'InfoMoneyChoiceForm'
      FormName = 'TInfoMoney_ObjectForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Key'
          Component = ClientDataSet
          ComponentItem = 'InfoMoneyId'
        end
        item
          Name = 'TextValue'
          Component = ClientDataSet
          ComponentItem = 'InfoMoneyName'
          DataType = ftString
        end
        item
          Name = 'InfoMoneyCode'
          Component = ClientDataSet
          ComponentItem = 'InfoMoneyCode'
        end
        item
          Name = 'InfoMoneyGroupId'
          Component = ClientDataSet
          ComponentItem = 'InfoMoneyGroupId'
        end
        item
          Name = 'InfoMoneyGroupName'
          Component = ClientDataSet
          ComponentItem = 'InfoMoneyGroupName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object JuridicalChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'JuridicalChoiceForm'
      FormName = 'TJuridical_ObjectForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Key'
          Component = ClientDataSet
          ComponentItem = 'JuridicalId'
        end
        item
          Name = 'TextValue'
          Component = ClientDataSet
          ComponentItem = 'JuridicalName'
          DataType = ftString
        end
        item
          Name = 'InfoMoneyId'
          Component = ClientDataSet
          ComponentItem = 'InfoMoneyId'
        end
        item
          Name = 'InfoMoneyName'
          Component = ClientDataSet
          ComponentItem = 'InfoMoneyName'
          DataType = ftString
        end
        item
          Name = 'OKPO'
          Component = ClientDataSet
          ComponentItem = 'OKPO'
          DataType = ftString
        end
        item
          Name = 'JuridicalCode'
          Component = ClientDataSet
          ComponentItem = 'JuridicalCode'
        end>
      isShowModal = True
    end
    object ContractKindChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'ContractKindChoiceForm'
      FormName = 'TContractKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Key'
          Component = ClientDataSet
          ComponentItem = 'ContractKindId'
        end
        item
          Name = 'TextValue'
          Component = ClientDataSet
          ComponentItem = 'ContractKindName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object ContractConditionKindChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'ContractConditionKindChoiceForm'
      FormName = 'TContractConditionKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Key'
          Value = Null
        end
        item
          Name = 'TextValue'
          Value = Null
          DataType = ftString
        end
        item
          Name = 'inContractId'
          Value = 0
        end>
      isShowModal = False
    end
    object PaidKindChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'PaidKindChoiceForm'
      FormName = 'TPaidKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Key'
          Component = ClientDataSet
          ComponentItem = 'PaidKindId'
        end
        item
          Name = 'TextValue'
          Component = ClientDataSet
          ComponentItem = 'PaidKindName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object actInsertJuridical: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1102#1088'. '#1083#1080#1094#1086
      ImageIndex = 0
      FormName = 'TJuridicalEditForm'
      FormNameParam.Value = 'TJuridicalEditForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Id'
          Value = '0'
        end>
      isShowModal = False
      IdFieldName = 'Id'
    end
    object actMultiInsertJuridical: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = actInsertJuridical
        end
        item
          Action = actInsert
        end>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1102#1088'. '#1083#1080#1094#1086
      ImageIndex = 0
    end
    object actUpdateJuridical: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1090#1100' '#1102#1088'. '#1083#1080#1094#1086
      ImageIndex = 1
      FormName = 'TJuridicalEditForm'
      FormNameParam.Value = 'TJuridicalEditForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Id'
          Component = ClientDataSet
          ComponentItem = 'JuridicalId'
        end>
      isShowModal = False
      IdFieldName = 'Id'
    end
    object actContractUnRead: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spContractUnRead
      StoredProcList = <
        item
          StoredProc = spContractUnRead
        end>
      Caption = 'dsdExecStoredProc1'
      Hint = #1053#1072' '#1089#1086#1075#1083#1072#1089#1086#1074#1072#1085#1080#1080
      ImageIndex = 11
    end
    object actContractInPartner: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spContractPartner
      StoredProcList = <
        item
          StoredProc = spContractPartner
        end>
      Caption = 'dsdExecStoredProc2'
      Hint = #1059' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
      ImageIndex = 66
    end
    object actContractRead: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spContractRead
      StoredProcList = <
        item
          StoredProc = spContractRead
        end>
      Caption = 'dsdExecStoredProc3'
      Hint = #1055#1086#1076#1089#1087#1080#1089#1072#1085
      ImageIndex = 12
    end
    object actContractClose: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spContractClose
      StoredProcList = <
        item
          StoredProc = spContractClose
        end>
      Caption = 'dsdExecStoredProc4'
      Hint = #1047#1072#1082#1088#1099#1090
      ImageIndex = 13
    end
  end
  object dsdStoredProc: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_ContractConditionValue'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    Params = <>
    Left = 256
    Top = 304
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 104
    Top = 208
  end
  object spErasedUnErased: TdsdStoredProc
    StoredProcName = 'gpUpdateObjectIsErased'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inObjectId'
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 160
    Top = 160
  end
  object dsdDBViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableView
    OnDblClickActionList = <
      item
        Action = actUpdate
      end
      item
        Action = dsdChoiceGuides
      end>
    ActionItemList = <
      item
        Action = dsdChoiceGuides
        ShortCut = 13
      end
      item
        Action = actUpdate
        ShortCut = 13
      end>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 272
    Top = 184
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Contract'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inCode'
        Component = ClientDataSet
        ComponentItem = 'Code'
        ParamType = ptInput
      end
      item
        Name = 'inInvNumber'
        Component = ClientDataSet
        ComponentItem = 'InvNumber'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inInvNumberArchive'
        Component = ClientDataSet
        ComponentItem = 'InvNumberArchive'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inComment'
        Component = ClientDataSet
        ComponentItem = 'Comment'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inBankAccount'
        Component = ClientDataSet
        ComponentItem = 'BankAccount'
        DataType = ftString
      end
      item
        Name = 'inSigningDate'
        Component = ClientDataSet
        ComponentItem = 'SigningDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inStartDate'
        Component = ClientDataSet
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndDate'
        Component = ClientDataSet
        ComponentItem = 'EndDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalId'
        Component = ClientDataSet
        ComponentItem = 'JuridicalId'
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalBasisId'
        Component = ClientDataSet
        ComponentItem = 'JuridicalBasisId'
        ParamType = ptInput
      end
      item
        Name = 'inInfoMoneyId'
        Component = ClientDataSet
        ComponentItem = 'InfoMoneyId'
        ParamType = ptInput
      end
      item
        Name = 'inContractKindId'
        Component = ClientDataSet
        ComponentItem = 'ContractKindId'
        ParamType = ptInput
      end
      item
        Name = 'inPaidKindId'
        Component = ClientDataSet
        ComponentItem = 'PaidKindId'
        ParamType = ptInput
      end
      item
        Name = 'inPersonalId'
        Component = ClientDataSet
        ComponentItem = 'PersonalId'
        ParamType = ptInput
      end
      item
        Name = 'inAreaId'
        Component = ClientDataSet
        ComponentItem = 'AreaId'
        ParamType = ptInput
      end
      item
        Name = 'inContractArticleId'
        Component = ClientDataSet
        ComponentItem = 'ContractArticleId'
        ParamType = ptInput
      end
      item
        Name = 'inContractStateKindId'
        Component = ClientDataSet
        ComponentItem = 'ContractStateKindId'
        ParamType = ptInput
      end
      item
        Name = 'inBankId'
        Component = ClientDataSet
        ComponentItem = 'BankId'
        ParamType = ptInput
      end>
    Left = 432
    Top = 176
  end
  object spContractUnRead: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Contract_ContractStateKind'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inContractId'
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inContractStateKindCode'
        Value = '2'
        ParamType = ptInput
      end
      item
        Name = 'outContractStateKindCode'
        Component = ClientDataSet
        ComponentItem = 'ContractStateKindCode'
      end
      item
        Name = 'outContractStateKindName'
        Value = Null
        DataType = ftString
      end>
    Left = 480
    Top = 104
  end
  object spContractRead: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Contract_ContractStateKind'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inContractId'
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inContractStateKindCode'
        Value = '1'
        ParamType = ptInput
      end
      item
        Name = 'outContractStateKindCode'
        Component = ClientDataSet
        ComponentItem = 'ContractStateKindCode'
      end
      item
        Name = 'outContractStateKindName'
        Value = Null
        DataType = ftString
      end>
    Left = 592
    Top = 128
  end
  object spContractPartner: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Contract_ContractStateKind'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inContractId'
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inContractStateKindCode'
        Value = '4'
        ParamType = ptInput
      end
      item
        Name = 'outContractStateKindCode'
        Component = ClientDataSet
        ComponentItem = 'ContractStateKindCode'
      end
      item
        Name = 'outContractStateKindName'
        Value = Null
        DataType = ftString
      end>
    Left = 480
    Top = 248
  end
  object spContractClose: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Contract_ContractStateKind'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inContractId'
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inContractStateKindCode'
        Value = '3'
        ParamType = ptInput
      end
      item
        Name = 'outContractStateKindCode'
        Component = ClientDataSet
        ComponentItem = 'ContractStateKindCode'
      end
      item
        Name = 'outContractStateKindName'
        Value = Null
        DataType = ftString
      end>
    Left = 560
    Top = 216
  end
end
