program jan20182;
type 
    pokaz = ^student;
    student = record
        indeks : string;
        ime : string;
        prezime : string;
        prisustvo : char;
        ocena : real;
        sled : pokaz;
    end;

function readString(var ulaz : text) : string;
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

    readString := pom;
end;

function unos() : pokaz;
var
    ulaz : text;
    novi, pret, prvi : pokaz;
    ime : string;
begin
    readln(ime);
    assign(ulaz, ime);
    reset(ulaz);
    
    novi := nil; pret := nil; prvi :=nil;
    while (not eof(ulaz)) do
    begin
        new(novi);
        novi^.indeks := readString(ulaz);
        novi^.ime := readString(ulaz);
        novi^.prezime := readString(ulaz);
        read(ulaz, novi^.prisustvo);
        if(novi^.prisustvo = 'P')then
            read(ulaz, novi^.ocena);
        readln(ulaz);
        
        if (prvi = nil) then
            prvi := novi
        else
            pret^.sled := novi;

        pret := novi;
    end;

    close(ulaz);
    unos := prvi;
end;

procedure izbaci(var prvi : pokaz; traz : pokaz);
var 
    pret, tek : pokaz;
begin
    pret := nil;
    tek := prvi;
    while(tek <> nil)do
    begin
        if(tek = traz)then
            if(pret = nil) then
            begin
                prvi := traz^.sled;
                dispose(traz);
                break;
            end
            else if(tek^.sled = nil) then
            begin
                pret^.sled := nil;
                dispose(traz);
                break;
            end
            else 
            begin
                pret^.sled := traz^.sled;
                dispose(traz);
                break;
            end;

        pret := tek;
        tek := tek^.sled;
    end;
end;

procedure izbaciPobegle(var prvi : pokaz);
var
    tek : pokaz;
begin
    tek := prvi;
    while(tek <> nil)do
    begin
        if(tek^.prisustvo = 'N')then
            izbaci(prvi, tek);
        tek := tek^.sled;
    end;
end;

procedure oslobodiListu(prvi : pokaz);
var
    tek : pokaz;
begin
    while(prvi <> nil)do
    begin
        tek := prvi;
        prvi := prvi^.sled;
        dispose(tek);
    end;
end;

function poeniUOcena(ocena : real) : integer;
begin
    if(ocena < 51)then
        poeniUOcena := 5
    else if(ocena < 61) then
        poeniUOcena := 6
    else if(ocena < 71) then
        poeniUOcena := 7
    else if(ocena < 81) then
        poeniUOcena := 8
    else if(ocena < 91) then
        poeniUOcena := 9
    else
        poeniUOcena := 10;
end;

procedure ispis(prvi : pokaz);
var
    isp : text;
    tek : pokaz;
    ime : string;
begin
    readln(ime);
    assign(isp, ime);
    rewrite(isp);

    tek := prvi;
    while(tek <> nil)do
    begin
        writeln(isp, tek^.indeks, ' ', tek^.ime,' ', tek^.prezime, ' ', poeniUOcena(tek^.ocena));
        
        tek := tek^.sled;
    end;

    close(isp);
end;

var
    prvi, tek : pokaz;
    
begin
    prvi := unos();
    izbaciPobegle(prvi);

    ispis(prvi);

    oslobodiListu(prvi);
end.