object Form1: TForm1
  Left = 259
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Temps :'
  ClientHeight = 670
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 50
    Width = 620
    Height = 620
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 620
    Height = 50
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 2
      Width = 119
      Height = 13
      Caption = 'algorithme de Bresenham'
    end
    object Bevel1: TBevel
      Left = 200
      Top = 8
      Width = 2
      Height = 33
    end
    object Label2: TLabel
      Left = 232
      Top = 2
      Width = 144
      Height = 13
      Caption = 'Extended, algo brut de pomme'
    end
    object Label3: TLabel
      Left = 456
      Top = 2
      Width = 64
      Height = 13
      Caption = 'API Windows'
    end
    object Bevel2: TBevel
      Left = 400
      Top = 9
      Width = 2
      Height = 33
    end
    object CercleBresenham: TButton
      Left = 8
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Cercle'
      TabOrder = 0
      OnClick = CercleBresenhamClick
    end
    object EllipseBresenham: TButton
      Tag = 1
      Left = 64
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Ellipse'
      TabOrder = 1
      OnClick = CercleBresenhamClick
    end
    object FillEllipseBresenham: TButton
      Tag = 2
      Left = 120
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Ellipse pleine'
      TabOrder = 2
      OnClick = CercleBresenhamClick
    end
    object CercleExtended: TButton
      Tag = 3
      Left = 208
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Cercle'
      TabOrder = 3
      OnClick = CercleBresenhamClick
    end
    object EllipseExtended: TButton
      Tag = 4
      Left = 264
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Ellipse'
      TabOrder = 4
      OnClick = CercleBresenhamClick
    end
    object FillEllipseExtended: TButton
      Tag = 5
      Left = 320
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Ellipse pleine'
      TabOrder = 5
      OnClick = CercleBresenhamClick
    end
    object CercleAPI: TButton
      Tag = 6
      Left = 408
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Cercle'
      TabOrder = 6
      OnClick = CercleBresenhamClick
    end
    object EllipseAPI: TButton
      Tag = 7
      Left = 464
      Top = 16
      Width = 49
      Height = 25
      Caption = 'Ellipse'
      TabOrder = 7
      OnClick = CercleBresenhamClick
    end
    object FillEllipseAPI: TButton
      Tag = 8
      Left = 520
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Ellipse pleine'
      TabOrder = 8
      OnClick = CercleBresenhamClick
    end
  end
end
