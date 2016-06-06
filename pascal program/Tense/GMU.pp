UNIT GMU;

INTERFACE
USES GRAPH,WINCRT,WINMOUSE;
TYPE List227 = ARRAY[1..227]OF INTEGER;

FUNCTION ClickIn(Press,NowX,NowY,TTX,TTY,TBX,TBY:INTEGER) : BOOLEAN;
PROCEDURE Rocket(x,y:INTEGER;S_Long:integer;OP_Type:INTEGER);
PROCEDURE FailRocket(rt,s,t,k,h:INTEGER);//rocket type, side long, TOp, botTOm, horizontal
FUNCTION MouseIn(NowX,NowY,TTX,TTY,TBX,TBY:INTEGER) : BOOLEAN; 
PROCEDURE Get227List(VAR array227 : List227);
FUNCTION CheckAns(G_Ans,C_Ans:STRING) : BOOLEAN;
FUNCTION GetName(Non : STRING[20]):STRING[20];
PROCEDURE ShowRank(dir: STRING);
PROCEDURE OpenGarph();
FUNCTION EntName(c : integer):STRING[20];
PROCEDURE start(dir: STRING);
PROCEDURE chooselv(var lv : integer;var ex:boolean);
PROCEDURE CheckRank(sc,lv:integer;dir:string);
PROCEDURE Tense();

IMPLEMENTATION

FUNCTION MouseIn(NowX,NowY,TTX,TTY,TBX,TBY:INTEGER) : BOOLEAN;
BEGIN
	RESULT := false;
	IF (NowX>Ttx)and(NowX<Tbx) THEN
		IF (NowY>Tty)and(NowY<Tby) THEN 
			RESULT := TRUE;
END;

FUNCTION ClickIn(Press,NowX,NowY,Ttx,Tty,Tbx,Tby:INTEGER) : BOOLEAN;
BEGIN
	RESULT := false;
	IF Press=1 THEN
		IF (NowX>Ttx)and(NowX<Tbx) THEN
			IF (NowY>Tty)and(NowY<Tby) THEN 
				RESULT := TRUE;
END;

PROCEDURE Rocket(x,y:INTEGER;S_Long:INTEGER;OP_Type:INTEGER);
VAR tmp:ARRAY[1..3] Of POINTTYPE;
    i  : INTEGER;
