push:
	@ git status
	@ git add .
	@ git log --pretty=format:"%h - %an, %ar : %s" | head -n 1
	@ read -p "Enter commit message: " MESSAGE && \
	if [ -z "$$MESSAGE" ]; then \
		echo "Error: Commit message cannot be empty"; \
	else \
		git commit -m "$$MESSAGE"; \
		git push; \
	fi
install:
	./scripts/install.sh
backup:
	./scripts/backup.sh 