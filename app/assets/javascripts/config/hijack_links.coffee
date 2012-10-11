# Use absolute URLs  to navigate to anything not in your Router.

# Only need this for pushState enabled browsers
if window.history.pushState
  
  # Use delegation to avoid initial DOM selection and allow all matching elements to bubble
  $(document).delegate "a", "click", (e) ->
    # Get the anchor href and protcol
    href = $(this).attr("href")
    protocol = @protocol + "//"
    
    # Ensure the protocol is not part of URL, meaning its relative.
    # Stop the event bubbling to ensure the link will not cause a page refresh.
    if href[0..protocol.length-1] isnt protocol
      e.preventDefault()
      
      # Note by using Backbone.history.navigate, router events will not be
      # triggered.  If this is a problem, change this to navigate on your
      # router.
      Backbone.history.navigate href, true
