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
				alert 'saved room'
			else
				alert 'there was a prob'