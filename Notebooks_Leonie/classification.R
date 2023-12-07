#install.packages("sf")
#install.packages("terra")
#install.packages("caret")
#install.packages("randomForest")

library(sf)
library(terra)
library(caret)
library(randomForest)

# Read in the training data shapefile

TrainingData <- st_read()  

# Read in the clipping extent

AOI <- st_read()

# Read in the Sentinel bands

b2 <- rast()
b3 <- rast()
b4 <- rast()
b8 <- rast()


# Clip the raster bands using the clipping extent

b2_clip <- crop()

# Project the raster data sets as well as the training data set to the projection of AOI

project()

# Calculate vegetation indices

ndvi <- 
ndwi <- 

names(ndvi) <- "ndvi"
names(ndwi) <- "ndwi"

# Stack the clipped raster bands as well as the vegetation indices together

img <- c()


# Extract a pixel value from every raster data set for each training point

smp <- extract()

# Add the binary indormatin back to the data frame

smp$cl <- as.factor( TrainingData$class[ match(smp$ID, seq(nrow(TrainingData)) ) ] )
smp <- smp[-1]

# Check for NAs

sum(is.na(smp))

# If there are any, replace them with some value

smp[is.na(smp)] <- 0 #or 999


# Create training and testing data set

set.seed(123)  # for reproducibility

train.test.split <- caret::createDataPartition(smp$cl , p = 0.8, list = FALSE)

training_data <- smp[train.test.split, ]

testing_data <- smp[-train.test.split, ]

str(training_data)


# Train the RF modle

rf_model <- train(cl ~ ., data = training_data, method = "rf",
                  trControl = trainControl(method = "cv", number = 10),
                  tuneLength = 3)


# Predict on the test data
predictions <- predict()

# Evaluate the model performance
confusionMatrix()


# Predict the whole stacked image
predicted_classes <- predict(img, rf_model)

plot(predicted_classes)

