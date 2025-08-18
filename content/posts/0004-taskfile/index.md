---
date: '2025-04-24T06:00:00+01:00'
draft: false 
title: 'Taskfile - Twój pomocnik przy budowaniu apki'
subtitle: 'Taskfile - instalacja i użycie'
aliases:
  - /posts/taskfile

categories: ["it"]
tags: ["taskfile", "narzędzia", "system budowania", "devops"]

toc:
  enable: true
  auto: true
  keepStatic: false
  
featuredImage: "/posts/taskfile/featured-image.png"
featuredImagePreview: "/posts/taskfile/featured-image.png"
---

Czasami, pracując nad różnymi projektami, zdarza się nam używać różnych technologii. Flutter, React, Python czy Java
mają różne systemy budowania, z których każdy charakteryzuje się własnym podejściem do problemu. Co więc zrobić,
jeśli chcemy mieć pewność, że nawet po dłuższym odpoczynku od technologii będziemy w stanie szybko zbudować i przetestować
nasz projekt.

<!--more-->

## 1. Dlaczego Taskfile?

Opisane wcześniej frameworki, czy języki mają naprawdę świetne sposoby na budowanie aplikacji. Najczęściej sprowadza się
to do korzystania z mniej lub bardziej skomplikowanego klienta, który umożliwia budowanie, testowanie, a nawet 
deployment projektu do chmury. To znaczy, nie jest żadnym problemem nauczenie się systemu budowania i tak robiłem przez
długi czas. Fajnie byłoby jednak mieć jednak jakiś zunifikowany sposób na otwieranie i zarządzanie pakietami.

### Może wystarczy jeden README.md {#why-readme}

Pierwszym moim podejściem na poradzenie sobie z zarządzaniem różnymi projektami było napisanie specjalnie do tego
przygotowanego pliku `REAMDE.md`. Pomimo dokumentowania, w jaki sposób otwieramy czy testujemy projekt, podejście takie
ma kilka zasadniczych braków. Umówmy się, komu chce się przechodzić przez kolejne kroki instrukcji, czytając które
z poleceń trzeba wykonać, aby uruchomić projekt i denerwować się kopiując kolejne polecenia do terminala, aby doczytać
potem, że nie były potrzebne w Twoim przypadku. Albo kto chce ryzykować, że przygotowanie projektu, ściągnięcie kolejnych
zależności będzie trwało dłużej niż to konieczne.

Ostatecznie dokumentowanie kodu i projektów jest niezbędne i sam nie wyobrażam sobie profesjonalnego programu bez udokumentowania
go odpowiednim plikiem. Szczególnie że fajnie wygląda on w projekcie np. na platformie github. W każdym razie uważam,
że dobra dokumentacja to ta, która zapisana jest w kodzie. Z tego powodu bardziej skomplikowane operacje wolę zapisać
w postaci pojedyńczych - ściśle określonych poleceń, które można łatwo wywołać. 

### To może skrypt w bashu? {#why-bash-script}

Co, gdyby polecenia zapisać w skrypcie bash? Teoretycznie można to zrobić, ale tutaj pojawia się kilka problemów. Skrypty
shellowe są co prawda zaprojektowane do automatyzowania poleceń powłoki, jednak ich uniwersalność jest tutaj zarówno 
zaletą, jak i wadą. Aby użyć ich w kontekście budowania aplikacji, trzeba się troszkę natrudzić. Można co prawda stworzyć
pętle do przetwarzania kolejnych poleceń, ale niestety wymaga to strasznie dużo dodatkowego kodu, który zaciemnia 
znaczenie tego, co chcemy osiągnąć. Dodanie dodatkowego polecenia do wypisywania dostępnych komend, czy napisanie prostego
helpa, to dodatkowe skomplikowanie kodu, które naprawdę nie jest w tym momencie potrzebne.

