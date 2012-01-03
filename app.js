var express = require('express'); 

var app = express.createServer(); 

app.configure(function(){ 
	app.use(express.logger()); 
	app.use(express.methodOverride()); 
	app.use(express.bodyParser()); 
	app.use(express.router); 
}); 

app.configure(function(){ 
	app.use(express.errorHandler({ 
		dumpExceptions: true, 
		showStack: true 
	})); 
}); 

app.configure(function(){ 
	app.use(express.errorHandler()); 
}); 

app.listen(3000);