BEGIN
	IF OP_Type IN [3,6] THEN BEGIN setcolor(0);setfillstyle(1,0);END;
	tmp[1].x := x;
	tmp[1].y := y;
	tmp[2].x := tmp[1].x - S_Long div 2;
	tmp[2].y := tmp[1].y + S_Long;
	tmp[3].x := tmp[2].x + S_Long ;
	tmp[3].y := tmp[2].y ;
	fillpoly(3,tmp);
	bar(tmp[2].x,tmp[2].y,tmp[3].x,tmp[2].y + S_Long*3-1);
	bar(tmp[2].x,tmp[2].y,tmp[3].x,tmp[2].y + S_Long*2);
	IF NOT(OP_Type IN [4,5,6]) THEN
		BEGIN
			tmp[1].x := tmp[2].x;
			tmp[1].y := tmp[2].y + S_Long*2;
			tmp[2].x := tmp[1].x - (S_Long div 2 - (6*S_Long div 28));
			tmp[2].y := tmp[1].y + S_Long;
			tmp[3].x := tmp[2].x + S_Long ;
			tmp[3].y := tmp[2].y ;
			fillpoly(3,tmp);
			tmp[1].x := tmp[1].x + S_Long;
			tmp[2].x := tmp[1].x - S_Long div 2- (6*S_Long div 28);
			tmp[2].y := tmp[1].y + S_Long;
			tmp[3].x := tmp[2].x + S_Long ;
			tmp[3].y := tmp[2].y ;
			fillpoly(3,tmp);
			tmp[2].x := tmp[2].x - 3*S_Long div 5 ;
			tmp[2].y := tmp[2].y +2;
			IF OP_Type = 2 THEN setcolor(0);
			FOR i := 1 TO 4 DO 
				BEGIN	
					tmp[1].x := tmp[2].x +2;
					tmp[1].y := tmp[2].y ;
					tmp[2].x := tmp[1].x + 2*S_Long div 5-2;
					tmp[2].y := tmp[1].y ;
					tmp[3].x := tmp[1].x + S_Long div 5;
					tmp[3].y := tmp[1].y + 2*S_Long div 5;
					fillpoly(3,tmp);		
				END;
		END	
	ELSE IF OP_Type IN [4,5,6] THEN 
		BEGIN
			tmp[1].x := tmp[2].x          ;
			tmp[1].y := tmp[2].y +2*S_Long;
			tmp[2].x := tmp[1].x          ;
			tmp[2].y := tmp[1].y +  S_Long;
			tmp[3].x := tmp[1].x -  S_Long;
			tmp[3].y := tmp[2].y +2*S_Long;
			fillpoly(3,tmp)               ;
			tmp[1].x := tmp[1].x +  S_Long;
			tmp[1].y := tmp[1].y          ;
			tmp[2].x := tmp[2].x +  S_Long;
			tmp[2].y := tmp[2].y          ;
			tmp[3].x := tmp[3].x +3*S_Long;
			tmp[3].y := tmp[3].y          ;
			fillpoly(3,tmp)  			  ;
			IF OP_Type = 5THEN setcolor(0);
			tmp[1].x := tmp[1].x -  S_Long;
			tmp[1].y := tmp[1].y +2*S_Long;
			tmp[2].x := tmp[2].x          ;
			tmp[2].y := tmp[2].y +  S_Long;
			tmp[3].x := tmp[2].x - S_long div 2;
			tmp[3].y := tmp[3].y+2*S_Long div 3;
			fillpoly(3,tmp)				  ;
 		END;	
END;

PROCEDURE FailRocket(rt,s,t,k,h:INTEGER);
VAR hz,j : INTEGER;
BEGIN
	hz := 10;
	rt := rt*rt;
	FOR j := k DIV hz DOwnTO t DIV hz DO BEGIN
		setcolor(4);
		setfillstyle(1,4);
		Rocket(h,j*hz,s,rt+0);
		delay(70);
		Rocket(h,j*hz,s,rt+2);
	END;
	j := t;
	REPEAT
		setcolor(4);
		setfillstyle(1,4);
		Rocket(h,t,s,rt+0);
		delay(250);
		Rocket(h,t,s,rt+2);
		inc(t,3);
		setcolor(4);
		setfillstyle(1,4);
		Rocket(h,t,s,rt+1);
		delay(250);
		Rocket(h,t,s,rt+2);
	UNTIL t = j+9;
	FOR t := (j+9) DIV hz +1 TO k DIV hz DO BEGIN
		setcolor(4);
		setfillstyle(1,4);
		Rocket(h,t*hz,s,rt+1);
		delay(70);
		Rocket(h,t*hz,s,rt+2);
	END;
END;

PROCEDURE Get227List(VAR array227 : List227);
VAR i, j : INTEGER;
	go   : BOOLEAN;
BEGIN
	ranDOmize;
	array227[1] := ranDOm(227)+1;
    FOR i := 2 TO 227 DO BEGIN
        REPEAT
              go := true;
              array227[i] := ranDOm(227)+1;
              j := 0;
              REPEAT
                 j := j + 1;
                 IF array227[j] = array227[i] THEN go := false;
              UNTIL (NOT(go))OR(j=i-1);
        UNTIL go;
    END;
END;

FUNCTION CheckAns(G_Ans,C_Ans:STRING) : BOOLEAN;
BEGIN
	result := (G_Ans=C_Ans);
END;

FUNCTION GetName(Non : STRING[20]):STRING[20];
VAR i : INTEGER;
BEGIN	
	FOR i := 1 TO 20 DO
		result[i] := chr(ord(Non[i])*2+3);
END;

