program jan2013;
type 
    niz = array [1..100] of integer;
var 
    a : niz;
    n, i : integer;

procedure swap(var a, b : integer);
var
    temp : integer;
begin
    temp := a;
    a := b;
    b := temp;
end;

procedure sortDesc(var a : niz; n : integer);
var 
    i, j : integer;
begin
    for i := 1 to n-1 do
        for j := i + 1 to n do
            if(a[j] > a[i]) then
                swap(a[j], a[i]);
end;

procedure remove(var a : niz; var n, pos : integer);
begin
    for i := pos to n - 1 do
        a[i] := a[i + 1];

    n := n - 1;
end;

procedure unique(var a : niz; var n : integer);
var
    t, i : integer;
begin
    t := a[1];
    i := 2;
    while(i <> n + 1)do
    begin
        if(a[i] = t)then
            remove(a, n, i)
        else
        begin
            t := a[i];
            inc(i);
        end;
    end;
end;
begin
    repeat
        readln(n);
        for i := 1 to n do
            read(a[i]);
        
        sortDesc(a, n);
        unique(a, n);

        for i := 1 to n do
            write(a[i], ' ');
        
    until(n = 0);
end.