.PHONY: generate_docs
generate_docs:
	@echo "Generating Helm Documents "
	@docker run --rm --volume "`pwd`:/helm-docs" -u `id -u` jnorwood/helm-docs:latest
