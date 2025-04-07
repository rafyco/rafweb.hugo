---
title: "GeForce now dla developerów"
subtitle: "Codespace - czyli programowanie w chmurze"
date: 2025-05-05T06:00:00+02:00
draft: true

tags: ["programowanie", "chmura", "github", "codespaces", "ide"]
categories: ["it"]

featuredImage: "/posts/codespaces/featured-image.jpg"
featuredImagePreview: "/posts/codespaces/featured-image.jpg"
---
Ach jak dobrze czasem poprogramować. Choć to tylko praca, dla wielu z nas programowanie jest także fajną odskocznią od
codziennych zmartwień. Ćwiczy nasz umysł, pomaga uporządkować myśli, rozwiązuje realne problemy, ale przede wszystkim
daje niesamowitą frajdę. Najczęściej, pracując nad projektem, musimy przygotować sobie środowisko, zainstalować odpowiednie
kompilatory i przygotować nasz sprzęt do pracy. A może by tak mieć to wszystko, ale na zdalnym serwerze?

<!--more-->

## tl;dr

## Skąd taka potrzeba?

Zazwyczaj pracując i pisząc różne projekty, korzystam z kilku urządzeń. Komputer do pracy, komputer prywatny czy smartfon,
każdy z nich ma różne zastosowanie i korzystam z niego w innych okolicznościach. Do większości z serwisów, których używam,
mam dostęp w nich wszystkich, przez dedykowane aplikacje, lub bezpośrednio z przeglądarki.

### Inni mają lepiej...

Rozwój narzędzi takich jak [Google docs](https://docs.google.com/) spowodował, że nawet do dokumentów czy prezentacji,
mamy dostęp praktycznie z każdego miejsca, a przy tym możemy kontynuować pracę w każdej chwili na każdym urządzeniu.
I nieważne czy to leciwy komputer, stary tablet, czy niewielki ekran smartfona. Po prostu wyłączamy przeglądarkę
i uruchamiamy ją na kolejnym urządzeniu.

Idea oprogramowania chmurowego wdarła się w nasze życie tak mocno, że powstały także dedykowane serwisy do grania w gry
komputerowe (np.: [GeForce Now](https://www.nvidia.com/pl-pl/geforce-now/) lub nieistniejąca już
[Stadia](https://stadia.google.com/gg/)). Rozgrywka odbywa się na zdalnym urządzeniu, do którego dostęp mamy praktycznie
z każdego miejsca. Oczywiście w przypadku czegoś tak skomplikowanego jak gra komputerowa, szybko zmieniająca obraz
wyświetlany na ekranie, potrzebny jest szybki i stabilny internet, to i tak jest to alternatywa, gdy nie chcemy
inwestować w coraz mocniejsze urządzenie, lub po prostu mamy ochotę pograć trochę na swoim smartfonie w coś
ambitniejszego.

{{< figure src="/posts/codespaces/img/geforce.png" title="To może pograjmy w Wiedźmina na moim leciwym komputerze" >}}

Pewnie znaleźlibyśmy więcej przykładów narzędzi dla księgowych, hydraulików, czy fryzjerów, których z racji na swój zawód
nie znam, ale które również umożliwiają pracę z chmury. Skupię się natomiast na jednym z takich narzędzi dedykowanym
programistom.

### Programiści nie gęsi, czy szewc bez butów chodzi?

Skupię się dzisiaj na narzędziu dostępnym dla użytkowników Githuba, ponieważ jest to jedna z najpopularniejszych platform
do zarządzania kodem. Większość swoich projektów wykonuje właśnie tutaj, dlatego to oprogramowanie jest mi najbardziej
znane.

Warto wspomnieć, że w usługę jest wbudowany edytor, który w razie potrzeby, czy szybkiej poprawki, umożliwia wprowadzenie
zmian w kodzie. W nagłych przypadkach jest to wystarczające i może nam uratować życie (pod warunkiem, że mamy zautomatyzowany
deployment), jednak ciężko w ten sposób zaimplementować bardziej skomplikowaną funkcjonalność.

{{< figure src="/posts/codespaces/img/github-editor.png" title="Edytor wbudowany w github jest prosty, ale spełnia swoje zadanie." >}}

We wbudowanym edytorze, brakuje możliwości edycji kilku plików naraz, uruchomienia programu czy też użycia narzędzi do 
sprawdzenia kodu. Trudno także kontynuować pracę, rozpoczętą w innym miejscu, bez zapisania pliku w commicie. Słowem
przydałoby się narzędzie z prawdziwego zdarzenia.

Idąc naprzeciw użytkownikom, Github przygotować narzędzie o nazwie Codespaces. Jest to serwis, który umożliwia tworzenie
wirtualnych instancji edytorów oprogramowania wraz z własną przestrzenią roboczą w postacji dostępu do terminala. Dzięki
temu można przetestować wybraną aplikację, uruchomić lintery, a nawet uruchomić ją w przeglądarce. Dzięki możliwości
przekierowywania portów do urządzenia, na którym pracujemy, możliwe jest także uruchamianie bardziej skomplikowanych
aplikacji takich jak serwery, czy aplikacje okienkowe (przykład [tutaj](https://dev.to/konmaz/gui-in-github-codespaces-jl0?utm_source=rafycopl)).


{{< figure src="/posts/codespaces/img/ide.png" title="Wygląd IDE przypomina Visual Code Studio, ale to dobrze, bo nie trzeba się od nowa uczyć obsługi" >}}

## Uruchomienie

Przyjrzyjmy się codespace od strony 

### Proste uruchomienie

### Konfiguracja środowiska w repo

### Podpięcie docker'a

## Praca na urządzeniach

## Alternatywa self-hosted

## Bibliografia

1. [https://github.com/codespaces](https://github.com/codespaces) - Strona głowna Github codespace
2. [https://docs.github.com/en/codespaces](https://docs.github.com/en/codespaces) - Dokumentacja projektu
