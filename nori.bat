@echo off

docker volume create fhir > /dev/null

docker run -e JAVA_OPTS="-Xmx2048m -Xms2048m" -p 2022:2022 -it --mount source=fhir,target=/home/dev/.fhir -v %cd%:/workspace bkaney/shorthand-docker %*