PROCEDURE ShowRank(dir : string);
VAR
	t : TEXT;
	i,j : INTEGER;
	s : ARRAY[1..10]OF STRING[20];
	st: STRING[20];
	x,y,click : INTEGER;
	b : BOOLEAN;
Begin
	ClearDevice;
	assign(t, dir + '\rank.dat');
	reset(t);
	FOR i := 1 TO 10 DO
		readln(t, s[i]);
	close(t);
    FOR i := 1 TO 10 DO
        BEGIN
             st := '';
             FOR j := 1 TO 20 DO
                 st := st + chr((ord(s[i][j])-3)div 2);
             s[i] := st;
        END;
	settextjustIFy(CenterText,CenterText);
	setTextStyle(1,0,4);
	setcolor(52);
	outtextxy(320,40,'RANK');
    setTextStyle(1,0,3);
    FOR i := 1 TO 10 DO
	outtextxy(320,i*36+45,s[i]);
    outtextxy(75,450,chr(27)+'BACK');
    b := false;
    REPEAT
    getmousestate(x,y,click);
    IF mouseIn(x,y,12,435,133,460) THEN setcolor(44) ELSE setcolor(52);
    IF mouseIn(x,y,12,435,133,460)<>b THEN outtextxy(75,450,chr(27)+'BACK');
    b := mouseIn(x,y,12,435,133,460);
    UNTIL (click=1)AND(b);
END;

PROCEDURE OpenGarph();
VAR	gd,gm : smallint;
BEGIN
    gd :=    d8bit;
	gm := m640x480;
	InitGraph(gd, gm,' ');
	ClearDevice;
END;

function EntName(c: integer):string[20];
var inp : char;
    st : string[15];
    i,j : integer;
	scr : string[3];
