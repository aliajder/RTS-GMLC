# This script is part of the PSSE2PLEXOS repository to function properly, it 
# should be inserted into a data repository as a git submodule. The PSSE2PLEXOS 
# submodule should reside in a folder with two other folders: InputData 
# (containing input *.csv and *.raw files), and OutputData


#------------------------------------------------------------------------------|
# input file parameters ----
#------------------------------------------------------------------------------|
# For information about the contents and required format of these input files, 
# see "Required Input Files" section in the readme.
# All files in input parameters and generic imports must be in "InputFiles" 
# directory. Exported Excel workbook will be saved in "OutputFiles" directory.

# ---- network data ----

# 'pre.parsed' or 'raw.psse'
choose.input <- 'pre.parsed'

# network data
node.file <- "node.data.csv"
line.file <- "line.data.csv"
load.file <- "node.lpf.csv"

# add new generators
add.RE.gens <- FALSE

remap.reference.nodes <- TRUE
map.ref.node.file <- 'region.refnode.data.csv'

# add generators to fuel
map.gen.to.fuel.file <- "gen.fuel.csv"

# add properties to objects. 
# files should be of the form: one column with names of all affected objects, 
# all other columns named a string of the exact name of the plexos property to 
# be added. 
# List elemtn structure: list where first element is name of input file and 
# second is a named list of arguments of add_to_properties_sheet. Required args 
# are names.col (name of column holding object names), object.class, and 
# collection.name
object.property.list <- list(
    
    # load
    list("region.load.da.csv",
         list(datafile.col = "Load",
              scenario.name = "Load: DA")),
    list("region.load.rt.csv",
         list(datafile.col = "Load",
              scenario.name = "Load: RT")),    
    
    # VG and hydro generator profiles
    list("gen.da.vg.csv",
         list(datafile.col = "Rating",
              scenario.name = "RE: DA")),    
    list("gen.rt.vg.csv",
         list(datafile.col = "Rating",
              scenario.name = "RE: RT")),    
    list("gen.da.vg.fixed.csv",
         list(datafile.col = "Fixed Load",
              scenario.name = "RE: DA")),
    list("gen.rt.vg.fixed.csv",
         list(datafile.col = "Fixed Load",
              scenario.name = "RE: RT")),
    list("storage.csp.csv",
         list(datafile.col = "Natural Inflow",
              scenario.name = "RE: DA")),
    list("storage.props.csv"),
    list("storage.props.rt.csv",
         list(scenario.name = "RT Run")),
    
    # generator properties
    list("gen.outages.csv", 
         list(scenario.name = "Gen Outages")),
    list("gen.cost.data.base.csv"),
    list("gen.cost.data.csv",
         list(band.col = "Band")),    
    
    # reserve profiles
    list("reserve.provisions.csv",
         list(datafile.col = 'Min Provision')),
    list("reserve.provisions.rt.csv",
         list(datafile.col = 'Min Provision',
              scenario.name = 'RT Run'))

)

objects.list <- list(
    "generator.data.csv",
    "fuel.price.csv"
)
 
#reserve
reserve.files <- list(
  reserves = 'reserve.data.csv',
  reserve.generators = 'reserve.generators.csv',
  reserve.regions = 'reserve.regions.csv'
)

# define filepointers for day ahead to real time 
interleave.models.list <- list(
  list('da_rt.csv',
       template.fuel = 'da_rt_filepointer_template.csv',
       interleave = FALSE)
)

# define as many files as needed for generic imports
# currently, this defines horizons, ST and MT schedules, reports, and models
generic.import.files <- c(
    "STSched_MTSched_Perf_Transm_Prod.csv",
    "import_report.csv",
    "storage_objs_csp.csv"
)

# compact generic files format (different file for each object type)
# c("path_to_file","model|horizon")
compact.generic.import.files <- list(
    c("import_models.csv", "model"),
    c("import_horizons.csv", "horizon")
)


