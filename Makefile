push:
	git status
	git add .
	echo "Commit Message: "
	read MESSAGE
	git commit -m "$MESSAGE"
	git push
