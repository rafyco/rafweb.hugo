---
date: '2025-04-11T22:52:12+01:00'
draft: true 
title: '[Taskfile] Twój pomocnik przy budowaniu apki'
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
to do korzystania z mniej, lub bardziej skomplikowanego klienta, który umożliwia budowanie, testowanie, a nawet 
deployment projektu do chmury.

## 2. Szybkie wprowadzenie

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

Podstawową jednostką operacyjną jest w tym przypadku jeden task. To on opisuje jak ma wyglądać zadanie do wykonania. 
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

### Praca z innymi package managerami na przykładzie yarn'a {#package-manager}

Pracę nad projektami zazwyczaj zaczynam od zdefiniowania podstawowych poleceń, które stanowią szkielet do dalszej pracy.
Są one wspólne pomiędzy moimi projektami i pozwalają szybko odnaleść się pomiędzy projektami. Są to:
* **init** - Przygotowuje środowisko, ściąga zależności, instaluje brakujące komponenty. Najczęscięj jest zależnością dla pozostałych zadań
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

### Konfiguracja github action

## 4. Podsumowanie

## 5. Bibliografia

1. [https://taskfile.dev/](https://taskfile.dev/) - Strona główna projektu Taskfile
2. [https://github.com/go-task/task](https://github.com/go-task/task) - Źródła projektu
3. [https://rafyco.pl/tags/taskfile](/tags/taskfile) - Wszystkie artykuły na temat taskfile na tej stronie