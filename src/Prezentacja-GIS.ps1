<#
.SYNOPSIS
    Prezentacja CLI: System Informacji Geograficznej (SIG / GIS).

.DESCRIPTION
    Interaktywna prezentacja w konsoli (CLI) o Systemie Informacji Geograficznej.
    Nawigacja: spacja / strzalki / n / p, l = lista slajdow, h = pomoc, q = wyjscie.

.EXAMPLE
    .\Prezentacja-GIS.ps1
    .\Prezentacja-GIS.ps1 -Start 5 -Ascii
    .\Prezentacja-GIS.ps1 -Auto -OutFile .\GIS-wydruk.txt
#>
[CmdletBinding()]
param(
    [int]$Start = 1,
    [switch]$Ascii,
    [switch]$Auto,
    [switch]$NoBox,
    [string]$OutFile,
    [string]$Trec = ''
)

$ErrorActionPreference = 'Stop'

# --------------------------------------------------------------------------
# Kodowanie i znak sterujacy wyswietlaczem
# --------------------------------------------------------------------------
try { [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding $false } catch { }
$script:Glyph = @{ h = [char]0x2500; v = [char]0x2502; tl = [char]0x2554; tr = [char]0x2557; bl = [char]0x255A; br = [char]0x255D; cross = [char]0x254C; dot = [char]0x00B7; bullet = [char]0x2022; arr = [char]0x2192; full = [char]0x2588; empty = [char]0x2591; mark = [char]0x25BA }
if ($Ascii) {
    $script:Glyph = @{ h = '-'; v = '|'; tl = '+'; tr = '+'; bl = '+'; br = '+'; cross = '+'; dot = '.'; bullet = '-'; arr = '->'; full = '#'; empty = '.'; mark = '>' }
}
# Rzut do [string] - inaczej mnozenie "znak * int" to arytmetyka (blad: char nie ma operatora *).
# Ten sam problem dotyczy wszystkich znakow ramki uzytych w mnozeniu.
foreach ($klucz in @($script:Glyph.Keys)) { $script:Glyph[$klucz] = [string]$script:Glyph[$klucz] }

# slownik case-sensitive (haszlet PowerShell bylby niewrazliwy na wielkosc liter!)
$script:Polish = New-Object 'System.Collections.Generic.Dictionary[char,string]'
# kazda para to klucz-znak-polski + zamiennik ASCII
$pary = @(
    ([char]0x0105 + 'a'), ([char]0x0107 + 'c'), ([char]0x0119 + 'e'), ([char]0x0142 + 'l'), ([char]0x0144 + 'n')
    ([char]0x00F3 + 'o'), ([char]0x015B + 's'), ([char]0x017A + 'z'), ([char]0x017C + 'z')
    ([char]0x0104 + 'A'), ([char]0x0106 + 'C'), ([char]0x0118 + 'E'), ([char]0x0141 + 'L'), ([char]0x0143 + 'N')
    ([char]0x00D3 + 'O'), ([char]0x015A + 'S'), ([char]0x0179 + 'Z'), ([char]0x017B + 'Z')
)
foreach ($p in $pary) {
    $script:Polish.Add($p[0], $p[1])
}

function Convert-ToSafeText {
    param([string]$Text)
    if ($null -eq $Text) { return '' }
    if (-not $Ascii) { return $Text }
    $sb = New-Object System.Text.StringBuilder
    foreach ($ch in $Text.ToCharArray()) {
        $code = [int][char]$ch
        if ($code -lt 128) { [void]$sb.Append($ch); continue }
        if ($script:Polish.ContainsKey($ch)) { [void]$sb.Append($script:Polish[$ch]); continue }
        if ($code -ge 0x0100 -and $code -le 0x017F) { [void]$sb.Append('?'); continue }
        switch ($code) {
            0x2013 { [void]$sb.Append('-') }
            0x2014 { [void]$sb.Append('-') }
            0x00A0 { [void]$sb.Append(' ') }
            0x2022 { [void]$sb.Append('-') }
            0x00B0 { [void]$sb.Append(' deg') }
            0x03C6 { [void]$sb.Append('fi') }   # phi
            0x03BB { [void]$sb.Append('lambda') } # lambda
            0x222A { [void]$sb.Append('U') }     # suma zbiorow
            0x2229 { [void]$sb.Append('^') }     # iloczyn / przeciecie
            0x2260 { [void]$sb.Append('!=') }
            0x2264 { [void]$sb.Append('<=') }
            0x2265 { [void]$sb.Append('>=') }
            0x00D7 { [void]$sb.Append('x') }
            0x2248 { [void]$sb.Append('~') }
            0x2192 { [void]$sb.Append('->') }
            0x2191 { [void]$sb.Append('^') }
            0x2193 { [void]$sb.Append('v') }
            0x25B6 { [void]$sb.Append('>') }
            0x2588 { [void]$sb.Append('#') }
            0x2591 { [void]$sb.Append('.') }
            0x2554 { [void]$sb.Append('+') }
            0x2557 { [void]$sb.Append('+') }
            0x255A { [void]$sb.Append('+') }
            0x255D { [void]$sb.Append('+') }
            0x2500 { [void]$sb.Append('-') }
            0x2502 { [void]$sb.Append('|') }
            0x254C { [void]$sb.Append('+') }
            default { [void]$sb.Append('?') }
        }
    }
    $sb.ToString()
}

function Write-Line {
    param([string]$Text = '', [string]$Color = $null)
    $safe = Convert-ToSafeText $Text
    if ($Color) { Write-Host $safe -ForegroundColor $Color } else { Write-Host $safe }
}

function Clear-Screen {
    # W trybie -Auto (przekierowanie do pliku / potoku) nie czyscimy ekranu,
    # bo Clear-Host kasuje linie z bufora i wynik wychodzi urwany.
    if ($Auto) { return }
    try { Clear-Host } catch { Write-Host "`n" }
}

# --------------------------------------------------------------------------
# Pomocnicze: szerokosc, zawijanie
# --------------------------------------------------------------------------
function Get-TermWidth {
    $w = 100
    try { $w = $Host.UI.RawUI.WindowSize.Width } catch { }
    if ($w -lt 46) { $w = 46 }
    if ($w -gt 100) { $w = 100 }
    return $w
}

function Get-WrappedLines {
    param([string[]]$Text, [int]$Width)
    $out = New-Object System.Collections.Generic.List[string]
    foreach ($paragraph in $Text) {
        $p = [string]$paragraph
        if ($p.Trim().Length -eq 0) { $out.Add(''); continue }
        foreach ($hard in ($p -split "`n")) {
            $line = ''
            foreach ($word in ($hard -split '\s+')) {
                if ($word -eq '') { continue }
                if ($line.Length -eq 0) { $line = $word }
                elseif (($line.Length + 1 + $word.Length) -le $Width) { $line = "$line $word" }
                else {
                    # slowo nie miesci sie w zrodle - domykamy biezaca linie
                    $out.Add($line)
                    # slowo dluzsze niz cala szerokosc: tniemy je na kawalki
                    while ($word.Length -gt $Width) {
                        $out.Add($word.Substring(0, $Width))
                        $word = $word.Substring($Width)
                    }
                    $line = $word
                }
            }
            if ($line.Length -gt 0) { $out.Add($line) }
        }
    }
    return $out.ToArray()
}

# --------------------------------------------------------------------------
# Renderowanie blokow tresci
# --------------------------------------------------------------------------
function Show-SlideBody {
    param($Slide, [int]$Inner, [switch]$Framed)

    $g = $script:Glyph
    $color = $Slide.Kolor
    if (-not $color) { $color = 'Gray' }
    $indent = '  '

    function Out-Line {
        param([string]$Text, [string]$C = $null)
        if ($Framed) {
            $pad = $Inner - $Text.Length
            if ($pad -lt 0) { $pad = 0 }
            Write-Line ($g.v + ' ' + $Text + (' ' * $pad) + ' ' + $g.v) $C
        } else {
            Write-Line ('  ' + $Text) $C
        }
    }

    $i = 0
    foreach ($blok in $Slide.Bloki) {
        $typ = $blok.Typ
        if ($i -gt 0) { Out-Line '' }
        $i++

        switch ($typ) {

            'Naglowek' {
                Out-Line ([string]$blok.Tekst) 'White'
            }

            'Tekst' {
                foreach ($l in (Get-WrappedLines -Text @($blok.Tekst) -Width $Inner)) { Out-Line $l $color }
            }

            'Punkty' {
                $n = 0
                foreach ($p in $blok.Pozycje) {
                    $n++
                    $pref = "$indent$($g.bullet) "
                    $lines = Get-WrappedLines -Text @([string]$p) -Width ($Inner - $pref.Length)
                    $k = 0
                    foreach ($l in $lines) {
                        if ($k -eq 0) { Out-Line ($pref + $l) $color } else { Out-Line ((' ' * $pref.Length) + $l) $color }
                        $k++
                    }
                }
            }

            'Kod' {
                foreach ($l in @($blok.Linie)) {
                    # znak '~' na koncu linii to znacznik "koniec wiersza w danych" -
                    # usuwamy tylko ten ostatni, bo wewnatryszy '~' bywa w rysunkach ASCII
                    $t = [string]$l
                    if ($t.EndsWith('~')) { $t = $t.Substring(0, $t.Length - 1) }
                    Out-Line $t 'DarkCyan'
                }
            }

            'Cytat' {
                $lines = Get-WrappedLines -Text @([string]$blok.Tekst) -Width ($Inner - 4)
                $k = 0
                foreach ($l in $lines) {
                    $c = 'Gray'
                    if ($k -eq 0) { $c = 'Yellow' }
                    Out-Line ('  | ' + $l) $c
                    $k++
                }
            }

            'Tabela' {
                Show-Table -Naglowki $blok.Naglowki -Wiersze $blok.Wiersze -Inner $Inner -Kolor $color -Indent $indent
            }

            'Quiz' {
                Invoke-Quiz -Blok $blok -Inner $Inner -Kolor $color
            }

            default {
                foreach ($l in (Get-WrappedLines -Text @([string]$blok.Tekst) -Width $Inner)) { Out-Line $l }
            }
        }
    }
}

function Show-Table {
    param([string[]]$Naglowki, [object[]]$Wiersze, [int]$Inner, [string]$Kolor, [string]$Indent = '  ')

    $g = $script:Glyph
    $cols = $Naglowki.Count
    $natural = New-Object int[] $cols
    for ($c = 0; $c -lt $cols; $c++) {
        $max = ([string]$Naglowki[$c]).Length
        foreach ($r in $Wiersze) {
            $len = ([string]$r[$c]).Length
            if ($len -gt $max) { $max = $len }
        }
        $natural[$c] = $max
    }
    $sum = ($natural | Measure-Object -Sum).Sum
    $avail = $Inner - ($cols + 1)
    $widths = New-Object int[] $cols
    for ($c = 0; $c -lt $cols; $c++) {
        $w = [int][math]::Floor($avail * $natural[$c] / [double]$sum)
        if ($w -lt 7) { $w = 7 }
        $widths[$c] = $w
    }
    $over = ($widths | Measure-Object -Sum).Sum - $avail
    while ($over -gt 0) {
        $big = 0
        for ($c = 0; $c -lt $cols; $c++) { if ($widths[$c] -gt $big) { $big = $widths[$c] } }
        if ($big -le 7) { break }
        $widths[$big - 1]--; $over--
    }
    while ((($widths | Measure-Object -Sum).Sum) -lt $avail) { $widths[$cols - 1]++ }

    function Border {
        param([string]$L, [string]$M, [string]$R)
        $parts = @()
        # kazda kolumna zajmuje: 1 spacja + szerokosc + 1 spacja
        foreach ($w in $widths) { $parts += ($g.h * ($w + 2)) }
        return ($Indent + $L + ($parts -join $M) + $R)
    }
    function Cell {
        # komorka zwraca TYLKO tresc z odstepem - piony dodaje wywolujacy
        param([string]$Text, [int]$W)
        return (' ' + ([string]$Text).PadRight($W) + ' ')
    }

    Write-Line (Border $g.tl $g.cross $g.tr) $Kolor
    $head = $Indent + $g.v
    for ($c = 0; $c -lt $cols; $c++) { $head = $head + (Cell $Naglowki[$c] $widths[$c]) + $g.v }
    Write-Line $head 'White'
    Write-Line (Border $g.bl $g.cross $g.br) $Kolor

    foreach ($r in $Wiersze) {
        # Kazda komorka to lista linii. Uzywamy List[string] + jawnego ToArray(),
        # bo zwykly string z pojedynczym elementem zostalby "spłaszczony"
        # i $cells[c][y] zwracaloby znak zamiast linii.
        $cells = New-Object System.Collections.Generic.List[object]
        for ($c = 0; $c -lt $cols; $c++) {
            $linie = @(Get-WrappedLines -Text @([string]$r[$c]) -Width $widths[$c])
            $cells.Add([object[]]$linie)
        }
        $height = 1
        foreach ($cc in $cells) { if ($cc.Count -gt $height) { $height = $cc.Count } }
        for ($y = 0; $y -lt $height; $y++) {
            # budujemy linie przez konkatenacje w liscie - "+=" na stringu gubi
            # pierwszy pion, gdy tresc komorki jest pusta
            $line = $Indent + $g.v
            for ($c = 0; $c -lt $cols; $c++) {
                $txt = ''
                if ($y -lt $cells[$c].Count) { $txt = [string]$cells[$c][$y] }
                $line = $line + (Cell $txt $widths[$c]) + $g.v
            }
            Write-Line $line $Kolor
        }
    }
    Write-Line (Border $g.bl $g.cross $g.br) $Kolor
}

# --------------------------------------------------------------------------
# Quiz
# --------------------------------------------------------------------------
$script:Wynik = @{ Dobre = 0; Razem = 0 }

function Invoke-Quiz {
    param($Blok, [int]$Inner, [string]$Kolor)
    $g = $script:Glyph
    Write-Line ('  ' + [string]$blok.Pytanie) 'White'
    Write-Line ''

    $litery = @('A', 'B', 'C', 'D')
    if ($Auto) {
        for ($i = 0; $i -lt $Blok.Odpowiedzi.Count; $i++) {
            Write-Line ("    $($litery[$i])) $($Blok.Odpowiedzi[$i])") 'Gray'
        }
        $script:Wynik.Razem++
        $prawidlowa = [int]$Blok.Poprawna
        if ($prawidlowa -ge 0 -and $prawidlowa -lt $Blok.Odpowiedzi.Count) { $script:Wynik.Dobre++ }
        Write-Line ''
        Write-Line ("    Poprawna odpowiedz: $($litery[$prawidlowa]) - $($Blok.Odpowiedzi[$prawidlowa])") 'Green'
        Write-Line ("    Wyjasnienie: $($blok.Wyjasnienie)") 'DarkYellow'
        return
    }

    $idx = 0
    $wybrano = -1
    while ($wybrano -lt 0) {
        Write-Line ("  Wybierz odpowiedz (strzalki gora/dol, Enter = zatwierdz, p = pomin):") 'DarkGray'
        for ($i = 0; $i -lt $Blok.Odpowiedzi.Count; $i++) {
            $marker = ' '
            $c = 'Gray'
            if ($i -eq $idx) { $marker = "$($g.mark)"; $c = 'White' }
            $pad = ' ' * ($Inner - 6 - ([string]$Blok.Odpowiedzi[$i]).Length)
            if ($pad.Length -lt 1) { $pad = ' ' }
            Write-Line ("    $($litery[$i]) [$marker]$pad$($Blok.Odpowiedzi[$i])") $c
        }
        $k = Read-Key
        switch ($k) {
            'Up' { $idx = ($idx - 1 + $Blok.Odpowiedzi.Count) % $Blok.Odpowiedzi.Count }
            'Down' { $idx = ($idx + 1) % $Blok.Odpowiedzi.Count }
            'Enter' { $wybrano = $idx }
            'Prev' { $wybrano = -2 }
            'Next' { $wybrano = -3 }
            'Quit' { $script:Wynik.Razem++; return }
            'PrevSlide' { $wybrano = -4 }
            'NextSlide' { $wybrano = -5 }
        }
    }
    if ($wybrano -le -2) { return }

    $script:Wynik.Razem++
    $prawidlowa = [int]$Blok.Poprawna
    Write-Line ''
    if ($wybrano -eq $prawidlowa) {
        $script:Wynik.Dobre++
        Write-Line ("    $($g.mark) Dobrze! $($Blok.Odpowiedzi[$prawidlowa])") 'Green'
    } else {
        Write-Line ("    X Zle. Poprawna odpowiedz: $($litery[$prawidlowa]) $($Blok.Odpowiedzi[$prawidlowa])") 'Red'
    }
    Write-Line ("    $($blok.Wyjasnienie)") 'DarkYellow'
    Write-Line ''
    Write-Line '    [Enter] = nastepny slajd' 'DarkGray'
    do { $k = Read-Key } while ($k -notin @('Enter', 'Next', 'PrevSlide', 'NextSlide'))
}

# --------------------------------------------------------------------------
# Klawiatura
# --------------------------------------------------------------------------
function Read-Key {
    try {
        $r = [Console]::ReadKey($true)
        switch ($r.Key) {
            'Right' { return 'Next' }
            'Down' { return 'Down' }
            'Left' { return 'Prev' }
            'Up' { return 'Up' }
            'PageDown' { return 'Next' }
            'PageUp' { return 'Prev' }
            'Home' { return 'Home' }
            'End' { return 'End' }
            'Escape' { return 'Quit' }
            'Backspace' { return 'Prev' }
            'Spacebar' { return 'Next' }
            'Enter' { return 'Enter' }
        }
        switch ($r.KeyChar.ToString().ToLower()) {
            'n' { return 'Next' }
            'k' { return 'Next' }
            'p' { return 'Prev' }
            'b' { return 'Prev' }
            'l' { return 'List' }
            'h' { return 'Help' }
            '?' { return 'Help' }
            'q' { return 'Quit' }
            'c' { return 'Quit' }
        }
    } catch {
        $t = (Read-Host 'Wpisz Enter')
        if ($t -eq '') { return 'Next' }
    }
    return ''
}

function Wait-Enter {
    if ($Auto) { return }
    Write-Line ''
    Write-Line '  [Enter] = dalej, q = wyjscie' 'DarkGray'
    do { $k = Read-Key } while ($k -notin @('Enter', 'Next', 'Quit', 'Prev', 'NextSlide', 'PrevSlide'))
}

# --------------------------------------------------------------------------
# Slajd
# --------------------------------------------------------------------------
function Show-Slide {
    param([int]$Index)

    $g = $script:Glyph
    $all = $script:Slajdy.Count
    $slide = $script:Slajdy[$Index - 1]
    $color = $slide.Kolor; if (-not $color) { $color = 'Gray' }

    Clear-Screen
    $W = Get-TermWidth
    if ($NoBox) {
        Write-Line ''
        Write-Line ('== ' + $slide.Tytul + ' ==') 'White'
        Write-Line ('   ' + $slide.Podtytul) 'DarkGray'
        Show-SlideBody -Slide $slide -Inner ($W - 4)
        return
    }

    $Inner = $W - 4
    $tytul = ' ' + $slide.Tytul + ' '
    if ($tytul.Length -gt ($Inner - 1)) { $tytul = ' ' + $slide.Tytul.Substring(0, [math]::Max(1, $Inner - 3)) + ' ' }
    $top = $g.tl + $g.h + $tytul + ($g.h * ($W - 3 - $tytul.Length)) + $g.tr

    Write-Line ''
    Write-Line $top $color
    $pod = ' ' + $slide.Podtytul
    if ($pod.Length -gt ($Inner - 1)) { $pod = $pod.Substring(0, $Inner) }
    Write-Line ($g.v + $pod.PadRight($W - 2) + $g.v) 'DarkGray'
    Write-Line ($g.bl + ($g.h * ($W - 2)) + $g.br) $color

    Show-SlideBody -Slide $slide -Inner $Inner -Framed

    Write-Line ($g.tl + ($g.h * ($W - 2)) + $g.tr) $color

    # pasek postepu + skrotow
    $pct = [int](100 * $Index / $all)
    $szer = 24
    $filled = [int][math]::Round($szer * $Index / $all)
    $bar = ($g.full * $filled) + ($g.empty * ($szer - $filled))
    Write-Line ''
    Write-Line ("  Slajd $Index/$all  [$bar] $pct%") $color
    if ($script:Wynik.Razem -gt 0) {
        Write-Line ("  Quiz: $($script:Wynik.Dobre)/$($script:Wynik.Razem) poprawnych") 'DarkYellow'
    }
    Write-Line '  Nawigacja: spacja / -> nastepna | <- wstecz | l lista | h pomoc | q wyjscie' 'DarkGray'
}

# --------------------------------------------------------------------------
# Ekran pomocy i lista slajdow
# --------------------------------------------------------------------------
function Show-Help {
    $g = $script:Glyph
    $W = Get-TermWidth
    Clear-Screen
    Write-Line ''
    Write-Line ("$($g.tl)" + ($g.h * ($W - 2)) + "$($g.tr)") 'Cyan'
    function H { param([string]$T) ; Write-Line ($g.v + ' ' + $T.PadRight($W - 4) + ' ' + $g.v) }
    H 'STEROWANIE' 'White'
    H ('  ' + $g.arr + ' / spacja / n / PageDown ....... nastepny slajd')
    H ('  ' + $g.arr + ' / p / Backspace / PageUp ..... poprzedni slajd')
    H ('  Home / End ........................... pierwszy / ostatni slajd')
    H ('  l ..................................... lista slajdow (wybierz numer)')
    H ('  h / ? ................................. ten ekran pomocy')
    H ('  q / Esc ............................... wyjscie z prezentacji')
    Write-Line ''
    H 'TRYBY URUCHOMIENIA' 'White'
    H '  .\Prezentacja-GIS.ps1 -Start 5 ......... od slajdu 5'
    H '  .\Prezentacja-GIS.ps1 -Auto ............. przewijanie bez klawiatury'
    H '  .\Prezentacja-GIS.ps1 -Ascii ............ bez polskich znakow diakrytycznych'
    H '  .\Prezentacja-GIS.ps1 -NoBox ............ bez ramki (szersza zawodnosc tekstu)'
    H '  .\Prezentacja-GIS.ps1 -OutFile plik.txt  zapis do pliku tekstowego'
    Write-Line ''
    H 'WSKAZOWOWKA' 'White'
    H '  Jesli polskie znaki sa zle, uruchom skrypt przez Start-GIS.cmd,'
    H '  ktory ustawia kodowanie UTF-8 (chcp 65001) dla konsoli.'
    Write-Line ("$($g.bl)" + ($g.h * ($W - 2)) + "$($g.br)") 'Cyan'
    Wait-Enter
}

function Show-SlideList {
    $g = $script:Glyph
    Clear-Screen
    Write-Line ''
    Write-Line ('  Spis slajdow (' + $script:Slajdy.Count + '):') 'White'
    foreach ($s in $script:Slajdy) {
        $nr = [array]::IndexOf($script:Slajdy, $s) + 1
        $mk = ' '
        if ($nr -eq $script:Aktualny) { $mk = "$($g.mark)" }
        Write-Line ("  [$mk] $nr. $($s.Tytul)") 'Gray'
    }
    Write-Line ''
    Write-Line '  Wpisz numer slajdu i Enter (puste = wroc, q = wyjscie):' 'DarkGray'
    $t = Read-Host '  '
    $t = ([string]$t).Trim()
    if ($t -eq '' ) { return $script:Aktualny }
    $n = 0
    if ([int]::TryParse($t, [ref]$n) -and $n -ge 1 -and $n -le $script:Slajdy.Count) { return $n }
    Write-Host '  Nieprawidlowy numer slajdu.' -ForegroundColor Red
    Wait-Enter
    return $script:Aktualny
}

# --------------------------------------------------------------------------
# Start
# --------------------------------------------------------------------------
# $PSScriptRoot nie jest zawsze dostepny w bloku param - wyznaczamy sciezke recznie
$katalog = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $Trec) { $Trec = Join-Path $katalog 'Trec-GIS.ps1' }
if (-not (Test-Path -LiteralPath $Trec)) {
    Write-Host "Nie znaleziono pliku tresci: $Trec" -ForegroundColor Red
    exit 1
}
. $Trec

