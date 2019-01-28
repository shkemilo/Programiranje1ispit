program jan2016;
type 
    arr = array [1..200] of integer;
    intSet = set of 0..255;
var
    n, m, i, nm : integer;
    a1, a2 : arr;
    merged : arr;

function isGrowing(a : arr; n : integer) : boolean;
var 
    growing : boolean;
begin
    growing := true;
    for i:=1 to n-1 do
        if(a[i] > a[i+1]) then
        begin
            growing := false;
            break;
        end;

    isGrowing := growing;
end;

function min(a, b : integer) : integer;
begin
    if(a > b) then
        min := b
    else
        min := a;
end;

function uniqueMerge(a1, a2 : arr; n, m : integer) : arr;
var 
    p1, p2 : integer;
    a3 : arr;
begin
    p1 := 1;
    p2 := 1;
    nm := 0;
    
    while((p1 <> n+1) and (p2 <> m+1)) do
    begin
        inc(nm);
        if(a1[p1] < a2[p2]) then
        begin
            a3[nm] := a1[p1];
            inc(p1);
        end
        else if(a2[p2] < a1[p1]) then
        begin
            a3[nm] := a2[p2];
            inc(p2);
        end
        else
        begin
            a3[nm] := a1[p1];
            inc(p1);
            inc(p2);
        end;
    end;
        write(p1, p2);
        if(p2 > p1) then
            for i:=p1 to m do
              a3[i] := a2[i]
        else if(p1 > p2) then
            for i:=p2 to n do
              a3[i] := a1[i];
        
        uniqueMerge := a3;
end;

begin
    repeat
        readln(n, m);
        for i := 1 to n do
            read(a1[i]);
        for i:= 1 to m do
            read(a2[i]);
    until(isGrowing(a1, n) and isGrowing(a2, m));

    merged := uniqueMerge(a1, a2, n, m);

    for i := 1 to (n + m) do
        write(merged[i], ' ');
end.