# user_sessions.coffee

class @App.Routers.UserSessions extends Backbone.Marionette.AppRouter
	routes:
		'sign_in'		:		'sign_in'

	sign_in: ->
		App.layouts.unauthenticated.content.show(new App.Views.NewUserSession)