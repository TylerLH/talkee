# app init

@App = new Backbone.Marionette.Application

@App.Models 		 = {}
@App.Collections = {}
@App.Layouts 		 = {}
@App.Views 			 = {}
@App.Routers		 = {}

# Create base app regions
@App.addRegions
	main: '#app'

@App.module 'notifier', ->
	@notify = (msg) ->
		$.jGrowl(msg)

# Create layout instances
@App.addInitializer ->
	@layouts =
		authenticated:	 new App.Layouts.Authenticated
		unauthenticated: new App.Layouts.Unauthenticated

# Check if user is signed in on startup
@App.addInitializer ->
	if App.currentUser?
		App.vent.trigger 'authentication:signed_in'
	else
		App.vent.trigger 'authentication:signed_out'

# Listen for user to be signed in
@App.vent.bind 'authentication:signed_in', ->
	App.rooms = new App.Collections.Rooms
	App.rooms.fetch()
	App.main.show(App.layouts.authenticated)

# Listen for user to be signed out
@App.vent.bind 'authentication:signed_out', ->
	App.main.show(App.layouts.unauthenticated)

@App.on 'initialize:after', ->
	# Create router instances
	@router = 
		main: 				 			new App.Routers.MainRouter
		user_sessions: 			new App.Routers.UserSessions
		user_registrations:	new App.Routers.UserRegistrations
		rooms:							new App.Routers.RoomsRouter

	# Start routers
	if Backbone.history
		Backbone.history.start({pushState: true})