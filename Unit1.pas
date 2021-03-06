unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OpenGL,
  ExtCtrls, StdCtrls, Dialogs, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Timer1: TTimer;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    TabControl1: TTabControl;
    Panel2: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2Resize(Sender: TObject);
  private
    h_RC:HGLRC; // Permanent Rendering Context
    h_DC:HDC; // Private GDI Device Context
    procedure DrawGLScene;
    procedure ReSizeGLScene(Width:GLsizei;Height:GLsizei);
    procedure InitGL(Width:GLsizei;Height:GLsizei);
    procedure DrawCzworoscian;
    procedure DrawSzescian;
    procedure DrawOsmioscian;
    procedure DrawDwunastoscian;
    procedure DrawDwudziestoscian;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  teta:GLfloat=0.0;           //zmienna wykozystywana przy obracaniu figur
  xRot:GLfloat = 0.0;         //zmienna wykozystywana przy obracaniu figur mysza
  yRot:GLfloat = 0.0;         //zmienna wykozystywana przy obracaniu figur mysza
  dragged:boolean = false;    //czy w tej chwili figura jest ciagnieta?

implementation

{$R *.dfm}

//procedura rysuj�ca czworoscian
procedure TForm1.DrawCzworoscian;
begin
  glColor3f(1,0,0);

  glBegin(GL_LINE_LOOP);
    glVertex3f(-1.0, -1.0, 1.0);
    glVertex3f( 1.0, 1.0,  1.0);
    glVertex3f( 1.0,  -1.0, -1.0);
    glVertex3f(-1.0, -1.0, 1.0);
    glVertex3f(1.0,  1.0, 1.0);
    glVertex3f(-1.0,  1.0, -1.0);
  glEnd;

  glBegin(GL_LINE_LOOP);
    glVertex3f(-1.0,  1.0, -1.0);
    glVertex3f( 1.0,  -1.0, -1.0);
  glEnd;
end;

//procedura rysujaca szescian
procedure TForm1.DrawSzescian;
begin
  glColor3f(1,0,0);
  // Front Face
  glBegin(GL_LINE_LOOP);
    glVertex3f(-1.0, -1.0,  1.0);
    glVertex3f( 1.0, -1.0,  1.0);
    glVertex3f( 1.0,  1.0,  1.0);
    glVertex3f(-1.0,  1.0,  1.0);
  glEnd;

  // Back Face
  glBegin(GL_LINE_LOOP);
    glVertex3f(-1.0, -1.0, -1.0);
    glVertex3f(-1.0,  1.0, -1.0);
    glVertex3f( 1.0,  1.0, -1.0);
    glVertex3f( 1.0, -1.0, -1.0);
  glEnd;

  // Top Face
  glBegin(GL_LINE_LOOP);
    glVertex3f(-1.0,  1.0, -1.0);
    glVertex3f(-1.0,  1.0,  1.0);
    glVertex3f( 1.0,  1.0,  1.0);
    glVertex3f( 1.0,  1.0, -1.0);
  glEnd;

  // Bottom Face
  glBegin(GL_LINE_LOOP);
    glVertex3f(-1.0, -1.0, -1.0);
    glVertex3f( 1.0, -1.0, -1.0);
    glVertex3f( 1.0, -1.0,  1.0);
    glVertex3f(-1.0, -1.0,  1.0);
  glEnd;

  // Right face
  glBegin(GL_LINE_LOOP);
    glVertex3f( 1.0, -1.0, -1.0);
    glVertex3f( 1.0,  1.0, -1.0);
    glVertex3f( 1.0,  1.0,  1.0);
    glVertex3f( 1.0, -1.0,  1.0);
  glEnd;

  // Left Face
  glBegin(GL_LINE_LOOP);
    glVertex3f(-1.0, -1.0, -1.0);
    glVertex3f(-1.0, -1.0,  1.0);
    glVertex3f(-1.0,  1.0,  1.0);
    glVertex3f(-1.0,  1.0, -1.0);
  glEnd();
end;

