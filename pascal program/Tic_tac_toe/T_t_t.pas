{$APPTYPE GUI}
program tic_tac_toe;
uses
    gl,glut,dos,iot,windows;

var
    box : gluint;
    top : gluint;
    base: gluint;
    m   : p;
    inp : byte;
    r   : GLfloat;

procedure Timer(value:GLint); cdecl;
begin
    glutPostReDisplay;
    glutTimerFunc(20,@Timer,0);
end;

procedure BuildLists();
const bw = 1.2 ;
begin
     box:=glGenLists(2);
     glNewList(box,GL_COMPILE);
     glBegin(GL_QUADS);
     glVertex3f(0.3,0.3,-0.05);
     glVertex3f(-0.3,0.3,-0.05);
     glVertex3f(-0.3,0.3,0.05);
     glVertex3f(0.3,0.3,0.05);
     glVertex3f(-0.3,0.3,0.05);
     glVertex3f(-0.3,0.3,-0.05);
     glVertex3f(-0.3,-0.3,-0.05);
     glVertex3f(-0.3,-0.3,0.05);
     glVertex3f(0.3,0.3,-0.05);
     glVertex3f(0.3,0.3,0.05);
     glVertex3f(0.3,-0.3,0.05);
     glVertex3f(0.3,-0.3,-0.05);
     glVertex3f(0.3,-0.3,0.05);
     glVertex3f(-0.3,-0.3,0.05);
     glVertex3f(-0.3,-0.3,-0.05);
     glVertex3f(0.3,-0.3,-0.05);
     glEnd();
     glEndList();
     top := box+1;
     glNewList(top,GL_COMPILE);
     glBegin(GL_QUADS);
     glVertex3f(0.3,0.3,0.05);
     glVertex3f(-0.3,0.3,0.05);
     glVertex3f(-0.3,-0.3,0.05);
     glVertex3f(0.3,-0.3,0.05);
     glEnd();
     glEndList();
     base := top+1;
     glNewList(base,GL_COMPILE);
     glBegin(GL_QUADS);
     glColor3f(0.0,0.9,1.0);
     glVertex3f(bw,bw,-0.05);
     glVertex3f(-bw,bw,-0.05);
     glVertex3f(-bw,-bw,-0.05);
     glVertex3f(bw,-bw,-0.05);
     glEnd();
     glEndList();
end;

procedure nothing(c:char;x,y:integer); cdecl;begin end;

procedure draww; cdecl;
forward;

procedure draww2; cdecl;
var k,j : GLuint;
    r,g,b : glfloat;
begin
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
  glCallList(base);
  glColor3f(0.7,1,0);
  glTranslatef(0,0.65*2,0);
  for j := 3 downto 1 do
  begin
  glTranslatef(0,-0.65,0);
  begin
  glTranslatef(-0.7*2,0,0);
  for k := 1 to 3 do
  begin
  glTranslatef(0.7,0,0);
  case m[k,j] of
      0 : begin r:= 0.69;g:=0.69;b:= 0.69;end;
      1 : begin r:= 0.99;g:=0.99;b:= 0.99;end;
      6 : begin r:= 0.39;g:=0.39;b:= 0.39;end;
  end;
  glColor3f(r,g,b);
  glCallList(top);
  glColor3f(r-0.19,g-0.19,b-0.19);
  glCallList(box);
  end;
  glTranslatef(-0.7,0,0);
  end;
  end;
  glTranslatef(0,0.65,0);
  glFlush;
  glutSwapBuffers;
  sleep(300);
  glutDisplayFunc(@draww);

end;

procedure draww; cdecl;
var k,j : GLuint;
    r,g,b : glfloat;
    fwps : byte;
begin
  glutKeyboardFunc(@nothing);

  fwps:=wps(m);
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
  glCallList(base);
  glColor3f(0.7,1,0);
  glTranslatef(0,0.65*2,0);
  for j := 3 downto 1 do
  begin
  glTranslatef(0,-0.65,0);
  begin
  glTranslatef(-0.7*2,0,0);
  for k := 1 to 3 do
  begin
  glTranslatef(0.7,0,0);
  case m[k,j] of
      0 : begin r:= 0.69;g:=0.69;b:= 0.69;end;
      1 : begin r:= 0.99;g:=0.99;b:= 0.99;end;
      6 : begin r:= 0.39;g:=0.39;b:= 0.39;end;
  end;
  if(fwps div 10=1)and(k=fwps mod 10)then begin r:=0.99;g:=0.99;b:=0.19;end;
  if(fwps div 10=2)and(j=fwps mod 10)then begin r:=0.99;g:=0.99;b:=0.19;end;
  if(fwps div 10=3)and(1=fwps mod 10)then if j=k then begin r:=0.99;g:=0.99;b:=0.19;end;
  if(fwps div 10=3)and(2=fwps mod 10)then if 4-j=k then begin r:=0.99;g:=0.99;b:=0.19;end;
  glColor3f(r,g,b);
  glCallList(top);
  glColor3f(r-0.19,g-0.19,b-0.19);
  glCallList(box);
  end;
  glTranslatef(-0.7,0,0);
  end;
  end;
  glTranslatef(0,0.65,0);
  glFlush;
  glutSwapBuffers;
  sleep(300);
  glutDisplayFunc(@draww2);
