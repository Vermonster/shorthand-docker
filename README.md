# Shorthand: FHIR Sushi and IG Publisher in Docker

This builds a docker image so you can run sushi and IG Publisher

## From Docker Hub

Pull:
```
> docker pull bkaney/shorthand-docker
```

## Build

Locally build a docker image named `shorthand-docker`:

```
> docker build -t shorthand-docker .
```

## Usage

Initalize a new IG (you need the `-it` because this part is interactive)
```
> docker run -it -v "$(pwd)":/home/dev/workspace shorthand-docker sushi --init
```

(NOTE: Absolute paths won't work for the following commands)

Run sushi
```
> docker run -v "$(pwd)":/home/dev/workspace shorthand-docker sushi ./MyNiceIG
```

Run IG Publisher (tip: notice setting JAVA to use more memory)
```
> docker run -v "$(pwd)":/home/dev/workspace -e JAVA_OPTS='-Xmx2048m -Xms2048m' shorthand-docker publish ./MyNiceIG
```

Launch the website (after publish, notice adding port 2022. Then open
http://localhost:2022 in your browser)
```
> docker run -p 2022:2022 -v "$(pwd)":/home/dev/workspace shorthand-docker serve ./MyNiceIG
```

NOTE: Recommend that you cache fhir packages.

You can do this a few ways, volume to a local directory on the host machine:
```
> docker run -p 2022:2022 \
    -v "$(pwd)":/home/dev/workspace \
    -v "$(pwd)"/.fhir:/home/dev/.fhir \
    shorthand-docker serve ./MyNiceIG
```

Or use a docker volume
```
> docker volume create fhir

> docker run -p 2022:2022 \
    --mount source=fhir,target=/home/dev/.fhir \
    -v "$(pwd)"/.fhir:/home/dev/.fhir \
    shorthand-docker serve ./MyNiceIG
```

## Helper

These helpers assume an image named `bkaney/shorthand-docker`. You might want
to copy these scripts into your PATH.

NOTE: The helper will create and use a docker volume for FHIR package caching.


*For Mac and linux* users, you can use the script `nori.sh`, which is a docker
wrapper:

```
> ./nori sushi --init
> ./nori sushi ./MyNiceIG
> ./nori publish ./MyNiceIG
> ./nori serve ./MyNiceIG
> ./nori gofsh ./json-input
```

*For windows users*, you can use the script `nori.bat`.

```
> .\nori sushi --init
> .\nori sushi ./MyNiceIG
> .\nori publish ./MyNiceIG
> .\nori serve ./MyNiceIG
> .\nori gofsh ./json-input
```

NOTE that when passing in the directory, use relative paths from the CWD.

TIP: Consider placing the nori wrapper script in your PATH.