//procedura rysujaca osmioscian
procedure TForm1.DrawOsmioscian;
begin
  glColor3f(1,0,0);
  glBegin(GL_LINE_LOOP);
    glVertex3f( 0.0, 1.5, 0.0);
	  glVertex3f(-1.5,0.0, 1.5);
	  glVertex3f( 1.5,0.0, 1.5);
	  glVertex3f( 0.0, 1.5, 0.0);
	  glVertex3f( 1.5,0.0, 1.5);
	  glVertex3f( 1.5,0.0, -1.5);
	  glVertex3f( 0.0, 1.5, 0.0);
	  glVertex3f( 1.5,0.0, -1.5);
	  glVertex3f(-1.5,0.0, -1.5);
	  glVertex3f( 0.0, 1.5, 0.0);
	  glVertex3f(-1.5,0.0,-1.5);
	  glVertex3f(-1.5,0.0, 1.5);
  glEnd;

  glBegin(GL_LINE_LOOP);
    glVertex3f( 0.0, -1.5, 0.0);
	  glVertex3f(-1.5,0.0, 1.5);
	  glVertex3f( 1.5,0.0, 1.5);
	  glVertex3f( 0.0, -1.5, 0.0);
	  glVertex3f( 1.5,0.0, 1.5);
	  glVertex3f( 1.5,0.0, -1.5);
	  glVertex3f( 0.0, -1.5, 0.0);
	  glVertex3f( 1.5,0.0, -1.5);
	  glVertex3f(-1.5,0.0, -1.5);
	  glVertex3f( 0.0, -1.5, 0.0);
	  glVertex3f(-1.5,0.0,-1.5);
	  glVertex3f(-1.5,0.0, 1.5);
  glEnd;
end;

//procedura rysujaca dwunastoscian
procedure TForm1.DrawDwunastoscian;
type TVector3f = array[0..2] of single;
const
   A = 1.61803398875*0.3*3; // (Sqrt(5)+1)/2
   B = 0.61803398875*0.3*3; // (Sqrt(5)-1)/2
   C = 1*0.3*3;
const
   vertices : packed array [0..19] of TVector3f =
      ((-A,  0,  B), (-A,  0, -B), ( A,  0, -B), (A,  0,  B),
       ( B, -A,  0), (-B, -A,  0), (-B,  A,  0), (B,  A,  0),
       ( 0,  B, -A), ( 0, -B, -A), ( 0, -B,  A), (0,  B,  A),
       (-C, -C,  C), (-C, -C, -C), ( C, -C, -C), (C, -C,  C),
       (-C,  C,  C), (-C,  C, -C), ( C,  C, -C), (C,  C,  C));

   polygons : packed array [0..11] of packed array [0..4] of Byte =
      (( 0, 12, 10, 11, 16),  ( 1, 17,  8,  9, 13),
       ( 2, 14,  9,  8, 18),  ( 3, 19, 11, 10, 15),
       ( 4, 14,  2,  3, 15),  ( 5, 12,  0,  1, 13),
       ( 6, 17,  1,  0, 16),  ( 7, 19,  3,  2, 18),
       ( 8, 17,  6,  7, 18),  ( 9, 14,  4,  5, 13),
       (10, 12,  5,  4, 15),  (11, 19,  7,  6, 16));

var
   i, j : Integer;
   faceIndices : PByteArray;
begin
   for i:=0 to 11 do begin
      faceIndices:=@polygons[i, 0];
      glBegin(GL_LINE_LOOP);
      for j:=0 to 4 do
         glVertex3fv(@vertices[faceIndices[j]]);
      glEnd;
   end;
end;

//procedura rysujaca dwudziestoscian
procedure TForm1.DrawDwudziestoscian;
type TVector3f = array[0..2] of single;
const
   A = 1.5;
   B = 0.30901699437*2.5; // 1/(1+Sqrt(5))
const
   vertices : packed array [0..11] of TVector3f =
      (( 0,-1.0,-A), ( 0,-B, A), ( 0, B,-A), ( 0, B, A),
       (-A, 0,-B), (-A, 0, B), ( A, 0,-B), ( A, 0, B),
       (-B,-A, 0), (-B, A, 0), ( B,-A, 0), ( B, A, 0));


   triangles : packed array [0..19] of packed array [0..2] of Byte =
      (( 2, 9,11), ( 3,11, 9), ( 3, 5, 1), ( 3, 1, 7),
       ( 2, 6, 0), ( 2, 0, 4), ( 1, 8,10), ( 0,10, 8),
       ( 9, 4, 5), ( 8, 5, 4), (11, 7, 6), (10, 6, 7),
       ( 3, 9, 5), ( 3, 7,11), ( 2, 4, 9), ( 2,11, 6),
       ( 0, 8, 4), ( 0, 6,10), ( 1, 5, 8), ( 1,10, 7));