end;

procedure draw; cdecl;
var k,j : GLuint;
    r,g,b : glfloat;
begin
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
  glCallList(base);
  glColor3f(0.7,1,0);
  glTranslatef(0,0.65*2,0);
  for j := 3 downto 1 do
  begin
  glTranslatef(0,-0.65,0);
  begin
  glTranslatef(-0.7*2,0,0);
  for k := 1 to 3 do
  begin
  glTranslatef(0.7,0,0);
  case m[k,j] of
      0 : begin r:= 0.69;g:=0.69;b:= 0.69;end;
      1 : begin r:= 0.99;g:=0.99;b:= 0.99;end;
      6 : begin r:= 0.39;g:=0.39;b:= 0.39;end;
  end;
  glColor3f(r,g,b);
  glCallList(top);
  glColor3f(r-0.19,g-0.19,b-0.19);
  glCallList(box);
  end;
  glTranslatef(-0.7,0,0);
  end;
  end;
  glTranslatef(0,0.65,0);
  glFlush;
  glutSwapBuffers;

  if ps(m)<> 0 then glutDisplayFunc(@draww);
end;

procedure drawn; cdecl;
var i : byte;
    k,j : GLuint;
    r,g,b : glfloat;
    counter : byte;
begin
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );

  for i := 1 to 6 do begin
  glCallList(base);
  glColor3f(0.7,1,0);
  glTranslatef(0,0.65*2,0);
  for j := 3 downto 1 do
  begin
  glTranslatef(0,-0.65,0);
  begin
  glTranslatef(-0.7*2,0,0);
  for k := 1 to 3 do
  begin
  glTranslatef(0.7,0,0);
  case m[k,j] of
      0 : begin r:= 0.69;g:=0.69;b:= 0.69;end;
      1 : begin r:= 0.99;g:=0.99;b:= 0.99;end;
      6 : begin r:= 0.39;g:=0.39;b:= 0.39;end;
  end;
  if(k=tn(inp)div 10)and(j=tn(inp)mod 10)then begin r:=1;g:=0.3;b:=0.3;end;
  glColor3f(r,g,b);
  glCallList(top);
  glColor3f(r-0.19,g-0.19,b-0.19);
  glCallList(box);
  end;
  glTranslatef(-0.7,0,0);
  end;
  end;
  glTranslatef(0,0.65,0);

  glFlush;
  glutSwapBuffers;
  sleep(300);
  end;

  glutDisplayFunc(@draw);
end;

procedure init;
begin
glutInitWindowPosition(100,100);
glutInitWindowSize(400,400);
glutInitDisplayMode( GLUT_DEPTH + GLUT_DOUBLE + GLUT_RGB );
glClearDepth(1.0);
glClear( GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT );
glDepthMask(GL_TRUE);
glutCreateWindow('MFOGLP');
glEnable(GL_DEPTH_TEST);
glEnable(GL_NORMALIZE);
glShadeModel( GL_SMOOTH );
glClearColor(0.9, 0.7, 0.8, 0.0);
glMatrixMode(GL_PROJECTION);
glLoadIdentity();
glFrustum( -0.7, 0.7, -0.7, 0.7, 0.5, 15.0 );
glMatrixMode(GL_MODELVIEW);
r := 0;
end;

procedure gr(c :char;x,y:integer);cdecl;
begin
     if(c>'9')or(c<'1')then exit;
     inp := ord(c)-48;
     if not(ccw(m,tn(inp))) then glutDisplayFunc(@drawn) else begin
     m := wp(m,tn(inp),1);
     if ps(m)=0 then
     m := wp(m,tn(tfw(m,6)),6);
     end;
end;

procedure pd; cdecl;
var k,j : GLuint;
    r,g,b : glfloat;
begin
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
  glRotatef(1,0,0,1);
  glCallList(base);
  glColor3f(0.7,1,0);
  glTranslatef(0,0.65*2,0);
  for j := 3 downto 1 do
  begin
  glTranslatef(0,-0.65,0);
  begin
  glTranslatef(-0.7*2,0,0);
  for k := 1 to 3 do
  begin
  glTranslatef(0.7,0,0);
  glColor3f(0.69,0.69,0.69);
  glCallList(top);
  glColor3f(0.5,0.5,0.5);
  glCallList(box);
  end;
  glTranslatef(-0.7,0,0);
  end;
  end;
  glTranslatef(0,0.65,0);
  glFlush;
  glutSwapBuffers;
end;

procedure pre(c :char;x,y:integer);cdecl;
begin
     glLoadIdentity();
     glTranslatef( 0.0, 0.35, -1.75 );
     glRotatef(-20,1,0,0);
     glutDisplayFunc(@draw);
     glutKeyboardFunc(@gr);
end;

begin
     init;
     glutTimerFunc(20,@Timer,0);
     glTranslatef( 0.0, 0.35, -1.75 );
     glRotatef(-20,1,0,0);
     BuildLists();
     glutDisplayFunc(@pd);
     glutKeyboardFunc(@pre);
     glutMainLoop;
end.