Wyobraźcie sobie w tym momencie jeszcze obsługę jakichś zależności. Koszmar!!! Można się co prawda ratować jakimś
template'm, ale moim zdaniem to gra nie warta świeczki. Tym bardziej że takie rozwiązanie wcale nie wygląda elegancko.

### Makefile? - Brzmi świetnie! {#why-check-makefile}

Przy opisanych wymaganiach `Makefile` wydaje się idealny. Możemy szybko zdefiniować jakie polecenia mają być wykonane,
a następnie wywołać wszytko jednym prostym poleceniem.

    make install

Ta prostota sprawia, że ten sposób był przeze mnie wykorzystywany w różnych projektach. Co prawda narzędzie zaprojektowane
do języków takich jak c/c++, sprawdza się przede wszystkim w definiowaniu, jak mają się kompilować poszczególne pliki, jednak
jako wrapper na inne systemy budowania także daje radę.

...

Ja jednak szukałem czegoś lepszego, co pomogłoby mi zarządzać wieloma projektami w różnych językach, a przy tym zapewnić
zależności pomiędzy zadaniami. Powinien też być łatwy w użyciu, a przy tym na tyle konfigurowalny, aby nie wykonywać
wielokrotnie tych samych poleceń przygotowujących kod i biblioteki, jeśli to nie jest potrzebne.

No i denerwowała mnie ta dziwna składnia z tabami, z którą był problem na różnych edytorach. Wystarczyło otworzyć plik
w niewłaściwym edytorze i już zamiast taba, pojawiały się spacje, które zakłócały wykonanie skryptu. 🤷

### To w końcu co? {#why-taskfile}

I tutaj pojawia się on, cały na biało - `Taskfile`.

Taskfile jest napisanym w języku `go` oprogramowaniem do zarządzania poleceniami, który z założenia ma być prosty w użyciu.
Kompilowany jest do zaledwie jednego pliku binarnego, przez co nie potrzebujemy zaciągać z internetu miliona zależności,
które i tak nam się nie przydadzą, a tylko zaśmiecają komputer. Dzięki temu łatwiejsze jest również implementowanie
tego rozwiązania we wszelkiego rodzaju systemach CICD.

Rozwiązanie to wspiera nie tylko proste wykonywanie pojedyńczych poleceń, ale umożliwia też określenie zależności pomiędzy
nimi, czy warunków wykonania. Możemy np. stworzyć polecenie do ściągnięcia z internetu zewnętrznych zasobów, a potem dodać
je jako zależność do polecenia budującego. Mając odpowiedni warunek dla pierwszej instrukcji, można też sprawić, że będzie
ona wykonywana tylko, jeśli jest taka potrzeba, a więc ściąganie obrazków, czy innych rzeczy nie musi się wykonywać za
każdym razem.

Poza tym mamy też wsparcie dla includowania plików `Taskfile` z innych lokacji. Umożliwia to nie tylko budowanie struktur
dla wielopakietowych projektów, ale również rozdzielenie instrukcji np. dla obsługi `dockera`, w oddzielnych plikach.

Dość powiedzieć, ze wiele rzeczy jestem w stanie obsłużyć używając jedynie `Taskfile`, w którym dodatkowo, każde z poleceń
może mieć własny opis.

## 2. Szybkie wprowadzenie

Powiedzmy, że damy szanse Taskfile. Jak się więc do tego zabrać, żeby nie tracić czasu

### Instalacja - czyli czas zacząć zabawę {#installation}

