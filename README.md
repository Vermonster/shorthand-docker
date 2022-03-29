# Shorthand: FHIR Sushi and IG Publisher in Docker

This is a wrapper script around the FHIR IG docker image to make it a snap
to use in your projects!

## NOTE: This no longer uses the shorthand docker image, it uses the HL7 one: https://hub.docker.com/r/hl7fhir/ig-publisher-base

## Example

First, recommend installing the `nori` script in your `$PATH`, so you can run it
anywhere.

Then, start a new project:
```
> nori sushi --init
```
(Take the defaults)

Next, try to run the sushi command to create fsh-generated FHIR resources
```
> cd ExampleIG
> nori sushi
```

Finally, build the entire IG using the Publisher
```
> nori publish
```

When it is done, you can view the HTML
```
> open ./output/index.html
```

---

For help, use the help command:
```
> nori help
```

NOTE that when passing in the directory as the second parameter, use therelative paths from the CWD.

