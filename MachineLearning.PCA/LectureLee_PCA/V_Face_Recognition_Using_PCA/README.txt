Jason Joseph Rebello
Carnegie Mellon University (Jan 2012 - May 2013)
MS in Electrical & Computer Engineering

Principal Component Analysis.

This program uses Principal Component Analysis to reduce the number of features used in face recognition. This program allows you to set K if you know the number of Principal Components needed or calculates K based on how much variance you would like to preserve in the images. 

Most of the time data consists of features that are highly correlated and hence we can reduce the number of features needed to analyze the data. This helps to speed up the computational time of the program.

Initializing Variables: K is the number of principal components. It has been commented out as I am trying to find K based on the variance. The variance of the image can take on values from 0 to 100 but typically should not be below 85(%). dispFaces and topeig are just variables used in visualization.

The data is first loaded. Each row is a set of pixels that represent a face. They have been resized such that the data matrix X is of size m x n, where m is the number of examples of faces and n is the number of features or pixels that make up the image.

normalizeFeatures : Sometimes features may not be of the same scale, hence we perform mean normalization of the features by subtracting the mean of each feature from each example and then dividing by the standard deviation. In place of std dev the range (max value - min value) can be used. Note that if you perform classification and get a new test point, you will want to subtract the mean of the training examples and not of the test data. This is the reason why mean 'mu' and standard deviation 'stddev' variables are declared.

performPCA : Here the covariance matrix is calculated. It gives a relation between two features in the data set. The singular value decomposition is then calculated to get the eigen values and eigen vectors. A nice video on SVD is available on youtube : http://www.youtube.com/watch?v=JEYLfIVvR9I

findK : When K is not specified, this function uses the variance to predict the minimum K needed to preserve the variance. Note that if you uncomment K in the program then you should not call this function as it will overwrite the value of K given by you.

reducedFeatures : In order to reduce computational time, we get the redeucedData from this function that can be fed to a neural network or logistic regression to train the model and perform classification.

recoverData : This function is used to recover the original data with 'n' features instead of 'k' features.
As can be seen some information is lost.

show : Displays original face images and recovered face images. 