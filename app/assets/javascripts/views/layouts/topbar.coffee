# topbar.coffee

class @App.Views.Topbar extends Backbone.Marionette.ItemView
	template: 'shared/topbar'

	onRender: ->
		rivets.bind $(@el), {user: App.currentUser}