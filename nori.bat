@echo off

docker run -e JAVA_OPTS="-Xmx2048m -Xms2048m" -p 2021:2021 -it -v %cd%:/workspace bkaney/shorthand-docker %*
