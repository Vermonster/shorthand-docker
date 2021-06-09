# Shorthand: FHIR Sushi and IG Publisher in Docker

This builds a docker image so you can run sushi and IG Publisher

## Build

```
> docker build -t shorthand .
```

## Usage

Initalize a new IG (you need the `-it` because this part is interactive)
```
> mkdir MyNiceIG
> docker run -it -v "$(pwd)"/MyNiceIG:/workspace/MyNiceIG shorthand sushi --init
```
(When prompted, your IG name should match the directory name you made)


Run sushi
```
> docker run -v "$(pwd)"/MyNiceIG:/workspace/MyNiceIG shorthand sushi ./MyNiceIG
```

Run IG Publisher (tip: notice setting JAVA to use more memory)
```
> docker run -v "$(pwd)"/MyNiceIG:/workspace/MyNiceIG -e JAVA_OPTS='-Xmx2048m -Xms2048m' shorthand publish ./MyNiceIG
```

Launch the website (after publish, notice adding port 2021. Then open http://localhost:2021 in your browser)
```
> docker run -p 2021:2021 -v "$(pwd)"/MyNiceIG:/workspace/MyNiceIG shorthand serve ./MyNiceIG
```

---

TIP: You could write a little wrapper script around these docker commands to make it simpler to run locally!
