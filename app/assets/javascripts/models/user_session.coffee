# user_session.coffee

class @App.Models.UserSession extends Backbone.Model
	url: '/users/sign_in.json'
	paramRoot: 'user'

	defaults:
		email: ""
		password: ""
		name: ""
		avatar: ""

	validation:
		email:
			required: true
		password:
			required: true
			