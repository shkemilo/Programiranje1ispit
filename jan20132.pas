program jan20132;
type 
    pokaz = ^student;
    student = record
        ime : string;
        prezime : string;
        prosek : real;
        sled : pokaz;
    end;

function citajString(var ulaz : text) : string;
var
    c : char;
    pom : string;
begin
    pom := '';
    read(ulaz, c);
    while((c <> ' ') and (not eoln(ulaz)))do
    begin
        pom := pom + c;
        read(ulaz, c);
    end;
    
    citajString := pom;
end;

function citajProsek(var ulaz : text) : real;
var
    ocena, sum, n : integer;
begin
    sum := 0;
    n := 0;
    while (not eoln(ulaz)) do
    begin
        read(ulaz, ocena);
        
        if(ocena > 5)then
        begin
            inc(n);
            sum := sum + ocena;
        end;
    end;

    citajProsek := sum / n;
end;

function ucitaj() : pokaz;
var 
    ulaz : text;
    prvi, novi, pret : pokaz;
    pom : string;
begin
    assign(ulaz, 'studenti.txt');
    reset(ulaz);

    prvi := nil;
    pret := nil;
    while (not eof(ulaz)) do
    begin
        new(novi);
        novi^.ime := citajString(ulaz);
        novi^.prezime := citajString(ulaz);
        novi^.prosek := citajProsek(ulaz);

        readln(ulaz);

        if (prvi = nil) then
            prvi := novi
        else 
            pret^.sled := novi;
        
        pret := novi;
    end;

    ucitaj := prvi;

    close(ulaz);
end;

function srednjaOcena(prvi : pokaz) : real;
var
    tek : pokaz;
    sum : real;
    n : integer;
begin
    tek := prvi;
    sum := 0;
    n := 0 ;
    while(tek <> nil)do
    begin
        sum := sum + tek^.prosek;
        inc(n);
        tek := tek^.sled;
    end;

    srednjaOcena := sum / n;
end;

procedure ispisi(student : pokaz);
begin
    writeln(student^.ime, ' ', student^.prezime, ' ', student^.prosek);
end;

procedure natprosecni(prvi : pokaz; prosecna : real);
var
    tek : pokaz;
begin
    tek := prvi;

    while(tek <> nil)do
    begin
        if(tek^.prosek >= prosecna)then
            ispisi(tek);
        tek := tek^.sled;
    end;
end;

procedure oslobodiListu(prvi : pokaz);
var 
    tek : pokaz;
begin
    tek := prvi^.sled;
    while(tek <> nil)do
    begin
        dispose(prvi);
        prvi := tek;
        tek := tek^.sled;
    end;
end;

var
    prvi, tek: pokaz;
begin
    prvi := ucitaj();

    natprosecni(prvi, srednjaOcena(prvi));
    oslobodiListu(prvi);
end.