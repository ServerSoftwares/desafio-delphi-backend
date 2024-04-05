object FormPrincipalCep: TFormPrincipalCep
  Left = 0
  Top = 0
  Caption = 'Sistema de Consulta de CEP'
  ClientHeight = 387
  ClientWidth = 517
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 517
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 517
    Height = 387
    Align = alClient
    BorderWidth = 5
    Color = clActiveCaption
    ParentBackground = False
    TabOrder = 0
    object GroupBoxPrincipal: TGroupBox
      Left = 6
      Top = 6
      Width = 505
      Height = 375
      Align = alClient
      Caption = 'C'#243'digo de Endere'#231'amento Postal'
      Color = clSkyBlue
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      DesignSize = (
        505
        375)
      object LabelBairro: TLabel
        Left = 56
        Top = 162
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object LabelCEP: TLabel
        Left = 56
        Top = 95
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object LabelCidade: TLabel
        Left = 56
        Top = 195
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object LabelLogradouro: TLabel
        Left = 56
        Top = 228
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object LabelUF: TLabel
        Left = 56
        Top = 130
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object EditBairro: TEdit
        Left = 113
        Top = 159
        Width = 328
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 3
      end
      object EditCidade: TEdit
        Left = 113
        Top = 192
        Width = 328
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 4
      end
      object EditLogradouro: TEdit
        Left = 113
        Top = 225
        Width = 328
        Height = 21
        Anchors = [akLeft, akTop, akRight, akBottom]
        Constraints.MinHeight = 21
        ReadOnly = True
        TabOrder = 5
      end
      object EditUF: TEdit
        Left = 113
        Top = 127
        Width = 104
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 2
      end
      object GroupBoxConsulta: TGroupBox
        Left = 56
        Top = 23
        Width = 385
        Height = 59
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Consulta por CEP'
        TabOrder = 0
        DesignSize = (
          385
          59)
        object ButtonConsultar: TButton
          Left = 225
          Top = 13
          Width = 149
          Height = 36
          Anchors = [akTop, akRight]
          Caption = 'Consultar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ButtonConsultarClick
        end
        object MaskEditCEPConsulta: TMaskEdit
          Left = 57
          Top = 24
          Width = 104
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditMask = '99999-999;1'
          MaxLength = 9
          TabOrder = 0
          Text = '     -   '
        end
      end
      object MaskEditCEP: TMaskEdit
        Left = 113
        Top = 92
        Width = 104
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditMask = '99999-999;1'
        MaxLength = 9
        ReadOnly = True
        TabOrder = 1
        Text = '     -   '
      end
      object GroupBoxCEPFaixa: TGroupBox
        Left = 56
        Top = 252
        Width = 385
        Height = 105
        Anchors = [akLeft, akRight, akBottom]
        Caption = 'Consulta CEPs por Faixa'
        TabOrder = 6
        DesignSize = (
          385
          105)
        object LabelInicioFaixa: TLabel
          Left = 20
          Top = 19
          Width = 25
          Height = 13
          Caption = 'Inicio'
        end
        object LabelFimFaixa: TLabel
          Left = 20
          Top = 56
          Width = 16
          Height = 13
          Caption = 'Fim'
        end
        object LabelExecutarIntervalo: TLabel
          Left = 225
          Top = 55
          Width = 69
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Executar ap'#243's'
        end
        object LabelExecutarSegundos: TLabel
          Left = 336
          Top = 56
          Width = 46
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'segundos'
        end
        object ButtonConsultarFaixa: TButton
          Left = 225
          Top = 13
          Width = 149
          Height = 36
          Anchors = [akTop, akRight]
          Caption = 'Consultar Por Faixa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = ButtonConsultarFaixaClick
        end
        object MaskEditCEPInicio: TMaskEdit
          Left = 57
          Top = 16
          Width = 104
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditMask = '99999-999;1'
          MaxLength = 9
          TabOrder = 0
          Text = '     -   '
          OnExit = EditSegundosExecutarExit
        end
        object MaskEditCEPFim: TMaskEdit
          Left = 57
          Top = 52
          Width = 104
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditMask = '99999-999;1'
          MaxLength = 9
          TabOrder = 1
          Text = '     -   '
          OnExit = EditSegundosExecutarExit
        end
        object EditSegundosExecutar: TEdit
          Left = 298
          Top = 53
          Width = 33
          Height = 21
          Anchors = [akTop, akRight]
          NumbersOnly = True
          TabOrder = 3
          OnExit = EditSegundosExecutarExit
        end
        object ProgressBarConsultaFaixa: TProgressBar
          Left = 20
          Top = 82
          Width = 354
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
        end
      end
    end
  end
  object TimerExecucaoFaixa: TTimer
    Enabled = False
    OnTimer = TimerExecucaoFaixaTimer
    Left = 462
    Top = 302
  end
end
