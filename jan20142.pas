program jan20142(input, output, ulaz);
type 
    pokaz = ^ocitavanje;
    ocitavanje = record
        datum : string[8];
        vt : integer;
        nt : integer;
        sled : pokaz;
    end;
var 
    ulaz : text;
    c : char;
    prvi, novi, pret, tek, minvt, maxnt : pokaz;
    ukupnaPotrosnja, min, max, pmin, pmax : integer;

begin
    assign(ulaz, 'struja.txt');
    reset(ulaz);

    prvi := nil;
    pret := nil;
    while not eof(ulaz) do
    begin
        new(novi);
        novi^.sled := nil;

        read(ulaz, novi^.datum);
        {read(ulaz, c);}
        read(ulaz, novi^.vt);
        readln(ulaz, novi^.nt);

        if(prvi = nil) then
            prvi := novi
        else 
            pret^.sled := novi;
        pret := novi;
    end;
    ukupnaPotrosnja := pret^.vt - prvi^.vt + pret^.nt - prvi^.nt;

    writeln('Ukupnja potrosnja je: ', ukupnaPotrosnja);

    minvt := prvi;
    min := prvi^.sled^.vt - prvi^.vt;
    tek := prvi^.sled;
    while(tek^.sled <> nil)do
    begin
        pmin := tek^.sled^.vt - tek^.vt;
        if(pmin < min)then
        begin
            min := pmin;
            minvt := tek;
        end;

        tek := tek^.sled;
    end;

    writeln('Minimalna visoka potrosnja je ', minvt^.sled^.vt - minvt^.vt, '. Dostignuta izmedju ', minvt^.datum, ' i ', minvt^.sled^.datum);

    maxnt := prvi;
    max := prvi^.sled^.nt - prvi^.nt;
    tek := prvi^.sled;
    while(tek^.sled <> nil)do
    begin
        pmax := tek^.sled^.nt - tek^.nt;
        if(pmax > max)then
        begin
            max := pmax;
            maxnt := tek;
        end;

        tek := tek^.sled;
    end;

    writeln('Maksimalna niska potrosnja je ', maxnt^.sled^.nt - maxnt^.nt, '. Dostignuta izmedju ', maxnt^.datum, ' i ', maxnt^.sled^.datum);

    tek := prvi;
    while(tek <> nil)do
    begin
        writeln(tek^.datum,' ',tek^.vt,' ',tek^.nt);
        tek := tek^.sled;
    end;
    while prvi <> nil do 
    begin
        tek := prvi;
        prvi := prvi^.sled;
        dispose(tek);
    end;
    close(ulaz);
end.