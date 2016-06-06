program Untitled;
{
   Name: Tetris
   Author: Alex Fuk
   Date: From 10/01/12 to 18/02/12
}
{$M MaxStackSize,MinHeapSize,MaxHeapSize}
uses graph,wincrt,dos;

const
    ltx =       80;
    lty =       80;
    bl  =       16;
var                                                                                      
   map   : array[-1..12, -1..22] of char;
   i,j   : shortint;
   cx3   : shortint;
   cy3   : shortint;
   inp   : char    ;
   lncd  : integer ;
   lose  : boolean ;
   nowlv : shortint;
   pass  : boolean ;
   move  : boolean ;
   next  : shortint;
   space : boolean ;
   gd,gm : smallint;
   scnt  : shortint;
   ltime : shortint;
   OPCU  : boolean ;
   nocho : shortint;
   yquit : boolean ;

//Short Name |         Full name                    |         Class And Mark             
//  MNC    -----     Make New Cube                -----            BP1                   
//  IOM    -----     Input Of Movement            -----            BP2                   
//  RTT    -----     Request To Turn              -----            BP3                   
//  FBT    -----     Fall By Time                 -----            BP4                   
//  RTM    -----     Request To Move              -----            BP5                   
//  CAR    -----     Clean A Rol                  -----            BP6                   
//  RBL    -----     Repeadtimes By Lv            -----            BP7                   
//  LBL    -----     Loop By Level                -----            BP8                   
//  ITV    -----     Initialize The Var           -----            BP9                   
//  SL     -----     Supre Loop                   -----            AP1                   
//  HL     -----     Hyper Loop                   -----            AP2                   
//  KILL   -----     KILL                         -----            FIN
                                                                                         
//Other Part ///////////////////////////////////////////////////////OP////////////Other Part
procedure CheckLastMove;                                            //
var i, j : shortint;                                                //
    k    : shortint;                                                //
    docnt: shortint;                                                //
    NL   : shortint;                                                //
begin                                                               //
     nl := 20;                                                      //
     for j := 1 to 20 do for i := 1 to 10 do                        //
         if (map[i,j] > 'A') and ('a' > map[i,j]) then              //
           if map[i,j+1] <> map[i,j]then                            //
           begin                                                    //
                docnt := 0;                                         //
                k := j;                                             //
                repeat                                              //
                      inc(docnt);                                   //
                      inc(k);                                       //
                until map[i,k+1] <> ' ';                            //
                      if docnt < nl then                            //
                        nl := docnt;                                //
           end;                                                     //
     ltime := nl                                                    //
end;                                                                //
                                                                    //
procedure Show;                                                     ////
var go : boolean;                                                   ////
    i, j, k : shortint;                                             ////
begin                                                               ////
     go := true;                                                    ////
     for j := cy3-2 to cy3+3 do for i := 1 to 10 do                 ////
         if map[i,j] = map[cx3,cy3] then                            ////
            if map[i,j+ltime] <> ' ' then go :=false;               ////
     if go then                                                     ////
     for j := cy3-2 to cy3+3 do for i := 1 to 10 do                 ////
         if map[i,j] = map[cx3,cy3] then begin                      ////
            SetFillStyle(1,230);                                    ////
            k := j;                                                 ////
            k := k+ltime;                                           ////
            bar(i*bl-bl+2+ltx,k*bl-bl+2+lty,i*bl-2+ltx,k*bl-2+lty); ////
            end;                                                    ////
end;                                                                ////
                                                                    ////
//End of Other Part ///////////////////////////////////////////////O.P

