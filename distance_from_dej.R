cells <- read.csv("C://Users/afwillia/Nuclei.csv", stringsAsFactors = FALSE)
dej <- read.delim("C://Users/afwillia/dej_coords.txt", sep = " ", stringsAsFactors = FALSE, header = FALSE)

cells <- split(cells, cells$ImageNumber)
cells <- cells[[1]]
#add and subtract 10 units from each dej y-position to account for thickness of DEJ

ymax <- dej[,3] + 10
ymin <- dej[,3] - 10

dej_adjust <- data.frame(x = rep(dej[,2],2), y = c(ymin, ymax))

#function to find distance between cell and dej pixels
distance <- function(cx, cy, dx, dy) {
  (( cx - dx ) ^2 + (cy - dy ) ^2) ^(1/2)
}

#for each cell in CP file, compare distance to DEJ object, return the smallest distance.
# postive value if above DEJ, negative if below
cell_dist <- rep(NA, nrow(cells))
cell_dist <- sapply(1:nrow(cells), function(i) {
  
  #calculate distance from cell center to each pixel on selection line
  minim <- distance(cells$Location_Center_X[i], cells$Location_Center_Y[i], dej_adjust[,1], dej_adjust[,2])
  closest_dist <- min(minim)
  
  #get nearest x cord to cell, check if cell is within DEJ boundaries, above, or below
  x_loc <- dej_adjust[which(minim == min(minim)), 1]
  dej_boundary <- dej_adjust[dej_adjust[,1]==x_loc, 2]
  
  if (closest_dist > dej_boundary[2]) closest_dist <- -closest_dist
  
  closest_dist

})

# find the closest point on DEJ to each cell and export coordinates.
cell_position <- sapply(1:nrow(cells), function(i) {
  dists <- distance(cells$Location_Center_X[i], cells$Location_Center_Y[i], 
           dej_adjust[,1], dej_adjust[,2])
  
  min_ind <- which(dists == min(dists))[1]
  
  closest_dej <- as.numeric(dej_adjust[min_ind,])
  
  c("cell_x" = cells$Location_Center_X[i], "cell_y" = cells$Location_Center_Y[i],
    "dej_x" = closest_dej[1], "dej_y" = closest_dej[2])
})

cell_position <- t(cell_position)
write.csv(cell_position, "cell_dej_points.csv", row.names=FALSE)
