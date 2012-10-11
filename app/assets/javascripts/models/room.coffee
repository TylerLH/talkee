class @App.Models.Room extends Backbone.Model
	url: '/rooms'

	defaults:
		name: ""

	validation:
		name:
				required: true