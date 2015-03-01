classdef AveragingVisitor
	%% AVERAGINGVISITOR   

	%  $Revision: 2625 $ 
 	%  was created $Date: 2013-09-16 01:17:32 -0500 (Mon, 16 Sep 2013) $ 
 	%  by $Author: jjlee $,  
 	%  last modified $LastChangedDate: 2013-09-16 01:17:32 -0500 (Mon, 16 Sep 2013) $ 
 	%  and checked into repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlaveraging/src/+mlaveraging/trunk/AveragingVisitor.m $,  
 	%  developed on Matlab 8.1.0.604 (R2013a) 
 	%  $Id: AveragingVisitor.m 2625 2013-09-16 06:17:32Z jjlee $ 
 	 
    properties
        visitHistory
    end
    
	methods 
        function element = visitAndFilter(this, element)
            element = foo(element);
            this.visitHistory.add(element);
        end
        
        function bldr = visitFilterOptimally(this, bldr)
            imcast(bldr.product, 'mlfourd.NIfTI');
        end
        function this = AveragingVisitor()
            this.visitHistory = mlpatterns.CellArrayList;
        end
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

