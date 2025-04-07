---
date: '2025-04-10T06:00:00+01:00'
draft: false
title: 'Issue navigations in inteliJ'
subtitle: 'Add links in commit in your version control system'

categories: ["it"]
tags: ["intelij", "development", "ide", "jetbrains"]

toc:
  enable: true
  auto: true
  keepStatic: false
  
featuredImage: "/posts/issue-link/featured-image.png"
featuredImagePreview: "/posts/issue-link/featured-image.png"
---

I use tools from JetBrains a lot in my work. One of the things that I like about their software
is the well-performing version control system management tool. In addition to an efficient overview of the code history,
we also have a lot of options to manage it in an easy and fun way. Today I will present a simple way to make
links in the commit descriptions to allow faster navigation from the history to the page with the bug you are viewing.

<!--more-->

{{< admonition type=warning >}}
This article was translated with [DeepL.com](https://deepl.com) (free version) from polish language. I have made every
effort to make it correct. However, if you found any errors or inaccuracies, please let me know.
{{< /admonition >}}

## tl;dr

* An article on how to make page links in commit descriptions in [IDE from JetBrains](https://www.jetbrains.com/ides/).
* You find this option in **Settings** | **Version Control** | **Issue Navigation**.
* You add a new entry, **Add issue Navigation Link**.
* In `Issue ID` you type the regexp of the commit fragment that you want to be the link.
* In `Issue link` you compose the link based on the regexp.
* The configuration is stored in the `.idea/vcs.xml` file in the project configuration. It can be commited,
so that it is available to collaborators.
* If you are my collaborator check [Bonus](#bonus-for-coworker).

## 0. Before you start reading

...make sure that:

- ✅ **You are using JetBrains tools (IDE)**. There is a good chance that in other IDEs the problem can be solved
  in a similar way, but every software is different and these differences cannot be covered in a single post.
- ✅ **You know the basics of regexp** - Regular expressions are a basic way to describe shuffle code. Without this knowledge
  will be difficult to understand how it even works. You don't need to be able to create complex descriptions, but it's a good idea to be able to
  analyze what is happening in the example shown.
- ✅ **You know what the task identifier looks like** - This could be, for example, `#123`. It is important that you know what this
  identifier and which part of it is needed to create the address.
- ✅ **Address with the job you want to have a link to** I will use my project [ytrss](https://github.com/rafyco/ytrss),
  and the [github issues](https://github.com/rafyco/ytrss/issues) website.
 
## 1. Issues links {#links-to-issues}

To create our links, we first need to think about what the task description looks like in our project, and where we
want it to redirect. In the example I will use linking to tasks on github issues, but you can successfully customize
it for your own project.

{{< figure src="/posts/issue-link/img/vcs-before.png" title="List of commits without additional links" >}}

Let's say we want the string `#123` to redirect to the link `https://github.com/rafyco/ytrss/pull/123`. Let's note,
that `123` is actually the ID of our task, which we want to pass to the url, as a variable.

{{< figure src="/posts/issue-link/img/add-issue.png" title="Add a position in Issue Navigation" >}}

Open the **Settings** menu (or select the keyboard shortcut: [ctrl][alt][s]) | **Version Control** | **Issue Navigation**.
Then add a new item by selecting `Add Issue Navigation Link`.

{{< figure src="/posts/issue-link/img/add-popup.png" title="Popup where we describe our links" >}}

In the `Issue ID` section, we type the element to be highlighted. For this, we use the regexp syntax to cut out a specific
fragment. In addition, in parentheses, we mark the fragment that will be needed to create the link. In this case, it is
task number. It will be available after the next sequence number started with a `$` character, for example: `$1`.
The `$0` character marks the entire selected fragment.

Under the item `Issue link` we enter the url where we want the tag to take us to. Remember to paste in the appropriate
place paste the tag, selected in the previous regexp.

After adding a new entry, the list looks as follows:

{{< figure src="/posts/issue-link/img/vcs-after.png" title="list of commits with described links" >}}

After clicking on the marked links, we should get a browser in which the page with the task will open.

## 2. Save the configuration in the repository. {#links-in-repo}

Correctly executed configuration should create or edit a file at `.idea/vcs.xml` in the root directory of the project.
It contains the appropriate conﬁguration. This file can be ignored, or it can be added to the project so that it is
available to other developers.

The file after the changes described above should look as follows:

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

Our rule is defined in the `<IssueNavigationLink>` tag. You may be tempted to write these rules yourself, while even
if you don't, it's good to know that the described configuration is available from the configuration file.

## 3. Some examples

While working on the [ytrss](https://github.com/rafyco/ytrss) project, I added some rules with links for commits.
I will try to describe them in this section, as an inspiration for your own solutions. All of them are related to
github issues, and links to this service, so they can be successfully used in your projects.

### Link to tasks

Here I have assumed that all shuffles should start with the keyword `closes` or `ref`. You can skip this assumption
and create a link as I described in [previous section](#links-in-repo), but I wanted to have confirmation that these
words would be used and that the correctness of the commit description would also be confirmed before highlighting
it in the changelog.

```xml
<IssueNavigationLink>
  <option name="issueRegexp" value="(closes|ref) #([0-9]*)" />
  <option name="linkRegexp" value="https://github.com/rafyco/ytrss/issues/$2" />
</IssueNavigationLink>
```

**Example**:

>  [closes #42](https://github.com/rafyco/ytrss/issues/42): We don't need info about completion

### Pull request

Actually, links to issues and pull requests in github are interchangeable, nevertheless, in the case of pull requests,
it is useful to use an additional tag to help us quickly locate the source of our changes.

```xml
<IssueNavigationLink>
  <option name="issueRegexp" value="pull request #([0-9]+)" />
  <option name="linkRegexp" value="https://github.com/rafyco/ytrss/pull/$1" />
</IssueNavigationLink>
```

**Example**:

> Merge [pull request #160](https://github.com/rafyco/ytrss/pull/160) from rafyco/rafyco-patch-1

### Link to a page with a tag or version.

In addition to tasks, you can also create a link to a specific version. This will quickly get you to the page from
which you download a specific version of the application.

```xml
<IssueNavigationLink>
  <option name="issueRegexp" value="([0-9]+.[0-9]+.[0-9]+(rc[0-9]+)?) version" />
  <option name="linkRegexp" value="https://github.com/rafyco/ytrss/releases/tag/v$1" />
</IssueNavigationLink>
```

**Example**:

> Upgrade to [0.3.5rc1 version](https://github.com/rafyco/ytrss/releases/tag/v0.3.5rc1)

### Other ideas

The possibilities of links are really many, and we can use links for really many applications, even more so if we take
care of the right commit message. Here are some of my ideas:

* Link to the page of the author of the changes, who is mentioned in the description.
* A link to the page of a specific customer who needs a particular change.
* A link to open a chat with the owner of the corresponding commit.
* Link to a page with documentation (based on some tag).
* Link to a page with a description of the functionality, or a list of tasks (epic) related to it.
* A link in the `see also` section that links to a search engine for relevant topics related to the task.
* Tags related to a particular topic.
* A link that opens an application with specific parameters described in the task.

Do you have anything else? Add in the comments 😊😊😊.

## 4 Bibliography

* [https://www.jetbrains.com/ides/](https://www.jetbrains.com/ides/) - Various IDEs from JetBrains.
* [https://www.jetbrains.com/help/webstorm/2024.3/handling-issues.html?reference.settings.vcs.issue.navigation.add.link=&keymap=XWin](https://www.jetbrains.com/help/webstorm/2024.3/handling-issues.html?reference.settings.vcs.issue.navigation.add.link=&keymap=XWin) -
  Guide from the manufacturer's website.

## 🎁🎁🎁 Bonus for coworkers {#bonus-for-coworker}

If we work together on a project, or are employed by the same employer, ask me about my `Navigation issues` file on
corporate messenger and I will be happy to share it with you.