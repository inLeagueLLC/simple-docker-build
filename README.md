# Sample "Extend a Docker Image" Build File

This repository is part of the "CF guide: End-to-End Coldfusion Pipeline In a Week" guide at cfswarm.inleague.io.

The Dockerfile extends the Ortus Commandbox image to perform a few simple tasks:

* Install `nano` as an example of adding packages to an Alpine-based Docker image
* Set the `LUCEE_EXTENSIONS` environment variable in preparation for "warming up" our Docker Image
* Warm up Commandbox by pulling the CF engine of our choice from Forgebox, starting it, and then shutting it down.

# Required: Replace `myDockerHubUsername` with your Docker Hub Account
The `docker-compose.yml` file in this repository will "tag" the image that is built with the Docker Hub username specified. The default value cannot be pushed to Docker Hub and should be replaced with your Docker Hub username.
