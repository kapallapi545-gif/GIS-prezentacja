<#
    Tresc prezentacji: System Informacji Geograficznej (SIG / GIS).
    Kazdy slajd to tablica: Tytul, Podtytul, Kolor, Bloki.
    Typy blokow: Naglowek, Tekst, Punkty, Kod, Cytat, Tabela, Quiz.
    W kodzie (blok Kod) znak "~" oznacza znak konca linii.
#>

$script:Slajdy = @(

    # ---------------------------------------------------------------- 01
    @{
        Tytul = 'SYSTEM INFORMACJI GEOGRAFICZNEJ'
        Podtytul = 'Prezentacja z geografii  |  SIG = GIS = Geographic Information System'
        Kolor = 'Cyan'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Jak swiat zamienia wspolrzedne w odpowiedzi na pytania' }
            @{ Typ = 'Tekst'; Tekst = 'Przedmiot: geografia. Temat: System Informacji Geograficznej - narzedzie, ktore laczy mape, dane i analize. Wszystkie informacje sa powiazane z MIEJSCEM na Ziemi - z tego miejsca wynika pelna nazwa systemu.' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Prezentacja ma 20 slajdow podzielonych na 6 czesci merytorycznych'
                'Na koncu krotki quiz - sprawdzisz siebie z najwazniejszych zagadnien'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Plan prezentacji' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'I.    Czym jest GIS - definicja, historia, 5 elementow systemu'
                'II.   Dane przestrzenne - wektorowe, rastrowe, uklady wspolrzednych, formaty'
                'III.  Jak dziala GIS - przeplyw danych i analizy przestrzenne'
                'IV.   Zastosowania - geografia, srodowisko, transport, gospodarka'
                'V.    GIS w Polsce, zalety i wady systemu'
                'VI.   Przyszlosc, quiz i bibliografia'
            ) }
            @{ Typ = 'Cytat'; Tekst = 'Wszystko, co robisz w GIS, sprowadza sie do trzech pytan: GDZIE? (lokalizacja), JAKIE? (atrybuty), JAK BLISKO? (relacje przestrzenne).' }
        )
    }

    # ---------------------------------------------------------------- 02
    @{
        Tytul = 'I. CZYM JEST GIS'
        Podtytul = 'Definicja i geneza systemu'
        Kolor = 'Cyan'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Definicja' }
            @{ Typ = 'Cytat'; Tekst = 'System Informacji Geograficznej (SIG, ang. GIS) to zintegrowany system informacyjny przeznaczony do gromadzenia, przetwarzania, analizowania i prezentacji danych o obiekcie przestrzennym - czylie danych opisujacych gdzie cos sie znajduje.' }
            @{ Typ = 'Tekst'; Tekst = 'Najwazniejsze slowo definicji: zintegrowany. GIS nie jest jednym programem ani jedna mapa - jest to polaczenie sprzetu, oprogramowania, danych, metod i ludzi, ktore dzialaja razem, aby zamienic surowe dane przestrzenne w gotowa informacje i decyzje.' }
            @{ Typ = 'Naglowek'; Tekst = 'Podobne systemy i pojecia pokrewne' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'SIG / ISGIS - polskie odmiany nazwy (System Informacji Geograficznej)',
                'GISS - Geographic Information System Science - nauka zajmujaca sie GIS',
                'DBMS - system zarzadzania baza danych przechowujaca atrybuty obiektow',
                'Teledetekcja (RS) - pozyskiwanie danych o powierzchni z oddali, np. z satelity',
                'GPS / GNSS - system nawigacji satelitarnej dostarczajacy wspolrzednych punktu'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Trzy pytania, na ktore odpowiada GIS' }
            @{ Typ = 'Kod'; Linie = @(
                'GDZIE?   -->  lokalizacja    -->  wspolrzedne X, Y (i Z), uklad odwzorowania',
                'JAKIE?   -->  atrybuty       -->  nazwa, powierzchnia,liczba mieszkancow',
                'JAK BLISKO? --> relacje        -->  odleglosc, sasiedztwo, zawieranie sie'
            ) }
        )
    }

    # ---------------------------------------------------------------- 03
    @{
        Tytul = 'HISTORIA GIS'
        Podtytul = 'Od eksperymentow naukowych do powszechnego narzedzia'
        Kolor = 'Green'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Kalendarium' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'lata 60. i 70. - ręczne digitowanie map na komputerach (Harvard, Cambridge, MIT); powstaje FOSS, pierwszy system GIS',
                '1963 - termin geographic information system; zwiazany z Robertem Tomlinsonem i planowaniem gruntow w Kanadzie',
                '1974 - powstaje ESRI (Environmental Systems Research Institute, Jack Dangermond)',
                '1982-1984 - Arc/Info, pierwszy komercyjny GIS, potem wersje na PC',
                '1992 - konferencja ONZ w Rio de Janeiro: GIS wchodzi do Agendy 21 jako narzedzie rozwoju zrównoważonego',
                '1999-2005 - Google Maps i Google Earth: GIS trafia do Internetu i do domu',
                '2002 - QGIS 1.0 (open source, dziś QGIS 3.x - najpopularniejszy darmowy GIS)',
                '2007 - dyrektywa INSPIRE w Unii Europejskiej: obowiazkowa infrastruktura danych przestrzennych',
                'od 2010 - chmura obliczeniowa, WebGIS, drony, LiDAR, sztuczna inteligencja w analizie obrazow'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Dlaczego GIS rozwinal sie tak szybko?' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Spadek kosztow mocy obliczeniowej i pamieci - analizy milionow obiektow staly sie mozliwe',
                'Dostęp do danych satelitarnych o wysokiej rozdzielczosci (Landsat, Sentinel, programy komercyjne)',
                'Rosnaca liczba komputerow osobistych i mobilnych z GPS',
                'Wymog prawne i planistyczne (INSPIRE, ustawa o gospodarce nieruchomosciami, dokumentacja planowa)'
            ) }
        )
    }

    # ---------------------------------------------------------------- 04
    @{
        Tytul = 'PIEC ELEMENTOW SYSTEMU GIS'
        Podtytul = 'Z czego sklada sie kazdy system informacji geograficznej'
        Kolor = 'Green'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Schemat systemu GIS' }
            @{ Typ = 'Kod'; Linie = @(
                '+++++++++++++++++++++++++++++++++++++++++++~',
                '|     S Y S T E M   G I S                 |~',
                '| zintegrowany system informacyjny        |~',
                '+++++++++++++++++++++++++++++++++++++++++++~',
                '                     |~',
                '                     v~',
                '+++++++++++++++++++++++++++++++++++++++++++~',
                '|   SPRZET    |     DANE    | OPROGRAMOW. |~',
                '| komputer,   | wektorowe,  | ArcGIS,     |~',
                '| GPS,        | rastrowe,   | QGIS,       |~',
                '| skaner,     | atrybuty,   | GRASS,      |~',
                '| serwer      | metadane    | PostGIS     |~',
                '+++++++++++++++++++++++++++++++++++++++++++~',
                '                     |~',
                '                     v~',
                '+++++++++++++++++++++++++++++++++++++++++++~',
                '|   METODY    |   LUDZIE    |    WYNIK    |~',
                '| analizy,    | geograf,    |   mapa      |~',
                '| modele,     | kartograf,  |  raport     |~',
                '| projekcje   | programist  |  decyzja    |~',
                '+++++++++++++++++++++++++++++++++++++++++++~',
                '+++++++++++++++++++++++++++++++++++++++++++'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Znaczenie kazdego elementu' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'SPRZET - komputer stacjonarny lub laptop, odbiornik GPS, skaner, drukarka plotujaca, serwer',
                'DANE - warstwy przestrzenne, tabele atrybutow, rastry, metadane opisujace zrodlo danych',
                'OPROGRAMOWANIE - programy GIS (QGIS, ArcGIS, GRASS, SAGA) oraz systemy zarzadzania bazami danych (PostgreSQL/PostGIS)',
                'METODY - algorytmy analizy, modele matematyczne, uklady odwzorowania, reguly generalizacji',
                'LUDZIE - geografowie, kartografowie, GIS-owcy, statystycy, decydenci - kto interpretuje wynik (najwazniejszy element!)'
            ) }
            @{ Typ = 'Cytat'; Tekst = 'Najslabszym ogniwem kazdego GIS jest czlowiek: blad czytania mapy lub zlej interpretacji danych nizczy caly system.' }
        )
    }

    # ---------------------------------------------------------------- 05
    @{
        Tytul = 'DANE PRZESTRZENNE - CZESC 1'
        Podtytul = 'Podzial danych na wektorowe i rastrowe'
        Kolor = 'Yellow'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Dane przestrzenne (spatial data) - podstawowy surowiec GIS' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'DANE NIEPRZESTRZENNE (atrybuty) - tabela: nazwa, liczba mieszkancow, rok zbudowania',
                'DANE PRZESTRZENNE - opis geometrii obiektu: gdzie on lezy i jak wyglada'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Dane wektorowe - obiekty jako punkty, linie, wielokaty' }
            @{ Typ = 'Kod'; Linie = @(
                '        PUNKT      jeden obrazek              (52,23 ; 21,01)~',
                '        LINIA      odcinek, droga, rzeka      (A)--------(B)~',
                '        POLIGON    obszar - miasto, las       +-------------+~',
                '                                               |             |~',
                '                                               |             |~',
                '                                               +-------------+~',
                '',
                'Obiekt wektorowy = geometria (wspolrzedne) + atrybuty (tabela):~',
                '  POLIGON: nazwa = las, powierzchnia = 1240 ha, status = ochronny'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Dane rastrowe - siatka pikseli, macierz liczb' }
            @{ Typ = 'Kod'; Linie = @(
                '          wysokosc terenu / temperatura / zarośnietość (NDVI)~',
                '        | 120 | 118 | 121 | 130 | 155 | 160 |~',
                '        +-----+-----+-----+-----+-----+-----+~',
                '        | 119 | 117 | 122 | 132 | 158 | 163 |~',
                '        +-----+-----+-----+-----+-----+-----+~',
                '        | 121 | 121 | 125 | 140 | 162 | 170 |~',
                '        +-----+-----+-----+-----+-----+-----+~',
                '          komorka (piksel) = 1 wartosc     macierz N x M liczb~',
                '',
                'Przyklady rastrowych zrodel danych: Landsat, Sentinel-2, ortofotomapy,~',
                'modele wysokosci terenu (LiDAR, SRTM), mapy temperatury i opadow'
            ) }
        )
    }

    # ---------------------------------------------------------------- 06
    @{
        Tytul = 'WEKTOR CZY RASTER?'
        Podtytul = 'Porownanie najwazniejszych formatow danych przestrzennych'
        Kolor = 'Yellow'
        Bloki = @(
            @{ Typ = 'Tekst'; Tekst = 'Wybór typu danych to pierwsza decyzja przy budowie GIS. Decyduje o tym, do czego dane zostaną użyte.' }
            @{ Typ = 'Tabela'
                Naglowki = @('Cecha', 'Dane wektorowe', 'Dane rastrowe')
                Wiersze = @(
                    @('Podstawowa jednostka', 'punkt, linia, wielokąt', 'piksel (komórka siatki)'),
                    @('Reprezentacja', 'obiekty dyskretne', 'zjawisko ciągłe / pole wartości'),
                    @('Dobre do', 'działki, budynki, drogi, sieci', 'wysokość, temperatura, zarośniętość, gęstość'),
                    @('Relacje przestrzenne', 'dokładne (długość, pole powierzchni)', 'przybliżone (zależne od rozdzielczości)'),
                    @('Skala', 'niezależna od skali, łatwa generalizacja', 'zależna od rozdzielczości (stała)'),
                    @('Pojemnosc danych', 'mała - oszczędne', 'duża - pliki setki MB / GB'),
                    @('Najlepsza operacja', 'analiza sieciowa, bufor, nakładanie', 'analiza rastrowa, interpolacja, klasyfikacja'),
                    @('Przykładowy format', 'Shapefile, GeoJSON, GeoPackage', 'GeoTIFF, ASCII Grid, NetCDF')
                )
            }
            @{ Typ = 'Naglowek'; Tekst = 'Rozdzielczość rastra = dokladosc danych rastrowych' }
            @{ Typ = 'Kod'; Linie = @(
                '  30 m   --> 1 piksel odpowiada 30 m x 30 m na terenie  --> mapa ogolna, planowanie~',
                '  10 m   --> 10 m x 10 m                        --> ortofotomapa, mapa uzytkowania~',
                '  1  m   --> 1 m x 1 m                           --> mapa rejestrowa~',
                '  0,5 m --> 0,5 m x 0,5 m                       --> ortofotomapa wysokiej rozdzielczosci~',
                '  10 cm --> 10 cm x 10 cm                       --> skan laserowy (LiDAR), model 3D miasta'
            ) }
            @{ Typ = 'Cytat'; Tekst = 'Regula: im wyzsza rozdzielczość, tym wieksza dokladosc - ale takze wiekszy plik i dluzszy czas przetwarzania.' }
        )
    }

    # ---------------------------------------------------------------- 07
    @{
        Tytul = 'UKLADY WS POLRZEDNYCH I ODWZOROWANIA'
        Podtytul = 'Jak mapa moze byc plaska, skoro Ziemia jest kula?'
        Kolor = 'Magenta'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Problem' }
            @{ Typ = 'Tekst'; Tekst = 'Ziemia jest kula, a mapa jest plaska - dlatego trzeba stosowac odwzorowanie kartograficzne. Odwzorowanie okresla, jak wspolrzedne na kuli (szerokosc i dlugosc geograficzna) przetworzyc na plasko. Kazde odwzorowanie cos znieksztalca: ksztalt, powierzchnie, katy lub odleglosci.' }
            @{ Typ = 'Naglowek'; Tekst = 'Rodzaje odwzorowan' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Walcowe (stereograficzne, Mercatora) - merkdiany proste, bieguny bardzo rozciagniete; do map morskich i nawigacji',
                'Stożkowe - wierne ksztalty kontinentow; mapy swiatowe, mapy kontynentalne',
                'Rownikowe - przydatne dla obszarow wokol rownika',
                'Azymutalne - mapy polarnych obszarow, planimetrie lokalne',
                'Plaskie prostokatulne - najprostsze, do malych obszarow; stosowane w Polsce mapy topograficzne (Gauss-Kruger)'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Najwazniejsze uklady wspolrzednych' }
            @{ Typ = 'Tabela'
                Naglowki = @('Nazwa układu', 'Kod EPSG', 'Zastosowanie')
                Wiersze = @(
                    @('WGS 84 (szer. / dł.)', 'EPSG:4326', 'GPS, dane globalne, WebGIS, granice'),
                    @('ETRS89 / PL-2000', 'EPSG:2177', 'Polska - mapy topograficzne, ewidencja gruntów'),
                    @('Układ Gaussa-Krügera 1992', 'EPSG:2180', 'Polska - od skali 1:5000 w górę'),
                    @('PL-1992 (PUWG)', 'EPSG:1992', 'starsze mapy topograficzne Polski'),
                    @('UTM (strefy 6°)', 'EPSG:326xx / 327xx', 'świat - arkusze 500 km x 500 km'),
                    @('Prosty kartezjański (lokalny)', 'EPSG:2177 + przesuniecie', 'mapy do wymiarowania, roboty ziemne')
                )
            }
            @{ Typ = 'Naglowek'; Tekst = 'Pojęcia, ktore trzeba umieć rozróżnić' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Szerokość geograficzna (φ) - kąt od rownika, 0° na rowniku, do 90° na biegunach',
                'Długość geograficzna (λ) - kąt od południka zerowego (Greenwich), 0°-180°W / 0°-180°E',
                'Odległość na powierzchni (geodezyjna), odległość w płaszczyźnie (spłaszczona), odległość wzdłuż drogi - trzy różne wyniki tego samego pomiaru',
                'EPSG - europejski system oznaczania układow wspolrzednych i projekcji'
            ) }
        )
    }

    # ---------------------------------------------------------------- 08
    @{
        Tytul = 'FORMATY PLIKOW I BAZY DANYCH'
        Podtytul = 'W jakim formacie zapisujemy dane przestrzenne?'
        Kolor = 'Magenta'
        Bloki = @(
            @{ Typ = 'Tabela'
                Naglowki = @('Format', 'Typ danych', 'Opis i uwagi')
                Wiersze = @(
                    @('Shapefile (.shp, .shx, .dbf)', 'wektorowy', 'standard ESRI z lat 90.; to trzy pliki, brak georeferencji w .dbf; problemy z polskimi znakami w nazwach'),
                    @('GeoPackage (.gpkg)', 'wektorowy + rastrowy', 'jeden plik SQLite; obecnie rekomendowany standard, obsługuje warstwy i typy przestrzenne'),
                    @('GeoJSON (.json)', 'wektorowy', 'tekstowy, łatwy do odczytu; domyślnie WGS 84; idealny do wymiany z aplikacjami webowymi'),
                    @('KML / KMZ', 'wektorowy', 'format Google Earth; KMZ to spakowany KML; dobry do prezentacji wyników'),
                    @('GeoTIFF (.tif)', 'rastrowy', 'obraz z georeferencją; wersja COG umożliwia przycinanie bez pobierania całego pliku'),
                    @('ASCII Grid', 'rastrowy', 'macierz liczb w pliku tekstowym z nagłówkiem rozdzielczości; prosty w edycji'),
                    @('CSV + plik .prj', 'punkty wektorowe', 'tabela współrzędnych X,Y; najprostszy sposób importu danych'),
                    @('PostgreSQL + PostGIS', 'wielkoformatowy', 'serwerowa baza przestrzenna; wspiera miliony obiektów, zapytania przestrzenne, wersjonowanie'),
                    @('WMS / WFS / WMTS', 'usługi sieciowe', 'standardy OGC: pobieranie mapy z serwera (WMS) albo samych danych (WFS)')
                )
            }
            @{ Typ = 'Naglowek'; Tekst = 'Warstwa (layer) - podstawowa jednostka organizacji danych' }
            @{ Typ = 'Kod'; Linie = @(
                '  Projekt GIS = baza danych + zbior warstw + uklad odwzorowania + reguly stylizacji~',
                '  ~',
                '  warstwa: budynki      -> wektor poligonow, atrybut: liczba kondygnacji~',
                '  warstwa: drogi         -> wektor linii,     atrybut: klasa drogi (k/k/l)~',
                '  warstwa: niz           -> raster,            atrybut: wysokosc n.p.m.~',
                '  warstwa: uzytkowanie  -> wektor poligonow, atrybut: rodzaj uzytkowania',
                '  ~',
                '  Kolejnosc warstw = kolejnosc rysowania (pod spodem / na wierzchu) - jak w grafiku.'
            ) }
        )
    }

    # ---------------------------------------------------------------- 09
    @{
        Tytul = 'METADANE I STANDARDY'
        Podtytul = 'Dokumentacja danych - warunek wiarygodnosci wynikow'
        Kolor = 'Blue'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Co to sa metadane?' }
            @{ Typ = 'Cytat'; Tekst = 'Metadane to dane o danych: kto je zrobił, kiedy, z jakiego zrodla, jaka jest ich dokladnosc, w jakim ukladzie wspolrzednych, jakie obejmuja terytorium i jakie maja ograniczenia.' }
            @{ Typ = 'Tekst'; Tekst = 'Bez metadanych mapa jest tylko kolorowym obrazkiem. Z metadanymi jest zrodlem wiedzy - wiadomo, czego mozna dowiarzyc, a czego nie.' }
            @{ Typ = 'Naglowek'; Tekst = 'Najwazniejsze metadane' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Identyfikacja - nazwa instytucji, autor, data, numer wersji',
                'Opis - temat, slowa kluczowe, zakres terytorialny i czasowy',
                'Jakasć / dokladnosc - pomiarowa, pozycyjna, tematyczna, czasowa',
                'Układ od wspolrzednych i uklad odwzorowania (CRS)',
                'Zrodlo i metoda pozyskania - pomiar lotniczy, skan laserowy, GPS, satelita, dyigitalizacja',
                'Ograniczenia i prawa - licencja, warunki uzytkowania, ograniczenia rozpowszechniania'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Standardy i organizacje' }
            @{ Typ = 'Tabela'
                Naglowki = @('Standard / organizacja', 'Zakres')
                Wiersze = @(
                    @('ISO 19115 / 19131', 'międzynarodowy standard metadanych dla danych przestrzennych'),
                    @('INSPIRE (Dyrektywa 2007/2/WE)', 'wspólna infrastruktura danych przestrzennych w UE - 34 tematyki danych'),
                    @('ETRS89 / ETRS89-LAEA', 'europejski układ odniesienia; w Polsce PL-2000'),
                    @('OGC (Open Geospatial Consortium)', 'standardy usług sieciowych: WMS, WFS, WCS, WMTS, KML'),
                    @('EPSG (org. EPSG Geomatics)', 'jednolity katalog układow wspolrzednych (np. EPSG:2180)'),
                    @('OGC Simple Features / ISO 19125', 'model typow geometrii: punkt, krzywa, powierzchnia'),
                    @('CORINE / EEA', 'zunifikowane mapy pokrycia i uzycia terenu Europy'),
                    @('GUGiK, KNG, PAN, GDOŚ', 'polskie instytucje tworzace i udostepniajace dane przestrzenne')
                )
            }
        )
    }

    # ---------------------------------------------------------------- 10
    @{
        Tytul = 'III. JAK DZIALA GIS - PRZEPLYW DANYCH'
        Podtytul = 'Od surowego pomiaru do mapy i decyzji'
        Kolor = 'Cyan'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Schemat przeplywu danych w systemie GIS' }
            @{ Typ = 'Kod'; Linie = @(
                '    ZRODLA DANYCH           PROCES GIS              WYNIK~',
                '+++++++++++++++++++++   +++++++++++++++++++   ++++++++++++++++++~',
                '| pomiar geodez.    |-> | pozyskanie      |-> |    MAPA        |~',
                '| GPS / GNSS        |   | danych          |   |   RAPORT       |~',
                '|                   |   |                 |   |                |~',
                '| teledetekcja      |-> | georeferencja   |-> |   TABELA       |~',
                '| satelitarna       |   |                 |   |                |~',
                '|                   |   | digiteryzacja   |   |  DECZYJA       |~',
                '| mapy cyfrowe      |-> |                 |   |                |~',
                '| NMT, OSM          |   | oczyszczanie    |   | INTERAKTYWNA   |~',
                '+++++++++++++++++++++   | oczyszczanie    |   |  APLIKACJA     |~',
                '+++++++++++++++++++++   +++++++++++++++++++~',
                '                        +++++++++++++++++++++++++~',
                '                        | analiza przestrzenna, |~',
                '                        | wizualizacja,         |~',
                '                        | modelowanie           |~',
                '                        +~~~~~~~~~~~~~~~~~~~~~~~~~',
                '',
                '  PETLE ZWRACNE: wynik analizy staje sie nowym zrodlem danych~',
                '  dla kolejnej analizy - to wlasnie odróznia GIS od zwykłej mapy.'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Etapy pracy z projektem GIS' }
            @{ Typ = 'Punkty'; Pozycje = @(
                '1. Zdefiniowanie problemu i celu - co chcemy zbadac? (np. gdzie wytyczyc droge, by nie zaszkodzic lasowi?)',
                '2. Zbieranie danych i ocena ich jakosci',
                '3. Nadanie ukladu odwzorowania i georeferencja',
                '4. Oczyszczenie danych (topologia, duplikaty, braki)',
                '5. Klasyfikacja i budowa bazy atrybutow',
                '6. Analiza przestrzenna i wizualizacja',
                '7. Walidacja wynikow i kontrola jakosci',
                '8. Publikacja (mapa, aplikacja web, raport) i archiwizacja'
            ) }
        )
    }

    # ---------------------------------------------------------------- 11
    @{
        Tytul = 'ANALIZY PRZESTRZENNE'
        Podtytul = 'Serce systemu GIS - operacje, ktore czego nie policzy sie arkuszem kalkulacyjnym'
        Kolor = 'Green'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Podstawowe analizy wektorowe' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Nakladanie (overlay) - porownanie dwoch warstw, wynik: obszary wspolne, roznicowe, przeciete',
                'Bufor - obszar w zadanej odleglosci od obiektu (np. 500 m od drogi, 1000 m od szkoly)',
                'Intersect / union / erase - operacje logiczne na zbiorach',
                'Rejestracja (join) - dolaczenie tabeli atrybutow na podstawie wspolnego klucza',
                'Statystyki atrybutow - suma, srednia, maksimum wg pola; np. liczba ludzi na km2',
                'Analiza sieciowa - najkrotsza trasa, obszar obslugi, problem komiwojazera',
                'Analiza terenu - nachylenia, ekspozycja, widocznosci, profile terenu'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Przyklad 1: bufor 500 m od osadnicy' }
            @{ Typ = 'Kod'; Linie = @(
                '        . . . . . . . . . . . . . . . . . . .~',
                '    . .                                     . .~',
                '  .                                           .~',
                ' .   X   X        X   X            O            .~',
                ' .   X                    X           O           .~',
                ' .         X   X                       O          .~',
                ' .                                  O    O        .~',
                ' .   O                                       .~',
                '  .            O                             .~',
                '  .                                           .~',
                '    . .                                     . .~',
                '        . . . . . . . . . . . . . . . . . . .~',
                '',
                '  X = punkt WEWNATRZ bufora (zachowany)    O = punkt POZA buforem~',
                '  Wynik: nowa warstwa bufor_500m + atrybut ilosc_punktow'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Przyklad 2: nakladanie drogi na las (overlay)' }
            @{ Typ = 'Kod'; Linie = @(
                '     warstwa DROGI              warstwa LASU~',
                '   ======        ======       /~~~~~~~~~~~~~~/~',
                '        ======            /~~~~  /~~~~~~  /~',
                '                    /~~  /  ~/~~/  /~~/  /~',
                '',
                '              nakladanie (overlay)~',
                '                     |~',
                '                     v~',
                '        +++++++++++++++++++++++++++++++++++++++++++++~',
                '        | drogi  /  lasy  =  KONFLIKT                |~',
                '        | obszar wymagajacy decyzji:                 |~',
                '        | zmiana przebiegu drogi lub wycinka lasu    |~',
                '        +++++++++++++++++++++++++++++++++++++++++++++'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Podstawowe analizy rastrowe' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Klasyfikacja (nadzorowana i nienadzorowana, np. k-means) - rozpoznawanie klas: las, pole, zabudowa na obrazie satelitarnym',
                'Regresja / analiza wielokrotnego prostego - zwiazek zmiennej (np. cena mieszkan) z odlegloscia od centrum',
                'Interpolacja (TIN, IDW, kriging) - estymacja wartosci w miejscach bez pomiaru',
                'Algebra rastrowa i analiza kosztow - trasy, przewidywanie powodzi, strefy buforowe terenu',
                'NDVI i inne wskazniki - ocena stanu roślinności z danych satelitarnych'
            ) }
        )
    }

    # ---------------------------------------------------------------- 12
    @{
        Tytul = 'IV. ZASTOSOWANIA GIS'
        Podtytul = 'Geografia i nie tylko - gdzie GIS zmienia sposob pracy'
        Kolor = 'Yellow'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Nauka i edukacja' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Geografia - atlasy cyfrowe, mapy tematyczne, analizy przestrzenne zjawisk',
                'Biologia i ekologia - rozmieszczenie gatunkow, siediska, ochrona przyrody',
                'Geologia i gornictwo - zloza, wady tektoniczne, ocena zagrożenia osuwiskami',
                'Historia i archeologia - rejestr stanowisk, rekonstrukcja krajobrazu historycznego',
                'Statystyka - GIS spoleczny, mapa gęstości zaludnienia, statystyki przestrzenne'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Gospodarka i zarzadzanie' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Planowanie przestrzenne - studium uwarunkowan, plany miejscowe, zagospodarowanie terenu',
                'Gospodarka nieruchomosciami - EGiB (ewidencja gruntow i budynkow), mapy ewidencyjne, mapy do celow planistycznych',
                'Transport - optymalizacja tras logistycznych, symulacja ruchu, planowanie obwodnic',
                'Budownictwo i utilities - lokalizacja inwestycji, sieci wodociagowe, gazowe, kanalizacyjne',
                'Energetyka - linie wysokiego napięcia, farmy wiatrowe i fotowoltaiczne, dystrybucja ciepla',
                'Leśnictwo i rolnictwo - monitoring upraw, planowanie gospodarki leśnej, ubezpieczenia',
                'Turystyka i rekreacja - mapy szlakow, analizy walorow, lokalizacja obiektow noclegowych'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Środowisko, zdrowie i bezpieczeństwo' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Ochrona środowiska - mapa emisji, monitoring jakości powietrza i wody, obszary Natura 2000',
                'Gospodarka wodna - zasięg powodzi, spływ powierzchniowy, ocena ryzyka powodziowego',
                'Służby ratunkowe - lokalizacja zdarzeń, wyznaczanie tras dojazdu hydropanii, strefy ewakuacji',
                'Epidemiologia i zdrowie - kartografia zachorowow, korelacja z czynnikami środowiskowymi',
                'Obronosnosc i monitoring - symulacje scenariuszy zagrożeń, zarzadzanie kryzysowe'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Biznes i uslugi cyfrowe' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Geomarketing (GIS-marketing) - wybór lokalizacji sklepu, stacji benzynowej, biura na podstawie gęstości ludności i ruchu',
                'Logistyka i zarzadzanie flotą - optymalizacja dostaw, śledzenie pojazdów',
                'Serwisy web - Google Maps, Mapy.cz, OpenStreetMap, interaktywne mapy na stronach urzędów',
                'Media i reklama - analiza zasięgu, geotargetowanie kampanii'
            ) }
            @{ Typ = 'Cytat'; Tekst = 'Wspolna cecha zastosowan: kazde z nich jest decyzja o tym, GDZIE cos zrobic - i GIS zamienia ja z intuicji na policzalna analize danych.' }
        )
    }

    # ---------------------------------------------------------------- 13
    @{
        Tytul = 'GIS, GPS, TELEDETEKCJA'
        Podtytul = 'Czesto mylone pojecia - czym sie roznia?'
        Kolor = 'Blue'
        Bloki = @(
            @{ Typ = 'Tekst'; Tekst = 'Te trzy pojecia sa ze soba powiazane, ale pelnia rozne role. Najprostsze skojarzenie: GPS mowi GDZIE jestem, teledetekcja mowi JAK WYGLADA ziemia, a GIS laczy jedno z drugim i odpowiada CO Z TEGO WYNIKA.' }
            @{ Typ = 'Tabela'
                Naglowki = @('Cecha', 'GIS (SIG)', 'GPS / GNSS', 'Teledetekcja')
                Wiersze = @(
                    @('Czym jest', 'systemem informacyjnym', 'systemem nawigacyjnym', 'metodą pozyskiwania danych'),
                    @('Podstawowe zadanie', 'analiza i wizualizacja danych', 'wyznaczenie pozycji', 'pomiar powierzchni z oddali'),
                    @('Dane wejsciowe', 'rastry, wektory, atrybuty', 'sygnał satelitarny', 'fale elektromagnetyczne / fale akustyczne'),
                    @('Wynik', 'mapa, raport, aplikacja', 'szerokość, długość, wysokość', 'obraz / wartość liczbowa'),
                    @('Sprzęt', 'komputer + oprogramowanie GIS', 'odbiornik GPS', 'satelita, samolot, dron, sensor'),
                    @('Rola geograficzna', 'analiza zjawisk przestrzennych', 'pomiar punktu w terenie', 'rozpoznawanie pokrycia terenu')
                )
            }
            @{ Typ = 'Naglowek'; Tekst = 'Polskie odpowiedniki' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'SIG - System Informacji Geograficznej (GIS)',
                'GPS / GNSS - Globalny System Pozycjonowania (wspomaganie: GLONASS, Galileo, BeiDou)',
                'Teledetekcja (RS) - rozpoznawanie zdalne',
                'Lotnictwo i satelity: Landsat (1972-), SPOT, Sentinel (Copernicus, od 2014), IKROS'
            ) }
        )
    }

    # ---------------------------------------------------------------- 14
    @{
        Tytul = 'V. GIS W POLSCE'
        Podtytul = 'Instytucje, rejestry i zrodla danych przestrzennych'
        Kolor = 'Cyan'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Instytucje zajmujace sie danymi przestrzennymi w Polsce' }
            @{ Typ = 'Tabela'
                Naglowki = @('Instytucja', 'Zakres dzialalnosci')
                Wiersze = @(
                    @('GUGiK', 'Geodezyjna Krajowa Administracja Wirtualna: Geoportal Krajowy, państwowy rejestr granic, ULDK, dane referencyjne'),
                    @('GDOŚ', 'mapa sozologiczna, mapy glebowe, mapa lasow i siedlisk'),
                    @('Instytut Geografii PAN', 'badania i atlasy, np. Polski Atlas Krainy'),
                    @('Instytut Geopolityki i Obronności / MON', 'dane o obronnosci i bezpieczenstwie (dostęp ograniczony)'),
                    @('ARMiR, Czerwonak', 'rejestr powierzchni gospodarstw rolnych (LPIS), warstwy tematyczne'),
                    @('Wojewódzkie Ośrodki Dokumentacji Geodezyjnej (WODG)', 'powiatowe i wojewódzkie zasoby geodezyjne'),
                    @('KGI (Krajowy Integrator Migrationski)', 'wspólna infrastruktura usług lokalizacyjnych i wymiany danych'),
                    @('GDOŚ / Lasy Państwowe', 'dane leśne, program ochrony lasu'),
                    @('Szkoły wyższe', 'ksiazki i publikacje, np. Koprowski, Kedzierski, Siwek (red.): Systemy Informacji Geograficznej')
                )
            }
            @{ Typ = 'Naglowek'; Tekst = 'Przydatne zrodla danych' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'geoportal.gov.pl - Geoportal Krajowy GUGiK (mapy, ortofotomapy, NMT, uslugi WMS/WFS)',
                'geoserwis.gov.pl - dane GDOŚ i mapa sozologiczna',
                'mapy.pl, mapy.cz - mapy turystyczne i warstwy tematyczne',
                'OpenStreetMap - globalna, otwarta baza danych wektorowych budowana przez spolecznosc',
                'Copernicus Sentinel / ESA - darmowe obrazy satelitarne do analiz (np. w Google Earth Engine)',
                'CORINE Land Cover - zunifikowane mapy pokrycia terenu Europy (CoRL)',
                'BDO i Centralna Ewidencja Emisyjnosci - dane o zrodłach emisji zanieczyszczen'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Dokumentacja geodezyjna i planistyczna jako GIS' }
            @{ Typ = 'Tekst'; Tekst = 'Praktyczny aspekt szkolny i zawodowy: wszystkie polskie decyzje planistyczne, budowlane i inwestycyjne sa przygotowywane na danych przestrzennych - studium uwarunkowan, warunki techniczne, mapy do celow planistycznych, ewidencja budynkow.' }
        )
    }

    # ---------------------------------------------------------------- 15
    @{
        Tytul = 'ZALETY I WADY GIS'
        Podtytul = 'Uczciwa ocena narzedzia'
        Kolor = 'Red'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Zalety' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Szybka i obiektywna analiza przestrzenna - powtarzalne wyniki zamiast szacunkow intuicyjnych',
                'Wizualizacja wielu zrodel danych na jednej mapie - zrozumienie zjawisk w przestrzeni',
                'Redukcja kosztow - optymalizacja lokalizacji, tras, zasobow',
                'Symulacja scenariuszy: co bedzie, jesli zmienimy granice, trase, warunki?',
                'Dostęp do ogromnych zbiorow danych (dane satelitarne, NMT) dla badaczy i uczniow',
                'Wspomaganie decyzji planistycznych i gospodarczych na podstawie faktow, nie wrazen',
                'Automatyzacja raportow, map i aplikacji, powtarzalnosc wynikow',
                'Wspolpraca miedzynarodowa i standaryzacja danych (INSPIRE, EPSG)'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Wady i ograniczenia' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Wysoki koszt: sprzet, licencje (np. ArcGIS), szkolenia i utrzymanie bazy danych',
                'Jakosc danych wejsciowych decyduje o jakosci wyniku: blad jest nieodwracalny i ukryty',
                'Aktualnosc danych - mapy i warstwy starzeja sie, wymagaja aktualizacji',
                'Zlozonosc - krzywa uczenia sie, trudna obsluga zaawansowanych funkcji',
                'Uzależnienie od formatow wlasciwych (Shapefile, formaty komercyjne) i od dostawcy danych',
                'Prywatnosc i ograniczenia dostepu do danych o mieszkancach, firmach, obiektach wrażliwych',
                'Ryzyko nadmiernego upraszczania - mapa pokazuje model rzeczywistosci, nie sama rzeczywistosc'
            ) }
            @{ Typ = 'Cytat'; Tekst = 'Garbage in, garbage out - smiec na wejsciu daje smiec na wyjsciu, tylko z kolorowa mapa.' }
        )
    }

    # ---------------------------------------------------------------- 16
    @{
        Tytul = 'PRZYSZLOSC GIS'
        Podtytul = 'Kierunki rozwoju'
        Kolor = 'Green'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Najwazniejsze trendy' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'WebGIS w przegladarce - caly GIS dziala w internecie, bez instalacji (Leaflet, MapLibre, uslugi REST)',
                'Chmura obliczeniowa (GIS Cloud) - obliczenia na serwerach, dostep z kazdego urzadzenia',
                'Dane 3D i LiDAR - chmury punktow, modele 3D miast (CityGML, BIM, digitalne blizniaki miast)',
                'Drony i teledetekcja wysokiej rozdzielczosci - mapy z centymetrowa dokladnoscia',
                'Sztuczna inteligencja i uczenie maszynowe - automatyczna klasyfikacja obrazow, rozpoznawanie obiektow, predykcja zmian uzytkowania terenu',
                'Dane 4D - informacja o zmianach w czasie (serie satelitarne, monitoring suszy, powodzi, urbanizacji)',
                'Dane otwarte i crowdsourcing - OpenStreetMap, API, wspoldzielenie danych obywatelskich',
                'Rozszerzona rzeczywistosc (AR) - nawigacja po danych GIS w terenie przez okulary lub telefon',
                'Systemy w czasie rzeczywistym - dane z czujnikow, monitoring ruchu, transportu, zagrozen'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Kompetencje przyszlego geografa' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Umiejetnosc czytania i oceny danych przestrzennych (w tym wykrywania bledow)',
                'Programowanie (Python, R) i automatyzacja analiz',
                'Znajomosc ukladow wspolrzednych i modeli danych przestrzennych',
                'Kompetencje kartograficzne i wizualizacja danych',
                'Krytyczne myslenie - umiejetnosc zapytania: czy ten wniosek naprawde wynika z danych?'
            ) }
        )
    }

    # ---------------------------------------------------------------- 17
    @{
        Tytul = 'QUIZ - SPRAWDZ SIE'
        Podtytul = 'Pytania 1-2 z 5'
        Kolor = 'Cyan'
        Bloki = @(
            @{ Typ = 'Quiz'
                Pytanie = 'Jaka jest podstawowa jednostka danych przestrzennych w modelu wektorowym?'
                Odpowiedzi = @('Kolor wypełnienia na mapie', 'Zbiór współrzędnych (x, y) definiujący położenie obiektu', 'Nazwa pliku z rozszerzeniem .shp')
                Poprawna = 1
                Wyjasnienie = 'Obiekt wektorowy to geometria (wspolrzedne) + tablica atrybutow; plik jest tylko kontenerem danych.'
            }
            @{ Typ = 'Quiz'
                Pytanie = 'Które dane lepiej sprawdzą się do analizy ciągłego zjawiska, np. temperatury powierzchni?'
                Odpowiedzi = @('Dane rastrowe (raster)', 'Dane wektorowe z liniami', 'Dane tekstowe z tabeli')
                Poprawna = 0
                Wyjasnienie = 'Zjawiska ciągłe (temperatura, wysokość, opad) naturalnie opisuje siatka wartości liczbowych w każdej komórce.'
            }
        )
    }

    # ---------------------------------------------------------------- 18
    @{
        Tytul = 'QUIZ - SPRAWDZ SIE'
        Podtytul = 'Pytania 3-5 z 5'
        Kolor = 'Cyan'
        Bloki = @(
            @{ Typ = 'Quiz'
                Pytanie = 'Który kod EPSG odpowiada układowi WGS 84 (szerokość / długość)?'
                Odpowiedzi = @('EPSG:2180', 'EPSG:4326', 'EPSG:1992')
                Poprawna = 1
                Wyjasnienie = 'EPSG:4326 = WGS 84 w stopniach; EPSG:2180 = Układ Gaussa-Krügera 1992 stosowany w Polsce; EPSG:1992 = PL-1992.'
            }
            @{ Typ = 'Quiz'
                Pytanie = 'Który standard UE dotyczy obowiązkowej infrastruktury danych przestrzennych?'
                Odpowiedzi = @('INSPIRE', 'ESRI', 'OGC Simple Features')
                Poprawna = 0
                Wyjasnienie = 'INSPIRE (Dyrektywa 2007/2/WE) ustala obowiązkowe zbiory danych przestrzennych w Unii Europejskiej.'
            }
            @{ Typ = 'Quiz'
                Pytanie = 'Które z poniższych jest skutkiem nakładania (overlay) dwóch warstw?'
                Odpowiedzi = @('Obszar wspólny i różnicowy obu warstw', 'Lista obiektów posortowana alfabetycznie', 'Zmiana układu odwzorowania mapy')
                Poprawna = 0
                Wyjasnienie = 'Overlay porównuje geometrie warstw i tworzy warstwę wynikową: przecięcie, sumę lub różnicę geometryczną.'
            }
        )
    }

    # ---------------------------------------------------------------- 19
    @{
        Tytul = 'PODSUMOWANIE'
        Podtytul = 'Najwazniejsze tezy prezentacji'
        Kolor = 'Yellow'
        Bloki = @(
            @{ Typ = 'Punkty'; Pozycje = @(
                'GIS to zintegrowany system informacyjny o obiekcie przestrzennym: sprzet, dane, oprogramowanie, metody i ludzie',
                'Dane przestrzenne dziela sie na wektorowe (obiekty) i rastrowe (piksele); wybor zalezy od zadania analitycznego',
                'Dane musza byc opisane ukladem od wspolrzednych i odwzorowaniem, inaczej nie nakladaja sie na mape',
                'Metadane gwarantuja wiarygodnosc i umozliwiaja ponowne wykorzystanie danych',
                'Najwieksza moc GIS: analiza przestrzenna (bufor, overlay, siec, teren, raster), ktora daje odpowiedz na pytanie GDZIE',
                'Zastosowania: od kartografii i planowania przestrzennego po ochrone srodowiska, transport, rolnictwo i sztuczna inteligencja',
                'Najwazniejsze ograniczenie to jakosc danych wejsciowych i interpretacja czlowieka - mapa jest modelem, nie rzeczywistoscia',
                'Przyszlosc: WebGIS, chmura, LiDAR i 3D, dane 4D, uczenie maszynowe i dane otwarte'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Kontekst wiedzy geograficznej' }
            @{ Typ = 'Tekst'; Tekst = 'System Informacji Geograficznej laczy trzy glowne dziedziny geografii: badanie zjawisk przestrzennych (geografia ogolna i regionalna), opis i prezentacje terenu (kartografia) oraz zbieranie i analize danych o powierzchni Ziemi (geografia fizyczna i teledetekcja). Dzieki GIS geografia stala sie nie tylko dyscyplina opisowa, lecz takze dziedziną wspierającą decyzje gospodarcze, planistyczne i srodowiskowe.' }
            @{ Typ = 'Cytat'; Tekst = 'Kazdy system GIS jest tak dobry, jak najslabsze dane i najslabsza interpretacja, ktora zostala z niego wyciagnieta.' }
        )
    }

    # ---------------------------------------------------------------- 20
    @{
        Tytul = 'BIBLIOGRAFIA I ZRODLA'
        Podtytul = 'Materialy do powtorzenia i dalszego czytania'
        Kolor = 'Gray'
        Bloki = @(
            @{ Typ = 'Naglowek'; Tekst = 'Ksiazki i publikacje' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'Koprowski A., Kędzierski B., Siwek K. (red.): Systemy Informacji Geograficznej, Wydawnictwo PAN, Instytut Geografii Przestrzennej, Warszawa',
                'Konečný G., Klepešta P., Výborný M.: Geoinformatika - prostota i moc, Open Source Press, Warszawa',
                'Długoszewski B.: Systemy Informacji Geograficznej, PKN Geomatics, Warszawa',
                'Longley P., Goodchild M., Maguire D., Ramachandran S.: GIS and Cartographic Modeling, Wiley, 2015',
                'Bolstad P.: Fundamentals of Geographic Information Systems, 2nd ed., Oxford University Press',
                'Biebler P. (red.): Systemy Informacji Geograficznej, Wolters Kluwer, Warszawa',
                'Nowak M., Olejnik A. (red.): GIS w praktyce - studia przypadków'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Zrodla internetowe i dokumenty' }
            @{ Typ = 'Punkty'; Pozycje = @(
                'geoportal.gov.pl - Geoportal Krajowy GUGiK',
                'geoserwis.gov.pl - geoserwis GDOŚ',
                'inspire.ec.europa.eu - dokumentacja dyrektywy INSPIRE',
                'ogc.org - standardy OGC (WMS, WFS, WMTS)',
                'epsg.org - katalog układow współrzędnych',
                'qgis.org - dokumentacja QGIS; grass.osgeo.org; saga-gis.sourceforge.io',
                'sentinel.esa.int - dane programu Copernicus',
                'copernicus.gov.pl - polskie dane satelitarne'
            ) }
            @{ Typ = 'Naglowek'; Tekst = 'Wskazówka' }
            @{ Typ = 'Tekst'; Tekst = 'Najlepszym sposobem nauki GIS jest samodzielne wykonanie malej analizy w darmowym QGIS: zaimportuj mape Polski z geoportalu.gov.pl, wykonaj bufor 500 m od autostrad i policz liczbe mieszkancow w zasiegu. To 30 minut pracy i wiecej nauki niz czytanie 300 stron.' }
        )
    }
)
