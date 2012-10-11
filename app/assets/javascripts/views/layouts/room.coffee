# room layout

class @App.Views.ShowRoom extends Backbone.Marionette.Layout
	template: 'layouts/room'

	regions:
		chat: '#chat'
		presence: '#presence'