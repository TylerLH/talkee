# new.coffee
# new room view

class @App.Views.NewRoom extends Backbone.Marionette.ItemView
	template: 'rooms/new'
	model: new App.Models.Room
	tagName: 'form'

	events:
		'submit'		:		'save'

	onRender: ->
		Backbone.Validation.bind(@, {forceUpdate: true})
		rivets.bind $(@el), {room: @model}

	save: (e) ->
		e.preventDefault()
		console.log @model
		if @model.isValid(true)
			success = App.rooms.create @model.attributes, {wait: true}
			if success
				App.notifier.notify 'Room created successfully'
				Backbone.history.navigate '', true
			else
				App.notifier.notify 'There was a problem creating this room.'