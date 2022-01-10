---
layout: home
title: Derived Categories
nav_exclude: true
seo:
  type: Course
  name: Derived Categories
---

# {{ site.tagline }}
{: .mb-2 }
{{ site.description }}
{: .fs-6 .fw-300 }

{% if site.announcements %}
{% assign announce_date = site.announcements.last.date | date: '%s' | plus: 604800 %}
{% assign today_date = 'now' | date: '%s' | times: 1 %}
{% if announce_date > today_date %}
{{ site.announcements.last }}
[Announcements](announcements.md){: .btn .btn-outline .fs-3 }
{% endif %}
{% endif %}

## Syllabus 

The syllabus can be found at the [about tab]({% link about.md %}). 

## Calendar 

At the [calendar tab]({% link calendar.md %}), you will find our topic schedule and 
due dates for assignments.  

## Notes 

The [notes tab]({% link notes/intro.md %}) is where you can find the course notes. 

## Homework

There is also a tab for class [homework]({% link homework/index.md %}).

## Weekly schedule 

If you ever need to remind yourself about the time and coordinates of our course or 
my office hours, you can quickly reference at the [schedule tab]({% link schedule.md %}).

## Me

If you are interested in a bit about who I am and what I do, check out the 
[Me tab]({% link staff.md %}) or visit [my website](https://www.matthewrobertballard.com).