if ($script:Slajdy.Count -eq 0) {
    Write-Host 'Plik tresci nie zawiera zadnych slajdow.' -ForegroundColor Red
    exit 1
}

$script:Aktualny = $Start
if ($script:Aktualny -lt 1) { $script:Aktualny = 1 }
if ($script:Aktualny -gt $script:Slajdy.Count) { $script:Aktualny = $script:Slajdy.Count }

if ($OutFile) {
    $zapis = New-Object System.Collections.Generic.List[string]
    $zapis.Add(('=' * 78))
    $zapis.Add('  PREZENTACJA: SYSTEM INFORMACJI GEOGRAFICZNEJ (SIG / GIS)')
    $zapis.Add(('=' * 78))
    $zapis.Add('')
    foreach ($s in $script:Slajdy) {
        $zapis.Add(('-' * 78))
        $zapis.Add('SLAJD: ' + $s.Tytul)
        $zapis.Add('      ' + $s.Podtytul)
        $zapis.Add(('-' * 78))
        foreach ($blok in $s.Bloki) {
            switch ($blok.Typ) {
                'Naglowek' { $zapis.Add(''); $zapis.Add([string]$blok.Tekst) }
                'Tekst' { $zapis.Add([string]$blok.Tekst) }
                'Cytat' { $zapis.Add('  | ' + [string]$blok.Tekst) }
                'Punkty' { foreach ($p in $blok.Pozycje) { $zapis.Add('  - ' + $p) } }
                'Kod' { foreach ($l in $blok.Linie) { $zapis.Add('  ' + $l) } }
                'Tabela' {
                    foreach ($r in $blok.Wiersze) { $zapis.Add('  ' + (($r | ForEach-Object { [string]$_ }) -join ' | ')) }
                }
                'Quiz' {
                    $lit = @('A', 'B', 'C', 'D')
                    $zapis.Add('  PYTANIE: ' + $blok.Pytanie)
                    for ($i = 0; $i -lt $blok.Odpowiedzi.Count; $i++) { $zapis.Add("    $($lit[$i]) $($blok.Odpowiedzi[$i])") }
                    $zapis.Add("    Poprawna: $($lit[[int]$blok.Poprawna]) - $($blok.Wyjasnienie)")
                }
            }
            $zapis.Add('')
        }
    }
    $zapis.Add('=' * 78)
    $zapis | Set-Content -LiteralPath $OutFile -Encoding UTF8
    Write-Host "Zapisano wydruk prezentacji do: $OutFile" -ForegroundColor Green
    exit 0
}

