program Untitled;
type p = array[1..3,1..3]of byte;

var a : p;
    wwyt : byte;

function wp(ns:p;where,what:byte):p;
begin
     ns[where div 10,where mod 10] := what;
     result := ns;
end;

function ccw(ns:p;rp:byte):boolean;
begin
     result := ns[rp div 10,rp mod 10] = 0;
end;


function ps(ns:p):byte;
function cw:byte;
var i,k : byte;
    f: boolean;
begin
     result := 3;
     f := false;
     for i := 1 to 3 do
         begin
              k := ns[i,1]+ns[i,2]+ns[i,3];
              if k < 13 then f := true;
              k := k div 3;
              if k in[1,6] then
                 begin
                      result := k;exit;
                 end;
         end;

     for i := 1 to 3 do
         begin
              k := ns[1,i]+ns[2,i]+ns[3,i];
              if k < 13 then f := true;
              k := k div 3;
              if k in[1,6] then
                 begin
                      result := k;exit;
                 end;
         end;

     k := ns[1,1]+ns[2,2]+ns[3,3];
     if k < 13 then f := true;
     k := k div 3;
     if k in[1,6] then
        begin
             result := k;exit;
        end;

     k := ns[1,3]+ns[2,2]+ns[3,1];
     if k < 13 then f := true;
     k := k div 3;
     if k in[1,6] then
        begin
             result := k;exit;
        end;

     if f then
        for i := 1 to 3 do
            for k := 1 to 3 do
                if ns[i,k] = 0 then
                   if result = 3 then
                      result := 0;
end;
begin
     result := (cw+1) *2div 3;
     if result = 4 then result := result-1;
end;


function tn(i:byte):byte;
begin
     result := (1+ (i-1) mod 3)*10;
     result := result + (i-1)div 3+1;
end;

function cmm(pp:p;ww:byte):byte;
const np = 99;
var i,j : byte;
    re: array[1..9]of byte;
    m : boolean;//true for max,false for min
begin
     for i := 1 to 9 do re[i] := np;
     result := ps(pp);
     if result <> 0 then begin {writeln(ps(pp),' win');}exit;end;


     for i := 1 to 9 do
         if ccw(pp,tn(i)) then
            begin
                 re[i]:=cmm(wp(pp,tn(i),1-ww+6),1-ww+6);
            end
         else re[i] := np;

     begin
          m := 1-ww+6 = 6;
          for j := 1 to 9 do if re[j]<>np then begin result := re[j];break;end;
          for i := j to 9 do
              if m then
                 begin if(re[i] > result)and(re[i] <> np)then result := re[i];end
              else
                 begin if re[i] < result then result := re[i]; end;
     end;

     for i := 1 to 9 do
         if result = re[i] then wwyt := i ;
end;

begin                              
     a[1,3]:=1;a[2,3]:=0;a[3,3]:=1;
     a[1,2]:=6;a[2,2]:=6;a[3,2]:=0;
     a[1,1]:=1;a[2,1]:=0;a[3,1]:=0;

     cmm(a,1);
     writeln(wwyt);
     readln;
end.
