unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    CercleBresenham: TButton;
    Label1: TLabel;
    EllipseBresenham: TButton;
    FillEllipseBresenham: TButton;
    Bevel1: TBevel;
    Label2: TLabel;
    CercleExtended: TButton;
    EllipseExtended: TButton;
    FillEllipseExtended: TButton;
    Image1: TImage;
    CercleAPI: TButton;
    EllipseAPI: TButton;
    Label3: TLabel;
    FillEllipseAPI: TButton;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure CercleBresenhamClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

    procedure draw_ellipse1(xc,yc,a,b,color:integer);
    procedure draw_ellipse2(xc,yc,a,b,color:integer);
    procedure draw_ellipse3(xc,yc,a,b,color:integer);

    procedure draw_circle1(xc,yc,r,color:integer);
    procedure draw_circle2(xc,yc,r,color:integer);
    procedure draw_circle3(xc,yc,r,color:integer);

    procedure fill_ellipse1(xc,yc,a,b,color:integer);
    procedure fill_ellipse2(xc,yc,a,b,color:integer);
    procedure fill_ellipse3(xc,yc,a,b,color:integer);
  end;

var
  Form1: TForm1;
  p:array of longint;
  w,h:integer;
  bit:tbitmap;
  palette:array[0..360] of longint;
  paletteWin:array[0..360] of longint;

implementation

{$R *.dfm}

// Méthode API Windows =========================================================
// =============================================================================

procedure tform1.draw_ellipse3(xc,yc,a,b,color:integer);
begin
 bit.Canvas.pen.Color:=color;
 bit.Canvas.Ellipse(xc-a,yc-b,xc+a,yc+b);
end;

procedure tform1.draw_circle3(xc,yc,r,color:integer);
begin
 bit.Canvas.pen.Color:=color;
 bit.Canvas.Ellipse(xc-r,yc-r,xc+r,yc+r);
end;

procedure tform1.fill_ellipse3(xc,yc,a,b,color:integer);
begin
 bit.Canvas.pen.Color:=color;
 bit.Canvas.brush.Color:=color;
 bit.Canvas.Ellipse(xc-a,yc-b,xc+a,yc+b);
end;

// Méthode extended ============================================================
// =============================================================================

// ellipse de rayons a,b version extended
procedure tform1.draw_ellipse2(xc,yc,a,b,color:integer);
var
 	angle,x,y,pas,s,c:extended;
begin
 if (a=0) and (b=0) then pas:=7 else pas:=1/max(a,b);
 angle:=0;
 while angle<6.2831853 do
  begin
   sincos(angle,s,c);
   x:=xc+c*a;
   y:=yc+s*b;
   p[round(x)+round(y)*width]:=color;
   angle:=angle+pas;
  end;
end;


// ellipse de rayon r version extended
procedure tform1.draw_circle2(xc,yc,r,color:integer);
var
 	angle,x,y,pas,s,c:extended;

begin
 if (r=0) then pas:=7 else pas:=1/r;
 angle:=0;
 while angle<6.2831853 do
  begin
   sincos(angle,s,c);
   x:=xc+c*r;
   y:=yc+s*r;
   p[round(x)+round(y)*width]:=color;

   angle:=angle+pas;
  end;
end;

// remplissage d'une ellipse avec la méthode mathématique pure
// x²/a²+y²/b²<=1, c'est la formule de l'ellipse...
procedure tform1.fill_ellipse2(xc,yc,a,b,color:integer);
var
 	x,y:integer;
  a2,b2:integer;
begin
 a2:=a*a;
 b2:=b*b;
 if (a2=0) or (b2=0) then p[xc+yc*width]:=color
 else
 for y:=-b to b do
  for x:=-a to a do
   if x*x/a2+y*y/b2<=1 then
    p[(x+xc)+(y+yc)*width]:=color;
end;

// Méthode Bresenham ===========================================================
// =============================================================================


// ellipse de rayon a,b version algorithme de Bresenham
procedure tform1.draw_ellipse1(xc,yc,a,b,color:integer);
var
 	t,dxt,d2xt,x,y:integer;
  a2,b2:integer;
  crit1,crit2,crit3:integer;
  d2yt,dyt:integer;

  procedure drawpoint(x,y:integer);
  begin
   p[x+y*width]:=color;
  end;

