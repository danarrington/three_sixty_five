$(document).on('page:change', function(){
  if(window._gaq) {
    _gaq.push ['_trackPageview'];
  } else if(window.pageTracker) {
    pageTracker._trackPageview();
  }
});
