# ActiveRecord Query Optimization

Shh, don't tell anyone... but all the Rails apps you've been building for the past 9 weeks probably have *really bad* database performance! Why? Because Rails makes it super easy to write code that causes **N+1 queries**.

N+1 is a performance issue where, in the process of displaying N records on a page, you end up sending N+1 (or more) SQL queries to the database. This is hugely inefficient, since every round-trip from Ruby to Postgres takes time. It's much better to **preload** or **cache** the data you know you'll need, so the number of database round-trips is a small constant number regardless of how many records are being displayed.

A typical example might be displaying a list of articles, which each belong to a user, and wanting to display information about each article's user. We make an initial query for articles in the controller using `Article.all`, and then every time we call `.user` on an individual article in the view, another SQL query is sent to retrieve that article's user. If we had 20 articles, we'd be making 21 queries.

Rails has two basic means of solving N+1 issues:

* **[Eager Loading](http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations)**
* **[Counter Caching](http://guides.rubyonrails.org/association_basics.html#counter-cache)**

There is also a gem called **[bullet](https://github.com/flyerhzm/bullet)** that can (imperfectly) detect N+1 issues for us, and tell us which of the above techniques we need to use.

## Setup

This repo is yet another copy of the [example branch](https://github.com/ga-wdi-boston/wdi_4_rails_hw_hacker_news/tree/example) from the Week 4 Hacker News project. It now includes seed data that will randomly generate a large-ish number of users, articles, comments, and votes. Run `rake db:setup` to set up the database, and the seed data will be loaded automatically.

Bullet is set up as per the gem's README &ndash; see `config/environments/development.rb`.

### Important bullet caveat!

Bullet can only detect missing counter caches when we use the `.size` method to get the number of records in a collection or association &ndash; using `.count` or `.length` will not trigger the warning, even if it generates N+1 queries. You should probably be using `.size` anyway: [See the differences here](http://web.archive.org/web/20100210204319/http://blog.hasmanythrough.com/2008/2/27/count-length-size).
