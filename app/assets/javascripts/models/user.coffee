# user.coffee

class @App.Models.User extends Backbone.Model
	url: '/users'
	paramRoot: 'user'

	defaults:
		email: ""
		name: ""
		avatar: ""

	validation:
		email:
			required: true
			