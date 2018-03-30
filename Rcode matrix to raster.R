#Creating a SpatialGridDataFrame in package sp

#Create the base grid
# - the smallest coordinates for each dimension, here: 0,0
# - cell size in each dimension, here: 1,1 
# - number of cells in each dimension, here: 5,5
bbgrid = GridTopology(c(1,1), c(1,1), c(4,8))

#Import data - Data must be a data.frame (worked as a 1 column data.frame, did not work as a 4x8 data.frame)
test_data <- read_csv("~/Dropbox/PhD/Study 3/Spatial modelling/test_data.csv", col_names = FALSE)

#Create the grid data frame
spdf = SpatialGridDataFrame(bbgrid, test_data)

#Plot
spplot(spdf, sp.layout = c("sp.points", SpatialPoints(coordinates(spdf))))

#Create raster grid from raster package

# specify the RasterLayer with the following parameters:
# - minimum x coordinate (left border)
# - minimum y coordinate (bottom border)
# - maximum x coordinate (right border)
# - maximum y coordinate (top border)
# - resolution (cell size) in each dimension
rastergrid = raster(xmn=0.5, ymn=0.5, xmx=4.5, ymx=8.5, resolution=c(1,1))
rastergrid = setValues(rastergrid, test_data_vec)
#Plot raster
plot(rastergrid); points(coordinates(rastergrid), pch=3)

#Can also convert matrix to raster but this does not work as well - dims are off 
rastergrid2 = raster(test_data)

#Calculating morans i for autocorrelation
Moran(rastergrid)                      #Single value that is the mean of each cell's autocor value
moran_test = MoranLocal(rastergrid)    #Returns a rasterlayer of morans i values (values of the rasterlayer are the results of the autocor test)
matrix(values(moran_test), nrow = 8, ncol = 4, byrow = T)  #Matrix of morans i values






