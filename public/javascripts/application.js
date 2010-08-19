(function(){
  
  if(!window.NAMESPACE) {window.NAMESPACE = {}}	//Create NAMESPACE
  
  window.NAMESPACE.Test = {
    init: function(){
      alert("Javascript wired in!");
    }
  }
  
})();


$(document).ready (function() {
	window.NAMESPACE.Test.init();
});