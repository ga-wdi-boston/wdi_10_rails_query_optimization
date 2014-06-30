# HaxorNews&trade;

*"Hack the planet!"*

[Hacker News](https://news.ycombinator.com/) is a social news web site that caters to programmers and entrepreneurs. Although it's quite popular, it doesn't look that hard to build... in fact, we could probably write our own in less than a week!

## Getting Started

Fork this repository as a starting point &ndash; it includes all the gems you'll need.

This project is divided into suggested implementation phases based on the order we will be covering material this week. The phases do not directly correspond to nights of the week, however this project is designed to take up the whole week. Budget your time wisely!

Remember, we are explicitly building a "clone" of Hacker News. If you're not sure how something in your app should appear or behave, just refer to the real thing!

## Phase 1: Users

Users should be able to register for accounts, sign in, and sign out. Don't worry about any other account functionality, like forgotten password emails. Note we've already run `rails g devise:install` in this repository.

## Phase 2: Articles

Signed-in users can submit articles. On the real Hacker News, articles can be a link to another web site, a chunk of text, or a poll. We'll remove some of that complexity and say that articles are just links. They have a title, which must be present, a URL, which must be valid, and a submission timestamp. The front page displays a list of all articles, with article titles linked to their URLs.

## Phase 3: Comments

Signed-in users can leave comments on articles. The real Hacker News supports threaded discussions where comments can be replies to other comments. Our cheap copy will only support top-level comments directly attached to articles, so we don't have to deal with weird self-referential associations. Comments have a body, which must be present, and a submission timestamp.

## Phase 4: Votes

Signed-in users can upvote or downvote both articles and comments. Each user can only cast one vote on a given article or comment, but they can take it back or change it at any time. For instance, I could upvote an article, then later change my upvote to a downvote, then later take back my downvote (so my vote is back to "neutral"). Both articles and comments should now be sorted by "score", which is the number of upvotes minus the number of downvotes.

## Phase 4.5: Testing?

Due to an abbreviated week this session, you may not have time to write many tests or develop features using Test-Driven Development. However, we recommend adding at least some feature test coverage for the primary workflows of your app, and unit tests for public model methods. Practice with writing tests will come in handy for Project #1.

## Phase 5: Ship It!

Your finished app must be deployed and functional at a Heroku URL that you provide in your pull request. This shouldn't take long, but leave some extra time for it in case you run into any strange issues.

## Specifications

* App has a database schema with appropriate columns and indexes
* App has working seed data to assist in manual testing
* Users can register for an account, sign in, and sign out
* Users can view a list of all articles and submit their own
* Users can view comments on articles and submit their own
* Users can upvote/downvote articles and comments, and change their vote
* Articles and comments are sorted by upvote/downvote score
* Models have appropriate validations and errors are shown to the user
* App has at least basic styles to provide an attractive and intuitive experience
* App generates HTML and CSS that validates with no errors
* Code is well-refactored and avoids duplication or repetition
* Code follows style conventions and has descriptive variable and method names
* App has at least some feature tests and unit tests using RSpec
* Repository has clean, logical, single-task commits with descriptive messages
* App is deployed and fully functional on Heroku

## Extra Challenges

* Having the front page display every single article on the site probably won't perform very well once we have thousands of articles. Use the Kaminari gem to implement paging of articles and comments.
* The real Hacker News doesn't display articles sorted by pure upvote/downvote score &ndash; it uses a "weighted" score that takes the time of the submission into account, so older articles gradually decay and move down the list. Implement this "decay factor" in your app.
