# dashboard index

class @App.Views.DashboardIndex extends Backbone.Marionette.ItemView
	template: 'dashboard/index'

	onRender: ->
		rivets.bind $(@el), {rooms: App.rooms}