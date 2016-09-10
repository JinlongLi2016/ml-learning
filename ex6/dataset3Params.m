function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
options = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
%function [model] = svmTrain(X, Y, C, kernelFunction, ...
%                            tol, max_passes)
C = 0.01; sigma = 0.01;
model = svmTrain(X, y, options(1), @(x1, x2) gaussianKernel(x1, x2, options(1)));
pred = svmPredict(model, Xval);
error_rate = mean(double(pred ~= yval));
for i=1:length(options)
  for j = 1:length(options)
    model = svmTrain(X, y, options(i), @(x1, x2) gaussianKernel(x1, x2, options(j)));
    pred = svmPredict( model, Xval);
    new_error_rate = mean(double(pred ~= yval));
    if new_error_rate < error_rate
      C = options(i); sigma = options(j);
      error_rate = new_error_rate;
    end
  end
end







% =========================================================================

end
