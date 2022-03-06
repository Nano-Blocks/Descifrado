APP_NAME = descifrado

.PHONY: help clean test lint format formatcheck requirements safety typecheck rundev hooksinit

help:
	@echo "Note: Please make sure you are in pipenv shell"
	@echo ""
	@echo "clean"
	@echo "    Remove generated files"
	@echo "lint"
	@echo "    Print pylint score"
	@echo "formatcheck"
	@echo "    Run black formatter, don't write to files"
	@echo "format"
	@echo "    Run black formatter"
	@echo "test"
	@echo "    Run tests"
	@echo "requirements"
	@echo "    Generate requirements.txt file"
	@echo "safety"
	@echo "    Check dependency vulnerabilities"
	@echo "typecheck"
	@echo "    Type check source"
	@echo "rundev"
	@echo "    Run server in autoreload mode"
	@echo "hooksinit"
	@echo "    Install pre commit hooks"
	@echo ""

clean:
	rm -f -r $(APP_NAME)/__pycache__
	rm -f -r .pytest_cache/
	rm -f -r reports/
	find . -type d -name  "__pycache__" -exec rm -r {} +
	rm -f -r build/
	rm -f -r dist/
	rm -rf .mypy_cache
	rm -f requirements.txt

test:
	pytest -vv tests/

lint:
	mkdir -p reports/
	pylint $(APP_NAME) tests --rcfile ./.pylintrc --output-format=parseable:reports/pylint-report.txt,parseable

formatcheck:
	black --check $(APP_NAME) tests

format:
	black $(APP_NAME) tests

requirements:
	pipenv lock --keep-outdated -r >> requirements.txt

safety:
	safety check -r requirements.txt

typecheck:
	mypy --package $(APP_NAME) --package tests --namespace-packages --install-types

rundev:
	INSECURE_ENGINE_REQUEST=true uvicorn $(APP_NAME):app --reload

hooksinit:
	pre-commit install