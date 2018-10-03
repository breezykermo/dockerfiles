REPO_DIR=$(pwd)
REPO_DCKER='/notebooks'
DOCKER_BASH_HISTORY='data/docker.bash_history'
DOCKER_BASE='tf-keras-pytorch'

# docker run -it -v \"$REPO_DIR:/$REPO_DCKER\" -v \"$HOME/.config/gcloud:/root/.config/gcloud\" -v \"$DOCKER_BASH_HISTORY:/root/.bash_history\" --rm $DOCKER_BASE
docker run -it -v "$REPO_DIR:/$REPO_DCKER" -v "$HOME/.config/gcloud:/root/.config/gcloud" -p 0.0.0.0:8888:8888 -p 0.0.0.0:6006:6006 --rm --hostname=localhost $DOCKER_BASE jupyter notebook --port=8888 --allow-root --no-browser --NotebookApp.custom_display_url=http://localhost:8888
