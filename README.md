# `gulf.metadata` **R** Package
`gulf.metadata` is an **R** package for treating Southern Gulf of St. Lawrence metadata. Metadata is data that provides information about other data. This includes such items as data provenance, measurement units, index keys, study and field descriptions, data and file formats and keywords. Metadata can be attached to or retrieved from objects using the set of functions in the table below. Note that some metadata are automatically linked with datasets when they are loaded.

Function      | Description
------------- | ------------------------------------------------------------------------
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

