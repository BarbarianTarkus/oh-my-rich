push:
	@git status
	@git add .
	@read -p "Enter commit message: " MESSAGE && \
	if [ -z "$$MESSAGE" ]; then \
		echo "Error: Commit message cannot be empty"; \
	else \
		git commit -m "$$MESSAGE"; \
		git push; \
	fi
