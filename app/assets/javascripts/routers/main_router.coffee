class @App.Routers.MainRouter extends Backbone.Marionette.AppRouter
	routes:
		''		:		'index'

	index: ->
		if App.currentUser?
			App.layouts.authenticated.content.show(new App.Views.DashboardIndex)
		else
			App.layouts.unauthenticated.content.show(new App.Views.MainIndex)