# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

body = "
This guide covers the basic layout features of Action Controller and Action View. After reading this guide,
you will know layout a bit at least.
"
parent1 = Post.create!(title: 'Layouts and Rendering in Rails', body: body, published: true)

body = "
This guide focuses on the interaction between Controller and View in the Model-View-Controller triangle.
As you know, the Controller is responsible for orchestrating the whole process of handling a request in Rails,
though it normally hands off any heavy code to the Model. But then, when it's time to send a response back to the user,
the Controller hands things off to the View. It's that handoff that is the subject of this guide.
"
chapter1 = Post.create!(title: '1. Overview: How the Pieces Fit Together', body: body, published: true)
chapter_draft = Post.create!(title: '2. Chapters Draft', body: 'dunno what to say about')
body = "
From the controller's point of view, there are three ways to create an HTTP response:
Call render, call redirect, reunion fellowship of the rings
"
chapter2 = Post.create!(title: '2. Creating Responses', body: body, published: true)
chapter3 = Post.create!(title: 'Additional info', body: 'some extra things to say about', published: true)

parent1.post_items.create!(section: 'Before start', order: 0)
parent1.post_items.create!(chapter: chapter3, order: 1)
parent1.post_items.create!(section: 'Main info', order: 2)
parent1.post_items.create!(chapter: chapter1, order: 3)
parent1.post_items.create!(chapter: chapter_draft, order: 4)
parent1.post_items.create!(chapter: chapter2, order: 5)

parent2 = Post.create!(title: 'Bulma: the modern CSS framework that just works', body: 'Bulma: the modern
CSS framework that
just works.', published: true)
chapter = Post.create!(title: 'bulma cooler than bootstrap soooo far!', body: 'what else do you want to know?', published: true)
parent2.post_items.create!(chapter: chapter, order: 1)

parent3 = Post.create!(title: 'draft', body: 'empty')
chapter = Post.create!(title: 'this chapter published', body: 'but anyway does not work', published: true)
parent3.post_items.create!(chapter: chapter, order: 1)