//Garph Part ///////////////////////////////////////////////////////GP////////////Garph Part
procedure quit;                                                     //
var i, j : shortint;                                                //
begin                                                               //
     for j := 0 to 10 do                                            //
         begin                                                      //
         for i := 0 to 9 do                                         //
             begin                                                  //
             SetFillStyle(1,30);                                    //
             bar(ltx+i*bl*2-bl,lty+j*bl*2-bl,                       //
                 ltx+i*bl*2+bl,lty+j*bl*2+bl);                      //
             delay(50);                                             //
             SetFillStyle(1,0);                                     //
             bar(ltx+i*bl*2-bl,lty+j*bl*2-bl,                       //
                 ltx+i*bl*2+bl,lty+j*bl*2+bl);                      //
             end;                                                   //
         if j > 3 then begin                                        //
            setcolor(10+j*2);                                       //
            setTextStyle(1,0,3);                                    //
            OutTextXY(245,200,'TETRIS');end;                        //
         if j > 4 then begin                                        //
            setcolor(10+j*2);                                       //
            setTextStyle(1,0,2);                                    //
            OutTextXY(220+bl div 2,230,'By Alex Fuk');end;          //
         end;                                                       //
     setTextStyle(1,0,2);                                           //
     setcolor(18);                                                  //
     OutTextXY(ltx-bl*3-9,255,'Press W to go up');                  //
     OutTextXY(ltx-bl*3-9,270,                                      //
               'Press S to activate ghost model');                  //
     OutTextXY(ltx-bl*3-9,285,                                      //
               'Press * to freeze/unfreeze');                       //
     OutTextXY(ltx-bl*3-9,300,                                      //
               'Press + to add a line cleaned record');             //
     OutTextXY(ltx-bl*3-9,315,                                      //
               'Press - to minus a line cleaned record');           //
     setcolor(31);                                                  //
     OutTextXY(140+bl div 2,345,'Press Any Key To Exit');           //
     readkey;                                                       //
     yquit := true;                                                 //
end;                                                                //
                                                                    //
procedure youlose;                                                  //
var x, y : shortint;                                                //
      ch : char;                                                    //
begin                                                               //
     setcolor(30);                                                  //
     setTextStyle(1,0,3);                                           //
     SetFillStyle(1,0);                                             //
     for y := 20 downto 1 do                                        //
     if y mod 2 = 0 then                                            //
     for x := 1 to 10 do                                            //
     begin bar(x*bl-bl+2+ltx,y*bl-bl+2+lty,x*bl-2+ltx,y*bl-2+lty);  //
     delay(10);end                                                  //
     else                                                           //
     for x := 10 downto 1 do                                        //
     begin bar(x*bl-bl+2+ltx,y*bl-bl+2+lty,x*bl-2+ltx,y*bl-2+lty);  //
     delay(10);end;                                                 //
     OutTextXY(ltx-bl+2,lty+bl*9+6,'YOU LOSE');                     //
     setTextStyle(1,0,2);                                           //
     setcolor(30);                                                  //
     OutTextXY(ltx+bl*12+2,lty+bl*16-bl div 2+9,'Press');           //
     OutTextXY(ltx+bl*12+2,lty+bl*17-bl div 2+9,'Enter');           //
     OutTextXY(ltx+bl*12+2,lty+bl*18-bl div 2+9,'To');              //
     OutTextXY(ltx+bl*12+2,lty+bl*19-bl div 2+9,'Restart');         //
     repeat ch := readkey;                                          //
            if ch = #0 then ch := readkey; until ch = #13;          //
     bar(ltx+bl*12,lty+bl*13,ltx+bl*19,lty+bl*20);                  //
end;                                                                //
                                                                    //
procedure welcome;                                                  //
begin                                                               //
     i := -15;                                                      //
     repeat                                                         //
         SetFillStyle(1,25);                                        //
         bar( 315,i*3,325,i*3 + 30);                                //
         bar( 315,i*3-6,340,i*3+3);                                 //
         delay(30);                                                 //
         SetFillStyle(1,0);                                         //
         bar( 315,i*3-7,340,i*3+30);                                //
         inc(i);                                                    //
     until (keypressed)or(i =73);                                   //
     SetFillStyle(1,25);                                            //
     bar( 315,219,325,249);                                         //
     bar( 315,219-6,340,219+3);                                     //
     setTextStyle(1,0,7);                                           //
     for i := 20 to 25 do                                           //
     begin                                                          //
     setcolor(i);                                                   //
     OutTextXY(96,200,' tet');                                      //
     OutTextXY(336,200,'is');                                       //
     delay(150);                                                    //
     end;                                                           //
     setTextStyle(1,0,2);                                           //
     OutTextXY(125,275,'Press any key to start');                   //
     readkey;                                                       //
     ClearDevice;                                                   //
end;                                                                //
                                                                    //
procedure choice;                                                   //
var pass : boolean;                                                 //
    inp  : char;                                                    //
