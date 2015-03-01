classdef AveragingSusan < mlaveraging.AveragingStrategy 
	%% AVERAGINGSUSAN is a place-holder for AveragingStrstegy for the case of Susan averaging
	%  Version $Revision: 2406 $ was created $Date: 2013-03-08 01:37:24 -0600 (Fri, 08 Mar 2013) $ by $Author: jjlee $,  
 	%  last modified $LastChangedDate: 2013-03-08 01:37:24 -0600 (Fri, 08 Mar 2013) $ and checked into svn repository $URL: file:///Users/jjlee/Library/SVNRepository_2012sep1/mpackages/mlfourd/src/+mlfourd/trunk/AveragingSusan.m $ 
 	%  Developed on Matlab 7.14.0.739 (R2012a) 
 	%  $Id: AveragingSusan.m 2406 2013-03-08 07:37:24Z jjlee $ 
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad) 

	properties 
        blur = mlpet.PETBuilder.petPointSpread;
 	end 

	methods 

 		function this = AveragingSusan(blur)
            if (exist('blur','var'))
                this.blur = blur;
            end
 		end %  ctor 
        
        function imout = average(this, im, blur)
            if (exist('blur','var'))
                this.blur = blur; end
            imout = mlaveraging.SusanFacade.doSusan( ...
                imcast(im, 'fqfilename'), ...
                norm(this.blur));
        end        
        
        function this  = set.blur(this, blr)
            %% SET.BLUR adds singleton dimensions as needed to fill 3D
            
            assert(isnumeric(blr));            
            if (norm(blr) < norm(mlpet.PETBuilder.petPointSpread))
                this.blur = mlpet.PETBuilder.petPointSpread;
            end
            switch (numel(blr))
                case 1
                    this.blur = [blr blr blr]; % isotropic
                case 2
                    this.blur = [blr(1) blr(2) 0]; % in-plane only
                case 3
                    this.blur = [blr(1) blr(2) blr(3)];
                otherwise
                    this.blur = [0 0 0];
            end
        end % set.blur     
        
        function tf    = blur2bool(this)
            assert(isnumeric(this.blur));
            tf = ~all([0 0 0] == this.blur);
        end    
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end