var
   i, j : Integer;
   faceIndices : PByteArray;
begin
   for i:=0 to 19 do begin
      faceIndices:=@triangles[i, 0];
      glBegin(GL_LINE_LOOP);
      for j:=0 to 2 do
         glVertex3fv(@vertices[faceIndices[j]]);
      glEnd;
   end;
end;

//procedura rysujaca nastepna klatke animacji
procedure TForm1.DrawGLScene;
begin
  //wyczyszczenie poprzedniej zawartosci sceny
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  //narysowanie du�ej figury na srodku ekranu
  glPushMatrix;                                    //zapisanie stanu wsp�rz�dnych
  glTranslatef(0.0,1.0,-8);                        //przesuniecie uk�adu wsp�rz�dnych o wektor 0,1,-8
  if CheckBox2.Checked then glRotatef(teta,1,0,0); //jezeli CheckBox1 jest zaznaczony to obr�c figur� wzgl�dem osi x o teta radianow
  if CheckBox3.Checked then glRotatef(teta,0,1,0); //jezeli CheckBox1 jest zaznaczony to obr�c figur� wzgl�dem osi y o teta radianow
  glRotatef(xRot,1.0,0.0,0.0);                     //obr�t wzgl�dem osi x ale tylko gdy wyst�pi�o ci�gni�cie myszk�
  glRotatef(yRot,0.0,1.0,0.0);                     //obr�t wzgl�dem osi y ale tylko gdy wyst�pi�o ci�gni�cie myszk�
    //narysuj to co jest zaznaczone
    case RadioGroup1.ItemIndex of
      0:DrawCzworoscian;
      1:DrawSzescian;
      2:DrawOsmioscian;
      3:DrawDwunastoscian;
      4:DrawDwudziestoscian;
    end;
  glPopMatrix;                                     //przwrcenie wczesniej zapisanego stanu wsp�lrz�dnych

  //ma�y Czworoscian
  glPushMatrix;
  glTranslatef(-8,-8,-28);
  glRotatef(teta,0,1,0);
  DrawCzworoscian;
  glPopMatrix;

  //ma�y szescian
  glPushMatrix;
  glTranslatef(-4,-8,-28);
  glRotatef(teta,0,1,0);
  DrawSzescian;
  glPopMatrix;

  //ma�y osmioscian
  glPushMatrix;
  glTranslatef(0.0,-8,-28);
  glRotatef(teta,0,1,0);
  DrawOsmioscian;
  glPopMatrix;

  //ma�y dwunastoscian
  glPushMatrix;
  glTranslatef(4.0,-8,-28);
  glRotatef(teta,0,1,0);
  DrawDwunastoscian;
  glPopMatrix;

  //ma�y dwudziestoscian
  glPushMatrix;
  glTranslatef(8.0,-8,-28);
  glRotatef(teta,0,1,0);
  DrawDwudziestoscian;
  glPopMatrix;

  //narysowanie sceny
  SwapBuffers(h_DC);
end;

//zmiana parametr�w grafiki w przypadku zmiany rozmiar�w okna
procedure TForm1.ReSizeGLScene(Width:GLsizei;Height:GLsizei);
var fWidth,fHeight:GLfloat;
begin
  {ReSizeGLScene(LOWORD(lParam),HIWORD(lParam));}
  if (Height=0) then Height:=1;
  glViewport(0,0,Width,Height);
  glMatrixMode(GL_PROJECTION); 
  glLoadIdentity(); 
  fWidth:=Width; 
  fHeight:=Height; 
  gluPerspective(45.0,fWidth/fHeight,0.4,50.0);
  glMatrixMode(GL_MODELVIEW); 
  glLoadIdentity();
end;

