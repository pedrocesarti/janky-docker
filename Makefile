run:
	docker run --name janky -p 9393:9393 -e JANKY_BASE_URL='http://localhost:9292/' -e JANKY_BUILDER_DEFAULT='http://localhost:8080/' -e JANKY_CONFIG_DIR='/app/janky' -id janky
build:
	docker build -t janky .
