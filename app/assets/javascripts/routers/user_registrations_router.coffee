# user_registrations.coffee

class @App.Routers.UserRegistrations extends Backbone.Marionette.AppRouter
	routes:
		'sign_up'		:		'sign_up'

	sign_up: ->
		App.layouts.unauthenticated.content.show(new App.Views.NewUserRegistration)