begin                                                               //
     repeat                                                         //
     pass := false;                                                 //
     SetFillStyle(1,114);                                           //
     bar(ltx+bl*12,lty+bl*10+nocho*bl*2,                            //
         ltx+bl*18,lty+bl*12+nocho*bl*2);                           //
     setTextStyle(1,0,4);                                           //
     setcolor(25);                                                  //
     OutTextXY(ltx+bl-bl+2,lty+bl*8,'PAUSE');                       //
     setTextStyle(1,0,2);                                           //
     setcolor(25);                                                  //
     OutTextXY(ltx+bl*12+2,lty+bl*15-bl div 2+2,'RESUME');          //
     OutTextXY(ltx+bl*12+2,lty+bl*17-bl div 2+2,'R');               //
     OutTextXY(ltx+bl*13+1,lty+bl*17-bl div 2+2,'E');               //
     OutTextXY(ltx+bl*14,lty+bl*17-bl div 2+2,'S');                 //
     OutTextXY(ltx+bl*15-4,lty+bl*17-bl div 2+2,'T');               //
     OutTextXY(ltx+bl*16-9,lty+bl*17-bl div 2+2,'AR');              //
     OutTextXY(ltx+bl*18-11,lty+bl*17-bl div 2+2,'T');              //
     OutTextXY(ltx+bl*13+2,lty+bl*19-bl div 2+2,'Q');               //
     OutTextXY(ltx+bl*14+4,lty+bl*19-bl div 2+2,'UI');              //
     OutTextXY(ltx+bl*16+1,lty+bl*19-bl div 2+2,'T');               //
     inp := readkey;                                                //
     if inp = #0 then                                               //
        inp := readkey;                                             //
     case inp of                                                    //
          #72 : if nocho-1 > 1 then dec(nocho);                     //
          #80 : if nocho+1 < 5 then inc(nocho);                     //
     end;                                                           //
        if (inp=#72)or(inp=#80) then                                //
            begin                                                   //
                 SetFillStyle(1,0);                                 //
                 bar(ltx+bl*12,lty+bl*13,ltx+bl*18,lty+bl*20);      //
                 SetFillStyle(1,114);                               //
                 bar(ltx+bl*12,lty+bl*10+nocho*bl*2,                //
                     ltx+bl*18,lty+bl*12+nocho*bl*2);               //
            end;                                                    //
        if inp=#13 then                                             //
          case nocho of                                             //
              3: begin                                              //
                      lose := true; pass := true;                   //
                      SetFillStyle(1,0);                            //
                      bar(ltx+bl*12,lty+bl*13,ltx+bl*18,lty+bl*20); //
                      pass := true;                                 //
                 end;                                               //
              4: begin quit;yquit := true;exit;end;                 //
              2: begin                                              //
                      SetFillStyle(1,0);                            //
                      bar(ltx+bl*12,lty+bl*13,ltx+bl*18,lty+bl*20); //
                      pass := true;                                 //
                 end;                                               //
          end;                                                      //
     if inp ='p' then                                               //
        begin                                                       //
             SetFillStyle(1,0);                                     //
             bar(ltx+bl*12,lty+bl*13,ltx+bl*18,lty+bl*20);          //
             pass := true;                                          //
        end;                                                        //
     until pass ;                                                   //
     SetFillStyle(1,19);                                            //
     bar(ltx-bl,lty-bl,ltx+bl*11,lty+bl*21);                        //
end;                                                                //
                                                                    //
procedure OpenGraph;                                                //
begin                                                               //
     gd :=    d8bit;                                                //
     gm := m640x480;                                                //
     InitGraph(gd, gm,' ');                                         //
     welcome;                                                       //
end;                                                                //
                                                                    //
procedure pbox(x,y:integer);                                        //
var c : shortint;                                                   //
begin                                                               //
    case lowercase(map[x,y]) of                                     //
        'i' : c := 1;                                               //
        's' : c := 44;                                              //
        'z' : c := 52;                                              //
        'o' : c := 4;                                               //
        'l' : c := 5;                                               //
        'j' : c := 59;                                              //
        't' : c := 86;                                              //
        else  c := 0;                                               //
    end;                                                            //
    SetFillStyle(1,25);                                             //
    if map[x,y] <> ' ' then                                         //
    SetFillStyle(1,c);                                              //
    bar(x*bl-bl+2+ltx,y*bl-bl+2+lty,x*bl-2+ltx,y*bl-2+lty);         //
end;                                                                //
//End of Garph Part////////////////////////////////////////////////G.P

//Main Part ///////////////////////////////////////////////////////////////////////Main Part
//procedure of Make New Cube //////////////////////////////////////BP1///////////////////MNC
procedure MNC;                                                      //                    //
var                                                                 //                    //
   l     :     array[1..2] of string ;                              //                    //
   lt    :                  string[4];                              //                    //
   tmap  :   array[1..4,1..2] of char;                              //                    //
   now,i,j,c:                shortint ;                             //                    //
                                                                    //                    //
procedure Comp;                                                     //                    //
var                                                                 //                    //
   i,j   :                    shortint;                             //                    //
begin                                                               //                    //
     for i := 1 to 2 do                                             //                    //
         for j := 1 to 4 do                                         //                    //
            begin                                                   //                    //
                 lt := l[3-i];                                      //                    //
                 map[j+3,i] := lt[j];                               //                    //
            end;                                                    //                    //
end;                                                                //                    //
                                                                    //                    //
procedure Mo;                                                       //                    //
begin                                                               //                    //
   l[2] := ' OO ';                                                  //                    //
   l[1] := ' OO ';                                                  //                    //
end;                                                                //                    //
                                                                    //                    //
procedure Mi;                                                       //                    //
begin                                                               //                    //
   l[2] := 'IIII';                                                  //                    //
   l[1] := '    ';                                                  //                    //
end;                                                                //                    //
                                                                    //                    //
procedure Ms;                                                       //                    //
begin                                                               //                    //
   l[2] := '  SS';                                                  //                    //
   l[1] := ' SS ';                                                  //                    //
end;                                                                //                    //
                                                                    //                    //
procedure Mz;                                                       //                    //
begin                                                               //                    //
   l[2] := ' ZZ ';                                                  //                    //
   l[1] := '  ZZ';                                                  //                    //
end;                                                                //                    //
                                                                    //                    //
procedure Ml;                                                       //                    //
begin                                                               //                    //
   l[2] := ' LLL';                                                  //                    //
   l[1] := ' L  ';                                                  //                    //
end;                                                                //                    //
                                                                    //                    //
procedure Mj;                                                       //                    //
begin                                                               //                    //
   l[2] := ' JJJ';                                                  //                    //
   l[1] := '   J';                                                  //                    //
end;                                                                //                    //
                                                                    //                    //
procedure Mt;                                                       //                    //
begin                                                               //                    //
   l[2] := ' TTT';                                                  //                    //
   l[1] := '  T ';                                                  //                    //
end;                                                                //                    //
                                                                    //                    //
begin                                                               //                    //
     if inp <> 'i' then begin                                       //                    //
     now := next;                                                   //                    //
     for i := 1 to 4 do for j := 1 to 2 do                          //                    //
         tmap[i,j] := map[i+3,j];                                   //                    //
     next := round(random(7)+1);                                    //                    //
     case now of                                                    //                    //
         1 : Mo;                                                    //                    //
         2 : Mi;                                                    //                    //
         3 : Ms;                                                    //                    //
         4 : Mz;                                                    //                    //
         5 : Ml;                                                    //                    //
         6 : Mj;                                                    //                    //
         7 : Mt;                                                    //                    //
     end;                                                           //                    //
     comp;                                                          //                    //
     for i := 1 to 4 do for j := 1 to 2 do                          //                    //
         if (map[i+3,j] > 'A')and                                   //                    //
            ('a' > map[i+3,j])and                                   //                    //
            (tmap[i,j] <> ' ') then                                 //                    //
            lose := true;                                           //                    //                    
     cx3 := 6;cy3 :=1;                                              //                    //
     end;                                                           //
     case next of                                                   ////                  ////                    
         1 : Mo;                                                    ////                  ////                    
         2 : Mi;                                                    ////                  ////                    
         3 : Ms;                                                    ////                  ////                    
         4 : Mz;                                                    ////                  ////                    
         5 : Ml;                                                    ////                  ////                    
         6 : Mj;                                                    ////                  ////                    
         7 : Mt;                                                    ////                  ////                    
     end;                                                           ////                  ////                    
     case next of                                                   ////                  ////                    
        2 : c := 1;                                                 ////                  ////                    
        3 : c := 44;                                                ////                  ////
        4 : c := 52;                                                ////                  ////
        1 : c := 4;                                                 ////                  ////
        5 : c := 5;                                                 ////                  ////
        6 : c := 59;                                                ////                  ////
        7 : c := 86;                                                ////                  ////
     else  c := 0;                                                  ////                  ////
     end;                                                           ////                  ////
     for j := 2 to 3 do                                             ////                  ////
     begin                                                          ////                  ////
          for i := 1 to 4 do                                        ////                  ////
          begin                                                     ////                  ////
          SetFillStyle(1, c);                                       ////                  ////
          if copy(l[2-j+2],i,1) = ' ' then                          ////                  ////
             SetFillStyle(1,25);                                    ////                  ////
          bar(i*bl+2+ltx+bl*12,j*bl-bl+2+lty,                       ////                  ////
              i*bl-2+ltx+bl*13,j*bl-2+lty);                         ////                  ////
          end;                                                      ////                  ////
     end;                                                           ////                  ////
end;                                                                //                    //
//end of Make New Cube //////////////////////////////////////////B.P.1                    //
                                                                                          //
//procedure of Request To Turn ////////////////////////////////////BP3///////////////////RTT
procedure RTT(x,y : shortint);                                      //                    //
var pos : array[1..5,1..5] of char;                                 //                    //
    mps : array[1..5,1..5] of char;                                 //                    //
    turn: boolean                 ;                                 //                    //
                                                                    //                    //
procedure MakePos;//--//--//--//--//--//--//--//--                  //                    //
procedure ClearPosShit;                         //                  //                    //
var i, j : shortint;                            //                  //                    //
begin                                           //                  //                    //
     for j := 1 to 5 do                         //                  //                    //
         for i := 1 to 5 do                     //                  //                    //
             begin                              //                  //                    //
               mps[i,j] := pos[i,j];            //                  //                    //
               if pos[i,j] <> pos[3,3] then     //                  //                    //
                  pos[i,j] := ' ';              //                  //                    //
             end;                               //                  //                    //
end;                                            //                  //                    //
                                                //                  //                    //
procedure FindingXYInPos;                       //                  //                    //
var i, j : shortint;                            //                  //                    //
begin                                           //                  //                    //
     for j := 1 to 5 do                         //                  //                    //
         for i := 1 to 5 do                     //                  //                    //
             pos[i,j]:= map[x-3+i,y-3+j];       //                  //                    //
end;                                            //                  //                    //
                                                //                  //                    //
begin                                           //                  //                    //
     FindingXYInPos;                            //                  //                    //
     ClearPosShit;                              //                  //                    //
end;//--//--//--//--//--//--//--//--//--//--//--//                  //                    //
                                                                    //                    //
procedure CoordinatesWilling;                                       //                    //
var a   : array[1..5,1..5] of char ;                                //                    //
    i,j : shortint;                                                 //                    //
begin                                                               //                    //
     a := pos;                                                      //                    //
     for i:=1 to 5 do                                               //                    //
     for j:=1 to 5 do                                               //                    //
     pos[i,j]:=a[6-j,i];                                            //                    //
end;                                                                //                    //
                                                                    //                    //
procedure TestIfTurn;                                               //                    //
var i, j : shortint;                                                //                    //
begin                                                               //                    //
     turn := true;                                                  //                    //
     for i := 5 downto 1 do                                         //                    //
         begin                                                      //                    //
              for j := 5 downto 1 do                                //                    //
                  if pos[j,i] <> ' ' then                           //                    //
                     if map[3-j+cx3,3-i+cy3] <> ' 'then             //                    //
                        if map[3-j+cx3,3-i+cy3]<> pos[3,3]then      //                    //
                           turn := false;                           //                    //
         end;                                                       //                    //
end;                                                                //                    //
                                                                    //                    //
procedure TryToTurn;                                                //                    //
var i, j : shortint;                                                //                    //
begin                                                               //                    //
     if turn then                                                   //                    //
        for j := 1 to 5 do                                          //                    //
            for i := 1 to 5 do                                      //                    //
                if pos[i,j] <> ' ' then                             //                    //
                   map[x+3-i,y+3-j] := pos[i,j];                    //                    //
end;                                                                //                    //
                                                                    //                    //
procedure CleanMapShit;                                             //                    //
begin                                                               //                    //
     if turn then begin                                             //                    //
     for j := 1 to 5 do                                             //                    //
         for i := 1 to 5 do                                         //                    //
             if mps[i,j] <> ' ' then                                //                    //
                if (mps[i,j]>'A')and('a'>mps[i,j]) then             //                    //
                   map[i+x-3,j+y-3] := ' ';                         //                    //
     end;                                                           //                    //
end;                                                                //                    //
                                                                    //                    //
begin                                                               //                    //
     if map[x,y] < 'a' then                                         //                    //
     begin                                                          //                    //
        MakePos;                                                    //                    //
        CoordinatesWilling;                                         //                    //
        TestIfTurn;                                                 //                    //
        CleanMapShit;                                               //                    //
        TryToTurn;                                                  //                    //
     end;                                                           //                    //
end;                                                                //                    //
//end of Request To Turn ////////////////////////////////////////B.P.3                    //
                                                                                          //
//procedure of Fall By Time ///////////////////////////////////////BP4///////////////////FBT
procedure FBT;                                                      //                    //
var i, j : shortint;                                                //                    //
                                                                    //                    //
procedure CheckMove;                                                //                    //
var i, j : shortint;                                                //                    //
begin                                                               //                    //
     move := true ;                                                 //                    //
     for j := -1 to 20 do                                           //                    //
         for i := 1 to 10 do                                        //                    //
             if (map[i,j]>'A')and('a'>map[i,j])then                 //                    //
                if map[i,j+1]<>map[i,j] then                        //                    //
                   if map[i,j+1] <> ' ' then                        //                    //
                      move := false;                                //                    //
end;                                                                //                    //
                                                                    //                    //
procedure MapMove;                                                  //                    //
var i, j : shortint;                                                //                    //
begin                                                               //                    //
     for j := 20 downto -1 do                                       //                    //
         for i := 1 to 10 do                                        //                    //
             if (map[i,j-1]>'A')and('a'>map[i,j-1])then             //                    //
                begin map[i,j] := map[i,j-1];                       //                    //
                      map[i,j-1] := ' ';                            //                    //
                end;                                                //                    //
     inc(cy3);                                                      //                    //
end;                                                                //                    //
                                                                    //                    //
begin                                                               //                    //
     CheckMove;                                                     //                    //
     if move then                                                   //                    //
        MapMove                                                     //                    //
     else for i := 1 to 20 do for j := 1 to 10 do                   //                    //
              map[j,i]:=lowercase(map[j,i]);                        //                    //
end;                                                                //                    //
//end of Fall By Time ///////////////////////////////////////////B.P.4                    //
                                                                                          //
//procedure of Request To Move ////////////////////////////////////BP5///////////////////RTM
procedure RTM(inp : char);                                          //                    //
var lrm : boolean;                                                  //                    //
begin                                                               //                    //
     lrm := true;                                                   //                    //
     if inp = #0 then                                               //                    //
     inp := readkey;                                                //                    //
     case inp of                                                    //                    //
     #75 : begin for j := -1 to 20 do for i := 1 to 10 do           //                    //
              if (map[i,j]>'A')and('a'>map[i,j])then                //                    //
                if map[i-1,j] <> map[i,j] then                      //                    //
                if(map[i-1,j] <> ' ')or(map[i-1,j] = '|')then       //                    //
                    lrm := false;                                   //                    //
           if lrm then                                              //                    //
           for j := -1 to 20 do for i := 1 to 10 do                 //                    //
              if (map[i,j]>'A')and('a'>map[i,j])then                //                    //
                 begin                                              //                    //
                       map[i-1,j]:= map[i,j];                       //                    //
                       map[i,j]:=' ';                               //                    //
                 end;                                               //                    //
           if lrm then cx3 := cx3 - 1;                              //                    //
           end;                                                     //                    //
     #77 : begin for j := -1 to 20 do for i := 1 to 10 do           //                    //
              if (map[i,j]>'A')and('a'>map[i,j])then                //                    //
                if map[i+1,j] <> map[i,j] then                      //                    //
                if(map[i+1,j] <> ' ')or(map[i+1,j] = '|')then       //                    //
                    lrm := false;                                   //                    //
           if lrm then                                              //                    //
           for j := -1 to 20 do for i := 10 downto 1 do             //                    //
              if (map[i,j]>'A')and('a'>map[i,j])then                //                    //
                 begin                                              //                    //
                       map[i+1,j]:= map[i,j];                       //                    //
                       map[i,j]:=' ';                               //                    //
                 end;                                               //                    //
           if lrm then cx3 := cx3 + 1;                              //                    //
           end;                                                     //                    //
     #72 : RTT(cx3,cy3);                                            //                    //
     #80 : pass := true;                                            //                    //
     'p' : begin                                                    ////                  ////
                 SetFillStyle(1,19);                                ////                  ////
                 bar(ltx-bl,lty-bl,ltx+bl*11,lty+bl*21);            ////                  ////
                 choice;if yquit then exit;                         ////                  ////
           end;                                                     ////                  ////
     ' ' : if not space then                                        //                    //
           if scnt < 2  then                                        //                    //
           begin                                                    //                    //
                repeat fbt until not move;                          //                    //
                space := true;                                      //                    //
                inc(scnt);                                          //                    //
           end;                                                     //                    //
                                                                    //                    //
     end;                                                           //                    //
end;                                                                //                    //
//end of Request To Move ////////////////////////////////////////B.P.5                    //
                                                                                          //
//procedure of Clean A Rol ////////////////////////////////////////BP6///////////////////CAR
procedure CAR;                                                      //                    //
var i,j,k: shortint;                                                //                    //
    rol  : boolean;                                                 //                    //
    srt  : shortstring;                                             //                    //
begin                                                               //                    //
    for i := 1 to 20 do                                             //                    //
        begin                                                       //                    //
             rol := true;                                           //                    //
             for j := 1 to 10 do                                    //                    //
                 if map[j,i] = ' ' then rol := false;               //                    //
             if rol then                                            //                    //
                 for j := i downto 1 do                             //                    //
                     for k := 1 to 10 do                            //                    //
                         begin                                      //                    //
                              map[k,j] := map[k,j-1];               //                    //
                              map[k,0] := ' ';                      //                    //
                         end;                                       //                    //
             if rol then inc(lncd);                                 //                    //
        end;                                                        //                    //
    str(nowlv,srt);                                                 ////                  ////
    SetFillStyle(1,0);                                              ////                  ////
    bar(ltx+bl*12,lty+bl*6,ltx+bl*18,lty+bl*13);                    ////                  ////
    setTextStyle(1,0,2);                                            ////                  ////
    setcolor(62);                                                   ////                  ////
    OutTextXY(ltx+bl*12+1,lty+bl*6,'LEVEL');                        ////                  ////
    OutTextXY(ltx+bl*17+9,lty+bl*6,':');                            ////                  ////
    OutTextXY(317-length(srt)*bl div 2+8,lty+bl*8,srt);             ////                  ////
    str(lncd,srt);setcolor(79);                                     ////                  ////
    OutTextXY(ltx+bl*12+1,lty+bl*10,'LINES');                       ////                  ////
    OutTextXY(ltx+bl*17+9,lty+bl*10,':');                           ////                  ////
    OutTextXY(317-length(srt)*bl div 2+8,lty+bl*12,srt);            ////                  ////
end;                                                                //                    //
//end of Clean A Rol ////////////////////////////////////////////B.P.6                    //
                                                                                          //
//procedure of Repeadtimes By Lv //////////////////////////////////BP7///////////////////RBL
procedure RBL;                                                      //                    //
begin                                                               //                    //
     if lncd = 0 then nowlv := 1                                    //                    //
     else if lncd > 90 then nowlv := 10                             //                    //
     else nowlv := lncd div 10 + 1                                  //                    //
end;                                                                //                    //
//end of Repeadtimes By Lv //////////////////////////////////////B.P.7                    //
                                                                                          //
//procedure of Input Of Moving ////////////////////////////////////BP2///////////////////IOM
procedure IOM;                                                      //                    //
var i, j : shortint;                                                //                    //
begin                                                               //                    //
     inp := '@';                                                    //                    //
     if keypressed then begin                                       //                    //
        inp := readkey;                                             //                    //
     RTM(inp);                                                      //                    //
     if yquit then exit;                                            //                    //
     if inp = '+' then begin inc(lncd);car;end;                     //                    //
     if inp = '-' then begin dec(lncd);car;end;                     //                    //
     if inp = 'S' then if opcu then opcu := false else opcu := true;//                    //
     if inp = '*' then repeat until readkey = '*'  ;                //                    //
     if inp = 'I' then
                       begin
                       for j := 1 to 20 do for i := 1 to 10 do
                       if (map[i,j] < 'a')and('A' < map[i,j]) then
                       map[i,j] := ' ';
                       next := 2;
                       mnc;
                       inp := '@';
                       end;
     if inp = 'W' then if cy3 > 4 then begin                        //                    //
                       for j := 1 to 20 do for i := 1 to 10 do      //                    //
                       if (map[i,j] < 'a')and('A' < map[i,j]) then  //                    //
                       begin                                        //                    //
                            map[i,j-1] := map[i,j];                 //                    //
                            map[i,j] := ' ';                        //                    //
                       end;                                         //                    //
                       cy3 := cy3 - 1 ;                             //                    //
                       end;                                         //                    //
end;end;                                                            //                    //
//end of Input Of Moving ////////////////////////////////////////B.P.2                    //
                                                                                          //
//procedure of Loop By Level //////////////////////////////////////BP8///////////////////LBL
procedure LBL;                                                      //                    //
var i,j,k : shortint;                                               //                    //
begin                                                               //                    //
     space := false;                                                //                    //
     pass  := False;                                                //                    //
     for i := nowlv to 10 do                                        //                    //
         begin if not pass then begin                               //                    //
               IOM;CheckLastMove;                                   //                    //
               if yquit then exit;                                  //                    //
               for k := 1 to 10 do for j := 1 to 20 do              ////                  ////
                   pbox(k,j);                                       ////                  ////
               if opcu then show;                                   ////                  ////
         delay(45);                                                 //                    //
         end;                                                       //                    //
         end;                                                       //                    //
     if not space then FBT;                                         //                    //
     if space then dec(scnt);                                       //                    //
end;                                                                //                    //
//end of Loop By Level //////////////////////////////////////////B.P.8                    //
                                                                                          //
//procedure of Initialize The Var /////////////////////////////////BP9///////////////////IYV
procedure ITV;                                                      //                    //
begin                                                               //                    //
     for i := 1 to 20 do begin map[0,i]:='|';map[11,i]:='|';end;    //                    //
     for i := 1 to 10 do map[i,21]:='-';                            //                    //
     for i := 1 to 20 do for j := 1 to 10 do map[j,i] := ' ';       //                    //
     for i := 1 to 10 do map[i,0] := ' ';                           //                    //
     nowlv := 1;                                                    //                    //
     lncd  := 0;                                                    //                    //
     next  := round(random(7)+1);                                   //                    //
     lose  := false;                                                //                    //
     scnt  := 0;                                                    //                    //
     nocho := 2;                                                    //                    //
     opcu  := false;                                                //                    //
     yquit := false;                                                //                    //
     SetFillStyle(1,19);                                            ////                  ////
     bar(ltx-bl,lty-bl,ltx+bl*11,lty+bl*21);                        ////                  ////
     bar(ltx+bl*12,lty-bl,ltx+bl*18,lty+bl*5);                      ////                  ////
     SetFillStyle(1,25);                                            ////                  ////
     for j := 1 to 4 do for i := 1 to 4 do                          ////                  ////
     bar(i*bl+2+ltx+bl*12,j*bl-bl+2+lty,                            ////                  ////
         i*bl-2+ltx+bl*13,j*bl-2+lty);                              ////                  ////
     car;                                                           ////                  ////
end;                                                                //                    //
//end of Initialize The Var /////////////////////////////////////B.P.9                    //
                                                                                          //
//procedure of Supre Loop /////////////////////////////////////////AP1////////////////////SL
procedure SL;                                                       //                    //
begin                                                               //                    //
     repeat                                                         //                    //
           MNC;                                                     //                    //
           if NOT lose then                                         //                    //
           begin                                                    //                    //
            repeat                                                  //                    //
              RBL;                                                  //                    //
              LBL;                                                  //                    //
              if yquit then exit;                                   //                    //
              if lose then break;                                   //                    //
            until not move;                                         //                    //
           CAR;                                                     //                    //
           end;                                                     //                    //
     until lose;                                                    //                    //
     youlose;                                                       //                    //
end;                                                                //                    //
//end of Superloop //////////////////////////////////////////////A.P.1                    //
                                                                                          //
//procedure of Hypre Loop /////////////////////////////////////////AP2////////////////////HL
procedure HL;                                                       //                    //
begin                                                               //                    //
     randomize;                                                     //                    //
     ITV;                                                           //                    //
     Sl;                                                            //                    //
     if yquit then exit;                                            //                    //
end;                                                                //                    //
//end of Hypreloop //////////////////////////////////////////////A.P.2                    //
//end of Main Part /////////////////////////////////////////////////////////////////////////

begin
     OpenGraph;
     repeat
     Hl;
     until yquit;
end.
     