Task jest narzędziem napisanym w języku go, przez co mając zainstalowane odpowiednie oprogramowanie, jesteśmy w stanie
zainstalować narzędzie bezpośrednio ze [źródeł](https://github.com/go-task/task?utm_source=rafycopl). Istnieje także możliwość instalacji
z użyciem jednego z managerów pakietów dla wielu różnych języków. 

Mając zainstalowany Python można też skorzystać z odpowiedniego dla tego języka managera pakietów - [pip](https://pip.pypa.io/?utm_source=rafycopl).

    pip install go-task-bin

Użytkownicy javascript mogą spróbować instalacji za pomocą [npm](https://www.npmjs.com/?utm_source=rafycopl)

    npm install -g @go-task/cli

Sam jednak, używając Linuxa, preferuję używanie pakietu [snap](https://snapcraft.io/task?utm_source=rafycopl).

    sudo snap install task --classic

Istnieje także wiele innych alternatywnych metod instalacji tego oprogramowania zarówna dla użytkowników Linuxa, Windowsa,
a nawet MacOS. Wszystkie zostały opisane na [stronie autora](https://taskfile.dev/installation/?utm_source=rafycopl).

### Prosty przykład {#prosty-przykład}

Aby rozpocząć używanie naszego systemu budowania, należy stworzyć plik yaml o nazwie `Taskfile.yml`. Jeśli pracujemy nad
zewnętrznym projektem, można go dodać jako ignorowany w systemie kontroli wersji (np. poprzez dodanie wpisu 
do pliku `.git/info/exclude`). W prywatnych projektach, gdzie chcemy go zacommitować, zalecam dodanie pliku o nazwie: 
`Taskfile.dist.yml`, oraz dodanie `Taskfile.yml` do `.gitignore` tak, aby każdy z programistów mógł we własnym zakresie
dopisać swoją implementację, jeśli ma taką potrzebę.

Najprostszy plik może wyglądać w ten sposób

```yaml
---
version: 3

tasks:
  hello-world:
    cmds:
      - echo "Hello world"
```

Podstawową jednostką operacyjną jest w tym przypadku jeden task. To on opisuje, jak ma wyglądać zadanie do wykonania. 
W tym przypadku stworzyliśmy taska o nazwie **hello-world**. Uruchomienie go, wygląda następująco:

    task hello-world

Polecenie powinno wypisać tekst `Hello world` na ekranie. Dodają nowe elementy do klucza `tasks` możemy rozszerzać swój
plik o kolejne polecenia. Więcej na przykładzie [managera yarn](#package-manager).

{{< admonition >}}
Oczywiście poszczególne taski mogą mieć swoje opisy, automatycznie wykonywane zależności, aliasy oraz zdefiniowany
folder, z którego będziemy wywoływać nasz program, jednak o tych zależnościach możecie poczytać 
na stronie autora: [https://taskfile.dev/usage](https://taskfile.dev/usage?utm_source=rafycopl).

{{< /admonition >}}

## 3. Jak tego używam?

W tej części kilka słów jak używam tego oprogramowania do swoich potrzeb.

### Praca z innymi package managerami na przykładzie yarn'a {#package-manager}

Pracę nad projektami zazwyczaj zaczynam od zdefiniowania podstawowych poleceń, które stanowią szkielet do dalszej pracy.
Są one wspólne pomiędzy moimi projektami i pozwalają szybko odnaleść się pomiędzy projektami. Są to:
* **init** - Przygotowuje środowisko, ściąga zależności, instaluje brakujące komponenty. Najczęściej jest zależnością dla pozostałych zadań
* **start** - Uruchamia środowisko developerskie
* **test** - Uruchamia unittesty, lintery i inne narzędzia do testowania kodu
* **build** - Tworzy paczkę z oprogramowaniem gotową do dystrybucji
* **deploy** - Ten task jest zazwyczaj opcjonalny i ma za zadanie wysłanie zbudowanej paczki na serwer lub do sklepu

Zestaw ten jest najczęściej rozszerzany o dodatkowe taski, które potem zazwyczaj stanowią część wyżej wymienionych.

Skorzystajmy więc z przykładu, który omówię w dalszej części wpisu. Oczywiście musimy założyć, że program yarn ma kilka
zdefiniowanych komend takich jak: start, build, test i lint. Przyjmijmy, że są one poprawnie skonfigurowanymi poleceniami 
oraz że wykonują pracę, na jaką wskazuje ich nazwa.

```yaml
---
version: 3

tasks:
  default:
    cmds:
      - task: start
  
  init:
    run: once
    cmd: yarn install
    sources:
      - package.json
    generates:
      - node_modules/.yarn-state.yml

  start:
    deps: [build]
    cmd: yarn start

  test-lint:
    deps: [init]
    cmd: yarn lint
    
  test-unittests:
    deps: [init]
    cmd: yarn test 
    
  test:
    cmds:
      - task: test-lint
      - task: test-unittests

  build:
    deps: [init]
    cmd: yarn build
```

#### nagłówek i `default`

Zacznijmy od dwóch pierwszych linijek. Pierwsza to opcjonalny element w pliku yaml, który określa, co w nim ma się znajdować.
Kolejna linijka `version: 3` określa, z której wersji api Taskfila będziemy korzystali. Oczywiście wersja 3 jest na ten
moment tą aktualną i należy to przyjąć jako domyślny nagłówek w nowych konfiguracjach.

Widzimy, że poszczególne zadania, zgrupowane są pod kluczem `tasks`. Oprócz tasków, które opisałem wcześniej, w pliku,
dodałem także zadanie o nazwie `default`. Jest to standardowy klucz, który określa zadanie, które ma się wykonać w przypadku,
jeśli wywołamy program `task` bez określenia żadnego taska.

#### `init`

To zadanie jest pod pewnymi względami wyjątkowe w tym pliku. Ma ono uruchomić zadania pobierania zależności i ogólnego
przygotowania kodu do działania. Będzie ono zależnością dla pozostałych zadań, dlatego powinno być wykonywane tylko raz,
oraz wyłącznie wtedy, jeśli kod nie jest przygotowany na wykonywanie pozostałych zadań.

Odpowiednikiem `init` w `yarn` jest polecenie `yarn install`. Wykonuje ono pobranie zewnętrznych zależności do działania
systemu budowania. Warto tutaj wspomnieć, że w skryptach zdefiniowanych w yarn, nie można wymusić opcji instalacji 
środowika, przed wywołaniem np.: unittestów.

W Taskfile, oprócz dodania zależności, mamy także opcję dodania warunków początkowych, w jakich ten task ma się wykonać.
Uzyskujemy to za pomocą klucz `status`, w którym definiujemy polecenie, określające czy dany task może być pominięty.

W naszym przypadku korzystamy z drugiego sposobu korzystającego z kluczy `sources` i `generates`. Pierwszy z nich określa
które pliki służą do wykonania taska, a drugi, jakie będą jej wynikiem. Jeśli któryś z plików w `sources` się zmieni, lub
nie istnieje `generates` musimy wykonać polecenie. W innym przypadku będzie pominięte. Więcej o tym mechanizmie możesz
przeczytać [tutaj](https://taskfile.dev/usage/?utm_source=rafyco#using-programmatic-checks-to-indicate-a-task-is-up-to-date).

Drugim ciekawym mechanizmem w tym tasku jest `run: once`. Jest on przydatny, jeśli z jakiegoś powodu `init` pojawiłby się
kilkukrotnie w zależnościach, a chcemy je wykonać tylko raz.
Więcej [tutaj](https://taskfile.dev/usage/?utm_source=rafycopl#limiting-when-tasks-run).

#### `start` i `build`

Tutaj żadnej filozofii nie ma. Proste zadania z zależnością do `init`. Oczywiście przy wywołaniu obu tych zadań będziemy
próbować automatycznie skonfigurować środowisko, o ile będzie to potrzebne.

#### `test` oraz `test-lint` i `test-unittests`

W tym przypadku podzieliłem testy na dwa polecenia `test-lint` oraz `test-unittests`. Można je wykonać oddzielnie lub
za pomocą jednej komendy `task test`. Zapisanie wywołania tasków w ten sposób, różni się od użycia klucza `deps` tym,
że przy użyciu dependecji, zadania są wywoływane zawsze na początku i nie bardzo mamy kontrolę nad ich kolejnością.

Warto tutaj zauważyć, że przy wywołaniu obu poleceń `test-*` mamy do czynienia z podwójnym zdefiniowaniem zależności init.
Dzięki dodaniu tam `run: once` nie musimy się martwić o to, że to polecenie zostanie zawołane dwukrotnie.

### Konfiguracja github action

Mając tak skonfigurowany plik `Taskfile` warto użyć go w automatycznym testowaniu. W przypadku github Aciton autor zaleca
użycie następującego polecenia [źródło](https://taskfile.dev/installation/?utm_source=rafycopl#github-actions):

```yaml
- name: Install Task
  uses: arduino/setup-task@v2
  with:
    version: 3.x
    repo-token: ${{ secrets.GITHUB_TOKEN }}
```

Ja natomiast używam w swoich projektach czegoś takiego:

```yaml
- name: Install Taskfile
  run: |
    echo "::group::Install Taskfile"
    sudo sh -c "$(curl --location 'https://taskfile.dev/install.sh')" -- -d -b /usr/bin/
    sudo chmod +x /usr/bin/task
    echo "::endgroup::"
```

## 4. Kilka innych funkcjonalności

Powyższy opis oddaje charakter działania Taskfile'a, ale nie wyczerpuje wszystkich funkcjonalności. O nich, można przeczytać
w [dokumentacji](https://taskfile.dev?utm_source=rafycopl). Warto jednak wymienić kilka ciekawszych:

* ☑️ [Wykorzystanie plików .env](https://taskfile.dev/usage/?utm_source=rafycopl#env-files)
* ☑️ [Korzystanie z zewnętrznych plików z zadaniami](https://taskfile.dev/usage/?utm_source=rafycopl#including-other-taskfiles)
* ☑️ [Aliasy poleceń](https://taskfile.dev/usage/?utm_source=rafycopl#task-aliases)
* ☑️ [Parametry w nazwie zadania](https://taskfile.dev/usage/?utm_source=rafycopl#wildcard-arguments)
* ☑️ [Czyszczenie po zadaniu](https://taskfile.dev/usage/?utm_source=rafycopl#doing-task-cleanup-with-defer)
* ☑️ [Opisywanie tasków (dokumentacja)](https://taskfile.dev/usage/?utm_source=rafycopl#help)
* ☑️ i oczywiście wiele innych...

## 5. Podsumowanie

Projekty pisane w różnych frameworkach wiążą się z wieloma systemami budowania, które działają w odmienny sposób. Czasami
trudno przypomnieć sobie jakie polecenie należy wywołać, aby zbudować, czy przetestować aplikację. Myślę, że w tym przypadku
warto zastosować łatwy w obsłudze wrapper, który pozwoli na szybkie uruchomienie aplikacji.

Myślę, że dobrym przykładem, takiego wrappera jest właśnie `Taskfile`. Jest łatwy w obsłudze, szybki do nauki i ma naprawdę
spore możliwości, które mogą być wykorzystane w razie potrzeby. Pozwala też na skorzystanie z funkcjonalności, których
nie ma natywnie w pozostałych rozwiązaniach.

A czy ty też znasz jakieś narzędzia rozwiązujące ten problem? Pisz w komentarzu.

## 6. Bibliografia

1. [https://taskfile.dev/](https://taskfile.dev/?utm_source=rafycopl) - Strona główna projektu Taskfile
2. [https://github.com/go-task/task](https://github.com/go-task/task?utm_source=rafycopl) - Źródła projektu
3. [https://rafyco.pl/tags/taskfile](/tags/taskfile) - Wszystkie artykuły na temat taskfile na tej stronie
