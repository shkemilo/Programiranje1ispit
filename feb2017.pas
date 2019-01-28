program feb2017;
type 
    pokaz = ^polinom;
    polinom = record
        stepen : integer;
        koef : real;
        sled : pokaz;
    end;
var
    prvi1, prvi2, prvi3 : pokaz;

procedure ucitaj(var prvi : pokaz; n : integer);
var
    novi, pret : pokaz;
    i : integer;
begin
    prvi := nil;
    pret := nil;
    for i:= 1 to n do
    begin
        new(novi);
        read(novi^.stepen, novi^.koef);
        
        if (prvi = nil) then
            prvi := novi
        else
            pret^.sled := novi;

        pret := novi;
    end;
end;

function provera(prvi : pokaz) : boolean;
var 
    tek : pokaz;
begin
    tek := prvi;
    
    provera := true;
    while(tek^.sled <> nil)do
    begin
        if(tek^.stepen <= tek^.sled^.stepen)then
        begin
            provera := false;
            break;
        end;

        tek := tek^.sled;
    end;
end;

function zbir(prvi1, prvi2 : pokaz) : pokaz;
var
    tek1, tek2, novi, pret : pokaz;
begin
    zbir := nil;
    tek1 := prvi1; tek2 := prvi2;
    while((tek1 <> nil) or (tek2 <> nil)) do
    begin
        new(novi);
        if(tek1 = nil) then
        begin
            novi^.stepen := tek2^.stepen;
            novi^.koef := tek2^.koef;
            tek2 := tek2^.sled;
        end
        else if(tek2 = nil) then
        begin
            novi^.stepen := tek1^.stepen;
            novi^.koef := tek1^.stepen;
            tek1 := tek1^.sled;
        end
        else if(tek1^.stepen > tek2^.stepen)then
        begin
            novi^.stepen := tek1^.stepen;
            novi^.koef := tek1^.koef;
            tek1 := tek1^.sled;
        end
        else if(tek1^.stepen < tek2^.stepen)then
        begin
            novi^.stepen := tek2^.stepen;
            novi^.koef := tek2^.koef;
            tek2 := tek2^.sled;
        end
        else
        begin
            novi^.stepen := tek1^.stepen;
            novi^.koef := tek1^.koef + tek2^.koef;
            tek1 := tek1^.sled;
            tek2 := tek2^.sled;
        end;

        if (zbir = nil) then
            zbir := novi
        else
            pret^.sled := novi;
        pret := novi;
    end;
end;
procedure ispisi(prvi : pokaz);
var
    tek : pokaz;
begin
    writeln('evo me');
    tek := prvi;
    while(tek <> nil)do
    begin
        write(tek^.koef, 'x^', tek^.stepen, ' + ');
        tek := tek^.sled;
    end;
end;

begin
    ucitaj(prvi1, 3);
    ucitaj(prvi2, 1);
    if(provera(prvi1) and provera(prvi2))then
    begin
        prvi3 := zbir(prvi1, prvi2);
        ispisi(prvi3);
    end;
end.