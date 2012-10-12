class @App.Collections.Rooms extends Backbone.Collection
	url: '/rooms'
	model: App.Models.Room

	findByToken: (token, callback) ->
		$.getJSON "/rooms/#{token}.json", (data) =>
			callback(data)