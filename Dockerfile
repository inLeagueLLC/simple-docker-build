# Making Our Own Commandbox Image
# 1) Start with the Ortus Commandbox image
# 2) Add a package. In this case we're just adding Nano to demonstrate how it's done.
# 3) Specify the LUCEE_EXTENSIONS environment variable so that Lucee will download and install the extensions when we warm up the server.
# 4) Specify a CFENGINE environment varibale to tell Commandbox which CF server we want warmed up
# 5) Install the commandbox-fusionreactor module
# 6) Warm up the server.

# 1 "FROM" tells Docker to pull the specified image and use that as the basis for what we're adding
FROM ortussolutions/commandbox

LABEL maintainer "Samuel Knowlton <sam@inleague.org>"
LABEL repository "https://github.com/inLeagueLLC/simple-docker-build"

# this just supresses some warnings we don't care about on Ubuntu or Debian-based images
ARG DEBIAN_FRONTEND=noninteractive

# 2) Get the package list; install nano; delete the package list archive. We'll write it on two lines for better readability, which can help if we're installing a lot of packages
RUN apt-get update && apt-get install -y nano && \
 	rm -rf /var/lib/apt/lists/*

# 3) Install Lucee Extensions. The format is a little clunky but likely to be smoother with Lucee 6:
# UUID (Package ID);name=Name Of Extension;version=bundle.version.number (,[UUID;name;version])
# These are available from https://download.lucee.org
# We'll install the Microsoft SQL Server JDBC drivers, the Lucee Administrator, and the PDF extension.

ENV LUCEE_EXTENSIONS "99A4EF8D-F2FD-40C8-8FB8C2E67A4EEEB6;name=Microsoft SQL Server (Vendor Microsoft);version=6.4.0.jre8,CED6227E-0F49-6367-A68D21AACA6B07E8;name=Lucee Administrator;version=1.0.0.3,66E312DD-D083-27C0-64189D16753FD6F0;name=PDF Extension;version=1.0.0.73-SNAPSHOT"

# 4) Specify the CF engine we want Commandbox to download that we will then warm up. This could be in a couple different formatS:
# Latest stable release of Lucee 5: lucee@5
# Adobe CF 2018: adobe@2018
# But these could resolve to different engine versions when they're updated, so it's best to be as specific as possible:
# Our value: lucee@5.3.1+102
# Another option: A Lucee snapshot not yet available on Forgebox: http://update.lucee.org/rest/update/provider/forgebox/5.3.3.11-SNAPSHOT

ENV CFENGINE=lucee@5.3.1+102

# 5) Install the commandbox-fusionreactor module

RUN box install commandbox-fusionreactor

# 6) WARM UP THE SERVER
RUN ${BUILD_DIR}/util/warmup-server.sh

CMD $BUILD_DIR/run.sh