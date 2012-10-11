# authenticated layout

class @App.Layouts.Authenticated extends Backbone.Marionette.Layout
	template: 'layouts/authenticated'

	regions:
		topbar:  '#topbar'
		content: '#content'

	onRender: ->
		@topbar.show(new App.Views.Topbar)