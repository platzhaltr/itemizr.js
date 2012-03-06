all:
	mkdir -p build
	./node_modules/.bin/pegjs ./lang/de.pegjs ./build/itemizr-de.js
	./node_modules/.bin/uglifyjs -o
test:
	./node_modules/.bin/nodeunit ./test/itemizr
	./node_modules/.bin/nodeunit ./test/lang