classdef AveragingContext < mlfsl.FslContext
% AVERAGINGSTRATEGY is a strategy design pattern

   properties (Dependent)
       blur
   end

   methods %% set/get
       function      set.blur(this, bl)
           this.theStrategy_.blur = bl;           
           fprintf('AveragingContext:  blurring to %s\n', num2str(this.theStrategy_.blur));
       end
       function bl = get.blur(this)
           bl = this.theStrategy.blur;
       end
   end
   
   methods
       function thish = AveragingContext(bldr, varargin)
           thish = thish@mlfsl.FslContext(bldr, varargin{:});
           thish.blur = mlpet.O15Builder.petSigma;
       end % ctor
       
       function         setStrategy(this, choice)
           if (isa(choice, 'mlaveraging.AveragingStrategy'))
               this.theStrategy_ = choice;
               choice = class(this.theStrategy_);
           elseif (ischar(choice))
               this.theStrategy_ = mlaveraging.AveragingStrategy.newStrategy(choice);
           end
           assert(ischar(choice));
           fprintf('AveragingContext:  choosing %s\n', choice);
       end       
       function imobj = average(this, imobj, blur)
           if (exist('blur','var'))
               this.blur = blur; end
           imobj = this.theStrategy.average(imobj);
       end
   end

end
%EOF
