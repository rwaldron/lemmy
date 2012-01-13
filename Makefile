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
	@rm -f ./*.log
	@rm -f ./$(APP_FILE)
	@rm -drf $(MODULES_DIRECTORY)
	@rm -drf $(ROUTES_DIRECTORY)
	@rm -drf $(CONTROLLERS_DIRECTORY)
	@rm -drf $(MODELS_DIRECTORY)
	@rm -drf $(DEPENDENCIES_DIRECTORY)
	@rm -drf $(TESTING_DIRECTORY)
	@rm -drf $(DEPLOYMENT_DIRECTORY)
else
clean:
	@rm -f *.log
	@rm -drf $(DEPENDENCIES_DIRECTORY)
	@rm -drf $(DEPLOYMENT_DIRECTORY)
endif

ifeq "$(APP_LANGUAGE)" "CS"
setup:
	@rm -drf .git
	@rm README.md LICENSE .gitignore
	@echo $(APP_CS) > $(SOURCE_DIRECTORY)/app.coffee
	@echo "APP_LANGUAGE = CS" > .lemmy/setup
	@echo $(PACKAGE) > package.json
	@echo $(GITIGNORE) > .gitignore
	@make git-init
else
setup:
	@rm -drf .git
	@rm README.md LICENSE .gitignore
	@echo $(APP_JS) > app.js
	@echo $(PACKAGE) > package.json
	@echo $(GITIGNORE) > .gitignore
	@make git-init
endif

mit-license:
	@echo $(MIT_LICENSE) > LICENSE

ifeq "$(APP_ENVIRONMENT)" "production"
dependencies:
	@npm install --production
else
dependencies:
	@npm install
endif

ifeq "$(NAME)" ""
module:
	@echo "ERROR: You're required to give the NAME argument to the 'module' task to create a new module in your project."
	@echo "SYNTAX: make module NAME=ModuleName"
else
ifeq "$(APP_LANGUAGE)" "CS"
module:
	@mkdir -p $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)
	@echo $(MODULE_CS) > $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)
	@echo $(TESTMODULE_CS) > $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
	@echo "The module '$(NAME)' had been generated in your project."
else
module:
	@mkdir -p $(MODULES_DIRECTORY)
	@echo $(MODULE_JS) > $(MODULES_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)
	@echo $(TESTMODULE_JS) > $(TESTING_DIRECTORY)/$(MODULES_DIRECTORY)/$(NAME_CAMELIZED)-test.js
	@echo "The module '$(NAME)' had been generated in your project."
endif
endif

ifeq "$(NAME)" ""
middleware:
	@echo "ERROR: You're required to give the NAME argument to the 'middleware' task to create a new middleware in your project."
	@echo "SYNTAX: make middleware NAME=MiddlewareName"
else
ifeq "$(APP_LANGUAGE)" "CS"
middleware:
	@mkdir -p $(SOURCE_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)
	@echo $(MIDDLEWARE_CS)  > $(SOURCE_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
	@echo "The middleware '$(NAME)' had been generated in your project."
else
middleware:
	@mkdir -p $(MIDDLEWARES_DIRECTORY)
	@echo $(MIDDLEWARE_JS) > $(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(MIDDLEWARES_DIRECTORY)/$(NAME_CAMELIZED)-test.js
	@echo "The middleware '$(NAME)' had been generated in your project."
endif
endif

ifeq "$(NAME)" ""
route:
	@echo "ERROR: You're required to give the NAME argument to the 'route' task to create a new route container in your project."
	@echo "SYNTAX: make route NAME=RouteContainerName"
else
ifeq "$(APP_LANGUAGE)" "CS"
route:
	@mkdir -p $(SOURCE_DIRECTORY)/$(ROUTES_DIRECTORY)
	@echo $(ROUTE_CS) > $(SOURCE_DIRECTORY)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
	@echo "The route container '$(NAME)' had been generated in your project."
else
route:
	@mkdir -p $(ROUTES_DIRECTORY)
	@echo $(ROUTE_JS) > $(ROUTES_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(ROUTES_DIRECTORY)/$(NAME_CAMELIZED)-test.js
	@echo "The route container '$(NAME)' had been generated in your project."
endif
endif

ifeq "$(NAME)" ""
controller:
	@echo "ERROR: You're required to give the NAME argument to the 'controller' task to create a new controller in your project."
	@echo "SYNTAX: make controller NAME=ControllerName"
else
ifeq "$(APP_LANGUAGE)" "CS"
controller:
	@mkdir -p $(SOURCE_DIRECTORY)/$(CONTROLLERS_DIRECTORY)
	@echo $(CONTROLLER_CS) > $(SOURCE_DIRECTORY)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
	@echo "The controller '$(NAME)' had been generated in your project."
else
controller:
	@mkdir -p $(CONTROLLERS_DIRECTORY)
	@echo $(CONTROLLER_JS) > $(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(CONTROLLERS_DIRECTORY)/$(NAME_CAMELIZED)-test.js
	@echo "The controller '$(NAME)' had been generated in your project."
endif
endif

ifeq "$(NAME)" ""
model:
	@echo "ERROR: You're required to give the NAME argument to the 'model' task to create a new model in your project."
	@echo "SYNTAX: make model NAME=ModelName"
else
ifeq "$(APP_LANGUAGE)" "CS"
model:
	@mkdir -p $(SOURCE_DIRECTORY)/$(MODELS_DIRECTORY)
	@echo $(MODEL_CS) > $(SOURCE_DIRECTORY)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED).coffee
	@mkdir -p $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED)-test.coffee
	@echo "The model '$(NAME)' had been generated in your project."
else
model:
	@mkdir -p $(MODELS_DIRECTORY)
	@echo $(MODEL_JS) > $(MODELS_DIRECTORY)/$(NAME_CAMELIZED).js
	@mkdir -p $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)
	@echo "" > $(TESTING_DIRECTORY)/$(MODELS_DIRECTORY)/$(NAME_CAMELIZED)-test.js
	@echo "The model '$(NAME)' had been generated in your project."
endif
endif

ifeq "$(APP_LANGUAGE)" "CS"
build:
	@$(COFFEE) --compile --output . $(SOURCE_DIRECTORY)
	@$(COFFEE) --compile --output $(MODULES_DIRECTORY) $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)
	@$(COFFEE) --compile --output $(ROUTES_DIRECTORY) $(SOURCE_DIRECTORY)/$(ROUTES_DIRECTORY)
	@$(COFFEE) --compile --output $(CONTROLLERS_DIRECTORY) $(SOURCE_DIRECTORY)/$(CONTROLLERS_DIRECTORY)
	@$(COFFEE) --compile --output $(MODELS_DIRECTORY) $(SOURCE_DIRECTORY)/$(MODELS_DIRECTORY)
	@$(COFFEE) --compile --output $(TESTING_DIRECTORY) $(SOURCE_DIRECTORY)/$(TESTING_DIRECTORY)
endif

ifeq "$(APP_LANGUAGE)" "CS"
watch:
	$(JITTER) $(SOURCE_DIRECTORY) . $(TEST_DIRECTORY)
endif

run:
	NODE_ENV=development node app.js

test:
	@NODE_ENV=test $(MOCHA) \
		--require $(TEST_DEPENDENCY) \
		--reporter $(TEST_REPORTER) \
		--ui $(TEST_INTERFACE) \
		--slow $(TEST_THRESHOLD) \
		--colors \
		--watch \
		$(TEST_FILES)

ifeq "$(APP_LANGUAGE)" "CS"
deploy:
	@make build
	@rm -drf $(DEPENDENCIES_DIRECTORY)
	@make dependencies APP_ENVIRONMENT=production
	@make move_files-to-deployment
else
deploy:
	@make clean
	@make dependencies APP_ENVIRONMENT=production
	@make move-files-to-deployment
endif

.PHONY: help clean create mit-license dependencies module middleware route controller model build watch run test deploy

# Helpers

git-init:
	@git init
	@git add .
	@git commit -m "Initial commit."

move-files-to-deployment:
	@mkdir $(DEPLOYMENT_DIRECTORY)
	@cp $(APP_FILE) $(DEPLOYMENT_DIRECTORY)
	@if [ -d "$(MODULES_DIRECTORY)" ]; then cp -r $(MODULES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(ROUTES_DIRECTORY)" ]; then cp -r $(ROUTES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(CONTROLLERS_DIRECTORY)" ]; then cp -r $(CONTROLLERS_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(MODELS_DIRECTORY)" ]; then cp -r $(MODELS_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	@if [ -d "$(DEPENDENCIES_DIRECTORY)" ]; then cp -r $(DEPENDENCIES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi

