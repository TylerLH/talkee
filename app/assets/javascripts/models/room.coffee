class @App.Models.Room extends Backbone.Model
	url: '/rooms'

	defaults:
		name: ""

	validation:
		name:
				required: true

	connectChat: ->
		if App.pusher.channel("public-chat-#{@get('token')}")?
			@chat = App.pusher.channel("public-chat-#{@get('token')}")
		else
			@chat = App.pusher.subscribe("public-chat-#{@get('token')}")
			App.vent.trigger 'chat:subscribed'