begin
		x := 0;
    y := b;
		a2 := a*a;
    b2 := b*b;
		crit1 := -(a2 shr 2 + a mod 2 + b2);
		crit2 := -(b2 shr 2 + b mod 2 + a2);
		crit3 := -(b2 shr 2 + b mod 2);
		t := -a2*y;
		dxt := 2*b2*x;
    dyt := -2*a2*y;
		d2xt := 2*b2;
    d2yt := 2*a2;

		while (y>=0) and (x<=a) do
     begin
      drawpoint(xc+x, yc+y);
      drawpoint(xc-x, yc-y);
      drawpoint(xc+x, yc-y);
      drawpoint(xc-x, yc+y);

			if (t + b2*x <= crit1) or (t + a2*y <= crit3) then begin inc(x); inc(dxt, d2xt);inc(t,dxt) end
			else
      if (t - a2*y > crit2)                         then begin dec(y); inc(dyt,d2yt); inc(t,dyt); end
			else
       begin
				inc(x); inc(dxt, d2xt);inc(t,dxt);
				dec(y); inc(dyt,d2yt); inc(t,dyt);
       end;
     end;
end;



// cercle de rayon a,b version algorithme de Bresenham
procedure tform1.draw_circle1(xc,yc,r,color:integer);
var
 x,y:integer;
 d,x2m1:integer;

  procedure drawpoint(x,y:integer);
  begin
   x:=x+xc; y:=y+yc;
   p[x+y*width]:=color;
  end;

begin
 y:=r;
 d:= -r;
 x2m1:= -1;
 x:=0;

 // on commence par mettre les 4 premiers points
 drawpoint(0,r);
 drawpoint(0,-r);
 drawpoint(r,0);
 drawpoint(-r,0);

 // on parcours un demi cadran
 while x<y do
 begin
  inc(x);
  inc(x2m1, 2);
  inc(d,x2m1);
  if (d>=0) then
    begin
       dec(y);
       dec(d,y shl 1);
    end;
    // l'algo ne fait qu'un huitième de cercle, le reste est de la symétrie
  drawpoint(-x, y);
  drawpoint( x,-y);
  drawpoint(-x,-y);
  drawpoint( x, y);
  drawpoint(-y, x);
  drawpoint( y,-x);
  drawpoint(-y,-x);
  drawpoint( y, x);
 end;
end;

// ellipse de rayon a,b version algorithme de Bresenham
procedure tform1.fill_ellipse1(xc,yc,a,b,color:integer);
var
 	t,dxt,d2xt,x,y,ofs1,ofs2,w4:integer;
  a2,b2:integer;
  crit1,crit2,crit3:integer;
  d2yt,dyt:integer;
  line1,line2:integer;
begin
    w4:=width*4;
		x := 0;
    y := b;
    line1:=(yc+b)*w4;
    line2:=(yc-b)*w4;
		a2 := a*a;
    b2 := b*b;
		crit1 := -(a2 shr 2 + a mod 2 + b2);
		crit2 := -(b2 shr 2 + b mod 2 + a2);
		crit3 := -(b2 shr 2 + b mod 2);
		t := -a2*y;
		dxt := 2*b2*x;
    dyt := -2*a2*y;
		d2xt := 2*b2;
    d2yt := 2*a2;

		while (y>=0) and (x<=a) do
     begin
			if (t + b2*x <= crit1) or (t + a2*y <= crit3) then
       begin
        inc(x); inc(dxt, d2xt);inc(t,dxt); dec(xc);
       end
			else
      if (t - a2*y > crit2) then
         begin
          // dessine les lignes haute et basse
          ofs1:=line1+xc shl 2;
          dec(line1,w4);

          ofs2:=line2+xc shl 2;
          inc(line2,w4);
          asm
           PUSH    EDI
           MOV     EDI,p
           PUSH    EDI
           ADD     EDI,ofs1
           MOV     EAX,color
           MOV     ECX,x
           SHL     ECX,1
           DEC     ECX
           PUSH    ECX
           JS      @@exit
           REP     STOSD

           POP     ECX
           POP     EDI
           ADD     EDI,ofs2

           REP     STOSD
           @@exit:
           POP     EDI
          end;
          dec(y); inc(dyt,d2yt); inc(t,dyt);
         end
			else
       begin
				inc(x); inc(dxt, d2xt);inc(t,dxt); dec(xc);

        // dessine les lignes haute et basse
        ofs1:=line1+xc shl 2;
        dec(line1,w4);

        ofs2:=line2+xc shl 2;
        inc(line2,w4);
          asm
           PUSH    EDI
           MOV     EDI,p
           PUSH    EDI
           ADD     EDI,ofs1
           MOV     EAX,color
           MOV     ECX,x
           SHL     ECX,1
           DEC     ECX
           PUSH    ECX
           JS      @@exit
           REP     STOSD

           POP     ECX
           POP     EDI
           ADD     EDI,ofs2

           REP     STOSD
           @@exit:
           POP     EDI
          end;

				dec(y); inc(dyt,d2yt); inc(t,dyt);
       end;
     end;
