---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
subtitle: ""
date: {{ .Date }}
lastmod: {{ .Date }}
draft: true

tags: []
categories: ["Domyślna"]

featuredImage: "/posts/{{ .File.ContentBaseName }}/featured-image.jpg"
featuredImagePreview: "/posts/{{ .File.ContentBaseName }}/featured-image.jpg"
---

<!--more-->
