---
date: '2025-04-15T06:00:00+01:00'
draft: true 
title: 'Linki do tasków w inteliJ [draft]'
subtitle: 'Dodaj linki do tasków w systemie wersjonowania'

categories: ["it"]
tags: ["intelij", "programowanie", "ide", "jetbrains"]

toc:
  enable: true
  auto: true
  keepStatic: false
  
featuredImage: "/posts/issue-link/featured-image.png"
featuredImagePreview: "/posts/issue-link/featured-image.png"
---

W swojej pracy bardzo często korzystam z narzędzi od JetBrains. Jedną z rzeczy która mi się podoba w ich oprogramowaniu
to dobrze działające narzędzie do zarządzania systemem kontroli wersji. Oprócz sprawnego przeglądania historii kodu,
mamy też wiele możliwości zarządzania nią w łatwy i przyjemny sposób. Dzisiaj przedstawię prosty sposób na zrobienie
linków w opisach commit'ów, które umożliwią szybszą nawigację od historii do strony z przeglądanym błędem.

<!--more-->

## tl;dr

* Artykuł o tym, jak w [IDE od JetBrains](https://www.jetbrains.com/ides/) zrobić linki do stron w opisach commit'ów
* Opcję tą znajdziesz w **Settings** | **Version Control** | **Issue Navigation**
* Dodajesz nowy wpis, **Add issue Navigation Link**
* W `Issue ID` wpisujesz regexp fragmentu commita który ma być linkiem
* W `Issue link` komponujesz link na podstawie regexpa
* Konfiguracja jest zapisana w pliku `.idea/vcs.xml` w konfiguracji projektu. Można go zacommitować,
aby był dostępny dla współpracowników.
* Jeśli jesteś moim współpracownikiem sprawdź [Bonus](#bonus-for-coworker)

## 0. Zanim przystąpisz do czytania

...upewnij się, że:

- ✅ **Korzystasz z narzędzi (IDE) JetBrains**. Istnieje duża szansa, że w innych IDE problem da się rozwiązać
w podobny sposób, jednak każde oprogramowanie jest inne i tych różnic nie sposób uwzględnić w jednym wpisie.
- ✅ **Znasz podstawy regexp** - Wyrażenia regularne są podstawowym sposobem do opisywania kodu tasków. Bez tej wiedzy
będzie trudno zrozumieć jak to w ogóle działa. Nie musisz umieć stworzyć skomplikowanych opisów, ale warto abyś umiał
przeanalizować co się dzieje w przedstawionym przykładzie.
- ✅ **Wiesz jak wygląda identyfikator zadania** - To może być np `#123`. Ważne, żebyś wiedział z czego się składa ten
identyfikator i która jego część jest potrzebna do stworzenia adresu.
- ✅ **Adres z zadzaniem do którego chcesz mieć odnośnik** Ja użyje swojego projektu [ytrss](https://github.com/rafyco/ytrss),
oraz strony [github issues](https://github.com/rafyco/ytrss/issues).
 
## 1. Linki do zadań {#links-to-issues}

Żeby utworzyć nasze linki, musimy najpierw zastanowić się, jak wygląda opis zadania w naszym projekcie, oraz gdzie 
chcemy, aby przekierowywał. W przykładzie wykorzystam linkowanie do zadań na github issues, ale z powodzeniem możesz to 
dostosować do własnego projektu.

{{< figure src="/posts/issue-link/img/vcs-before.png" title="Lista commitów bez dodatkowych linków" >}}

Powiedzmy, że chcemy, aby ciąg znaków `#123` przekierowywał do linku `https://github.com/rafyco/ytrss/pull/123`. Zauważmy,
że `123` to tak naprawdę identyfikator naszego zadania, który chcemy przekazać do url, jako zmienną.

{{< figure src="/posts/issue-link/img/add-issue.png" title="Dodanie pozycji w Issue Navigation" >}}

Otwieramy menu **Settings** (lub wybieramy skrót klawiszowy: [ctrl][alt][s]) | **Version Control** | **Issue Navigation**. 
Następnie dodajemy nową pozycję wybierając `Add Issue Navigation Link`.

{{< figure src="/posts/issue-link/img/add-popup.png" title="Popup w którym definiujemy link" >}}

W sekcji `Issue ID` wpisujemy element, który ma zostać podkreślony. Używamy do tego składni regexp, aby wyciąć konkretny
fragment. Dodatkowo w nawiasy, oznaczamy fragment, który będzie potrzebny do stworzenia linku. W tym przypadku jest to
numer zadania. Będzie on dostępny po kolejnym numerem kolejności rozpoczętym znakiem `$` np: `$1`. Znak `$0` oznacza cały
zaznaczony fragment.

Pod pozycją `Issue link` wprowadzamy url, pod który ma nas prowadzić dany znacznik. Pamiętajmy, aby w odpowiednim miejscu
wkleić znacznik, wybrany w poprzednim regexpie.

Po dodaniu nowego wpisu lista prezentuje się następująco:

{{< figure src="/posts/issue-link/img/vcs-after.png" title="Lista commitów ze zdefiniowanymi linkami" >}}

Po kliknięciu w zaznaczone linki powinna nam się uruchomić przeglądarka w której otworzy się strona z zadaniem.

## 2. Zapisanie konfiguracji w repozytorium {#links-in-repo}

Poprawnie wykonana konfiguracja powinna stworzyć lub edytować plik pod adresem `.idea/vcs.xml` w głównym katalogu projektu.
Znajduje się w nim odpowiednia konfiugracja. Plik ten można ignorować, można też dodać do projektu, aby był dostępny dla
pozostałych programistów.

Plik po opisanych wyżej zmianach powinien wyglądać nastepująco:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="IssueNavigationConfiguration">
    <option name="links">
      <list>
        <IssueNavigationLink>
          <option name="issueRegexp" value="#([0-9]*)" />
          <option name="linkRegexp" value="https://github.com/rafyco/ytrss/issues/$1" />
        </IssueNavigationLink>
      </list>
    </option>
  </component>
  <component name="VcsDirectoryMappings">
    <mapping directory="$PROJECT_DIR$" vcs="Git" />
  </component>
</project> 
```

Nasza reguła zdefiniowana jest w znaczniku `<IssueNavigationLink>`. Można się pokusić o własnoręczne napisanie tych reguł,
natomiast nawet jeśli tego nie zrobimy, warto wiedzieć, że opisana konfiguracja jest dostępna z poziomu pliku konfiguracyjnego.

## 3. Kilka przykładów

Pracując nad projektem [ytrss](https://github.com/rafyco/ytrss) dodałem kilka reguł z linkami dla commitów. Postram się
opisać je w tej części, jako inspiracja dla własnych rozwiązań. Wszystkie są powiązane z github issue, oraz linkami do tego
serwisu, dlatego mogą być z powodzeniem wykorzystane w waszych projektach.

### Link do zadań

Tutaj założyłem, że wszystkie taski mają się rozpoczynać słowem kluczowym `closes` lub `ref`. Można pominąć to założenie
i stworzyć link tak jak opisywałem w [poprzednim rozdziale](#links-in-repo), jednak chciałem mieć potwierdzenie, że te
słowa zostaną użyte i że poprawność opisu commita zostnie potwierdzona również przed podkreślenie go na liście zmian.

```xml
<IssueNavigationLink>
  <option name="issueRegexp" value="(closes|ref) #([0-9]*)" />
  <option name="linkRegexp" value="https://github.com/rafyco/ytrss/issues/$2" />
</IssueNavigationLink>
```

**Przykład**:

>  [closes #42](https://github.com/rafyco/ytrss/issues/42): We don't need info about completion

### Pull request

Właściwie linki do issuesów i pull requestów w githubie są zamienne, niemniej w przypadku pull requestów warto posiłkować
się dodatkowym tagiem, który pomoże nam szybko zlokalizować źródło naszych zmian.

```xml
<IssueNavigationLink>
  <option name="issueRegexp" value="pull request #([0-9]+)" />
  <option name="linkRegexp" value="https://github.com/rafyco/ytrss/pull/$1" />
</IssueNavigationLink>
```

**Przykład**:

> Merge [pull request #160](https://github.com/rafyco/ytrss/pull/160) from rafyco/rafyco-patch-1

### Link do strony z tagiem lub wersją

Oprócz zadań, można też stworzyć odnośnik do konkretnej wersji. Dzięki temu szybko dostaniemy się na stronę z której pobierzemy
konkretną wersję aplikacji.

```xml
<IssueNavigationLink>
  <option name="issueRegexp" value="([0-9]+.[0-9]+.[0-9]+(rc[0-9]+)?) version" />
  <option name="linkRegexp" value="https://github.com/rafyco/ytrss/releases/tag/v$1" />
</IssueNavigationLink>
```

**Przykład**:

> Upgrade to [0.3.5rc1 version](https://github.com/rafyco/ytrss/releases/tag/v0.3.5rc1)

### Inne pomysły

Możliwości linków jest naprawdę dużo, a odnośniki możemy wykorzystać do naprawdę wielu zastosować, tym bardziej jeśli
zadbamy o odpowiednie commit message. Oto kilka moich pomysłów:

* Link do strony autora zmian, który został wymieniony w opisie
* Link do strony konkretnego klient, który potrzebuje danej zmiany
* Link otwierający chat z właścicielem dopowiedniego commita
* Link do strony z dokumentacją (na podstawie jakiegoś taga)
* Link do strony z opisem funkcjonalności, lub listą zadań (epika) z nią związanych
* Link w sekcji `see also` który odsyła do wyszukiwarki odpowiednich tematów związanych z taskiem
* Tagi związane z danym tematem
* Link otwierający aplikację z konkretnymi parametrami opisanymi w zadaniu

Masz coś jeszcze? Dodaj w komentarzu 😊😊😊

## 4. Bibliografia

* [https://www.jetbrains.com/ides/](https://www.jetbrains.com/ides/) - Różne IDE od JetBrains
* [https://www.jetbrains.com/help/webstorm/2024.3/handling-issues.html?reference.settings.vcs.issue.navigation.add.link=&keymap=XWin](https://www.jetbrains.com/help/webstorm/2024.3/handling-issues.html?reference.settings.vcs.issue.navigation.add.link=&keymap=XWin) -
poradnik ze strony producenta.

## 🎁🎁🎁 Bonus dla współpracowników {#bonus-for-coworker}

Jeśli pracujemy wspólnie w jakimś projekcie, albo jesteśmy zatrudnieni u tego samego pracodawcy, zapytaj mnie o mój
plik z `Navigation issues` na korporacyjnym komunikatorze, a chętnie się nim z Tobą podzielę.
