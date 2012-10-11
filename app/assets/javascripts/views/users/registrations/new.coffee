class @App.Views.NewUserRegistration extends Backbone.Marionette.ItemView
	template: 'users/registrations/new'
	model: new App.Models.UserRegistration
	tagName: 'form'
	id: 'sign-up'

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
					App.notifier.notify('Account created successfully.')
					Backbone.history.navigate '', true
				error: (model, response) ->
					$.each JSON.parse(response.responseText).errors, (attr, msg) ->
						App.notifier.notify("#{_.string.titleize(attr)} #{msg}.")