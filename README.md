# README

## Installation

These should be installed:
- Ruby 3.0.0
- bundler
- postgresql

```
bundle
bundle exec rake db:create db:migrate db:seed
rails s
```

## Structure

- **Post records**
  Post records can be parent or chapters (which related to some parent). 
  Parent post has at least one post_item record related.
  Post contains title, body, published flag with date (TODO use published_at) and slug for accessing by url.
  If parent post not published, it's hidden. Every related chapter will be hidden too, even if they are published.
  
- **PostItem records**
  Relation between parent posts and chapters or sections.
  Record contains order (for sorting and prioritising), related parent and optional related chapter (can be just "section").  

## Usage

Seeds contains several pages:
- `http://localhost:3000/layouts-and-rendering-in-rails` and it's chapters (one chapter is not published)
- `http://localhost:3000/bulma-the-modern-css-framework-that-just-works` with only one chapter
- `http://localhost:3000/draft` with one chapter. This exact returns 404 cause it's not published. 
  And even with published chapter (`http://localhost:3000/draft/this-chapter-published`) it should not work in any way.


## TODO

Application code contains some note to possible improvements.
Also it needs some kind of post builder or at least api module for creation of posts and chapters.
