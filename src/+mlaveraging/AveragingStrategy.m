classdef AveragingStrategy
% Interface / Abstract Class 
% This class must be inherited. The child class must deliver the
% RunAveragingStrategy method that accepts the concrete Averaging class

   properties (Abstract)
       blur
   end
   
   methods (Abstract)
       average(imagingObject, blur)
   end
   
   methods (Static)
       function concrete = newStrategy(choice)
          import mlaveraging.*;
          switch lower(choice)
                % If you want to add more strategies, simply put them in
                % here and then create another class file that inherits
                % this class and implements the average method
              case {'none' 'default'}
                  concrete = AveragingNone;
              case {'gauss' 'gaussian' 'blur' 'blurring'}
                  concrete = AveragingGauss;
              case {'blindd' 'blinddeconv' 'blinddeconvolution'}
                  concrete = AveragingBlindDeconv;
              case  'susan'
                  concrete = AveragingSusan;
              otherwise
                  error('mlfourd:UnsupportedValue', 'newStrategy.value->%s', choice);
          end
       end
   end
end 

%EOF