# TDD News

[Hacker News](https://news.ycombinator.com/) is a social news web site that caters to programmers and entrepreneurs. Although it's quite popular, it doesn't look that hard to build... in fact, we could probably write our own in less than a week!

## Getting Started

Fork this repository as a starting point &ndash; it already has RSpec, database_cleaner, Capybara, FactoryGirl, and the other gems needed for our TDD workflow installed and set up.

This project is divided into suggested implementation phases based on the order we will be covering material this week. The phases do not directly correspond to nights of the week, however this project is designed to take up the whole week. Budget your time wisely!

## Phase 1: Articles

On the real Hacker News, articles can be either a link to another web site or simply a chunk of text (polls are also supported). We'll remove some of that complexity and just say that articles are links. They have a title, which must be present, a URL, which must be valid, and a submission timestamp. Since we don't have users yet, articles will be submitted anonymously and cannot be edited or deleted. Since we also don't have voting yet, articles will be listed on the front page in descending order of submission date. Article titles should be linked to their external URLs.

## Phase 2: Comments

The real Hacker News supports threaded discussions where comments can be replies to other comments. Our cheap copy will only support top-level comments directly attached to articles, so we don't have to deal with weird self-referential associations. Since we still don't have users or voting yet, comments are anonymous and should be listed in order of submission date. Comments have only a body, which of course is required, and a submission timestamp.

## Phase 3: Users

Users should be able to register for accounts, sign in, and sign out. Don't worry about any more advanced account functionality, like forgotten password emails. Both articles and comments must now be attached to a user (this will require updating nearly all of your existing feature specs!). Note we've already run `rails g devise:install` in this repository.

## Phase 4: Votes

Users can upvote or downvote both articles and comments. Each user can only cast one vote on a given article or comment, but they can take it back or change it at any time. For instance, I could upvote an article, then later change my upvote to a downvote, then later take back my downvote (so my vote is back to "neutral"). Both articles and comments should now be sorted by "score", which is the number of upvotes minus the number of downvotes.

## Phase 5: Ship It!

Your finished app must be deployed and functional at a Heroku URL that you provide in your pull request. This shouldn't take long, but leave some extra time for it in case you run into a strange issue. Note we've already installed the `rails_12factor` gem in the production group.

## Grading

* **(2)** App has a database schema with appropriate columns and indexes
* **(1)** App has working seed data to assist in manual testing
* **(2)** Users can register for an account, sign in, and sign out
* **(2)** Users can view a list of all articles and submit their own
* **(2)** Users can view comments on articles and submit their own
* **(2)** Users can upvote/downvote articles and comments, and change their vote
* **(2)** Articles and comments are sorted by upvote/downvote score
* **(2)** Models have appropriate validations and errors are shown to the user
* **(1)** App has at least basic styles to provide an attractive and intuitive experience
* **(1)** App generates HTML and CSS that validates with no errors
* **(2)** Code is well-refactored and avoids duplication or repetition
* **(2)** Code follows style conventions and has descriptive variable and method names
* **(3)** App has feature specs that cover all relevant user stories and scenarios
* **(2)** App has model specs with full coverage of all public methods and behavior
* **(2)** Repository has clean, logical, single-task commits with descriptive messages
* **(2)** App is deployed and fully functional on Heroku

Total points: **30**

## Bonuses

* **(2)** Having the front page display every single article on the site probably won't perform very well once we have thousands of articles. Use the Kaminari gem to implement paging of articles and comments.
* **(4)** The real Hacker News doesn't display articles sorted by pure upvote/downvote score &ndash; it uses a "weighted" score that takes the time of the submission into account, so older articles gradually decay and move down the list. Implement this "decay factor" in your app.

Total bonus points: **6**
