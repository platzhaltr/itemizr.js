# ===== Project =====

PROJECT_NAME = itemizr
VERSION=$(shell echo "process.stdout.write(JSON.parse(require('fs').readFileSync('package.json', 'utf8')).version)" | node)

# ===== Directories =====

SRC_DIR				= src
NODE_MODULES_DIR	= node_modules
NODE_MODULES_BIN_DIR= $(NODE_MODULES_DIR)/.bin
BUILD_DIR			= build
DIST_DIR			= dist
TEST_DIR			= test

# ===== Binaries =====

UGLIFY_BIN			= $(NODE_MODULES_BIN_DIR)/uglifyjs
PEGJS_BIN			= $(NODE_MODULES_BIN_DIR)/pegjs
NODEUNIT_BIN		= $(NODE_MODULES_BIN_DIR)/nodeunit

# ===== Files =====

SRC_FILE_CORE 		= $(SRC_DIR)/$(PROJECT_NAME).core.js 
SRC_FILE_GRAMMAR 	= $(SRC_DIR)/grammar.pegjs

BUILD_FILE_CORE		= $(BUILD_DIR)/$(PROJECT_NAME).core.js 
BUILD_FILE_PARSER	= $(BUILD_DIR)/$(PROJECT_NAME).parser.js

DIST_FILE_CORE		= $(DIST_DIR)/$(PROJECT_NAME).core.$(VERSION).min.js
DIST_FILE_PARSER	= $(DIST_DIR)/$(PROJECT_NAME).parser.$(VERSION).min.js

TEST_FILE_CORE		= $(TEST_DIR)/test.$(PROJECT_NAME).core.js 
TEST_FILE_PARSER	= $(TEST_DIR)/test.$(PROJECT_NAME).parser.js

LICENSE_FILE		= LICENSE
README_FILE			= README.md

# ===== Targets =====

all: clean build test dist
build: mkdirBuild compileGrammar copyToBuild
dist: mkdirDist uglify
clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(DIST_DIR)
mkdirBuild:
	mkdir -p build
mkdirDist:
	mkdir -p dist
compileGrammar:
	$(PEGJS_BIN) $(SRC_FILE_GRAMMAR) $(BUILD_FILE_PARSER)
copyToBuild:
	cp $(SRC_FILE_CORE) $(BUILD_FILE_CORE)
test: testParser testCore
testParser:
	$(NODEUNIT_BIN) $(TEST_FILE_PARSER)
testCore:
	$(NODEUNIT_BIN) $(TEST_FILE_CORE)
uglify: uglifyCore uglifyParser
uglifyCore:
	$(UGLIFY_BIN) --output $(DIST_FILE_CORE) $(BUILD_FILE_CORE)
uglifyParser:
	$(UGLIFY_BIN) --output $(DIST_FILE_PARSER) $(BUILD_FILE_PARSER)

.PHONY: clean test dist