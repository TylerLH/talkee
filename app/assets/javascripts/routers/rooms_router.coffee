class @App.Routers.RoomsRouter extends Backbone.Marionette.AppRouter
	routes:
		'rooms/new'		:		'new_room'
		'join/:token'	:		'join_room'

	new_room: ->
		if App.currentUser?
			App.layouts.authenticated.content.show(new App.Views.NewRoom)
		else
			App.notifier.notify 'You must be signed in!'
			App.layouts.unauthenticated.content.show(new App.Views.MainIndex)

	join_room: (token) ->
		if App.currentUser?
			App.rooms.findByToken token, (res) ->
				App.currentRoom = new App.Models.Room(res)
				App.layouts.authenticated.content.show(new App.Layouts.ShowRoom(room: App.currentRoom))
		else
			App.notifier.notify 'You must be signed in first'