begin
    ClearDevice;
	settextjustify(CenterText,CenterText);
	setcolor(31);
    setTextStyle(1,0,3);
    outtextxy(320,140,'Enter Your name:');
	str(c,scr);
	st := 'Your score: '+scr;
    outtextxy(320,260,st);
	st :='';
     repeat
                setfillStyle(1,0);
                bar(140,185,500,215);
                j := 0;
                for i := length(st)+1 to 15 do
                    begin
                         inc(j);
                         st := st + chr(177);
                    end;
                outtextxy(320,200,st);
                st := copy(st,1,15-j);
				inp := readkey;
                if inp = #0 then inp := readkey
                else if (inp <> #13)and(inp <> #8) then st := st + inp;
                if inp = #8 then st := copy(st,1,length(st)-1); 
	 until inp = #13;
	 for i := 1 to 20-length(st) do
		st := st + '.';
	 if c < 99 then scr := '0' + scr;
	 if c < 9 then scr := '0' + scr;
	 result := st+'..'+scr;
end;

PROCEDURE chooselv(var lv : integer;var ex:boolean);
var wr : string;
    l,r,e : boolean;
    x,y,click:INTEGER;
    tmp:ARRAY[1..2,1..3] Of POINTTYPE;
begin
     ClearDevice;
     lv := 5;
     settextjustify(CenterText,CenterText);
     setTextStyle(1,0,3);
	 setcolor(52);
     outtextxy(320,140,'Choose LV:');
     setTextStyle(1,0,2);
     outtextxy(315,160,'(Easy<-LV->Hard)');
     setTextStyle(1,0,3);
     tmp[1,1].x := 253;
     tmp[1,1].y := 215;
	 tmp[1,2].x := 280;
	 tmp[1,2].y := 200;
	 tmp[1,3].x := 280;
	 tmp[1,3].y := 227;
     fillpoly(3,tmp);
     tmp[1,1].x := 374;
     tmp[1,1].y := 215;
	 tmp[1,2].x := 347;
	 tmp[1,2].y := 200;
	 tmp[1,3].x := 347;
	 tmp[1,3].y := 227;
     fillpoly(3,tmp);
     setfillstyle(1,50);
     str(lv,wr);
     bar(287,200,340,227);
     setcolor(31);
     if lv > 5 then setcolor(42);
     outtextxy(315,215,wr);
     outtextxy(316,300,'START');
     outtextxy(75,450,chr(27)+'BACK');
     e := false;ex := false;l := false;r:= false;
	 repeat
     delay(70);
     getmousestate(x,y,click);
     tmp[1,1].x := 253;
     tmp[1,1].y := 215;
	 tmp[1,2].x := 280;
	 tmp[1,2].y := 200;
	 tmp[1,3].x := 280;
	 tmp[1,3].y := 227;
     if mouseIn(x,y,253,200,280,227) then setcolor(44) else setcolor(52);
     if mouseIn(x,y,253,200,280,227)<>l then fillpoly(3,tmp);
     l := mouseIn(x,y,253,200,280,227);
     if clickin(click,x,y,253,200,280,227) then if lv > 1 then dec(lv);
     tmp[1,1].x := 374;
     tmp[1,1].y := 215;
	 tmp[1,2].x := 347;
	 tmp[1,2].y := 200;
	 tmp[1,3].x := 347;
	 tmp[1,3].y := 227;
     if mouseIn(x,y,347,200,374,227) then setcolor(44) else setcolor(52);
     if mouseIn(x,y,347,200,374,227)<>r then fillpoly(3,tmp);
     r := mouseIn(x,y,347,200,374,227);
     if clickin(click,x,y,347,200,374,227) then if lv < 10 then inc(lv);
     if click = 1 then begin
     setfillstyle(1,50);
     str(lv,wr);
     bar(287,200,340,227);
     setcolor(31);
     if lv > 5 then setcolor(42);
     outtextxy(315,215,wr);
     end;
     if mouseIn(x,y,255,288,370,309) then setcolor(52) else setcolor(31);
     if mouseIn(x,y,255,288,370,309)<> e then outtextxy(316,300,'START');;
     e := mouseIn(x,y,255,288,370,309);
	 IF mouseIn(x,y,12,435,133,460) THEN setcolor(44) ELSE setcolor(52);
     IF mouseIn(x,y,12,435,133,460)<>ex THEN outtextxy(75,450,chr(27)+'BACK');
     ex := mouseIn(x,y,12,435,133,460);
     until (click=1)and((e)or(ex));
end;	
	
PROCEDURE CheckRank(sc,lv:integer;dir:string);
VAR
	t : TEXT;
	i,j : INTEGER;
	s : ARRAY[1..10]OF STRING[20];
	st: STRING[20];
	ts : integer;
Begin
	assign(t, dir + '\rank.dat');
	reset(t);
    sc := sc div (11-lv);
	FOR i := 1 TO 10 DO
		readln(t, s[i]);
    FOR i := 1 TO 10 DO
        BEGIN
             st := '';
             FOR j := 1 TO 20 DO
                 st := st + chr((ord(s[i][j])-3)div 2);
             s[i] := st;
        END;
	for i := 1 to 10 do
	begin
		val(s[i][18]+s[i][19]+s[i][20],ts,ts);
		if sc > ts then 
			begin				
				close(t);
				j := i;
				while i <> 10 do
					begin 
						s[i+1] := s[i];
						inc(i);
					end;
				s[j]:=entname(sc); 	
				rewrite(t);
				for j := 1 to 10 do 
					writeln(t,getname(s[j]));
				break;
			end;
	end;
	close(t);
end;
	
PROCEDURE start(dir : string);
type alltenes = array[1..227] of array[1..4] of string[15];
var i,j : integer;
    t : text;
    st : string[15];
    s : string[19];
    te : alltenes;
    a : list227;
    l : 0..3;
    tene : 1..4;
    inp : char;
    time : integer;
	lv : integer;
	ex : boolean;
begin
	chooselv(lv,ex);
	if ex then exit;
	ClearDevice;
    assign(t, dir + '\bvt.txt');
    reset(t);
    for i := 1 to 227 do
        for j := 1 to 4 do
			readln(t,te[i][j]);
    close(t);
    Get227List(a);
    i := 0;
    l := 11 - lv;
    setcolor(31);
    SetLineStyle(3,0,3);
	Rectangle(2,2,200,100);
    Rectangle(200,2,638,100);
    Rectangle(558,100,638,180);
	Rectangle(200,100,558,130);
    line(200,50,638,50);
    setTextStyle(1,0,2);
    Rectangle(2,100,200,130);
    setcolor(4);
    for j := 1 to l do
    outtextxy(j*200div (l+1),115,chr(3));
    while keypressed do
	begin
    inp := readkey;
	st := inp;
	end; 
	repeat
          tene := random(3)+2;
          setcolor(31);
		  setfillstyle(1,0);
		  bar(205,105,553,125);
		  str(i,st);
          str(i-(11-lv)+l,s);
          st := s +' / '+st;
          outtextxy(379,115,st);
          inc(i);
          write(te[a[i]][1]:27);
          bar(6,6,196,95);
          bar(205,6,634,45);
          bar(205,55,634,95);
          case tene of
               2 : begin outtextxy(100,35,'Simple');outtextxy(100,65,'Past')end;
               3 : begin outtextxy(100,35,'Present');outtextxy(100,65,'Perfect')end;
               4 : begin outtextxy(100,35,'Present');outtextxy(100,65,'Progressive')end;
          end;
		  outtextxy(410,25,te[a[i]][1]);
		  st := '';
          SetLineStyle(0,0,3);
          time := 1440;
		  repeat
                delay(50);
                inp := '@';
                if keypressed then begin
                inp := readkey;
                if inp = #0 then inp := readkey
                else if (inp <> #13)and(inp <> #8) then st := st + inp;
                if inp = #8 then st := copy(st,1,length(st)-1);
                bar(203,53,635,97);
                outtextxy(410,75,st);
                end;
                dec(time,5);
                setcolor(31);
                PieSlice(598,140,0,time div 4,25);
          until (inp = #13)or(time<=0);
          st := lowercase(st);
          case tene of
               2 : s := '    Simple Past    ';
               3 : s := '  Present Perfect  ';
               4 : s := 'Present Progressive';
          end;
          if not(st = 'pass') then
          if not(checkans(st,te[a[i]][tene])) then
             begin outtextxy(l*200div (j+1),115,'X');dec(l);end;
          writeln(' -[',s,']=> ',te[a[i]][tene]);
    until (l=0) or (i = 227);
    i := i-(11-lv)+l;
    CheckRank(i,lv,dir);
end;

PROCEDURE Tense();
VAR x,y,click:INTEGER;
    s,e,r : boolean;
    dir : string;
    shit : byte;
BEGIN 
    opengarph;
    shit := 0;
    getdir(shit,dir);
	settextjustify(CenterText,CenterText);
    repeat
    ClearDevice;
	setTextStyle(1,0,3);
	setcolor(52);
	outtextxy(320,140,'Tense Test');
    setTextStyle(1,0,2);
    outtextxy(320,200,'START');
    outtextxy(320,230,'RANK');
	outtextxy(320,260,'EXIT');
    s := false;r:= false;e:= false;
    REPEAT
          getmousestate(x,y,click);
          if mouseIn(x,y,278,190,357,207) then setcolor(44) else setcolor(52);
          if mouseIn(x,y,278,190,357,207)<>s then outtextxy(320,200,'START');
          s := mouseIn(x,y,278,190,357,207);
		  if mouseIn(x,y,286,220,350,236) then setcolor(44) else setcolor(52);
          if mouseIn(x,y,286,220,350,236)<> r then outtextxy(320,230,'RANK');
          r := mouseIn(x,y,286,220,350,236);
          if mouseIn(x,y,286,250,349,268) then setcolor(44) else setcolor(52);
          if mouseIn(x,y,286,250,349,268)<> e then outtextxy(320,260,'EXIT');
          e := mouseIn(x,y,286,250,349,268);
    until (click=1)and((s)or(e)or(r));
    if r then showrank(dir);
    if s then start(dir);
    until e;
END;
		
END.				
