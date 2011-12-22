APP_ENVIRONMENT = development
APP_FILE = app.js

SOURCE_DIRECTORY = src
LIBRARY_DIRECTORY = lib
MODULES_DIRECTORY = modules
DEPENDENCIES_DIRECTORY = node_modules
TESTING_DIRECTORY = test
DEPLOYMENT_DIRECTORY = deploy

TEST_EXECUTABLE = ./$(DEPENDENCIES_DIRECTORY)/.bin/mocha
TEST_DEPENDENCY = should
TEST_REPORTER = spec
TEST_INTERFACE = bdd
TEST_THRESHOLD = 20
TEST_FILES = $(TESTING_DIRECTORY)/**/*.js

clean:
	rm -f ./*.log
	rm -f ./$(APP_FILE)
	rm -drf $(LIBRARY_DIRECTORY)
	rm -drf $(MODULES_DIRECTORY)
	rm -drf $(DEPENDENCIES_DIRECTORY)
	rm -drf $(TESTING_DIRECTORY)
	rm -drf $(DEPLOYMENT_DIRECTORY)

dependencies:
	npm install

dependencies-deploy:
	npm install --production

build:
	coffee --compile --output . $(SOURCE_DIRECTORY)
	coffee --compile --output $(LIBRARY_DIRECTORY) $(SOURCE_DIRECTORY)/$(LIBRARY_DIRECTORY)
	coffee --compile --output $(MODULES_DIRECTORY) $(SOURCE_DIRECTORY)/$(MODULES_DIRECTORY)
	coffee --compile --output $(TESTING_DIRECTORY) $(SOURCE_DIRECTORY)/$(TESTING_DIRECTORY)

watch:
	./$(DEPENDENCIES_DIRECTORY)/.bin/jitter $(SOURCE_DIRECTORY) . $(TEST_DIRECTORY)

test:
	@NODE_ENV=test $(TEST_EXECUTABLE) \
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
