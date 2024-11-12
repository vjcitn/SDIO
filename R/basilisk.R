


# necessary for python module control
bsklenv <- basilisk::BasiliskEnvironment(envname="bsklenv",
    pkgname="SDIO",
    packages=c("spatialdata==0.2.3", "spatialdata-io==0.1.5"))


#' enumerate modules
#' @examples
#' look_sdio()
#' @export
look_sdio = function() {
 proc = basilisk::basiliskStart(bsklenv, testload="spatialdata") # avoid package-specific import
 on.exit(basilisk::basiliskStop(proc))
 basilisk::basiliskRun(proc, function() {
     sdio = reticulate::import("spatialdata_io") 
     names(sdio)
   })
}

#' expose a reader
#' @examples
#' expose_sdio("xenium") # not basilisk-standards compliant -- leaks python reference into R
#' @export
expose_sdio = function(platform="xenium") {
 proc = basilisk::basiliskStart(bsklenv, testload="spatialdata") # avoid package-specific import
 on.exit(basilisk::basiliskStop(proc))
 basilisk::basiliskRun(proc, function(platform) {
     sdio = reticulate::import("spatialdata_io") 
     sdio[[platform]]
   }, platform=platform)
}
