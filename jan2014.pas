program jan2014;
type 
    intSet = set of 1..256;
var
    n, m, pom : integer;
    setn, setm : intSet;

procedure input(var set1 : intSet; n : integer);
var 
    pom : integer;
begin
    set1 := [];

    for i := 1 to n do
    begin
        read(pom);
        if ((pom % 2) = 0) then
          set1 := set1 + [pom];
    end;
end;

function obrada(set1, set2 : intSet;) : intSet;
begin
    obrada := set1 - set2;
end;

begin
    readln(n, m);
    input(setn, n);
    input(setm, m);
    
    obrada(setn, setm);
end.