//inicjacja parametr�w wyswietlania grafiki
procedure TForm1.InitGL(Width: GLsizei; Height: GLsizei);
var
  fWidth, fHeight: GLfloat;
begin
  glClearColor(0.0,0.0,0.0,0);    //ustawienie koloru t�a na czarny
  glClearDepth(1.0);
  glDepthFunc(GL_LESS);
  glEnable(GL_DEPTH_TEST);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  fWidth:=Width;
  fHeight:=Height;
  gluPerspective(45.0,fWidth/fHeight,0.1,100.0);
  glMatrixMode(GL_MODELVIEW);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //wy��czenie trybu graficznego
  wglMakeCurrent(h_DC,0);
  wglDeleteContext(h_RC);
  ReleaseDC(self.Handle,h_DC);
end;

//uruchomienie trybu graficznego
//zaraz po utworzeniu okna
procedure TForm1.FormCreate(Sender: TObject);
const
  pfd:PIXELFORMATDESCRIPTOR=(
    nSize:sizeof(PIXELFORMATDESCRIPTOR);
    nVersion:1;
    dwFlags:PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
    iPixelType:PFD_TYPE_RGBA;
    cColorBits:32;
    cRedBits:0;
    cRedShift:0;
    cGreenBits:0;
    cBlueBits:0;
    cBlueShift:0;
    cAlphaBits:0;
    cAlphaShift:0;
    cAccumBits:0;
    cAccumRedBits:0;
    cAccumGreenBits:0;
    cAccumBlueBits:0;
    cAccumAlphaBits:0;
    cDepthBits:16;
    cStencilBits:0;
    cAuxBuffers:0;
    iLayerType:PFD_MAIN_PLANE;
    bReserved:0;
    dwLayerMask:0;
    dwVisibleMask:0;
    dwDamageMask:0);
var
  PixelFormat:GLuint;
begin
  self.h_DC:=Windows.GetDC(self.Panel2.Handle);
  PixelFormat:=ChoosePixelFormat(h_DC,@pfd);
  if (PixelFormat=0) then
  begin
    MessageBox(0,'Cant''t Find A Suitable PixelFormat.','Error',MB_OK or MB_ICONERROR);
    exit;
  end;
  if (not SetPixelFormat(h_DC,PixelFormat,@pfd)) then
  begin
    MessageBox(0,'Can''t Set The PixelFormat.','Error',MB_OK or MB_ICONERROR);
    exit;
  end;
  h_RC:=wglCreateContext(h_DC);
  if (h_RC=0) then
  begin
    MessageBox(0,'Can''t Create A GL Rendering Context.','Error',MB_OK or MB_ICONERROR);
    exit;
  end;
  if (not wglMakeCurrent(h_DC, h_RC)) then
  begin
    MessageBox(0,'Can''t activate GLRC.','Error',MB_OK or MB_ICONERROR);
    exit;
  end;
  InitGL(Form1.ClientWidth-GroupBox1.ClientWidth-5, Form1.ClientHeight);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  //zmienna nie moze przekroczyc wartosci maksymalnej
  if teta > 100000 then teta:=0.0;
  //obroc figury co kazde 10 ms
  teta:=teta+1;
  //ponowne narysowanie sceny
  DrawGLScene;
end;

procedure TForm1.TabControl1Change(Sender: TObject);
begin
  //zaznaczenie odpowiedniego radiobuttona
  RadioGroup1.ItemIndex:=TabControl1.TabIndex;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  //zaznaczenie odpowiedniej zak�adki
  TabControl1.TabIndex:=RadioGroup1.ItemIndex;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
   self.DrawGLScene;
end;

procedure TForm1.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //uzytkownik rozpoczal ciagniecie myszka
  dragged:=true;
end;

procedure TForm1.Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //jezeli myszka ciagnie figure to
  //ustal o ile i w jakich osiach ja obrocic
  if dragged then
  begin
    xRot:=Y+0.0;
    yRot:=X+0.0;
  end;
end;

procedure TForm1.Panel2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //uzytkownik zakonczyl ciagniecie myszka
  dragged:=false;
end;

procedure TForm1.Panel2Resize(Sender: TObject);
begin
  ReSizeGLScene(Form1.Panel2.ClientWidth, Form1.Panel2.ClientHeight);
end;

end.

