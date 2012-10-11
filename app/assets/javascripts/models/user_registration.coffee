class @App.Models.UserRegistration extends Backbone.Model
	url: '/users'
	paramRoot: 'user'

	defaults:
		email: null
		name: null
		password: null

	validation:
		email:
			required: true
			pattern: 'email'
		name:
			required: true
		password:
			required: true