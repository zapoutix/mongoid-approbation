Mongoid Approbation
============

Mongoid Approbation will change the status of your model object before save it.
For exemple if your are developping a Blog, you want that comments wrote by visitors are under your probation before publish it on your website
If the user update his comment, this one will return to pending status

Quick Start
-----------

Add mongoid_approbation to your Gemfile:

```ruby
gem 'mongoid_approbation'
```

Set up model:

```ruby
class Comment
  include Mongoid::Document
  include Mongoid::Approbation

  field :title
  field :content

  under_approbation :default => :pending, :save_as => :pending, :accepted_status => [:pending, :accepted, :rejected]
end
```

Exemple :

```ruby
	comment = Comment.new
	comment.title = "Hello world !"
	comment.save
	
	comment.status # <= pending
	
	#accept comment
	comment.set_status(:accepted)
	comment.save
	# same as :
	comment.save_as(:accepted)
	
	#reject comment
	comment.set_status(:rejected)
	comment.save
	# same as :
	comment.save_as(:accepted)
	
```

If the user update the comment, it will automatically return to pending status.

```ruby
	comment.status # <= accepted
	comment.content = "i am the content"
	comment.save
	comment.status # <= pending
```

In your controller, use available finder:

```ruby
# GET all pending comments
pending_comment = Comment.find_by_status(:pending)
published_comment = Comment.find_by_status(:accepted)

```
This gem is use on [Passion Gourmande](http://www.passion-gourmande.com "Passion Gourmande")
