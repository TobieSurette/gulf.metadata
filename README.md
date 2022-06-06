# `gulf.metadata` **R** Package
`gulf.metadata` is an **R** package for treating Southern Gulf of St. Lawrence metadata. Metadata is data which provides information about other data, such data provenance, measurement units, index keys, study and field descriptions, data and file formats and keywords. Metadata can be attached to or retrieved from objects using the set of functions in the table below. Note that some metadata are automatically linked with datasets when they are loaded.

Function      | Description
------------- | --------------------------------------------------------------------------
`metadata`    | Retrieve and collate metadata associated with an object.
`key`         | Set or retrieve an index key for a data table.
`keyword`     | Set or retrieve an keyword(s) for a data table.
`description` | Set or retrieve a text description(s) for a data table or variable field.
`format`      | Set or retrieve the format defintion of a variable field.
`units`       | Set or retrieve the units of a variable field.
`project`     | Set or retrieve a project tag for a data table.  
`header`      | Set or retrieve file header information associated with a data table

## Example:
```
# Define sample data set:
x <- data.frame(year = 2010:2014,
                site = letters[1:5],
                weight = exp(rnorm(5)),
                number = rpois(5,5))

# Define metadata attributes:
units(x, "weight") <- "kilogram"
format(x, "year") <- "YYYY"
description(x) <- c(year = "Year of sampling",
                    site = "Sampling site",
                    weight = "Weight of specimen",
                    number = "Number observed")
key(x) <- "year"
keywords(x) <- c("annual", "survey")
project(x) <- "survey"

# Retrieve metadata:
metadata(x)
```
## Gulf Data Projects

The package comes with a number of predefined data projects. Shown below is a portion of the project data table, the full version of which can be accessed using `project()`:

   name       | description
------------- | --------------------------------------------------------------------------
`scs`         | Southern Gulf of St. Lawrence snow crab survey
`sco`         | Snow crab at-sea observer sampling program
`rvs`         | Southern Gulf of St. Lawrence multispecies survey
`qrvs`        | Quebec Gulf of St. Lawrence multispecies survey
`nss`         | Northumberland Strait multispecies survey
`scfec`       | Southern Gulf of St. Lawrence snow crab fecundity studies
`alsi`        | Southern Gulf of St. Lawrence component of the Atlantic Lobster Settlement Index (ALSI) program
`sens`        | Southern Gulf of St. Lawrence groundfish industry-led sentinel survey
`ins`         | Inshore survey
`jans`        | January survey
`juvs`        | Juvenile cod survey
`seas`        | Seasonal survey
`scas`        | Scallop drag survey
`vms`         | Fishery vessel monitoring system coordinate data
