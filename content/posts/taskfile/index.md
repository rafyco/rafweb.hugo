---
date: '2025-04-22T06:00:00+01:00'
draft: true 
title: 'Taskfile - Twój pomocnik przy budowaniu apki [draft]'
subtitle: 'Taskfile - instalacja i użycie'

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

{{< admonition type=warning title="TODO" >}}
Skrytykować trochę makefile
{{< /admonition >}}

### To w końcu co? {#why-taskfile}

I tutaj pojawia się on, cały na biało - `Taskfile`.

Taskfile jest napisanym w języku `go` oprogramowaniem do zarządzania poleceniami, który z założenia ma być prosty w użyciu.
Kompilowany jest do zaledwie jednego pliku binarnego, przez co nie potrzebujemy zaciągać z internetu miliona zależności,
które i tak nam się nie przydadzą, a tylko zaśmiecają komputer. Dzięki temu łatwiejsze jest również implementowanie
tego rozwiązania we wszelkiego rodzaju systemach CICD.

Rozwiązanie to wspiera nie tylko proste wykonywanie pojedyńczych poleceń, ale umożliwia też określenie zależności pomiędzy
nimi, czy warunków wykonania. Możemy np. stworzyć polecenie do ściągnięcia z internetu zewnętrznych zasobów, a potem dodać
je jako zależność do polecenia budującego. Mając odpowiedni warunek dla pierwszej instarukcji, można też sprawić, że będzie
ona wykonywana tylko, jeśli jest taka potrzeba, a więc ściąganie obrazków, czy innych rzeczy nie musi się wykonywać za
każdym razem.

Poza tym mamy też wsparcie dla includowania plików `Taskfile` z innych lokacji. Umożliwia to nie tylko budowanie struktur
dla wielopakietowych projektów, ale również rozdzielenie instrukcji np. dla obsługi `dockera`, w oddzielnych plikach.

Dość powiedzieć, ze wiele rzeczy jestem w stanie obsłużyć używając jedynie `Taskfile`, w którym dodatkowo, każde z poleceń
może mieć własny opis.

## 2. Szybkie wprowadzenie

Powiedzmy, że damy szanse Taskfile. Jak się więc do tego zabrać, żeby nie tracić czasu

### Instalacja - czyli czas zacząć zabawę

Task jest narzędziem napisanym w języku go, przez co mając zainstalowane odpowiednie oprogramowanie, jesteśmy w stanie
zainstalować narzędzie bezpośrednio ze [źródeł](https://github.com/go-task/task). Istnieje także możliwość instalacji
z użyciem jednego z managerów pakietów dla wielu różnych języków. 

Mając zainstalowany Python można też skorzystać z odpowiedniego dla tego języka managera pakietów - [pip](https://pip.pypa.io/).

    pip install go-task-bin

Użytkownicy javascript mogą spróbować instalacji za pomocą [npm](https://www.npmjs.com/)

    npm install -g @go-task/cli

Sam jednak, używając Linuxa, preferuję używanie pakietu [snap](https://snapcraft.io/task).

    sudo snap install task --classic

Istnieje także wiele innych alternatywnych metod instalacji tego oprogramowania zarówna dla użytkowników Linuxa, Windowsa,
a nawet MacOS. Wszystkie zostały opisane na [stronie autora](https://taskfile.dev/installation/).

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
na stronie autora: [https://taskfile.dev/usage](https://taskfile.dev/usage).

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

{{< admonition type=warning title="TODO" >}}
Opisać plik yaml
{{< /admonition >}}

### Konfiguracja github action

Mając tak skonfigurowany plik `Taskfile` warto użyć go w automatycznym testowaniu. W przypadku github Aciton autor zaleca
użycie następującego polecenia [źródło](https://taskfile.dev/installation/#github-actions):

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

## 4. Podsumowanie

{{< admonition type=warning title="TODO" >}}
Zrobić podsumowanie + wady i zalety
{{< /admonition >}}

## 5. Bibliografia

1. [https://taskfile.dev/](https://taskfile.dev/) - Strona główna projektu Taskfile
2. [https://github.com/go-task/task](https://github.com/go-task/task) - Źródła projektu
3. [https://rafyco.pl/tags/taskfile](/tags/taskfile) - Wszystkie artykuły na temat taskfile na tej stronie