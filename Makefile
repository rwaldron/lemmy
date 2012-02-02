include .lemmy/setup
include .lemmy/directories
include .lemmy/executables
include .lemmy/templates
include .lemmy/test
include .lemmy/licenses

help:
	@echo $(HELPMENU)

ifeq "$(APP_LANGUAGE)" "CS"
clean:
	@rm -f *.log
	@rm -f $(APP_FILE)
	@rm -drf $(APPS_DIRECTORY)
	@rm -drf $(MODULES_DIRECTORY)
	@rm -drf $(MIDDLEWARES_DIRECTORY)
	@rm -drf $(ROUTES_DIRECTORY)
	@rm -drf $(CONTROLLERS_DIRECTORY)
	@rm -drf $(MODELS_DIRECTORY)
	@rm -drf $(DEPLOYMENT_DIRECTORY)
else
clean:
	@rm -f *.log
	@rm -drf $(DEPLOYMENT_DIRECTORY)
endif

ifeq "$(APP_LANGUAGE)" "CS"
setup:
	@rm -drf .git
	@rm README.md LICENSE .gitignore
	@echo "APP_LANGUAGE = CS" >> .lemmy/setup
	@mkdir -p $(SOURCE_DIRECTORY)
	@echo $(APP_CS) > $(SOURCE_DIRECTORY)/app.coffee
	@echo $(PACKAGE) > package.json
	@echo $(GITIGNORE) | sed 's/ //g' > .gitignore
	@make git-init
else
setup:
	@rm -drf .git
	@rm README.md LICENSE .gitignore
	@echo $(APP_JS) > app.js
	@echo $(PACKAGE) > package.json
	@echo $(GITIGNORE) | sed 's/ //g' > .gitignore
	@make git-init
endif

update:
	@git clone https://github.com/rock-n-code/lemmy $(TEMPORARY_DIRECTORY)
	@mv .lemmy/setup $(TEMPORARY_DIRECTORY)
	@rm -drf .lemmy
	@rm Makefile
	@mv $(TEMPORARY_DIRECTORY)/.lemmy .
	@rm .lemmy/setup
	@mv $(TEMPORARY_DIRECTORY)/setup .lemmy
	@mv $(TEMPORARY_DIRECTORY)/Makefile .
	@rm -drf $(TEMPORARY_DIRECTORY)

mit-license:
	@echo $(MIT_LICENSE) > LICENSE

ifeq "$(APP_ENVIRONMENT)" "production"
dependencies:
	@if [ -d "$(DEPENDENCIES_DIRECTORY)" ]; then rm -drf $(DEPENDENCIES_DIRECTORY); fi
	@npm install --production
else
dependencies:
	@if [ -d "$(DEPENDENCIES_DIRECTORY)" ]; then rm -drf $(DEPENDENCIES_DIRECTORY); fi
	@npm install
endif

