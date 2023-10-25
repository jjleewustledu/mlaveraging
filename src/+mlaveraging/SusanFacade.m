classdef SusanFacade 
	%% SUSANFACADE is a wrapper for the FSL Susan filtering schemes
	 
	%% Version $Revision$ was created $Date$ by $Author$  
 	%% and checked into svn repository $URL$ 
 	%% Developed on Matlab 7.10.0.499 (R2010a) 
 	%% $Id$ 
 	%  N.B. classdef (Sealed, Hidden, InferiorClasses = {?class1,?class2}, ConstructOnLoad) 

	properties (Constant)
        dimensionality = 3;
        useMedian = 1;
        nUsans = 0;
    end 
    
    properties (Dependent)
        nii
        brightThresh
        halfWidth
        fileprefix
        fileprefix_out
    end

	methods (Static)
        function [fileout, sf] = doSusan(varargin)
            %% DOSUSAN 
            %  Usage:  image_blur = SusanFacade.doSusan(image_in[, nsigma])
            
            sf = mlaveraging.SusanFacade(varargin{:});
            try
                r = '';     
                cmd = sprintf('susan %s %g %g %g %g %g %s %s', ...
                    sf.nii.fileprefix, sf.brightThresh, sf.halfWidth, sf.dimensionality, sf.useMedian, sf.nUsans, ...
                    sf.fileprefix_out);
                [~,r] = mlbash(cmd); 
                fileout = sf.fileprefix_out;
            catch ME
                handexcept(ME, r);
            end
        end
    end 
    
    methods %% set/get
        function ni  = get.nii(this)
            assert(isa(this.nii_, 'mlfourd.INIfTI'));
            ni = this.nii_;
        end          
        function bth = get.brightThresh(this)
            SAMPLING_FRAC = 0.2;
            sampSize      = floor(this.nii.size*SAMPLING_FRAC);
            sampImg       = this.nii.img(1:sampSize(1), 1:sampSize(2), 1:sampSize(3));
            medianNoise   = median(median(median(sampImg)));
            medianImg     = median(median(median(this.nii.img)));
            if (medianNoise < medianImg)
                bth       = medianNoise + (medianImg - medianNoise)*SAMPLING_FRAC;
            else
                bth       = medianNoise;
            end
        end
        function shw = get.halfWidth(this)
            shw = this.hwhh_;
        end
        function fp  = get.fileprefix(this)
            fp = this.nii.fileprefix;
        end
        function fp  = get.fileprefix_out(this)
            fp = [this.fileprefix '_susan' blur2str(this.hwhh_) 'mm'];
        end
    end
    
    methods (Access='protected')   
 		function this = SusanFacade(nii, varargin) 
 			%% SUSANFACADE (ctor) 
 			%  Usage:  obj = SusanFacade(nifti, nsigma)
            
            nii = imcast(nii, 'mlfourd.NIfTI');
            p = inputParser;
            addRequired(p, 'nii', @(x) isa(x, 'mlfourd.INIfTI'));
            addOptional(p, 'hwhh', max(mlpet.PETBuilder.petPointSpread)/2, @isnumeric);
            parse(p, nii, varargin{:});

            this.nii_    = p.Results.nii;
            this.hwhh_ = p.Results.hwhh;
 		end % SusanFacade (ctor)    
    end
    
    properties (Access = 'private')
        nii_
        hwhh_
    end
    
	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
 end 
