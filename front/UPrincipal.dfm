object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Consultar CEP'
  ClientHeight = 345
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 49
    Width = 410
    Height = 292
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    ExplicitHeight = 317
    object Label1: TLabel
      Left = 83
      Top = 15
      Width = 98
      Height = 21
      Caption = 'Digite o CEP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnPesquisar: TButton
      Left = 295
      Top = 12
      Width = 97
      Height = 30
      Caption = 'Pesquisar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnPesquisarClick
    end
    object MEdtCEP: TMaskEdit
      Left = 192
      Top = 12
      Width = 85
      Height = 27
      EditMask = '99999-999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentFont = False
      TabOrder = 1
      Text = '     -   '
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 47
      Width = 376
      Height = 226
      Caption = 'Resultado'
      TabOrder = 2
      object Label2: TLabel
        Left = 22
        Top = 25
        Width = 21
        Height = 15
        Caption = 'CEP'
      end
      object Label3: TLabel
        Left = 312
        Top = 75
        Width = 14
        Height = 15
        Caption = 'UF'
      end
      object Label4: TLabel
        Left = 22
        Top = 75
        Width = 37
        Height = 15
        Caption = 'Cidade'
      end
      object Label5: TLabel
        Left = 22
        Top = 125
        Width = 31
        Height = 15
        Caption = 'Bairro'
      end
      object Label6: TLabel
        Left = 22
        Top = 176
        Width = 62
        Height = 15
        Caption = 'Logradouro'
      end
      object EdtBairro: TEdit
        Left = 22
        Top = 146
        Width = 331
        Height = 21
        TabOrder = 0
      end
      object EdtCEP: TEdit
        Left = 22
        Top = 46
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object EdtCidade: TEdit
        Left = 22
        Top = 96
        Width = 284
        Height = 21
        TabOrder = 2
      end
      object EdtLogradouro: TEdit
        Left = 22
        Top = 197
        Width = 331
        Height = 21
        TabOrder = 3
      end
      object EdtUF: TEdit
        Left = 312
        Top = 96
        Width = 41
        Height = 21
        TabOrder = 4
      end
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 410
    Height = 41
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'CONSULTA DE CEP'
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
end
