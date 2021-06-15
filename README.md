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
> docker run -it -v "$(pwd)":/workspace shorthand-docker sushi --init
```

(NOTE: Absolute paths won't work for the following commands)

Run sushi
```
> docker run -v "$(pwd)":/workspace shorthand-docker sushi ./MyNiceIG
```

Run IG Publisher (tip: notice setting JAVA to use more memory)
```
> docker run -v "$(pwd)":/workspace -e JAVA_OPTS='-Xmx2048m -Xms2048m' shorthand-docker publish ./MyNiceIG
```

Launch the website (after publish, notice adding port 2021. Then open
http://localhost:2021 in your browser)
```
> docker run -p 2021:2021 -v "$(pwd)":/workspace shorthand-docker serve ./MyNiceIG
```

## Helper

These helpers assume an image named `bkaney/shorthand-docker`. You might want
to copy these scripts into your PATH.


*For Mac and linux* users, you can use the script `nori.sh`, which is a docker
wrapper:

```
> ./nori.sh sushi --init
> ./nori.sh sushi ./MyNiceIG
> ./nori.sh publish ./MyNiceIG
> ./nori.sh serve ./MyNiceIG
> ./nori.sh gofsh ./json-input
```

*For windows users*, you can use the script `nori.bat`. NOTE that when passing in
the directory, use relative paths using forward slashes, as shown here:

```
> nori sushi --init
> nori sushi ./MyNiceIG
> nori publish ./MyNiceIG
> nori serve ./MyNiceIG
> nori gofsh ./json-input
```