end;


//==============================================================================
//==============================================================================
//==============================================================================


// juste pour faire une jolie palette
function BGR(r, g, b: Byte): COLORREF;
begin
  Result := (b or (g shl 8) or (r shl 16));
end;

function RGB(r, g, b: Byte): COLORREF;
begin
  Result := (r or (g shl 8) or (b shl 16));
end;

// préparation des pointers, palettes...
procedure TForm1.FormCreate(Sender: TObject);
var
 i:integer;
begin
 bit:=tbitmap.Create;
 bit.Width:=width; bit.Height:=height;
 bit.PixelFormat:=pf32bit;
 setlength(p,width*height);
 GetBitmapBits(Bit.Handle,width*height*4,p);
 for i:=0 to 360 do
   Case (i div 60) of
      0,6:palette[i]:=bgr(255,(i Mod 60)*255 div 60,0);
      1: palette[i]:=bgr(255-(i Mod 60)*255 div 60,255,0);
      2: palette[i]:=bgr(0,255,(i Mod 60)*255 div 60);
      3: palette[i]:=bgr(0,255-(i Mod 60)*255 div 60,255);
      4: palette[i]:=bgr((i Mod 60)*255 div 60,0,255);
      5: palette[i]:=bgr(255,0,255-(i Mod 60)*255 div 60);
   end;

 for i:=0 to 360 do
   Case (i div 60) of
      0,6:paletteWin[i]:=rgb(255,(i Mod 60)*255 div 60,0);
      1: paletteWin[i]:=rgb(255-(i Mod 60)*255 div 60,255,0);
      2: paletteWin[i]:=rgb(0,255,(i Mod 60)*255 div 60);
      3: paletteWin[i]:=rgb(0,255-(i Mod 60)*255 div 60,255);
      4: paletteWin[i]:=rgb((i Mod 60)*255 div 60,0,255);
      5: paletteWin[i]:=rgb(255,0,255-(i Mod 60)*255 div 60);
   end;
end;



procedure TForm1.CercleBresenhamClick(Sender: TObject);
var
 i,j,t:integer;
 tick1,tick2:longint;
begin
 t:=tbutton(sender).Tag;
 caption:='Temps :';
 image1.Canvas.FillRect(image1.ClientRect);
 bit.Canvas.brush.Color:=clwhite;
 bit.Canvas.FillRect(image1.ClientRect);
 image1.Refresh;
 fillchar(p[0],high(p)*4+4,255);
 if t in [6..7] then bit.Canvas.Brush.Style:=BSClear
                else bit.Canvas.Brush.Style:=BSSolid;
 tick1:=GetTickCount;
 for j:=0 to 100 do
 for i:=150 downto 0 do
 case t of
  // bresenhan
  0:draw_circle1(310,310,i*2,palette[i*2]);
  1:draw_ellipse1(310,310,i*2,i,palette[i*2]);
  2:fill_ellipse1(310,310,i*2,i,palette[i*2]);

  3:draw_circle2(310,310,i*2,palette[i*2]);
  4:draw_ellipse2(310,310,i*2,i,palette[i*2]);
  5:fill_ellipse2(310,310,i*2,i,palette[i*2]);

  6:draw_circle3(310,310,i*2,paletteWin[i*2]);
  7:draw_ellipse3(310,310,i*2,i,paletteWin[i*2]);
  8:fill_ellipse3(310,310,i*2,i,paletteWin[i*2]);
 end;

 tick2:=GetTickCount;
 if t in [0..5] then SetBitmapBits(Bit.Handle,width*height*4,p);
 image1.canvas.Draw(0,0,bit);
 tick1:=tick2-tick1;
 caption:='Temps : '+inttostr(tick1 div 1000)+'s'+inttostr(tick1 mod 1000)+'''' ;
end;

end.
