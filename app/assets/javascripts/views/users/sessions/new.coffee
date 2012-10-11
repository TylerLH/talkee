class @App.Views.NewUserSession extends Backbone.Marionette.ItemView
	template: 'users/sessions/new'
	model: new App.Models.UserSession
	tagName: 'form'
	id: 'sign-in'

	events:
		'submit'		:		'save'

	onRender: ->
		Backbone.Validation.bind(@, {forceUpdate: true})
		rivets.bind $(@el), {user: @model}

	save: (e) ->
		e.preventDefault()
		if @model.isValid(true)
			@model.save @model.attributes,
				success: (model, response) ->
					App.currentUser = new App.Models.User(response)
					App.vent.trigger 'authentication:signed_in'
					App.notifier.notify('Signed in successfully.')
					Backbone.history.navigate '', true
				error: ->
					App.notifier.notify('Invalid email or password.')