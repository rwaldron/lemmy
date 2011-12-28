include .lemmy/setup
include .lemmy/directories
include .lemmy/executables
include .lemmy/templates
include .lemmy/test

ifeq "$(APP_LANGUAGE)" "coffeescript"
clean:
	rm -f ./*.log
	rm -f ./$(APP_FILE)
	rm -drf $(LIBRARY_DIRECTORY)
	rm -drf $(MODULES_DIRECTORY)
	rm -drf $(DEPENDENCIES_DIRECTORY)
	rm -drf $(TESTING_DIRECTORY)
	rm -drf $(DEPLOYMENT_DIRECTORY)
else
clean:
	rm -f *.log
	rm -drf $(DEPENDENCIES_DIRECTORY)
	rm -drf $(DEPLOYMENT_DIRECTORY)
endif

git-init:
	git init
	git add .
	git commit -m "Initial commit."

ifeq "$(APP_LANGUAGE)" "coffeescript"
create:
	mkdir $(SOURCE_DIRECTORY)
	mkdir $(SOURCE_DIRECTORY)/$(LIBRARY_DIRECTORY)
	mkdir $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)
	mkdir $(SOURCE_DIRECTORY)/$(TESTING_DIRECTORY)
	echo $(MODULAR_CS) > $(SOURCE_DIRECTORY)/app.coffee
	echo "APP_LANGUAGE = coffeescript" > .lemmy/setup
	echo $(GITIGNORE_CS) > .gitignore
	make git-init
else
create:
	mkdir $(LIBRARY_DIRECTORY)
	mkdir $(MODULES_DIRECTORY)
	mkdir $(TESTING_DIRECTORY)
	echo $(MODULAR_JS) > app.js
	echo $(GITIGNORE_JS) > .gitignore
	make git-init
endif

ifeq "$(APP_ENVIRONMENT)" "production"
dependencies:
	npm install --production
else
dependencies:
	npm install
endif

build:
	$(COFFEE) --compile --output . $(SOURCE_DIRECTORY)
	$(COFFEE) --compile --output $(LIBRARY_DIRECTORY) $(SOURCE_DIRECTORY)/$(LIBRARY_DIRECTORY)
	$(COFFEE) --compile --output $(MODULES_DIRECTORY) $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)
	$(COFFEE) --compile --output $(TESTING_DIRECTORY) $(SOURCE_DIRECTORY)/$(TESTING_DIRECTORY)

watch:
	$(JITTER) $(SOURCE_DIRECTORY) . $(TEST_DIRECTORY)

run:
	node app.js

test:
	@NODE_ENV=test $(EXECUTABLE_DIRECTORY)/mocha \
		--require $(TEST_DEPENDENCY) \
		--reporter $(TEST_REPORTER) \
		--ui $(TEST_INTERFACE) \
		--slow $(TEST_THRESHOLD) \
		--colors \
		--watch \
		$(TEST_FILES)

deploy:
	make clean
	make dependencies-deploy
	make build
	mkdir $(DEPLOYMENT_DIRECTORY)
	cp $(APP_FILE) $(DEPLOYMENT_DIRECTORY)
	if [ -d "$(LIBRARY_DIRECTORY)" ]; then cp -r $(LIBRARY_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	if [ -d "$(MODULES_DIRECTORYD)" ]; then cp -r $(MODULES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi
	if [ -d "$(DEPENDENCIES_DIRECTORY)" ]; then cp -r $(DEPENDENCIES_DIRECTORY) $(DEPLOYMENT_DIRECTORY); fi

.PHONY: clean dependencies dependencies-deploy build watch test deploy
