#requires -Version 3

# TODO: Replace with HL7 once they update dockerhub
# $image="hl7fhir/ig-publisher-base"
$image="bkaney/ig-publisher-base:latest"

function Invoke-InDocker {
    docker run --rm -it -v ${PWD}:/home/publisher/ig `
        -e JAVA_OPTS='-Xmx2048m -Xms2048m' `
        -v ${HOME}\.ig-publisher-cache\.fhir:/home/publisher/.fhir `
        -v ${HOME}\.ig-publisher-cache\.gradle:/home/publisher/.gradle `
        -v ${HOME}\.ig-publisher-cache\.node:/home/publisher/.node `
        $image `
        $args
}

function Invoke-Publish {
    if (-not(Test-Path -Path $PWD\input-cache)) {
        Invoke-InDocker ./_updatePublisher.sh -f
    }

    Invoke-InDocker ./_genonce.sh
}


function Set-CacheDirectories {
    if (-not(Test-Path $HOME\.ig-publisher-cache\.gradle)) {
            mkdir -p $HOME\.ig-publisher-cache\.gradle
    }
    if (-not(Test-Path $HOME\.ig-publisher-cache\.fhir)) {
            mkdir -p $HOME\.ig-publisher-cache\.fhir
    }
    if (-not(Test-Path $HOME\.ig-publisher-cache\.node)) {
            mkdir -p $HOME\.ig-publisher-cache\.node
    }
}

function Reset-CacheDirectories {
    if (Test-Path $HOME\.ig-publisher-cache) {
        rm -r "$Home\.ig-publisher-cache"
    }
    if (Test-Path $PWD\input-cache) {
        rm -r $PWD\input-cache
    }
    docker pull $image
    Set-CacheDirectories
}


# Program Flow...

$param1=$args[0]

Set-CacheDirectories

if ($param1 -match "publish") {
    Invoke-Publish
} elseif ($param1 -match "reset") {
    Reset-CacheDirectories
} elseif ($param1 -match "(help|h)$") {
    $help = @"

Usage: nori <COMMAND>

A wrapper around IG Publisher and related tools.

--

Commands:
publish:  runs the IG publisher
sushi:    runs the sushi command
reset:    rest local cache and docker image

NOTE: You can also run any command relative to your IG root, e.g.

> nori ./_updatePublisher.sh

--

Examples:

> nori sushi --init
> nori sushi --version
> nori sushi
> nori publish

"@

    echo $help

} else {
    Invoke-InDocker @args
}
