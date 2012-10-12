# room layout

class @App.Layouts.ShowRoom extends Backbone.Marionette.Layout
	template: 'layouts/room'

	regions:
		chat: '#chat'
		presence: '#presence'

	initialize: (opts) ->
		@room = opts.room

	onRender: ->
		rivets.bind $(@el), {room: @room}
		@chat.show(new App.Views.ChatWindow(model:@room))