if ($Auto) {
    foreach ($s in $script:Slajdy) { Show-Slide -Index ([array]::IndexOf($script:Slajdy, $s) + 1) }
    Write-Line ''
    exit 0
}

Write-Host ''
Write-Host '  Prezentacja: System Informacji Geograficznej (SIG / GIS)' -ForegroundColor Cyan
Write-Host '  Wcisnij Enter, aby rozpoczac.  h = pomoc, q = wyjscie.' -ForegroundColor DarkGray
Wait-Enter

while ($true) {
    Show-Slide -Index $script:Aktualny
    $k = Read-Key
    switch ($k) {
        'Next' { if ($script:Aktualny -lt $script:Slajdy.Count) { $script:Aktualny++ } }
        'Prev' { if ($script:Aktualny -gt 1) { $script:Aktualny-- } }
        'Home' { $script:Aktualny = 1 }
        'End' { $script:Aktualny = $script:Slajdy.Count }
        'List' { $script:Aktualny = Show-SlideList }
        'Help' { Show-Help }
        'Quit' { break }
    }
}

Write-Line ''
Write-Line '  Koniec prezentacji. Do zobaczenia!' -ForegroundColor Cyan
if ($script:Wynik.Razem -gt 0) {
    Write-Line ("  Wynik quizu: $($script:Wynik.Dobre)/$($script:Wynik.Razem)") -ForegroundColor Yellow
}
