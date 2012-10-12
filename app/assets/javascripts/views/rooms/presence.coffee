# presence sidebar (who's online)

class @App.Views.Presence extends Backbone.Marionette.ItemView
	template: 'rooms/presence'

	onRender: ->
		rivets.bind $(@el), {room: @model, presence: @model.presence}