ifeq "$(APP)" ""
layout:
	@git clone https://github.com/h5bp/html5-boilerplate.git $(TEMPORARY_DIRECTORY)
	@mkdir -p $(VIEWS_DIRECTORY)
	@mkdir -p $(PUBLIC_DIRECTORY)/$(STYLES_DIRECTORY)
	@mkdir -p $(PUBLIC_DIRECTORY)/$(IMAGES_DIRECTORY)
	@mkdir -p $(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY)
	@echo $(EJS_LAYOUT) > $(VIEWS_DIRECTORY)/layout.ejs
	@echo $(EJS_404) > $(VIEWS_DIRECTORY)/404.ejs
	@echo $(EJS_500) > $(VIEWS_DIRECTORY)/500.ejs
	@mv $(TEMPORARY_DIRECTORY)/*.txt $(PUBLIC_DIRECTORY)
	@mv $(TEMPORARY_DIRECTORY)/*.png $(PUBLIC_DIRECTORY)
	@mv $(TEMPORARY_DIRECTORY)/*.ico $(PUBLIC_DIRECTORY)
	@mv $(TEMPORARY_DIRECTORY)/$(STYLES_DIRECTORY)/*.css $(PUBLIC_DIRECTORY)/$(STYLES_DIRECTORY)
	@mv $(TEMPORARY_DIRECTORY)/$(SCRIPTS_DIRECTORY)/script.js $(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY)
	@mv $(TEMPORARY_DIRECTORY)/$(SCRIPTS_DIRECTORY)/plugins.js $(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY)
	@mv $(TEMPORARY_DIRECTORY)/$(SCRIPTS_DIRECTORY)/libs/jquery-*.min.js $(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY)/jquery.js
	@mv $(TEMPORARY_DIRECTORY)/$(SCRIPTS_DIRECTORY)/libs/modernizr-*.min.js $(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY)/modernizr.js
	@rm -drf $(TEMPORARY_DIRECTORY)
else
layout:
	@if [ -d "$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		git clone https://github.com/h5bp/html5-boilerplate.git $(TEMPORARY_DIRECTORY); \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(VIEWS_DIRECTORY); \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY)/$(STYLES_DIRECTORY); \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY)/$(IMAGES_DIRECTORY); \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY); \
		echo $(EJS_LAYOUT) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(VIEWS_DIRECTORY)/layout.ejs; \
		echo $(EJS_404) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(VIEWS_DIRECTORY)/404.ejs; \
		echo $(EJS_500) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(VIEWS_DIRECTORY)/500.ejs; \
		mv $(TEMPORARY_DIRECTORY)/*.txt $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY); \
		mv $(TEMPORARY_DIRECTORY)/*.png $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY); \
		mv $(TEMPORARY_DIRECTORY)/*.ico $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY); \
		mv $(TEMPORARY_DIRECTORY)/$(STYLES_DIRECTORY)/*.css $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY)/$(STYLES_DIRECTORY); \
		mv $(TEMPORARY_DIRECTORY)/$(SCRIPTS_DIRECTORY)/script.js $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY); \
		mv $(TEMPORARY_DIRECTORY)/$(SCRIPTS_DIRECTORY)/plugins.js $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(PUBLIC_DIRECTORY)/$(SCRIPTS_DIRECTORY); \
		rm -drf $(TEMPORARY_DIRECTORY); \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'layout' task to create a new layout inside your application."; \
	fi
endif

ifeq "$(NAME)" ""
app:
	@echo "ERROR: You're required to give the NAME argument to the 'app' task to create a new app in your project."
	@echo "SYNTAX: make app NAME=AppName"
else
ifeq "$(APP_LANGUAGE)" "CS"
app:
	@mkdir -p $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(NAME_CAMELIZED)
	@echo $(SUBAPP_CS) > $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(NAME_CAMELIZED)/app.coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(NAME_CAMELIZED)
	@echo $(TESTSUBAPP_CS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(NAME_CAMELIZED)/app-test.coffee
else
app:
	@mkdir -p $(APPS_DIRECTORY)/$(NAME_CAMELIZED)
	@echo $(SUBAPP_JS) > $(APPS_DIRECTORY)/$(NAME_CAMELIZED)/app.js
	@mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(NAME_CAMELIZED)
	@echo $(TESTSUBAPP_JS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(NAME_CAMELIZED)/app-test.js
endif
endif

ifeq "$(NAME)" ""
module:
	@echo "ERROR: You're required to give the NAME argument to the 'module' task to create a new module in your project."
	@echo "SYNTAX: make module NAME=ModuleName [APP=AppName]"
else
ifeq "$(APP)" ""
ifeq "$(APP_LANGUAGE)" "CS"
module:
	@mkdir -p $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)
	@echo $(MODULE_CS) > $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)
	@echo $(TESTMODULE_CS) > $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
else
module:
	@mkdir -p $(MODULES_DIRECTORY)
	@echo $(MODULE_JS) > $(MODULES_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)
	@echo $(TESTMODULE_JS) > $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED)-test.js
endif
else
ifeq "$(APP_LANGUAGE)" "CS"
module:
	@if [ -d "$(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY); \
		echo $(MODULE_CS) > $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED).coffee; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY); \
		echo $(TESTMODULE_CS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'module' task to create a new module inside your application."; \
	fi
else
module:
	@if [ -d "$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY); \
		echo $(MODULE_JS) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED).js; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY); \
		echo $(TESTMODULE_JS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED)-test.js; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'module' task to create a new module inside your application."; \
	fi
endif
endif
endif

ifeq "$(NAME)" ""
middleware:
	@echo "ERROR: You're required to give the NAME argument to the 'middleware' task to create a new middleware in your project."
	@echo "SYNTAX: make middleware NAME=MiddlewareName [APP=AppName]"
else
ifeq "$(APP)" ""
ifeq "$(APP_LANGUAGE)" "CS"
middleware:
	@mkdir -p $(SOURCE_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)
	@echo $(MIDDLEWARE_CS) > $(SOURCE_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)
	@echo $(TESTMIDDLEWARE_CS) > $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
else
middleware:
	@mkdir -p $(MIDDLEWARES_DIRECTORY)
	@echo $(MIDDLEWARE_JS) > $(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)
	@echo $(TESTMIDDLEWARE_JS) > $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED)-test.js
endif
else
ifeq "$(APP_LANGUAGE)" "CS"
middleware:
	@if [ -d "$(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY); \
		echo $(MIDDLEWARE_CS) > $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED).coffee; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY); \
		echo $(TESTMIDDLEWARE_CS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'middleware' task to create a new middleware inside your application."; \
	fi
else
middleware:
	@if [ -d "$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY); \
		echo $(MIDDLEWARE_JS) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED).js; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY); \
		echo $(TESTMIDDLEWARE_JS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED)-test.js; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'middleware' task to create a new middleware inside your application."; \
	fi
endif
endif
endif

ifeq "$(NAME)" ""
route:
	@echo "ERROR: You're required to give the NAME argument to the 'route' task to create a new route container in your project."
	@echo "SYNTAX: make route NAME=RouteContainerName [APP=AppName]"
else
ifeq "$(APP)" ""
ifeq "$(APP_LANGUAGE)" "CS"
route:
	@mkdir -p $(SOURCE_DIRECTORY)/$(ROUTES_DIRECTORY)
	@echo $(ROUTE_CS) > $(SOURCE_DIRECTORY)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)
	@echo $(TESTROUTE_CS) > $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
else
route:
	@mkdir -p $(ROUTES_DIRECTORY)
	@echo $(ROUTE_JS) > $(ROUTES_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)
	@echo $(TESTROUTE_JS) > $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED)-test.js
endif
else
ifeq "$(APP_LANGUAGE)" "CS"
route:
	@if [ -d "$(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY); \
		echo $(ROUTE_CS) > $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED).coffee; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY); \
		echo $(TESTROUTE_CS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'route' task to create a new route inside your application."; \
	fi
else
route:
	@if [ -d "$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY); \
		echo $(ROUTE_JS) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED).js; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY); \
		echo $(TESTROUTE_JS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED)-test.js; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'middleware' task to create a new route inside your application."; \
	fi
endif
endif
endif

ifeq "$(NAME)" ""
controller:
	@echo "ERROR: You're required to give the NAME argument to the 'controller' task to create a new controller in your project."
	@echo "SYNTAX: make controller NAME=ControllerName [APP=AppName]"
else
ifeq "$(APP)" ""
ifeq "$(APP_LANGUAGE)" "CS"
controller:
	@mkdir -p $(SOURCE_DIRECTORY)/$(CONTROLLERS_DIRECTORY)
	@echo $(CONTROLLER_CS) > $(SOURCE_DIRECTORY)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)
	@echo $(TESTCONTROLLER_CS) > $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
else
controller:
	@mkdir -p $(CONTROLLERS_DIRECTORY)
	@echo $(CONTROLLER_JS) > $(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)
	@echo $(TESTCONTROLLER_JS) > $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED)-test.js
endif
else
ifeq "$(APP_LANGUAGE)" "CS"
controller:
	@if [ -d "$(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY); \
		echo $(CONTROLLER_CS) > $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED).coffee; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY); \
		echo $(TESTCONTROLLER_CS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'controller' task to create a new controller inside your application."; \
	fi
else
controller:
	@if [ -d "$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY); \
		echo $(CONTROLLER_JS) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED).js; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY); \
		echo $(TESTCONTROLLER_JS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED)-test.js; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'controller' task to create a new controller inside your application."; \
	fi
endif
endif
endif

ifeq "$(NAME)" ""
model:
	@echo "ERROR: You're required to give the NAME argument to the 'model' task to create a new model in your project."
	@echo "SYNTAX: make model NAME=ModelName [APP=AppName]"
else
ifeq "$(APP)" ""
ifeq "$(APP_LANGUAGE)" "CS"
model:
	@mkdir -p $(SOURCE_DIRECTORY)/$(MODELS_DIRECTORY)
	@echo $(MODEL_CS) > $(SOURCE_DIRECTORY)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)
	@echo $(TESTMODEL_CS) > $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
else
model:
	@mkdir -p $(MODELS_DIRECTORY)
	@echo $(MODEL_JS) > $(MODELS_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)
	@echo $(TESTMODEL_JS) > $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED)-test.js
endif
else
ifeq "$(APP_LANGUAGE)" "CS"
model:
	@if [ -d "$(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY); \
		echo $(MODEL_CS) > $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED).coffee; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY); \
		echo $(TESTMODEL_CS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'model' task to create a new model inside your application."; \
	fi
else
model:
	@if [ -d "$(APPS_DIRECTORY)/$(APP_CAMELIZED)" ]; \
	then \
		mkdir -p $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY); \
		echo $(MODEL_JS) > $(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED).js; \
		mkdir -p $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY); \
		echo $(TESTMODEL_JS) > $(TESTING_DIRECTORY)/$(APPS_DIRECTORY)/$(APP_CAMELIZED)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED)-test.js; \
	else \
		echo "ERROR: You're required to give an existing APP argument to the 'model' task to create a new model inside your application."; \
	fi
endif
endif
endif

ifeq "$(APP_LANGUAGE)" "CS"
build:
	@$(COFFEE) --compile --output . $(SOURCE_DIRECTORY)
	@if [ -d "$(SOURCE_DIRECTORY)/$(APPS_DIRECTORY)" ]; then $(COFFEE) --compile --output $(MODULES_DIRECTORY) $(SOURCE_DIRECTORY)/$(APPS_DIRECTORY); fi
	@if [ -d "$(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)" ]; then $(COFFEE) --compile --output $(MODULES_DIRECTORY) $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY); fi
	@if [ -d "$(SOURCE_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)" ];	then $(COFFEE) --compile --output $(MIDDLEWARES_DIRECTORY) $(SOURCE_DIRECTORY)/$(MIDDLEWARES_DIRECTORY); fi
	@if [ -d "$(SOURCE_DIRECTORY)/$(ROUTES_DIRECTORY)" ]; then $(COFFEE) --compile --output $(ROUTES_DIRECTORY) $(SOURCE_DIRECTORY)/$(ROUTES_DIRECTORY); fi
	@if [ -d "$(SOURCE_DIRECTORY)/$(CONTROLLERS_DIRECTORY)" ]; then $(COFFEE) --compile --output $(CONTROLLERS_DIRECTORY) $(SOURCE_DIRECTORY)/$(CONTROLLERS_DIRECTORY); fi
	@if [ -d "$(SOURCE_DIRECTORY)/$(MODELS_DIRECTORY)" 	]; then $(COFFEE) --compile --output $(MODELS_DIRECTORY) $(SOURCE_DIRECTORY)/$(MODELS_DIRECTORY); fi
endif

ifeq "$(APP_LANGUAGE)" "CS"
watch:
	$(JITTER) $(SOURCE_DIRECTORY) . $(TEST_DIRECTORY)
endif

run:
	NODE_ENV=development node app.js

ifeq "$(APP_LANGUAGE)" "CS"
test:
	@NODE_ENV=test $(MOCHA) \
		--require $(TEST_DEPENDENCY) \
		--reporter $(TEST_REPORTER) \
		--ui $(TEST_INTERFACE) \
		--slow $(TEST_THRESHOLD) \
		--colors \
		$(TEST_FILES_CS)
else
test:
	@NODE_ENV=test $(MOCHA) \
		--require $(TEST_DEPENDENCY) \
		--reporter $(TEST_REPORTER) \
		--ui $(TEST_INTERFACE) \
		--slow $(TEST_THRESHOLD) \
		--colors \
		--watch \
		$(TEST_FILES_JS)
endif

ifeq "$(APP_LANGUAGE)" "CS"
prepare:
	@make build
	@make dependencies APP_ENVIRONMENT=production
	@make move_files-to-deployment
else
prepare:
	@make clean
	@make dependencies APP_ENVIRONMENT=production
	@make move-files-to-deployment
endif

version:
	@echo "0.4.1"

.PHONY: help clean create update mit-license dependencies layout app module middleware route controller model build watch run test prepare version

# Helpers

git-init:
	@git init
	@git add .
	@git commit -m "Initial commit."

move-files-to-deployment:
	@mkdir $(DEPLOYMENT_DIRECTORY)
	@cp $(APP_FILE) $(DEPLOYMENT_DIRECTORY)
	@if [ -d "$(APPS_DIRECTORY)" ]; then cp -r $(APPS_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(MODULES_DIRECTORY)" ]; then cp -r $(MODULES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(MIDDLEWARES_DIRECTORY)" ]; then cp -r $(MIDDLEWARES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(ROUTES_DIRECTORY)" ]; then cp -r $(ROUTES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(CONTROLLERS_DIRECTORY)" ]; then cp -r $(CONTROLLERS_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(MODELS_DIRECTORY)" ]; then cp -r $(MODELS_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(DEPENDENCIES_DIRECTORY)" ]; then cp -r $(DEPENDENCIES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
